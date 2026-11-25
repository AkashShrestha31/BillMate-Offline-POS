import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

/// Applies bundled [assets/data/books_schema.sql] to a SQLite database.
abstract final class LocalBooksSchemaExecutor {
  static const schemaAsset = 'assets/data/books_schema.sql';
  static const invoiceReturnTablesAsset = 'assets/data/invoice_return_tables.sql';
  static const backupChangeLogAsset = 'assets/data/backup_change_log.sql';

  static Future<void> apply(
    Database db, {
    bool ifNotExists = false,
    String assetPath = schemaAsset,
  }) async {
    final sql = await rootBundle.loadString(assetPath);
    final buffer = StringBuffer();
    for (final line in sql.split('\n')) {
      final trimmed = line.trim();
      if (trimmed.startsWith('--')) continue;
      buffer.writeln(line);
    }

    final chunks = buffer.toString().split(';');
    for (final chunk in chunks) {
      var statement = chunk.trim();
      if (statement.isEmpty) continue;

      if (ifNotExists &&
          RegExp(r'^CREATE\s+TABLE', caseSensitive: false).hasMatch(statement)) {
        statement = statement.replaceFirst(
          RegExp(r'^CREATE\s+TABLE', caseSensitive: false),
          'CREATE TABLE IF NOT EXISTS',
        );
      }

      await db.execute(statement);
    }
  }
}
