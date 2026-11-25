import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:injectable/injectable.dart';

/// Reads and updates `SystemSettings` SingleValue rows.
@lazySingleton
class SystemSettingsService {
  SystemSettingsService(this._db);

  final LocalDb _db;

  static const minDisplayPrecision = 0;
  static const maxDisplayPrecision = 5;
  static const defaultDisplayPrecision = 2;

  Future<int> loadDisplayPrecision() async {
    final db = await _db.database;
    final raw = await _readField(db, 'displayPrecision');
    final parsed = int.tryParse(raw ?? '');
    if (parsed == null) return defaultDisplayPrecision;
    return parsed.clamp(minDisplayPrecision, maxDisplayPrecision);
  }

  Future<void> updateDisplayPrecision(int value) async {
    if (value < minDisplayPrecision || value > maxDisplayPrecision) {
      throw ArgumentError(
        'Display precision must be between '
        '$minDisplayPrecision and $maxDisplayPrecision',
      );
    }

    final db = await _db.database;
    final now = DateTime.now().toIso8601String();
    await _upsert(
      db,
      fieldname: 'displayPrecision',
      value: value.toString(),
      now: now,
    );
    AppMoneyFormat.apply(value);
  }

  Future<String?> _readField(dynamic db, String fieldname) async {
    final rows = await db.query(
      'SingleValue',
      columns: ['value'],
      where: 'parent = ? AND fieldname = ?',
      whereArgs: ['SystemSettings', fieldname],
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
      whereArgs: ['SystemSettings', fieldname],
    );
    if (updated > 0) return;

    await db.insert('SingleValue', {
      'name': 'SystemSettings-$fieldname',
      'parent': 'SystemSettings',
      'fieldname': fieldname,
      'value': value,
      'created': now,
      'modified': now,
      'createdBy': 'system',
      'modifiedBy': 'system',
    });
  }
}

SystemSettingsService get systemSettingsService => getIt<SystemSettingsService>();
