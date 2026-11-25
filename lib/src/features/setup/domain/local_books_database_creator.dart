import 'dart:io';

import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/backup/domain/drive_restore_debug.dart';
import 'package:hotel/src/features/setup/domain/local_books_schema_executor.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

/// Creates the on-device books SQLite file from bundled DDL (84 tables).
class LocalBooksDatabaseCreator {
  static Future<void> createFresh({required String orgSlug}) async {
    final path = await LocalDb.databasePathForOrg(orgSlug);
    final file = File(path);
    final replacedExisting = file.existsSync();
    if (replacedExisting) {
      await file.delete();
    }
    await Directory(p.dirname(path)).create(recursive: true);

    final db = await openDatabase(path);
    try {
      await LocalBooksSchemaExecutor.apply(db);
      await DriveRestoreDebug.logCreateDatabase(
        canonicalSlug: orgSlug,
        replacedExisting: replacedExisting,
      );
    } finally {
      await db.close();
    }
  }
}
