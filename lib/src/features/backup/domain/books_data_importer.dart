import 'dart:convert';

import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/backup/domain/drive_restore_debug.dart';
import 'package:hotel/src/features/backup/domain/table_import_order.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

typedef RestoreProgressCallback = void Function(String message, double progress);

@lazySingleton
class BooksDataImporter {
  BooksDataImporter(this._db);

  final LocalDb _db;
  final Map<String, List<_TableColumn>> _columnCache = {};

  Future<void> importTables({
    required Map<String, String> tableFiles,
    required List<String> tables,
    RestoreProgressCallback? onProgress,
  }) async {
    _columnCache.clear();

    final db = await _db.database;
    final importOrder = TableImportOrder.sort(
      tables.isNotEmpty ? tables : tableFiles.keys,
    );

    final skipped = <String, List<String>>{};
    for (final table in importOrder) {
      final reasons = <String>[];
      final raw = tableFiles[table];
      if (raw == null || raw.isEmpty) {
        reasons.add('no payload on Drive');
      } else {
        try {
          final decoded = jsonDecode(raw);
          if (decoded is! Map) {
            reasons.add('invalid JSON shape');
          } else {
            final rows = decoded['rows'];
            if (rows is! List) {
              reasons.add('missing rows array');
            } else if (rows.isEmpty) {
              reasons.add('empty rows');
            }
          }
        } catch (e) {
          reasons.add('JSON decode failed: $e');
        }
      }
      if (reasons.isNotEmpty) skipped[table] = reasons;
    }

    // Resolve schemas before the transaction — PRAGMA queries inside a txn
    // can be flaky on Android.
    final columnsByTable = <String, List<_TableColumn>>{};
    for (final table in importOrder) {
      if (skipped.containsKey(table)) continue;
      final raw = tableFiles[table];
      if (raw == null || raw.isEmpty) continue;
      final columns = await _tableColumns(db, table);
      if (columns.isEmpty) {
        skipped[table] = ['table not in local schema'];
        continue;
      }
      columnsByTable[table] = columns;
    }

    DriveRestoreDebug.logImportPlan(
      importOrder: importOrder,
      tableFiles: tableFiles,
      skipped: skipped,
    );

    await db.execute('PRAGMA foreign_keys = OFF');
    try {
      await db.transaction((txn) async {
        for (var i = 0; i < importOrder.length; i++) {
          final table = importOrder[i];
          if (skipped.containsKey(table)) continue;

          final raw = tableFiles[table];
          if (raw == null || raw.isEmpty) continue;

          List<dynamic> rows;
          try {
            final json = jsonDecode(raw);
            if (json is! Map) continue;
            final rowList = json['rows'];
            if (rowList is! List || rowList.isEmpty) continue;
            rows = rowList;
          } catch (e, st) {
            DriveRestoreDebug.logTableImportFailed(
              table: table,
              error: e,
              stack: st,
            );
            continue;
          }

          final columns = columnsByTable[table];
          if (columns == null || columns.isEmpty) continue;

          try {
            await _clearTable(txn, table);
            final inserted = await _insertRowsBatched(
              txn: txn,
              table: table,
              rows: rows,
              columns: columns,
            );
            DriveRestoreDebug.logTableImported(
              table: table,
              sourceRows: rows.length,
              insertedRows: inserted.inserted,
              skippedRows: inserted.skipped,
            );
          } catch (e, st) {
            DriveRestoreDebug.logTableImportFailed(
              table: table,
              error: e,
              stack: st,
            );
            rethrow;
          }

          onProgress?.call(table, (i + 1) / importOrder.length);
        }
      });
    } finally {
      try {
        await db.execute('PRAGMA foreign_keys = ON');
      } catch (_) {}
    }
  }

  Future<List<_TableColumn>> _tableColumns(DatabaseExecutor db, String table) async {
    final cached = _columnCache[table];
    if (cached != null) return cached;

    final rows = await db.rawQuery('PRAGMA table_info("$table")');
    final columns = rows
        .map(
          (row) => _TableColumn(
            name: row['name']?.toString() ?? '',
            notNull: (row['notnull'] as int? ?? 0) == 1,
            isPrimaryKey: (row['pk'] as int? ?? 0) == 1,
          ),
        )
        .where((column) => column.name.isNotEmpty)
        .toList(growable: false);

    _columnCache[table] = columns;
    return columns;
  }

  Map<String, dynamic> _mapRowToSchema(
    Map<String, dynamic> row,
    List<_TableColumn> columns,
  ) {
    final allowed = {for (final column in columns) column.name: column};
    final mapped = <String, dynamic>{};

    for (final entry in row.entries) {
      final target = _resolveColumnName(entry.key, allowed.keys);
      if (target == null) continue;
      mapped[target] = entry.value;
    }

    final now = DateTime.now().toIso8601String();
    for (final column in columns) {
      if (mapped.containsKey(column.name)) continue;
      if (!column.notNull || column.isPrimaryKey) continue;
      mapped[column.name] = _defaultForColumn(column.name, now, mapped);
    }

    return mapped;
  }

  String? _resolveColumnName(String key, Iterable<String> targets) {
    final byLower = <String, String>{
      for (final target in targets) target.toLowerCase(): target,
    };

    final normalized = key.toLowerCase();
    if (byLower.containsKey(normalized)) {
      return byLower[normalized];
    }

    const aliases = <String, List<String>>{
      'creation': ['created'],
      'owner': ['createdby', 'created_by'],
      'createdby': ['created_by'],
      'created_by': ['createdby'],
      'modifiedby': ['modified_by'],
      'modified_by': ['modifiedby'],
    };

    for (final candidate in aliases[normalized] ?? const []) {
      final match = byLower[candidate];
      if (match != null) return match;
    }

    return null;
  }

  dynamic _defaultForColumn(
    String name,
    String now,
    Map<String, dynamic> mapped,
  ) {
    final lower = name.toLowerCase();
    if (lower == 'created' || lower == 'creation') {
      return mapped['modified'] ?? mapped['creation'] ?? now;
    }
    if (lower == 'modified') return now;
    if (lower == 'createdby' ||
        lower == 'created_by' ||
        lower == 'owner' ||
        lower == 'modifiedby' ||
        lower == 'modified_by') {
      return 'restore';
    }
    return '';
  }

  static const _insertBatchSize = 400;

  Future<({int inserted, int skipped})> _insertRowsBatched({
    required Transaction txn,
    required String table,
    required List<dynamic> rows,
    required List<_TableColumn> columns,
  }) async {
    var batch = txn.batch();
    var pending = 0;
    var inserted = 0;
    var skipped = 0;

    Future<void> commitBatch() async {
      if (pending == 0) return;
      await batch.commit(noResult: true);
      batch = txn.batch();
      pending = 0;
    }

    for (final entry in rows) {
      if (entry is! Map) {
        skipped++;
        continue;
      }
      final row = _deserializeRow(Map<String, dynamic>.from(entry));
      final mapped = _mapRowToSchema(row, columns);
      if (mapped.isEmpty) {
        skipped++;
        continue;
      }

      batch.insert(
        table,
        mapped,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      pending++;
      inserted++;

      if (pending >= _insertBatchSize) {
        await commitBatch();
      }
    }

    await commitBatch();
    return (inserted: inserted, skipped: skipped);
  }

  Future<void> _clearTable(Transaction txn, String table) async {
    try {
      await txn.rawDelete('DELETE FROM "$table"');
    } catch (_) {}
  }

  Map<String, dynamic> _deserializeRow(Map<String, dynamic> row) {
    return row.map((key, value) {
      if (value is String && _looksLikeBase64Blob(value)) {
        try {
          return MapEntry(key, base64Decode(value));
        } catch (_) {
          return MapEntry(key, value);
        }
      }
      return MapEntry(key, value);
    });
  }

  bool _looksLikeBase64Blob(String value) {
    if (value.length < 16 || value.length % 4 != 0) return false;
    return RegExp(r'^[A-Za-z0-9+/=]+$').hasMatch(value);
  }
}

class _TableColumn {
  const _TableColumn({
    required this.name,
    required this.notNull,
    required this.isPrimaryKey,
  });

  final String name;
  final bool notNull;
  final bool isPrimaryKey;
}
