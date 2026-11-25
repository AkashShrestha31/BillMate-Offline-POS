import 'dart:io';

import 'package:sqflite/sqflite.dart';

/// Validates that an on-device books database is complete enough to use.
abstract final class LocalBooksDatabaseHealth {
  static const coreTables = <String>[
    'Employee',
    'SingleValue',
    'Party',
    'Account',
  ];

  static Future<bool> hasCoreTables(Database db) async {
    for (final table in coreTables) {
      final rows = await db.rawQuery(
        "SELECT 1 FROM sqlite_master WHERE type='table' AND name=? LIMIT 1",
        [table],
      );
      if (rows.isEmpty) return false;
    }
    return true;
  }

  static Future<bool> hasEmployeeRecords(Database db) async {
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM Employee'),
    );
    return (count ?? 0) > 0;
  }

  static Future<bool> isHealthyDatabase(Database db) async {
    if (!await hasCoreTables(db)) return false;
    return hasEmployeeRecords(db);
  }

  static Future<bool> isHealthyAtPath(String path) async {
    if (!File(path).existsSync()) return false;

    Database? db;
    try {
      db = await openDatabase(path, readOnly: true);
      return await isHealthyDatabase(db);
    } catch (_) {
      return false;
    } finally {
      await db?.close();
    }
  }
}
