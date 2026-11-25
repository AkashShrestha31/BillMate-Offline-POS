import 'package:flutter/foundation.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_direct_report_request.dart';
import 'package:hotel/src/features/setup/domain/local_books_schema_ensurer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class StockMovementLine {
  const StockMovementLine({
    required this.item,
    required this.quantity,
    this.rate = 0,
    this.location,
  });

  final String item;
  final double quantity;
  final double rate;
  final String? location;
}

/// Global live stock tracking: sales reduce on-hand qty, purchases add it.
class LiveStockTrackingService extends ChangeNotifier {
  LiveStockTrackingService(this._db);

  static const _prefKey = 'live_stock_tracking_v1';
  static const defaultLocation = 'Stores';

  final LocalDb _db;

  bool _enabled = false;
  /// Keyed by `item` + location (`item\\u001flocation`).
  final Map<String, double> _onHand = {};
  final Set<String> _untrackedItems = {};

  bool get enabled => _enabled;

  static String cacheKey(String itemName, String location) =>
      '${itemName.trim()}\u001f${_normalizeLocation(location)}';

  static String _normalizeLocation(String? location) {
    final value = location?.trim() ?? '';
    return value.isEmpty ? defaultLocation : value;
  }

  /// Book qty. Omit [location] to sum every warehouse for the item.
  double onHand(String itemName, {String? location}) {
    final item = itemName.trim();
    if (item.isEmpty) return 0;
    if (location != null) {
      return _onHand[cacheKey(item, location)] ?? 0;
    }
    var total = 0.0;
    final prefix = '$item\u001f';
    for (final entry in _onHand.entries) {
      if (entry.key.startsWith(prefix) || entry.key == item) {
        total += entry.value;
      }
    }
    return total;
  }

  /// Per-warehouse book qty for [itemName]. Empty when nothing is on hand.
  Map<String, double> onHandByLocation(String itemName) {
    final item = itemName.trim();
    final prefix = '$item\u001f';
    final result = <String, double>{};
    for (final entry in _onHand.entries) {
      if (!entry.key.startsWith(prefix)) continue;
      final loc = entry.key.substring(prefix.length);
      if (loc.isEmpty) continue;
      result[loc] = entry.value;
    }
    return result;
  }

  Future<List<String>> listLocations() async {
    final names = <String>{defaultLocation};
    for (final key in _onHand.keys) {
      final sep = key.indexOf('\u001f');
      if (sep >= 0) names.add(key.substring(sep + 1));
    }
    try {
      await _ensureSchema();
      final rows = await _db.rawQuery('SELECT name FROM Location');
      for (final row in rows) {
        final name = row['name']?.toString().trim() ?? '';
        if (name.isNotEmpty) names.add(name);
      }
    } catch (_) {}
    final list = names.toList()..sort();
    if (list.remove(defaultLocation)) {
      list.insert(0, defaultLocation);
    }
    return list;
  }

  Future<void> ensureLocation(String location) async {
    try {
      await _ensureSchema();
      final db = await _db.database;
      await _ensureLocation(db, location, 'local_user');
    } catch (_) {}
  }

  bool limitsItem(String itemName, {String? itemType}) {
    if (!_enabled) return false;
    if (itemName.trim().isEmpty) return false;
    if ((itemType ?? '').trim().toLowerCase() == 'service') return false;
    if (_untrackedItems.contains(itemName)) return false;
    return true;
  }

  bool canIssue({
    required String itemName,
    required double requestedQty,
    String? itemType,
  }) {
    if (!limitsItem(itemName, itemType: itemType)) return true;
    if (requestedQty <= 0) return true;
    return requestedQty <= onHand(itemName) + 0.0000001;
  }

  /// First product on a sales document that exceeds on-hand quantity.
  ({String item, double onHand})? findSalesShortage(
    Iterable<StockMovementLine> lines,
  ) {
    if (!_enabled) return null;
    final totals = <String, double>{};
    for (final line in lines) {
      final name = line.item.trim();
      if (name.isEmpty || _untrackedItems.contains(name)) continue;
      totals[name] = (totals[name] ?? 0) + line.quantity.abs();
    }
    for (final entry in totals.entries) {
      if (!canIssue(itemName: entry.key, requestedQty: entry.value)) {
        return (item: entry.key, onHand: onHand(entry.key));
      }
    }
    return null;
  }

  static String formatQty(double qty) {
    if (qty == qty.roundToDouble()) return qty.round().toString();
    return qty.toStringAsFixed(2);
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _enabled = prefs.getBool(_prefKey) ?? false;
    if (_enabled) {
      await refreshCache();
    }
    notifyListeners();
  }

  Future<void> setEnabled(bool enabled) async {
    if (enabled == _enabled) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, enabled);
    _enabled = enabled;
    if (enabled) {
      await backfillExistingDocuments();
      await refreshCache();
    } else {
      _onHand.clear();
      _untrackedItems.clear();
    }
    notifyListeners();
  }

  Future<void> refreshCache() async {
    _onHand.clear();
    _untrackedItems.clear();
    if (!_enabled) {
      notifyListeners();
      return;
    }
    try {
      if (!await LocalDb.databaseFileExists()) {
        notifyListeners();
        return;
      }
      await _ensureSchema();
      await _reverseUnsubmittedPurchases();
      final rows = await _db.rawQuery(
        'SELECT item, IFNULL(NULLIF(location, \'\'), ?) AS loc, '
        'SUM(quantity) AS qty FROM StockLedgerEntry '
        "WHERE item IS NOT NULL AND item != '' GROUP BY item, loc",
        [defaultLocation],
      );
      for (final row in rows) {
        final item = row['item']?.toString() ?? '';
        if (item.isEmpty) continue;
        final loc = _normalizeLocation(row['loc']?.toString());
        _onHand[cacheKey(item, loc)] = _toDouble(row['qty']);
      }
      try {
        final serviceRows = await _db.rawQuery(
          "SELECT name FROM Item WHERE LOWER(IFNULL(itemType, '')) = 'service'",
        );
        for (final row in serviceRows) {
          final name = row['name']?.toString() ?? '';
          if (name.isNotEmpty) _untrackedItems.add(name);
        }
      } catch (_) {}
    } catch (e, st) {
      debugPrint('Live stock cache refresh failed: $e\n$st');
    }
    notifyListeners();
  }

  Future<void> applyInvoiceByName({
    required String invoiceName,
    required bool isPurchase,
  }) async {
    if (!_enabled) return;
    try {
      await _ensureSchema();
      final table = isPurchase ? 'PurchaseInvoice' : 'SalesInvoice';
      final itemTable =
          isPurchase ? 'PurchaseInvoiceItem' : 'SalesInvoiceItem';
      final rows = await _db.query(
        table,
        where: 'name = ?',
        whereArgs: [invoiceName],
        limit: 1,
      );
      if (rows.isEmpty) return;
      final row = rows.first;
      if (_isTruthy(row['cancelled'])) return;
      if (!_isTruthy(row['submitted'])) return;
      final items = await _db.query(
        itemTable,
        where: 'parent = ?',
        whereArgs: [invoiceName],
      );
      await recordDocument(
        referenceType: isPurchase ? 'PurchaseInvoice' : 'SalesInvoice',
        referenceName: invoiceName,
        date: row['date']?.toString() ?? DateTime.now().toIso8601String(),
        createdBy: row['createdBy']?.toString() ?? 'local_user',
        inbound: isPurchase,
        lines: [
          for (final item in items)
            StockMovementLine(
              item: item['item']?.toString() ?? '',
              quantity: _toDouble(item['quantity']),
              rate: _toDouble(item['rate']),
              location: item['location']?.toString(),
            ),
        ],
      );
    } catch (e, st) {
      debugPrint('Live stock apply invoice failed: $e\n$st');
    }
  }

  Future<void> applyReturnByName({
    required String returnName,
    required bool isSales,
  }) async {
    if (!_enabled) return;
    try {
      await _ensureSchema();
      final table = isSales ? 'SalesReturn' : 'PurchaseReturn';
      final itemTable = isSales ? 'SalesReturnItem' : 'PurchaseReturnItem';
      final rows = await _db.query(
        table,
        where: 'name = ?',
        whereArgs: [returnName],
        limit: 1,
      );
      if (rows.isEmpty) return;
      final row = rows.first;
      if (_isTruthy(row['cancelled'])) return;
      final items = await _db.query(
        itemTable,
        where: 'parent = ?',
        whereArgs: [returnName],
      );
      await recordDocument(
        referenceType: table,
        referenceName: returnName,
        date: row['date']?.toString() ?? DateTime.now().toIso8601String(),
        createdBy: row['createdBy']?.toString() ?? 'local_user',
        inbound: isSales,
        lines: [
          for (final item in items)
            StockMovementLine(
              item: item['item']?.toString() ?? '',
              quantity: _toDouble(item['quantity']),
              rate: _toDouble(item['rate']),
              location: item['location']?.toString(),
            ),
        ],
      );
    } catch (e, st) {
      debugPrint('Live stock apply return failed: $e\n$st');
    }
  }

  /// Physical count. Omit [location] to make **total** on-hand equal [qty]
  /// by posting the difference on [defaultLocation].
  Future<void> setOnHand({
    required String itemName,
    required double qty,
    String? location,
  }) async {
    if (!_enabled) return;
    final name = itemName.trim();
    if (name.isEmpty) return;
    final desired = qty < 0 ? 0.0 : qty;
    final loc = location == null
        ? defaultLocation
        : _normalizeLocation(location);
    try {
      await _ensureSchema();
      final db = await _db.database;
      if (await _isServiceItem(db, name)) return;
      await _ensureLocation(db, loc, 'local_user');

      final bookAtLoc = await _bookQty(db, name, loc);
      final totalBook = location == null
          ? await _bookQtyTotal(db, name)
          : bookAtLoc;
      final desiredAtLoc = location == null
          ? desired - totalBook + bookAtLoc
          : desired;
      await reconcileToCount(
        itemName: name,
        location: loc,
        countedQty: desiredAtLoc,
        referenceType: 'StockAdjustment',
        reason: 'Physical count / opening stock',
        writeSnapshot: true,
        persistAdjustment: true,
      );
    } catch (e, st) {
      debugPrint('Live stock set on-hand failed: $e\n$st');
    }
  }

  /// Sets book qty at [location] to [countedQty] (stock reconciliation).
  Future<void> reconcileToCount({
    required String itemName,
    required String location,
    required double countedQty,
    String referenceType = 'PreviousStock',
    String? referenceName,
    String? reason,
    bool writeSnapshot = false,
    bool persistAdjustment = false,
    bool replaceExisting = false,
    bool refresh = true,
  }) async {
    if (!_enabled) return;
    final name = itemName.trim();
    if (name.isEmpty) return;
    final loc = _normalizeLocation(location);
    final desired = countedQty;
    final refName = (referenceName ?? '').trim().isEmpty
        ? 'SADJ-${DateTime.now().millisecondsSinceEpoch}'
        : referenceName!.trim();
    try {
      await _ensureSchema();
      final db = await _db.database;
      if (await _isServiceItem(db, name)) return;
      await _ensureLocation(db, loc, 'local_user');
      final existing = await db.query(
        'StockLedgerEntry',
        where: 'referenceType = ? AND referenceName = ?',
        whereArgs: [referenceType, refName],
        limit: 1,
      );
      if (existing.isNotEmpty) {
        if (referenceType == 'StockAdjustment') {
          // Unique SADJ names; keep posting.
        } else if (!replaceExisting) {
          return;
        } else {
          await reverseDocument(
            referenceType: referenceType,
            referenceName: refName,
            refresh: false,
          );
        }
      }
      final bookQty = await _bookQty(db, name, loc);
      await db.transaction((txn) async {
        if (writeSnapshot) {
          await _upsertPreviousStock(
            txn,
            StockItem(item: name, location: loc, quantity: desired),
          );
        }
        await _postVariance(
          txn,
          itemName: name,
          location: loc,
          bookQty: bookQty,
          desiredQty: desired,
          referenceType: referenceType,
          referenceName: refName,
          reason: reason ?? 'Physical count',
          persistAdjustment: persistAdjustment,
        );
      });
      if (refresh) await refreshCache();
    } catch (e, st) {
      debugPrint('Live stock reconcile failed: $e\n$st');
    }
  }

  /// Corrects a count that already posted, by the change in counted qty.
  Future<void> applyCountQuantityChange({
    required String itemName,
    required String location,
    required String referenceName,
    required double oldQty,
    required double newQty,
  }) async {
    if (!_enabled) return;
    final delta = newQty - oldQty;
    if (delta.abs() <= 0.0000001) return;
    try {
      await _ensureSchema();
      final db = await _db.database;
      final loc = _normalizeLocation(location);
      await _ensureLocation(db, loc, 'local_user');
      final bookQty = await _bookQty(db, itemName, loc);
      final stamp = DateTime.now().millisecondsSinceEpoch;
      await _postVariance(
        db,
        itemName: itemName.trim(),
        location: loc,
        bookQty: bookQty,
        desiredQty: bookQty + delta,
        referenceType: 'StockAdjustment',
        referenceName: 'SADJ-$stamp',
        reason: 'Count correction',
        persistAdjustment: true,
      );
      await refreshCache();
    } catch (e, st) {
      debugPrint('Live stock count correction failed: $e\n$st');
    }
  }

  Future<void> applyStockMovementByName(
    String movementName, {
    bool refresh = true,
  }) async {
    if (!_enabled) return;
    final name = movementName.trim();
    if (name.isEmpty) return;
    try {
      await _ensureSchema();
      final db = await _db.database;
      final existing = await db.query(
        'StockLedgerEntry',
        where: 'referenceType = ? AND referenceName = ?',
        whereArgs: ['StockMovement', name],
        limit: 1,
      );
      if (existing.isNotEmpty) return;
      final header = await db.query(
        'StockMovement',
        where: 'name = ?',
        whereArgs: [name],
        limit: 1,
      );
      if (header.isEmpty) return;
      final row = header.first;
      if (_isTruthy(row['cancelled'])) return;
      if (!_isTruthy(row['submitted'])) return;
      final items = await db.query(
        'StockMovementItem',
        where: 'parent = ?',
        whereArgs: [name],
      );
      final createdBy = row['createdBy']?.toString() ?? 'local_user';
      final date = row['date']?.toString() ?? DateTime.now().toIso8601String();
      var index = 0;
      for (final item in items) {
        final itemName = item['item']?.toString().trim() ?? '';
        if (itemName.isEmpty) continue;
        if (await _isServiceItem(db, itemName)) continue;
        final qty = _toDouble(item['quantity']).abs();
        if (qty <= 0.0000001) continue;
        final from = (item['fromLocation']?.toString() ?? '').trim();
        final to = (item['toLocation']?.toString() ?? '').trim();
        if (from.isNotEmpty) {
          index++;
          await _insertLedgerRow(
            db,
            itemName: itemName,
            location: from,
            signedQty: -qty,
            rate: _toDouble(item['rate']),
            referenceType: 'StockMovement',
            referenceName: name,
            date: date,
            createdBy: createdBy,
            suffix: '$index',
          );
        }
        if (to.isNotEmpty) {
          index++;
          await _insertLedgerRow(
            db,
            itemName: itemName,
            location: to,
            signedQty: qty,
            rate: _toDouble(item['rate']),
            referenceType: 'StockMovement',
            referenceName: name,
            date: date,
            createdBy: createdBy,
            suffix: '$index',
          );
        }
      }
      if (refresh) await refreshCache();
    } catch (e, st) {
      debugPrint('Live stock apply movement failed: $e\n$st');
    }
  }

  Future<void> reverseDocument({
    required String referenceType,
    required String referenceName,
    bool refresh = true,
  }) async {
    try {
      if (!await LocalDb.databaseFileExists()) return;
      await _ensureSchema();
      final db = await _db.database;
      await db.delete(
        'StockLedgerEntry',
        where: 'referenceType = ? AND referenceName = ?',
        whereArgs: [referenceType, referenceName],
      );
      if (refresh) await refreshCache();
    } catch (e, st) {
      debugPrint('Live stock reverse failed: $e\n$st');
    }
  }

  Future<void> recordDocument({
    required String referenceType,
    required String referenceName,
    required String date,
    required String createdBy,
    required bool inbound,
    required List<StockMovementLine> lines,
  }) async {
    if (!_enabled) return;
    try {
      await _ensureSchema();
      final db = await _db.database;
      final existing = await db.query(
        'StockLedgerEntry',
        where: 'referenceType = ? AND referenceName = ?',
        whereArgs: [referenceType, referenceName],
        limit: 1,
      );
      if (existing.isNotEmpty) return;

      var index = 0;
      for (final line in lines) {
        final itemName = line.item.trim();
        if (itemName.isEmpty || line.quantity.abs() <= 0.0000001) continue;
        if (!await _isTrackableItem(db, itemName, inbound: inbound)) continue;
        index++;
        final signedQty = inbound ? line.quantity.abs() : -line.quantity.abs();
        await _insertLedgerRow(
          db,
          itemName: itemName,
          location: _normalizeLocation(line.location),
          signedQty: signedQty,
          rate: line.rate,
          referenceType: referenceType,
          referenceName: referenceName,
          date: date,
          createdBy: createdBy,
          suffix: '$index',
        );
      }
      await refreshCache();
    } catch (e, st) {
      debugPrint('Live stock record failed: $e\n$st');
    }
  }

  Future<void> backfillExistingDocuments() async {
    try {
      if (!await LocalDb.databaseFileExists()) return;
      await _ensureSchema();
      await _reverseUnsubmittedPurchases();
      await _backfillInvoices(isPurchase: false);
      await _backfillInvoices(isPurchase: true);
      await _backfillReturns(isSales: true);
      await _backfillReturns(isSales: false);
      await _backfillStockMovements();
      await _markItemsTracked();
    } catch (e, st) {
      debugPrint('Live stock backfill failed: $e\n$st');
    }
  }

  Future<void> _backfillInvoices({required bool isPurchase}) async {
    final table = isPurchase ? 'PurchaseInvoice' : 'SalesInvoice';
    const submittedClause =
        'IFNULL(submitted, 0) = 1 AND IFNULL(cancelled, 0) = 0';
    final rows = await _db.rawQuery(
      'SELECT name FROM $table WHERE $submittedClause',
    );
    for (final row in rows) {
      final name = row['name']?.toString() ?? '';
      if (name.isEmpty) continue;
      await applyInvoiceByName(invoiceName: name, isPurchase: isPurchase);
    }
  }

  Future<void> _reverseUnsubmittedPurchases() async {
    try {
      final rows = await _db.rawQuery(
        'SELECT DISTINCT sle.referenceName AS name '
        'FROM StockLedgerEntry sle '
        'LEFT JOIN PurchaseInvoice pi ON pi.name = sle.referenceName '
        "WHERE sle.referenceType = 'PurchaseInvoice' "
        'AND (pi.name IS NULL OR IFNULL(pi.submitted, 0) = 0 '
        'OR IFNULL(pi.cancelled, 0) = 1)',
      );
      for (final row in rows) {
        final name = row['name']?.toString() ?? '';
        if (name.isEmpty) continue;
        await reverseDocument(
          referenceType: 'PurchaseInvoice',
          referenceName: name,
          refresh: false,
        );
      }
    } catch (_) {
      // PurchaseInvoice may not exist on older databases.
    }
  }

  Future<void> _backfillReturns({required bool isSales}) async {
    final table = isSales ? 'SalesReturn' : 'PurchaseReturn';
    try {
      final rows = await _db.rawQuery(
        'SELECT name FROM $table '
        'WHERE IFNULL(cancelled, 0) = 0',
      );
      for (final row in rows) {
        final name = row['name']?.toString() ?? '';
        if (name.isEmpty) continue;
        await applyReturnByName(returnName: name, isSales: isSales);
      }
    } catch (_) {
      // Return tables may not exist on older databases.
    }
  }

  Future<void> _backfillStockMovements() async {
    try {
      final rows = await _db.rawQuery(
        'SELECT name FROM StockMovement '
        'WHERE IFNULL(submitted, 0) = 1 AND IFNULL(cancelled, 0) = 0',
      );
      for (final row in rows) {
        final name = row['name']?.toString() ?? '';
        if (name.isEmpty) continue;
        await applyStockMovementByName(name, refresh: false);
      }
    } catch (_) {
      // StockMovement may not exist on older databases.
    }
  }

  Future<void> _markItemsTracked() async {
    try {
      final db = await _db.database;
      await db.rawUpdate(
        "UPDATE Item SET trackItem = 1 "
        "WHERE LOWER(IFNULL(itemType, '')) != 'service'",
      );
    } catch (e, st) {
      debugPrint('Live stock mark items failed: $e\n$st');
    }
  }

  Future<void> _ensureSchema() async {
    final db = await _db.database;
    final path = await LocalDb.databasePath();
    await LocalBooksSchemaEnsurer.ensureAllTables(db, databasePath: path);
  }

  Future<void> _ensureLocation(
    DatabaseExecutor db,
    String location,
    String createdBy,
  ) async {
    final name = _normalizeLocation(location);
    final existing = await db.query(
      'Location',
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );
    if (existing.isNotEmpty) return;
    final now = DateTime.now().toIso8601String();
    await db.insert('Location', {
      'name': name,
      'created': now,
      'modified': now,
      'createdBy': createdBy,
      'modifiedBy': createdBy,
    });
  }

  Future<double> _bookQty(
    DatabaseExecutor db,
    String itemName,
    String location,
  ) async {
    final rows = await db.rawQuery(
      'SELECT COALESCE(SUM(quantity), 0) AS qty FROM StockLedgerEntry '
      'WHERE (item = ? OR LOWER(item) = LOWER(?)) '
      'AND IFNULL(NULLIF(location, \'\'), ?) = ?',
      [
        itemName,
        itemName,
        defaultLocation,
        _normalizeLocation(location),
      ],
    );
    if (rows.isEmpty) return 0;
    return _toDouble(rows.first['qty']);
  }

  Future<double> _bookQtyTotal(DatabaseExecutor db, String itemName) async {
    final rows = await db.rawQuery(
      'SELECT COALESCE(SUM(quantity), 0) AS qty FROM StockLedgerEntry '
      'WHERE item = ? OR LOWER(item) = LOWER(?)',
      [itemName, itemName],
    );
    if (rows.isEmpty) return 0;
    return _toDouble(rows.first['qty']);
  }

  Future<void> _postVariance(
    DatabaseExecutor db, {
    required String itemName,
    required String location,
    required double bookQty,
    required double desiredQty,
    required String referenceType,
    required String referenceName,
    required String reason,
    bool persistAdjustment = false,
  }) async {
    final delta = desiredQty - bookQty;
    if (delta.abs() <= 0.0000001) return;
    const createdBy = 'local_user';
    final now = DateTime.now();
    final nowIso = now.toIso8601String();
    final loc = _normalizeLocation(location);
    await _ensureLocation(db, loc, createdBy);
    if (persistAdjustment) {
      try {
        await db.insert(
          'StockAdjustment',
          {
            'name': referenceName.startsWith('SADJ-')
                ? referenceName
                : 'SADJ-$referenceName',
            'adjustmentDate': nowIso.substring(0, 10),
            'adjustmentType': 'Stock Reconciliation',
            'item': itemName,
            'location': loc,
            'previousQuantity': bookQty,
            'adjustedQuantity': desiredQty,
            'variance': delta,
            'reason': reason,
            'adjustedBy': createdBy,
            'isApproved': 1,
            'createdBy': createdBy,
            'modifiedBy': createdBy,
            'created': nowIso,
            'modified': nowIso,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } catch (e, st) {
        debugPrint('StockAdjustment insert skipped: $e\n$st');
      }
    }
    await _insertLedgerRow(
      db,
      itemName: itemName,
      location: loc,
      signedQty: delta,
      rate: 0,
      referenceType: referenceType,
      referenceName: referenceName,
      date: nowIso,
      createdBy: createdBy,
      suffix: '1',
    );
  }

  Future<void> _insertLedgerRow(
    DatabaseExecutor db, {
    required String itemName,
    required String location,
    required double signedQty,
    required double rate,
    required String referenceType,
    required String referenceName,
    required String date,
    required String createdBy,
    required String suffix,
  }) async {
    final loc = _normalizeLocation(location);
    await _ensureLocation(db, loc, createdBy);
    final now = DateTime.now().toIso8601String();
    await db.insert(
      'StockLedgerEntry',
      {
        'name': 'SLE-$referenceName-$suffix',
        'date': date,
        'location': loc,
        'item': itemName,
        'rate': rate.toStringAsFixed(11),
        'quantity': signedQty,
        'referenceType': referenceType,
        'referenceName': referenceName,
        'createdBy': createdBy,
        'modifiedBy': createdBy,
        'created': now,
        'modified': now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _upsertPreviousStock(DatabaseExecutor db, StockItem stock) async {
    final now = DateTime.now();
    final nowIso = now.toIso8601String();
    final reportingDate = nowIso.substring(0, 10);
    final location =
        stock.location.trim().isEmpty ? defaultLocation : stock.location.trim();
    final recordName = '${stock.item}-$location-$reportingDate';
    const createdBy = 'local_user';
    await db.insert(
      'PreviousStock',
      {
        'name': recordName,
        'item': stock.item,
        'location': location,
        'previousQuantity': stock.quantity,
        'reportingDate': reportingDate,
        'uploadDate': nowIso,
        'uploadedBy': createdBy,
        'isActive': 1,
        'createdBy': createdBy,
        'modifiedBy': createdBy,
        'created': nowIso,
        'modified': nowIso,
        'notes': 'Live stock on-hand count',
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> _isServiceItem(Database db, String itemName) async {
    final rows = await db.rawQuery(
      'SELECT itemType FROM Item '
      'WHERE name = ? OR LOWER(name) = LOWER(?) LIMIT 1',
      [itemName, itemName],
    );
    if (rows.isEmpty) return true;
    final type =
        (rows.first['itemType']?.toString() ?? '').trim().toLowerCase();
    return type == 'service';
  }

  Future<bool> _isTrackableItem(
    Database db,
    String itemName, {
    required bool inbound,
  }) async {
    final rows = await db.rawQuery(
      'SELECT itemType, "for" AS purpose FROM Item '
      'WHERE name = ? OR LOWER(name) = LOWER(?) LIMIT 1',
      [itemName, itemName],
    );
    if (rows.isEmpty) return false;
    final type = (rows.first['itemType']?.toString() ?? '').trim().toLowerCase();
    if (type == 'service') return false;
    final purpose = (rows.first['purpose']?.toString() ?? '').trim().toLowerCase();
    if (inbound) {
      return purpose != 'sales';
    }
    return purpose != 'purchases' && purpose != 'purchase';
  }

  static bool _isTruthy(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is num) return value != 0;
    final raw = value.toString().trim().toLowerCase();
    return raw == '1' || raw == 'true';
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }
}
