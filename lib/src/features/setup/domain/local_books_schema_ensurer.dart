import 'package:hotel/src/features/setup/domain/local_books_schema_executor.dart';
import 'package:sqflite/sqflite.dart';

/// Ensures every table from [books_schema.sql] exists (repairs partial / legacy DBs).
class LocalBooksSchemaEnsurer {
  LocalBooksSchemaEnsurer._();

  static final Set<String> _syncedPaths = <String>{};

  /// Creates any missing tables without dropping existing data.
  static Future<void> ensureAllTables(
    Database db, {
    required String databasePath,
  }) async {
    if (_syncedPaths.contains(databasePath)) return;

    await LocalBooksSchemaExecutor.apply(db, ifNotExists: true);
    await LocalBooksSchemaExecutor.apply(
      db,
      ifNotExists: true,
      assetPath: LocalBooksSchemaExecutor.invoiceReturnTablesAsset,
    );
    await LocalBooksSchemaExecutor.apply(
      db,
      ifNotExists: true,
      assetPath: LocalBooksSchemaExecutor.backupChangeLogAsset,
    );
    await _ensureItemFavoriteColumn(db);
    await _ensureItemColumn(db, 'barcode', 'TEXT');
    await _ensureItemColumn(db, 'hsnCode', 'TEXT');
    await _ensureItemColumn(db, 'description', 'TEXT');
    _syncedPaths.add(databasePath);
  }

  static Future<void> _ensureItemColumn(
    Database db,
    String column,
    String type,
  ) async {
    try {
      final info = await db.rawQuery('PRAGMA table_info("Item")');
      final has = info.any((row) => (row['name']?.toString() ?? '') == column);
      if (has) return;
      await db.execute('ALTER TABLE "Item" ADD COLUMN $column $type');
    } catch (_) {}
  }

  static Future<void> _ensureItemFavoriteColumn(Database db) async {
    try {
      final info = await db.rawQuery('PRAGMA table_info("Item")');
      final has = info.any((row) => (row['name']?.toString() ?? '') == 'isFavorite');
      if (has) return;
      await db.execute(
        'ALTER TABLE "Item" ADD COLUMN isFavorite INTEGER NOT NULL DEFAULT 0',
      );
    } catch (_) {}
  }

  /// Call when switching organization databases in the same session.
  static void resetSessionCache() {
    _syncedPaths.clear();
  }
}
