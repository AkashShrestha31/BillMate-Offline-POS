import 'package:hotel/src/features/backup/domain/backup_excluded_tables.dart';
import 'package:hotel/src/features/setup/domain/local_books_schema_executor.dart';
import 'package:sqflite/sqflite.dart';

/// One collapsed row mutation since the last backup checkpoint.
class BackupChangeEntry {
  const BackupChangeEntry({
    required this.logId,
    required this.tableName,
    required this.rowKey,
    required this.operation,
    required this.changedAt,
  });

  final int logId;
  final String tableName;
  final String rowKey;

  /// `upsert` or `delete`.
  final String operation;
  final String changedAt;

  bool get isDelete => operation == 'delete';
}

/// Reads and maintains [BackupChangeLog] for fast incremental backup.
abstract final class BackupChangeLogService {
  static const logTable = 'BackupChangeLog';

  static final Set<String> _installedPaths = <String>{};
  static Future<void> _installChain = Future<void>.value();

  static const _internalTables = {
    logTable,
    'sqlite_sequence',
  };

  static bool shouldSkipTable(String tableName) {
    final lower = tableName.toLowerCase();
    if (_internalTables.contains(tableName)) return true;
    if (lower.startsWith('sqlite_')) return true;
    return BackupExcludedTables.shouldSkip(tableName);
  }

  /// Creates the log table and AFTER INSERT/UPDATE/DELETE triggers on user tables.
  static Future<void> ensureInstalled(
    Database db, {
    required String databasePath,
  }) async {
    if (_installedPaths.contains(databasePath)) return;

    final run = _installChain.then((_) async {
      if (_installedPaths.contains(databasePath)) return;

      await LocalBooksSchemaExecutor.apply(
        db,
        ifNotExists: true,
        assetPath: LocalBooksSchemaExecutor.backupChangeLogAsset,
      );

      final tables = await _listUserTables(db);
      for (final table in tables) {
        if (shouldSkipTable(table)) continue;
        await _ensureTriggersForTable(db, table);
      }

      _installedPaths.add(databasePath);
    });
    _installChain = run.then((_) {}, onError: (_) {});
    await run;
  }

  static void resetSessionCache() => _installedPaths.clear();

  /// Drops incremental-backup triggers so they can be recreated after a migration.
  static Future<void> dropAllTriggers(Database db) async {
    final rows = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type = 'trigger' AND name LIKE 'trg_bcl_%'",
    );
    for (final row in rows) {
      final name = row['name']?.toString();
      if (name == null || name.isEmpty) continue;
      await db.execute('DROP TRIGGER IF EXISTS "$name"');
    }
  }

  static Future<int> maxLogId(Database db) async {
    final row = await db.rawQuery('SELECT MAX(id) AS m FROM "$logTable"');
    return (row.first['m'] as int?) ?? 0;
  }

  static Future<int> pendingCount(Database db, {required int sinceLogId}) async {
    final row = await db.rawQuery(
      'SELECT COUNT(*) AS c FROM "$logTable" WHERE id > ?',
      [sinceLogId],
    );
    return (row.first['c'] as int?) ?? 0;
  }

  /// Distinct (table, row) pairs changed since [sinceLogId] — matches delta export.
  static Future<int> pendingUniqueRowCount(
    Database db, {
    required int sinceLogId,
  }) async {
    final changes = await readCollapsedDelta(db, sinceLogId: sinceLogId);
    return changes.length;
  }

  /// Latest operation per (table, row) since [sinceLogId].
  static Future<List<BackupChangeEntry>> readCollapsedDelta(
    Database db, {
    required int sinceLogId,
  }) async {
    final rows = await db.query(
      logTable,
      where: 'id > ?',
      whereArgs: [sinceLogId],
      orderBy: 'id ASC',
    );
    if (rows.isEmpty) return const [];

    final latest = <String, BackupChangeEntry>{};
    for (final row in rows) {
      final table = row['table_name']?.toString() ?? '';
      final key = row['row_key']?.toString() ?? '';
      if (table.isEmpty || key.isEmpty) continue;

      final id = row['id'] as int? ?? 0;
      latest['$table|$key'] = BackupChangeEntry(
        logId: id,
        tableName: table,
        rowKey: key,
        operation: row['operation']?.toString() ?? 'upsert',
        changedAt: row['changed_at']?.toString() ?? '',
      );
    }
    return latest.values.toList(growable: false);
  }

  static Future<void> pruneThrough(Database db, int throughLogId) async {
    if (throughLogId <= 0) return;
    await db.delete(
      logTable,
      where: 'id <= ?',
      whereArgs: [throughLogId],
    );
  }

  static Future<List<String>> _listUserTables(Database db) async {
    final rows = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%' ORDER BY name",
    );
    return rows
        .map((row) => row['name']?.toString() ?? '')
        .where((name) => name.isNotEmpty)
        .toList(growable: false);
  }

  static Future<void> _ensureTriggersForTable(Database db, String table) async {
    final escaped = table.replaceAll('"', '""');
    final columns = await _listColumns(db, table);
    final hasName = columns.contains('name');
    final hasId = columns.contains('id');
    final hasValue = columns.contains('value');
    final hasCreatedBy = columns.contains('createdBy');
    final hasCreatedBySnake = columns.contains('created_by');
    final hasModifiedBy = columns.contains('modifiedBy');
    final hasModifiedBySnake = columns.contains('modified_by');

    final newKey = _rowKeySql('NEW', hasName: hasName, hasId: hasId);
    final oldKey = _rowKeySql('OLD', hasName: hasName, hasId: hasId);
    final suffix = _triggerSuffix(table);

    final insertWhen = _systemInsertWhen(
      hasCreatedBy: hasCreatedBy,
      hasCreatedBySnake: hasCreatedBySnake,
    );
    final updateWhen = _meaningfulUpdateWhen(
      columns: columns,
      hasValue: hasValue,
      hasModifiedBy: hasModifiedBy,
      hasModifiedBySnake: hasModifiedBySnake,
    );

    await _replaceTrigger(
      db,
      name: 'trg_bcl_${suffix}_ins',
      sql: '''
CREATE TRIGGER "trg_bcl_${suffix}_ins"
AFTER INSERT ON "$escaped"
WHEN $insertWhen
BEGIN
  INSERT INTO "$logTable" (table_name, row_key, operation, changed_at)
  VALUES ('$escaped', $newKey, 'upsert', strftime('%Y-%m-%dT%H:%M:%fZ', 'now'));
END;
''',
    );

    await _replaceTrigger(
      db,
      name: 'trg_bcl_${suffix}_upd',
      sql: '''
CREATE TRIGGER "trg_bcl_${suffix}_upd"
AFTER UPDATE ON "$escaped"
WHEN $updateWhen
BEGIN
  INSERT INTO "$logTable" (table_name, row_key, operation, changed_at)
  VALUES ('$escaped', $newKey, 'upsert', strftime('%Y-%m-%dT%H:%M:%fZ', 'now'));
END;
''',
    );

    await _replaceTrigger(
      db,
      name: 'trg_bcl_${suffix}_del',
      sql: '''
CREATE TRIGGER "trg_bcl_${suffix}_del"
AFTER DELETE ON "$escaped"
BEGIN
  INSERT INTO "$logTable" (table_name, row_key, operation, changed_at)
  VALUES ('$escaped', $oldKey, 'delete', strftime('%Y-%m-%dT%H:%M:%fZ', 'now'));
END;
''',
    );
  }

  static String _systemInsertWhen({
    required bool hasCreatedBy,
    required bool hasCreatedBySnake,
  }) {
    final checks = <String>[];
    if (hasCreatedBy) {
      checks.add("COALESCE(NEW.createdBy, '') != 'system'");
    }
    if (hasCreatedBySnake) {
      checks.add("COALESCE(NEW.created_by, '') != 'system'");
    }
    if (checks.isEmpty) return '1';
    return checks.join(' AND ');
  }

  static const _metadataColumns = {
    'modified',
    'modifiedby',
    'modified_by',
    'created',
    'createdby',
    'created_by',
  };

  static String _meaningfulUpdateWhen({
    required Set<String> columns,
    required bool hasValue,
    required bool hasModifiedBy,
    required bool hasModifiedBySnake,
  }) {
    final checks = <String>[];

    final dataColumns = columns.where((column) {
      final lower = column.toLowerCase();
      if (lower == 'id') return false;
      return !_metadataColumns.contains(lower);
    }).toList(growable: false);

    if (dataColumns.isNotEmpty) {
      final dataChanged = dataColumns
          .map((column) {
            final escaped = column.replaceAll('"', '""');
            return 'OLD."$escaped" IS NOT NEW."$escaped"';
          })
          .join(' OR ');
      checks.add('($dataChanged)');
    } else if (hasValue) {
      checks.add('OLD.value IS NOT NEW.value');
    }

    if (hasModifiedBy) {
      checks.add("COALESCE(NEW.modifiedBy, '') != 'system'");
    }
    if (hasModifiedBySnake) {
      checks.add("COALESCE(NEW.modified_by, '') != 'system'");
    }

    if (checks.isEmpty) return '1';
    return checks.join(' AND ');
  }

  static Future<Set<String>> _listColumns(Database db, String table) async {
    final rows = await db.rawQuery('PRAGMA table_info("$table")');
    return rows
        .map((row) => row['name']?.toString() ?? '')
        .where((name) => name.isNotEmpty)
        .toSet();
  }

  static Future<void> _replaceTrigger(
    Database db, {
    required String name,
    required String sql,
  }) async {
    final existing = await db.rawQuery(
      "SELECT 1 FROM sqlite_master WHERE type='trigger' AND name=? LIMIT 1",
      [name],
    );
    if (existing.isNotEmpty) return;

    await db.execute('DROP TRIGGER IF EXISTS "$name"');
    try {
      await db.execute(sql);
    } on DatabaseException catch (e) {
      if (!_isTriggerAlreadyExists(e)) rethrow;
    }
  }

  static bool _isTriggerAlreadyExists(DatabaseException error) {
    final message = error.toString().toLowerCase();
    return message.contains('already exists') && message.contains('trigger');
  }

  static Future<bool> _hasColumn(Database db, String table, String column) async {
    final columns = await _listColumns(db, table);
    return columns.contains(column);
  }

  static String _rowKeySql(
    String prefix, {
    required bool hasName,
    required bool hasId,
  }) {
    if (hasName && hasId) {
      return "COALESCE(NULLIF($prefix.name, ''), NULLIF(CAST($prefix.id AS TEXT), ''), CAST($prefix.rowid AS TEXT))";
    }
    if (hasName) {
      return "COALESCE(NULLIF($prefix.name, ''), CAST($prefix.rowid AS TEXT))";
    }
    if (hasId) {
      return "COALESCE(NULLIF(CAST($prefix.id AS TEXT), ''), CAST($prefix.rowid AS TEXT))";
    }
    return 'CAST($prefix.rowid AS TEXT)';
  }

  static String _triggerSuffix(String table) {
    final cleaned = table.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_');
    if (cleaned.length <= 40) return cleaned;
    return cleaned.substring(0, 40);
  }

  /// Resolves a live row for delta export.
  static Future<Map<String, dynamic>?> fetchRow(
    Database db,
    String table,
    String rowKey,
  ) async {
    final hasName = await _hasColumn(db, table, 'name');
    if (hasName) {
      final rows = await db.query(table, where: 'name = ?', whereArgs: [rowKey], limit: 1);
      if (rows.isNotEmpty) return rows.first;
    }

    final hasId = await _hasColumn(db, table, 'id');
    if (hasId) {
      final rows = await db.query(table, where: 'id = ?', whereArgs: [rowKey], limit: 1);
      if (rows.isNotEmpty) return rows.first;
    }

    final rowid = int.tryParse(rowKey);
    if (rowid != null) {
      final rows = await db.rawQuery('SELECT * FROM "$table" WHERE rowid = ?', [rowid]);
      if (rows.isNotEmpty) return rows.first;
    }
    return null;
  }
}
