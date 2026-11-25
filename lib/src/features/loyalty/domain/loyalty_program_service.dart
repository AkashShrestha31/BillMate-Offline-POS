import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_features.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_math.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_program.dart';
import 'package:hotel/src/features/setup/domain/default_books_single_values.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

/// Local loyalty programs, settings, balances, and invoice earn/redeem.
@lazySingleton
class LoyaltyProgramService {
  LoyaltyProgramService(this._db);

  final LocalDb _db;

  static const defaultExpenseAccount = 'Discounts';
  static const _defaultPrograms = <String>[
    'Bronze Member',
    'Silver Member',
    'Gold Member',
    'Platinum Member',
  ];

  Future<bool> isEnabled() async {
    if (!LoyaltyFeatures.enabled) return false;
    final db = await _db.database;
    return DefaultBooksSingleValues.readBool(
      db,
      parent: 'AccountingSettings',
      fieldname: 'enableLoyaltyProgram',
      defaultValue: false,
    );
  }

  Future<void> setEnabled(bool enabled) async {
    if (!LoyaltyFeatures.enabled) return;
    final db = await _db.database;
    final now = DateTime.now().toIso8601String();
    final updated = await db.update(
      'SingleValue',
      {
        'value': enabled ? '1' : '0',
        'modified': now,
        'modifiedBy': 'system',
      },
      where: 'parent = ? AND fieldname = ?',
      whereArgs: ['AccountingSettings', 'enableLoyaltyProgram'],
    );
    if (updated > 0) return;
    await db.insert('SingleValue', {
      'name': 'AccountingSettings-enableLoyaltyProgram',
      'parent': 'AccountingSettings',
      'fieldname': 'enableLoyaltyProgram',
      'value': enabled ? '1' : '0',
      'created': now,
      'modified': now,
      'createdBy': 'system',
      'modifiedBy': 'system',
    });
  }

  Future<List<LoyaltyProgram>> listPrograms({bool enabledOnly = false}) async {
    if (!LoyaltyFeatures.enabled) return const [];
    await ensureDefaultPrograms();
    final db = await _db.database;
    final rows = await db.query(
      'LoyaltyProgram',
      orderBy: 'name ASC',
    );
    final programs = rows.map(_fromRow).toList();
    if (!enabledOnly) return programs;
    final today = DateTime.now();
    return programs.where((p) => p.isActiveOn(today)).toList();
  }

  Future<LoyaltyProgram?> getProgram(String? name) async {
    if (!LoyaltyFeatures.enabled) return null;
    final key = name?.trim();
    if (key == null || key.isEmpty) return null;
    final db = await _db.database;
    final rows = await db.query(
      'LoyaltyProgram',
      where: 'name = ?',
      whereArgs: [key],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return _fromRow(rows.first);
  }

  Future<LoyaltyProgram> createProgram({
    required String name,
    double conversionFactor = 1,
    int expiryDurationMonths = 12,
    String? expenseAccount,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    if (!LoyaltyFeatures.enabled) {
      throw StateError('Loyalty is temporarily disabled');
    }
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Loyalty program name is required');
    }
    final existing = await getProgram(trimmed);
    if (existing != null) return existing;

    final db = await _db.database;
    final account = await _resolveExpenseAccount(db, expenseAccount);
    final now = DateTime.now();
    final from = fromDate ?? DateTime(now.year, 1, 1);
    final to = toDate ?? DateTime(now.year + 10, 12, 31);
    final factor = conversionFactor <= 0 ? 1.0 : conversionFactor;

    await db.insert(
      'LoyaltyProgram',
      {
        'name': trimmed,
        'fromDate': _dateOnly(from),
        'toDate': _dateOnly(to),
        'isEnabled': 1,
        'conversionFactor': factor,
        'expiryDuration': expiryDurationMonths <= 0 ? 12 : expiryDurationMonths,
        'expenseAccount': account,
        'createdBy': 'system',
        'modifiedBy': 'system',
        'created': now.toIso8601String(),
        'modified': now.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    if (!await isEnabled()) {
      await setEnabled(true);
    }
    return (await getProgram(trimmed))!;
  }

  Future<void> ensureDefaultPrograms() async {
    if (!LoyaltyFeatures.enabled) return;
    final db = await _db.database;
    final count = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) AS c FROM LoyaltyProgram'),
        ) ??
        0;
    if (count > 0) return;
    for (final name in _defaultPrograms) {
      await createProgram(name: name);
    }
  }

  Future<PartyLoyaltySnapshot> snapshotForParty(String partyName) async {
    if (!LoyaltyFeatures.enabled) {
      return PartyLoyaltySnapshot(partyName: partyName.trim(), points: 0);
    }
    final name = partyName.trim();
    if (name.isEmpty) {
      return const PartyLoyaltySnapshot(partyName: '', points: 0);
    }
    final db = await _db.database;
    final rows = await db.query(
      'Party',
      columns: ['loyaltyProgram', 'loyaltyPoints'],
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );
    if (rows.isEmpty) {
      return PartyLoyaltySnapshot(partyName: name, points: 0);
    }
    final programName = rows.first['loyaltyProgram']?.toString();
    final points = _toInt(rows.first['loyaltyPoints']);
    final program = await getProgram(programName);
    return PartyLoyaltySnapshot(
      partyName: name,
      points: points,
      program: program,
    );
  }

  /// Applies earn / redeem after a sales invoice is written.
  Future<void> applyInvoiceLoyalty({
    required String invoiceName,
    required String partyName,
    required double eligibleAmount,
    required bool submitted,
    required String createdBy,
    String? programName,
    int redeemPoints = 0,
  }) async {
    if (!LoyaltyFeatures.enabled) return;
    if (!await isEnabled()) return;
    if (!submitted) return;

    final party = partyName.trim();
    final invoice = invoiceName.trim();
    if (party.isEmpty || invoice.isEmpty) return;

    final snapshot = await snapshotForParty(party);
    final program = (programName != null && programName.trim().isNotEmpty)
        ? await getProgram(programName)
        : snapshot.program;
    if (program == null || !program.isActiveOn(DateTime.now())) return;

    final db = await _db.database;
    final now = DateTime.now();
    final nowIso = now.toIso8601String();
    final postingDate = _dateOnly(now);
    var balance = snapshot.points;
    final factor = program.conversionFactor <= 0 ? 1.0 : program.conversionFactor;

    final redeem = redeemPoints.clamp(0, balance);
    if (redeem > 0) {
      balance -= redeem;
      await _insertPointEntry(
        db: db,
        name: 'LPE-RDM-$invoice',
        programName: program.name,
        customer: party,
        invoice: invoice,
        points: -redeem,
        purchaseAmount: LoyaltyMath.amountFromPoints(redeem, factor),
        postingDate: postingDate,
        expiryDate: null,
        createdBy: createdBy,
        now: nowIso,
      );
    }

    final earnEligible = (eligibleAmount).clamp(0.0, double.infinity);
    final earned = LoyaltyMath.pointsFromAmount(earnEligible, factor);
    if (earned > 0) {
      balance += earned;
      final expiry = DateTime(now.year, now.month + program.expiryDuration, now.day);
      await _insertPointEntry(
        db: db,
        name: 'LPE-ERN-$invoice',
        programName: program.name,
        customer: party,
        invoice: invoice,
        points: earned,
        purchaseAmount: earnEligible,
        postingDate: postingDate,
        expiryDate: _dateOnly(expiry),
        createdBy: createdBy,
        now: nowIso,
      );
    }

    await db.update(
      'Party',
      {
        'loyaltyPoints': balance,
        'loyaltyProgram': program.name,
        'modified': nowIso,
        'modifiedBy': createdBy,
      },
      where: 'name = ?',
      whereArgs: [party],
    );
  }

  Future<String> _resolveExpenseAccount(Database db, String? preferred) async {
    final candidates = <String>[
      if (preferred != null && preferred.trim().isNotEmpty) preferred.trim(),
      defaultExpenseAccount,
      'Sales Expenses',
      'Miscellaneous Expenses',
      'Cost of Goods Sold',
    ];
    for (final name in candidates) {
      final rows = await db.query(
        'Account',
        columns: ['name'],
        where: 'name = ?',
        whereArgs: [name],
        limit: 1,
      );
      if (rows.isNotEmpty) return name;
    }
    final any = await db.query(
      'Account',
      columns: ['name'],
      where: 'isGroup = 0',
      limit: 1,
    );
    if (any.isEmpty) {
      throw StateError('No expense account available for loyalty program');
    }
    return any.first['name']!.toString();
  }

  Future<void> _insertPointEntry({
    required Database db,
    required String name,
    required String programName,
    required String customer,
    required String invoice,
    required int points,
    required double purchaseAmount,
    required String postingDate,
    required String? expiryDate,
    required String createdBy,
    required String now,
  }) async {
    await db.insert(
      'LoyaltyPointEntry',
      {
        'name': name,
        'loyaltyProgram': programName,
        'customer': customer,
        'invoice': invoice,
        'loyaltyPoints': points,
        'purchaseAmount': purchaseAmount.toStringAsFixed(11),
        'postingDate': postingDate,
        'expiryDate': expiryDate,
        'createdBy': createdBy,
        'modifiedBy': createdBy,
        'created': now,
        'modified': now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  LoyaltyProgram _fromRow(Map<String, Object?> row) {
    return LoyaltyProgram(
      name: row['name']?.toString() ?? '',
      fromDate: row['fromDate']?.toString() ?? '',
      toDate: row['toDate']?.toString() ?? '',
      isEnabled: _toBool(row['isEnabled']),
      conversionFactor: _toDouble(row['conversionFactor'], fallback: 1),
      expiryDuration: _toInt(row['expiryDuration'], fallback: 12),
      expenseAccount: row['expenseAccount']?.toString() ?? defaultExpenseAccount,
    );
  }

  static String _dateOnly(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static bool _toBool(Object? value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    final s = value?.toString().trim().toLowerCase();
    return s == '1' || s == 'true' || s == 'yes';
  }

  static int _toInt(Object? value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is num) return value.round();
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }

  static double _toDouble(Object? value, {double fallback = 0}) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? fallback;
  }
}
