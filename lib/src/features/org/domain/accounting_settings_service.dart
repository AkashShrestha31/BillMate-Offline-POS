import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/setup/domain/default_books_single_values.dart';
import 'package:injectable/injectable.dart';

/// Reads and updates fiscal year dates stored in `AccountingSettings` SingleValue rows.
@lazySingleton
class AccountingSettingsService {
  AccountingSettingsService(this._db);

  final LocalDb _db;

  Future<({String fiscalYearStart, String fiscalYearEnd})> loadFiscalYear() async {
    final db = await _db.database;
    final start = await _readField(db, 'fiscalYearStart') ?? '2025-04-01';
    final end = await _readField(db, 'fiscalYearEnd') ?? '2026-03-31';
    return (fiscalYearStart: start, fiscalYearEnd: end);
  }

  Future<bool> loadEnableInvoiceReturns() async {
    final db = await _db.database;
    return DefaultBooksSingleValues.readBool(
      db,
      parent: 'AccountingSettings',
      fieldname: 'enableInvoiceReturns',
      defaultValue: true,
    );
  }

  Future<void> updateEnableInvoiceReturns(bool enabled) async {
    final db = await _db.database;
    final now = DateTime.now().toIso8601String();
    await _upsert(
      db,
      fieldname: 'enableInvoiceReturns',
      value: enabled ? '1' : '0',
      now: now,
    );
  }

  Future<bool> loadEnableLoyaltyProgram() async {
    final db = await _db.database;
    return DefaultBooksSingleValues.readBool(
      db,
      parent: 'AccountingSettings',
      fieldname: 'enableLoyaltyProgram',
      defaultValue: false,
    );
  }

  Future<void> updateEnableLoyaltyProgram(bool enabled) async {
    final db = await _db.database;
    final now = DateTime.now().toIso8601String();
    await _upsert(
      db,
      fieldname: 'enableLoyaltyProgram',
      value: enabled ? '1' : '0',
      now: now,
    );
  }

  Future<void> updateFiscalYear({
    required String fiscalYearStart,
    required String fiscalYearEnd,
  }) async {
    final start = fiscalYearStart.trim();
    final end = fiscalYearEnd.trim();
    if (start.isEmpty || end.isEmpty) {
      throw ArgumentError('Fiscal year start and end are required');
    }

    final db = await _db.database;
    final now = DateTime.now().toIso8601String();
    await _upsert(db, fieldname: 'fiscalYearStart', value: start, now: now);
    await _upsert(db, fieldname: 'fiscalYearEnd', value: end, now: now);
  }

  Future<String?> _readField(dynamic db, String fieldname) async {
    final rows = await db.query(
      'SingleValue',
      columns: ['value'],
      where: 'parent = ? AND fieldname = ?',
      whereArgs: ['AccountingSettings', fieldname],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    final value = rows.first['value']?.toString().trim();
    return (value == null || value.isEmpty) ? null : value;
  }

  Future<void> _upsert(
    dynamic db, {
    required String fieldname,
    required String value,
    required String now,
  }) async {
    final updated = await db.update(
      'SingleValue',
      {
        'value': value,
        'modified': now,
        'modifiedBy': 'system',
      },
      where: 'parent = ? AND fieldname = ?',
      whereArgs: ['AccountingSettings', fieldname],
    );
    if (updated > 0) return;

    await db.insert('SingleValue', {
      'name': 'AccountingSettings-$fieldname',
      'parent': 'AccountingSettings',
      'fieldname': fieldname,
      'value': value,
      'created': now,
      'modified': now,
      'createdBy': 'system',
      'modifiedBy': 'system',
    });
  }
}

/// Convenience after DI is ready.
AccountingSettingsService get accountingSettingsService =>
    getIt<AccountingSettingsService>();
