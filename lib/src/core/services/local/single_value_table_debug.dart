import 'package:flutter/foundation.dart';
import 'package:hotel/src/core/services/local/local_db.dart';

/// Debug helper: dumps all `SingleValue` rows to the console.
abstract final class SingleValueTableDebug {
  static Future<void> printAll(LocalDb db) async {
    if (!kDebugMode) return;

    try {
      final database = await db.database;
      final rows = await database.query(
        'SingleValue',
        columns: ['parent', 'fieldname', 'value'],
        orderBy: 'parent ASC, fieldname ASC',
      );

      debugPrint('[SingleValue] ${rows.length} row(s):');
      for (final row in rows) {
        debugPrint(
          '[SingleValue] ${row['parent']}.${row['fieldname']} = ${row['value']}',
        );
      }
    } catch (e, st) {
      debugPrint('[SingleValue] query failed: $e\n$st');
    }
  }
}
