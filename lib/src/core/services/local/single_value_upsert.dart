import 'package:sqflite/sqflite.dart';

/// Upserts rows in the books `SingleValue` table by logical key or primary key name.
abstract final class SingleValueUpsert {
  static Future<void> upsert(
    Database db, {
    required String parent,
    required String fieldname,
    required String value,
    String? preferredName,
    String actor = 'system',
  }) async {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;

    final now = DateTime.now().toIso8601String();
    final name = preferredName ?? '$parent-$fieldname';
    final patch = <String, dynamic>{
      'value': trimmed,
      'parent': parent,
      'fieldname': fieldname,
      'modified': now,
      'modifiedBy': actor,
    };

    final existingName = await _resolveExistingName(
      db,
      parent: parent,
      fieldname: fieldname,
      preferredName: name,
    );

    if (existingName != null) {
      await db.update(
        'SingleValue',
        patch,
        where: 'name = ?',
        whereArgs: [existingName],
      );
      return;
    }

    await db.insert(
      'SingleValue',
      {
        'name': name,
        ...patch,
        'created': now,
        'createdBy': actor,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<String?> _resolveExistingName(
    Database db, {
    required String parent,
    required String fieldname,
    required String preferredName,
  }) async {
    final byLogicalKey = await db.rawQuery(
      '''
      SELECT name FROM SingleValue
      WHERE lower(trim(parent)) = lower(trim(?))
        AND lower(trim(fieldname)) = lower(trim(?))
      LIMIT 1
      ''',
      [parent, fieldname],
    );
    if (byLogicalKey.isNotEmpty) {
      return byLogicalKey.first['name']?.toString();
    }

    final byPreferredName = await db.query(
      'SingleValue',
      columns: ['name'],
      where: 'name = ?',
      whereArgs: [preferredName],
      limit: 1,
    );
    if (byPreferredName.isNotEmpty) {
      return byPreferredName.first['name']?.toString();
    }

    return null;
  }
}
