import 'dart:convert';

import 'package:hotel/src/core/config/app_platform_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:sqflite/sqflite.dart';

/// Default `SingleValue` rows aligned with backend `insert_initial_books_data`.
abstract final class DefaultBooksSingleValues {
  static const _settingsAsset = 'assets/data/default_books_settings.json';
  static String get _logoAsset => AppPlatformConfig.logoAsset;

  static Map<String, Map<String, String>>? _cachedDefaults;

  /// Loads bundled defaults, applies [overrides], and encodes values for SQLite.
  static Future<Map<String, Map<String, String>>> all({
    required Map<String, Map<String, String>> overrides,
  }) async {
    final base = await _loadDefaultsFromAsset();
    final merged = <String, Map<String, String>>{};
    for (final entry in base.entries) {
      merged[entry.key] = Map<String, String>.from(entry.value);
    }
    for (final entry in overrides.entries) {
      merged.putIfAbsent(entry.key, () => {});
      merged[entry.key]!.addAll(entry.value);
    }
    return merged;
  }

  /// Inserts any missing default rows without overwriting existing values.
  static Future<void> ensureMissingDefaults(LocalDb db) async {
    if (!await LocalDb.databaseFileExists()) return;
    await ensureMissingOnDatabase(
      await db.database,
      createdBy: 'system',
    );
  }

  /// Inserts any missing default rows without overwriting existing values.
  static Future<void> ensureMissingOnDatabase(
    Database database, {
    Map<String, Map<String, String>> overrides = const {},
    String createdBy = 'system',
  }) async {
    final defaults = await all(overrides: overrides);
    final now = DateTime.now().toIso8601String();

    for (final parentEntry in defaults.entries) {
      for (final fieldEntry in parentEntry.value.entries) {
        final value = fieldEntry.value;
        if (value.isEmpty && fieldEntry.key != 'logo') continue;

        final rows = await database.query(
          'SingleValue',
          where: 'parent = ? AND fieldname = ?',
          whereArgs: [parentEntry.key, fieldEntry.key],
          limit: 1,
        );
        if (rows.isNotEmpty) continue;

        if (kDebugMode) {
          debugPrint(
            '[SingleValue] ensureMissingOnDatabase insert '
            '${parentEntry.key}.${fieldEntry.key}',
          );
        }

        await database.insert('SingleValue', {
          'name': '${parentEntry.key}-${fieldEntry.key}',
          'parent': parentEntry.key,
          'fieldname': fieldEntry.key,
          'value': value,
          'created': now,
          'modified': now,
          'createdBy': createdBy,
          'modifiedBy': createdBy,
        });
      }
    }
  }

  static Future<Map<String, Map<String, String>>> _loadDefaultsFromAsset() async {
    if (_cachedDefaults != null) return _cachedDefaults!;

    final raw = await rootBundle.loadString(_settingsAsset);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final result = <String, Map<String, String>>{};

    for (final parentEntry in decoded.entries) {
      final fields = parentEntry.value as Map<String, dynamic>;
      result[parentEntry.key] = {
        for (final field in fields.entries)
          field.key: encodeValue(field.value),
      };
    }

    final logo = await _defaultPrintLogoDataUrl();
    if (logo != null && logo.isNotEmpty) {
      result.putIfAbsent('PrintSettings', () => {});
      final current = result['PrintSettings']!['logo'];
      if (current == null || current.isEmpty) {
        result['PrintSettings']!['logo'] = logo;
      }
    }

    _cachedDefaults = result;
    return result;
  }

  static Future<String?> _defaultPrintLogoDataUrl() async {
    try {
      final bytes = await rootBundle.load(_logoAsset);
      final b64 = base64Encode(bytes.buffer.asUint8List());
      return 'data:image/png;base64,$b64';
    } catch (_) {
      return null;
    }
  }

  static String encodeValue(Object? value) {
    if (value == null) return '';
    if (value is bool) return value ? '1' : '0';
    if (value is num) return value.toString();
    return value.toString();
  }

  /// Reads a boolean `SingleValue` field (`1`, `true`, `1.0`).
  static Future<bool> readBool(
    Database db, {
    required String parent,
    required String fieldname,
    bool defaultValue = false,
  }) async {
    final rows = await db.query(
      'SingleValue',
      columns: ['value'],
      where: 'parent = ? AND fieldname = ?',
      whereArgs: [parent, fieldname],
      limit: 1,
    );
    if (rows.isEmpty) return defaultValue;
    final raw = rows.first['value']?.toString().trim().toLowerCase();
    if (raw == null || raw.isEmpty) return defaultValue;
    return raw == '1' || raw == 'true' || raw == '1.0';
  }
}
