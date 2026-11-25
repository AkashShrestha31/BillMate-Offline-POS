import 'dart:convert';

import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/backup/domain/backup_change_log_service.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
class BooksDeltaImporter {
  BooksDeltaImporter(this._db);

  final LocalDb _db;

  Future<void> applyDelta({
    required Map<String, String> tableFiles,
    required Map<String, List<String>> deletes,
  }) async {
    final db = await _db.database;
    final tables = <String>{
      ...tableFiles.keys,
      ...deletes.keys,
    }.toList()
      ..sort();

    await db.transaction((txn) async {
      for (final table in tables) {
        if (BackupChangeLogService.shouldSkipTable(table)) continue;

        final deleteKeys = deletes[table] ?? const [];
        for (final key in deleteKeys) {
          await _deleteRow(txn, table, key);
        }

        final raw = tableFiles[table];
        if (raw == null || raw.isEmpty) continue;

        final decoded = jsonDecode(raw);
        if (decoded is! Map) continue;
        final rows = decoded['rows'];
        if (rows is! List || rows.isEmpty) continue;

        final columns = await _tableColumns(txn, table);
        if (columns.isEmpty) continue;

        for (final entry in rows) {
          if (entry is! Map) continue;
          final row = _deserializeRow(Map<String, dynamic>.from(entry));
          final mapped = _mapRowToSchema(row, columns);
          if (mapped.isEmpty) continue;
          await txn.insert(
            table,
            mapped,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }
    });
  }

  Future<void> _deleteRow(DatabaseExecutor db, String table, String rowKey) async {
    final hasName = await _hasColumn(db, table, 'name');
    if (hasName) {
      final count = await db.delete(table, where: 'name = ?', whereArgs: [rowKey]);
      if (count > 0) return;
    }

    final hasId = await _hasColumn(db, table, 'id');
    if (hasId) {
      final count = await db.delete(table, where: 'id = ?', whereArgs: [rowKey]);
      if (count > 0) return;
    }

    final rowid = int.tryParse(rowKey);
    if (rowid != null) {
      await db.rawDelete('DELETE FROM "$table" WHERE rowid = ?', [rowid]);
    }
  }

  Future<bool> _hasColumn(DatabaseExecutor db, String table, String column) async {
    final rows = await db.rawQuery('PRAGMA table_info("$table")');
    for (final row in rows) {
      if ((row['name']?.toString().toLowerCase() ?? '') == column.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  Future<List<_TableColumn>> _tableColumns(DatabaseExecutor db, String table) async {
    final rows = await db.rawQuery('PRAGMA table_info("$table")');
    return rows
        .map(
          (row) => _TableColumn(
            name: row['name']?.toString() ?? '',
            notNull: (row['notnull'] as int? ?? 0) == 1,
            isPrimaryKey: (row['pk'] as int? ?? 0) == 1,
          ),
        )
        .where((column) => column.name.isNotEmpty)
        .toList(growable: false);
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
