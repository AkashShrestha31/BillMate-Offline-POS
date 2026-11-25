import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/invoice/data/datasources/invoice_return_remote_data_source.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_return_check_model.dart';
import 'package:hotel/src/features/settings/domain/bank_account_service.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';
import 'package:hotel/src/features/setup/domain/local_books_schema_ensurer.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton(as: InvoiceReturnRemoteDataSource)
class InvoiceReturnLocalDataSource implements InvoiceReturnRemoteDataSource {
  InvoiceReturnLocalDataSource(this._db);

  final LocalDb _db;

  LiveStockTrackingService? get _stock {
    if (!getIt.isRegistered<LiveStockTrackingService>()) return null;
    return getIt<LiveStockTrackingService>();
  }

  @override
  Future<InvoiceReturnCheckData> checkReturn({
    required InvoiceType invoiceType,
    required String invoiceName,
  }) async {
    final db = await _db.database;
    final path = await LocalDb.databasePath();
    await LocalBooksSchemaEnsurer.ensureAllTables(db, databasePath: path);

    final isSales = invoiceType == InvoiceType.sales;
    final invTable = isSales ? 'SalesInvoice' : 'PurchaseInvoice';
    final itemTable = isSales ? 'SalesInvoiceItem' : 'PurchaseInvoiceItem';
    final returnTable = isSales ? 'SalesReturn' : 'PurchaseReturn';
    final returnItemTable = isSales ? 'SalesReturnItem' : 'PurchaseReturnItem';

    final invRows = await db.query(
      invTable,
      where: 'name = ?',
      whereArgs: [invoiceName],
      limit: 1,
    );
    if (invRows.isEmpty) {
      throw AppException(message: 'Invoice not found.');
    }

    final inv = invRows.first;
    if (_isTruthy(inv['cancelled'])) {
      throw AppException(message: 'Cancelled invoices cannot be returned.');
    }
    if (!_isTruthy(inv['submitted'])) {
      throw AppException(message: 'Only submitted invoices can be returned.');
    }

    final returnedByLine = await _returnedQtyByOriginalLine(
      db,
      returnTable: returnTable,
      returnItemTable: returnItemTable,
      invoiceName: invoiceName,
    );

    final itemRows = await db.query(
      itemTable,
      where: 'parent = ?',
      whereArgs: [invoiceName],
      orderBy: 'idx ASC',
    );

    final lines = <InvoiceReturnLine>[];
    for (final row in itemRows) {
      final lineId = row['name']?.toString() ?? '';
      if (lineId.isEmpty) continue;

      final qty = _toDouble(row['quantity']);
      final already = returnedByLine[lineId] ?? 0;
      final maxReturn = (qty - already).clamp(0.0, qty).toDouble();
      final rate = _toDouble(row['rate']);
      final amount = _toDouble(row['amount']);
      final itemCode = row['item']?.toString() ?? lineId;
      final unit = row['unit']?.toString() ?? 'Unit';

      lines.add(
        InvoiceReturnLine(
          lineId: lineId,
          displayName: itemCode,
          quantity: qty,
          alreadyReturnedQty: already,
          maxReturnQty: maxReturn,
          rate: rate,
          amount: amount > 0 ? amount : qty * rate,
          unit: unit,
          canReturn: maxReturn > 0.005,
        ),
      );
    }

    final grandTotal = _toDouble(inv['grandTotal']);
    final outstanding = _toDouble(inv['outstandingAmount']);
    final paidAmount = (grandTotal - outstanding).clamp(0.0, grandTotal).toDouble();

    final history = await _loadReturnHistory(
      db,
      returnTable: returnTable,
      returnItemTable: returnItemTable,
      invoiceName: invoiceName,
    );
    final alreadyReturnedAmount = history
        .where((h) => !_isCancelledStatus(h.status))
        .fold<double>(0, (s, h) => s + h.returnAmount);

    final summary = InvoiceReturnSummary(
      name: invoiceName,
      party: inv['party']?.toString(),
      date: inv['date']?.toString(),
      currency: inv['currency']?.toString() ?? 'NPR',
      grandTotal: grandTotal,
      outstandingAmount: outstanding,
      paidAmount: paidAmount,
      alreadyReturnedAmount: alreadyReturnedAmount,
      remainingReturnable: (grandTotal - alreadyReturnedAmount).clamp(0.0, grandTotal).toDouble(),
      paymentStatus: outstanding > 0.005 ? 'unpaid' : 'paid',
    );

    final data = InvoiceReturnCheckData(
      success: true,
      invoice: summary,
      items: lines,
      returnInvoices: history,
    );

    return data;
  }

  @override
  Future<String?> createReturn({
    required InvoiceType invoiceType,
    required CreateInvoiceReturnRequest body,
  }) async {
    if (body.items.isEmpty) {
      throw AppException(message: 'No return lines provided.');
    }

    final db = await _db.database;
    final path = await LocalDb.databasePath();
    await LocalBooksSchemaEnsurer.ensureAllTables(db, databasePath: path);

    final isSales = invoiceType == InvoiceType.sales;
    final invTable = isSales ? 'SalesInvoice' : 'PurchaseInvoice';
    final itemTable = isSales ? 'SalesInvoiceItem' : 'PurchaseInvoiceItem';
    final returnTable = isSales ? 'SalesReturn' : 'PurchaseReturn';
    final returnItemTable = isSales ? 'SalesReturnItem' : 'PurchaseReturnItem';
    final returnPrefix = isSales ? 'SRET' : 'PRET';

    final invRows = await db.query(
      invTable,
      where: 'name = ?',
      whereArgs: [body.invoiceName],
      limit: 1,
    );
    if (invRows.isEmpty) {
      throw AppException(message: 'Invoice not found.');
    }
    final inv = invRows.first;
    if (_isTruthy(inv['cancelled']) || !_isTruthy(inv['submitted'])) {
      throw AppException(message: 'Invoice is not eligible for return.');
    }

    final returnedByLine = await _returnedQtyByOriginalLine(
      db,
      returnTable: returnTable,
      returnItemTable: returnItemTable,
      invoiceName: body.invoiceName,
    );

    var netReturn = 0.0;
    for (final line in body.items) {
      if (line.returnQuantity <= 0.005) continue;

      final itemRows = await db.query(
        itemTable,
        where: 'name = ? AND parent = ?',
        whereArgs: [line.originalItemName, body.invoiceName],
        limit: 1,
      );
      if (itemRows.isEmpty) {
        throw AppException(message: 'Line ${line.originalItemName} not found on invoice.');
      }

      final soldQty = _toDouble(itemRows.first['quantity']);
      final already = returnedByLine[line.originalItemName] ?? 0;
      final maxReturn = soldQty - already;
      if (line.returnQuantity > maxReturn + 0.005) {
        throw AppException(
          message: 'Return quantity exceeds available for ${line.item}.',
        );
      }

      netReturn += line.returnQuantity * line.rate;
    }

    if (netReturn <= 0.005) {
      throw AppException(message: 'Return total must be greater than zero.');
    }

    final now = DateTime.now();
    final nowIso = now.toIso8601String();
    final returnDate = _normalizeDate(body.returnDate);
    final returnName = '$returnPrefix-${now.millisecondsSinceEpoch}';
    final party = inv['party']?.toString() ?? '';
    final outstanding = _toDouble(inv['outstandingAmount']);
    final refundMethod = body.refundMethod.trim().toLowerCase();
    final isUnpaid = outstanding > 0.005;

    final refundStatus = isUnpaid || refundMethod == 'none'
        ? 'no_refund'
        : refundMethod == 'credit'
            ? 'credit'
            : 'refunded';

    await db.transaction((txn) async {
      await txn.insert(returnTable, {
        'name': returnName,
        'party': party,
        'date': returnDate,
        'returnAgainst': body.invoiceName,
        'grandTotal': netReturn.toStringAsFixed(11),
        'reason': body.reason,
        'status': 'Returned',
        'refundStatus': refundStatus,
        'refundMethod': refundMethod,
        'refundPaymentMethod': body.refundPaymentMethod,
        'createdBy': body.createdBy,
        'modifiedBy': body.createdBy,
        'created': nowIso,
        'modified': nowIso,
        'submitted': 1,
        'cancelled': 0,
      });

      var idx = 0;
      for (final line in body.items) {
        if (line.returnQuantity <= 0.005) continue;
        idx++;
        final amount = line.returnQuantity * line.rate;
        await txn.insert(returnItemTable, {
          'name': '$returnName-$idx',
          'item': line.item,
          'originalItemName': line.originalItemName,
          'quantity': line.returnQuantity,
          'rate': line.rate.toStringAsFixed(11),
          'amount': amount.toStringAsFixed(11),
          'unit': line.unit,
          'idx': idx,
          'parent': returnName,
          'parentSchemaName': returnTable,
          'parentFieldname': 'items',
        });
      }

      final newOutstanding = isUnpaid
          ? (outstanding - netReturn).clamp(0.0, double.infinity)
          : outstanding;
      await txn.update(
        invTable,
        {'outstandingAmount': newOutstanding.toStringAsFixed(11), 'modified': nowIso},
        where: 'name = ?',
        whereArgs: [body.invoiceName],
      );

      if (!isUnpaid && refundMethod == 'cash') {
        final method = body.refundPaymentMethod ?? 'Cash';
        final paymentType = isSales ? 'Pay' : 'Receive';
        final account = isSales ? 'Debtors' : 'Creditors';
        await txn.insert('Payment', {
          'name': 'PAY-$returnName',
          'numberSeries': 'PAY-',
          'party': party,
          'date': returnDate.split('T').first,
          'paymentType': paymentType,
          'account': account,
          'paymentAccount': await _paymentAccountFor(method),
          'paymentMethod': method,
          'amount': netReturn.toStringAsFixed(11),
          'writeoff': '0.00000000000',
          'referenceType': returnTable,
          'referenceId': returnName,
          'createdBy': body.createdBy,
          'modifiedBy': body.createdBy,
          'created': nowIso,
          'modified': nowIso,
          'submitted': 1,
          'cancelled': 0,
        });
      }
    });

    await _stock?.applyReturnByName(
      returnName: returnName,
      isSales: isSales,
    );

    return 'Return $returnName created';
  }

  @override
  Future<String?> cancelReturn({
    required InvoiceType invoiceType,
    required String returnInvoiceName,
    required String cancelledBy,
  }) async {
    final db = await _db.database;
    final path = await LocalDb.databasePath();
    await LocalBooksSchemaEnsurer.ensureAllTables(db, databasePath: path);

    final isSales = invoiceType == InvoiceType.sales;
    final invTable = isSales ? 'SalesInvoice' : 'PurchaseInvoice';
    final returnTable = isSales ? 'SalesReturn' : 'PurchaseReturn';

    final rows = await db.query(
      returnTable,
      where: 'name = ?',
      whereArgs: [returnInvoiceName],
      limit: 1,
    );
    if (rows.isEmpty) {
      throw AppException(message: 'Return not found.');
    }
    final ret = rows.first;
    if (_isTruthy(ret['cancelled'])) {
      throw AppException(message: 'Return is already cancelled.');
    }

    final returnAmount = _toDouble(ret['grandTotal']);
    final invoiceName = ret['returnAgainst']?.toString() ?? '';
    final nowIso = DateTime.now().toIso8601String();

    await db.transaction((txn) async {
      await txn.update(
        returnTable,
        {
          'cancelled': 1,
          'status': 'Cancelled',
          'modified': nowIso,
          'modifiedBy': cancelledBy,
        },
        where: 'name = ?',
        whereArgs: [returnInvoiceName],
      );

      if (invoiceName.isNotEmpty && returnAmount > 0) {
        final invRows = await txn.query(
          invTable,
          where: 'name = ?',
          whereArgs: [invoiceName],
          limit: 1,
        );
        if (invRows.isNotEmpty) {
          final outstanding = _toDouble(invRows.first['outstandingAmount']);
          final grandTotal = _toDouble(invRows.first['grandTotal']);
          final refundStatus = ret['refundStatus']?.toString();
          final adjustedOutstanding = refundStatus == 'no_refund' || outstanding > 0.005;
          if (adjustedOutstanding) {
            final restored = (outstanding + returnAmount).clamp(0.0, grandTotal);
            await txn.update(
              invTable,
              {
                'outstandingAmount': restored.toStringAsFixed(11),
                'modified': nowIso,
              },
              where: 'name = ?',
              whereArgs: [invoiceName],
            );
          }
        }
      }

      await txn.update(
        'Payment',
        {'cancelled': 1, 'modified': nowIso},
        where: 'referenceType = ? AND referenceId = ?',
        whereArgs: [returnTable, returnInvoiceName],
      );
    });

    await _stock?.reverseDocument(
      referenceType: returnTable,
      referenceName: returnInvoiceName,
    );

    return 'Return cancelled';
  }

  Future<Map<String, double>> _returnedQtyByOriginalLine(
    Database db, {
    required String returnTable,
    required String returnItemTable,
    required String invoiceName,
  }) async {
    final result = <String, double>{};
    try {
      final rows = await db.rawQuery('''
        SELECT ri.originalItemName AS lineId, SUM(ri.quantity) AS total
        FROM $returnItemTable ri
        INNER JOIN $returnTable r ON ri.parent = r.name
        WHERE r.returnAgainst = ? AND r.cancelled = 0 AND r.submitted = 1
        GROUP BY ri.originalItemName
      ''', [invoiceName]);

      for (final row in rows) {
        final lineId = row['lineId']?.toString();
        if (lineId == null || lineId.isEmpty) continue;
        result[lineId] = _toDouble(row['total']);
      }
    } catch (_) {
      // Tables may not exist on very old DBs until ensurer runs.
    }
    return result;
  }

  Future<List<InvoiceReturnHistoryEntry>> _loadReturnHistory(
    Database db, {
    required String returnTable,
    required String returnItemTable,
    required String invoiceName,
  }) async {
    try {
      final rows = await db.query(
        returnTable,
        where: 'returnAgainst = ?',
        whereArgs: [invoiceName],
        orderBy: 'date DESC',
      );

      final entries = <InvoiceReturnHistoryEntry>[];
      for (final row in rows) {
        final returnName = row['name']?.toString() ?? '';
        final refundStatus = row['refundStatus']?.toString();
        final refundMethod = row['refundMethod']?.toString();
        final refundAmount = _toDouble(row['grandTotal']);
        final isRefunded = refundStatus == 'refunded';

        final itemRows = await db.query(
          returnItemTable,
          where: 'parent = ?',
          whereArgs: [returnName],
          orderBy: 'idx ASC',
        );

        final items = itemRows
            .map(
              (item) => InvoiceReturnHistoryLine(
                item: item['item']?.toString() ?? '—',
                quantity: _toDouble(item['quantity']),
                rate: _toDouble(item['rate']),
                unit: item['unit']?.toString() ?? 'Unit',
              ),
            )
            .toList();

        entries.add(
          InvoiceReturnHistoryEntry(
            name: returnName,
            returnAmount: refundAmount,
            date: row['date']?.toString(),
            status: row['status']?.toString(),
            refundStatus: refundStatus,
            refund: isRefunded
                ? InvoiceReturnRefundInfo(
                    refundAmount: refundAmount,
                    paymentMethod: row['refundPaymentMethod']?.toString(),
                    status: refundStatus,
                    date: row['date']?.toString(),
                  )
                : refundMethod == 'none' || refundStatus == 'no_refund'
                    ? const InvoiceReturnRefundInfo(status: 'no_refund')
                    : null,
            items: items,
          ),
        );
      }
      return entries;
    } catch (_) {
      return const [];
    }
  }

  Future<String> _paymentAccountFor(String paymentMethod) async {
    if (!getIt.isRegistered<BankAccountService>()) {
      return paymentMethod == 'Cash' ? 'Cash In Hand' : paymentMethod;
    }
    return getIt<BankAccountService>().paymentAccountForMethod(paymentMethod);
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  static String _normalizeDate(String raw) {
    final trimmed = raw.trim();
    final parsed = DateTime.tryParse(trimmed);
    if (parsed != null) return parsed.toIso8601String();
    return DateTime.now().toIso8601String();
  }

  static bool _isCancelledStatus(String? status) {
    final s = (status ?? '').toLowerCase().trim();
    return s == 'cancelled' || s == 'canceled';
  }

  static bool _isTruthy(dynamic value) => value == true || value == 1 || value == '1';
}
