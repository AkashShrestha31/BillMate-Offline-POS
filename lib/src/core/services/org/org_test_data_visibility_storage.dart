import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

/// Per-organization preference: whether Test Data UI is shown in More / setup.
class OrgTestDataVisibilityStorage {
  OrgTestDataVisibilityStorage._();

  static const _prefsPrefix = 'org_show_test_data_';
  static const singleValueParent = 'Organization';
  static const singleValueField = 'showTestData';
  static const singleValueRowName = 'Organization-showTestData';

  /// True unless the user explicitly hides Test Data for this org (More → ✕).
  static Future<bool> shouldShow({String? orgSlug}) async {
    final slug = await _resolveSlug(orgSlug);
    if (slug == null) return true;

    final prefs = await SharedPreferences.getInstance();
    final key = '$_prefsPrefix$slug';
    if (prefs.containsKey(key)) {
      return prefs.getBool(key) ?? true;
    }

    return true;
  }

  static Future<void> setShow(bool show, {String? orgSlug}) async {
    final slug = await _resolveSlug(orgSlug);
    if (slug == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_prefsPrefix$slug', show);
    await _writeToLocalDb(show);
  }

  static Future<String?> _resolveSlug(String? orgSlug) async {
    final slug = orgSlug ?? await OrgStorage.getOrgSlug();
    if (slug == null || slug.trim().isEmpty) return null;
    return slug.trim();
  }

  static Future<bool> _readFromLocalDb() async {
    try {
      final db = await getIt<LocalDb>().database;
      final rows = await db.query(
        'SingleValue',
        where: 'parent = ? AND fieldname = ?',
        whereArgs: [singleValueParent, singleValueField],
        limit: 1,
      );
      if (rows.isEmpty) return true;
      final v = rows.first['value']?.toString().trim();
      return v != '0' && v != 'false';
    } catch (_) {
      return true;
    }
  }

  static Future<void> _writeToLocalDb(bool show) async {
    try {
      final db = await getIt<LocalDb>().database;
      final now = DateTime.now().toIso8601String();
      final value = show ? '1' : '0';
      final rows = await db.query(
        'SingleValue',
        where: 'parent = ? AND fieldname = ?',
        whereArgs: [singleValueParent, singleValueField],
        limit: 1,
      );
      if (rows.isNotEmpty) {
        await db.update(
          'SingleValue',
          {
            'value': value,
            'modified': now,
            'modifiedBy': 'system',
          },
          where: 'parent = ? AND fieldname = ?',
          whereArgs: [singleValueParent, singleValueField],
        );
      } else {
        await db.insert(
          'SingleValue',
          {
            'name': singleValueRowName,
            'parent': singleValueParent,
            'fieldname': singleValueField,
            'value': value,
            'created': now,
            'modified': now,
            'createdBy': 'system',
            'modifiedBy': 'system',
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } catch (_) {
      // DB may not exist yet during very early bootstrap.
    }
  }
}
