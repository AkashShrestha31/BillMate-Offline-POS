import 'dart:convert';

/// Merges incremental backup rows into an existing per-table JSON payload.
abstract final class BackupTableMerge {
  static String mergeTableJson({
    required String tableName,
    required String? existingJson,
    required List<Map<String, dynamic>> upsertRows,
    required List<String> deleteKeys,
  }) {
    final merged = <String, Map<String, dynamic>>{};

    for (final row in _parseRows(existingJson)) {
      final key = rowKeyFromMap(row);
      if (key.isEmpty) continue;
      merged[key] = row;
    }

    for (final key in deleteKeys) {
      merged.remove(key);
    }

    for (final row in upsertRows) {
      final key = rowKeyFromMap(row);
      if (key.isEmpty) continue;
      merged[key] = row;
    }

    return jsonEncode({
      'table': tableName,
      'rows': merged.values.toList(growable: false),
    });
  }

  static List<Map<String, dynamic>> _parseRows(String? json) {
    if (json == null || json.trim().isEmpty) return const [];
    try {
      final decoded = jsonDecode(json);
      if (decoded is! Map) return const [];
      final rows = decoded['rows'];
      if (rows is! List) return const [];
      return rows
          .whereType<Map>()
          .map((row) => Map<String, dynamic>.from(row))
          .toList(growable: false);
    } catch (_) {
      return const [];
    }
  }

  static String rowKeyFromMap(Map<String, dynamic> row) {
    final name = row['name']?.toString().trim();
    if (name != null && name.isNotEmpty) return name;

    final id = row['id'];
    if (id != null) {
      final text = id.toString().trim();
      if (text.isNotEmpty) return text;
    }

    final rowid = row['rowid'];
    if (rowid != null) return rowid.toString();
    return '';
  }
}
