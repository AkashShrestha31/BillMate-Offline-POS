import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/features/setup/domain/local_books_database_health.dart';
import 'package:sqflite/sqflite.dart';

/// Debug helper: logs Google Drive restore phases to the console.
abstract final class DriveRestoreDebug {
  static const _tag = '[DriveRestore]';

  static void log(String message) {
    if (!kDebugMode) return;
    debugPrint('$_tag $message');
  }

  static void logError(String message, [Object? error, StackTrace? stack]) {
    if (!kDebugMode) return;
    debugPrint('$_tag ERROR $message');
    if (error != null) debugPrint('$_tag   $error');
    if (stack != null) debugPrint('$_tag   $stack');
  }

  static Future<void> logRestoreStart({
    required String driveFolderSlug,
    required String metaSlug,
    required String canonicalSlug,
    required bool replaceExisting,
    required int manifestTableCount,
    required int downloadedTableCount,
    required int tablesToImportCount,
  }) async {
    if (!kDebugMode) return;

    final orgSlug = await OrgStorage.getOrgSlug();
    final activeSlug = await OrgStorage.getActiveDatabaseSlug();

    log('── restore start ──');
    log(
      'slugs: driveFolder=$driveFolderSlug meta=$metaSlug '
      'canonical=$canonicalSlug',
    );
    log('storage before clear: org=$orgSlug activeDb=$activeSlug');
    log(
      'backup: manifestTables=$manifestTableCount '
      'downloadedTables=$downloadedTableCount '
      'tablesToImport=$tablesToImportCount '
      'replaceExisting=$replaceExisting',
    );
  }

  static Future<void> logCreateDatabase({
    required String canonicalSlug,
    required bool replacedExisting,
  }) async {
    if (!kDebugMode) return;

    final path = await LocalDb.databasePathForOrg(canonicalSlug);
    final file = File(path);
    final exists = file.existsSync();
    final bytes = exists ? file.lengthSync() : 0;

    log('create_database slug=$canonicalSlug');
    log('  path=$path');
    log('  replacedExisting=$replacedExisting exists=$exists bytes=$bytes');
  }

  static void logImportPlan({
    required List<String> importOrder,
    required Map<String, String> tableFiles,
    required Map<String, List<String>> skipped,
  }) {
    if (!kDebugMode) return;

    log('import plan: ${importOrder.length} table(s) in order');
    for (final table in importOrder) {
      final raw = tableFiles[table];
      final rowCount = _countRowsInPayload(raw);
      final skipReason = skipped[table];
      if (skipReason != null && skipReason.isNotEmpty) {
        log('  SKIP $table → ${skipReason.join('; ')}');
        continue;
      }
      log('  $table rows=$rowCount payloadBytes=${raw?.length ?? 0}');
    }
  }

  static void logTableImported({
    required String table,
    required int sourceRows,
    required int insertedRows,
    required int skippedRows,
  }) {
    if (!kDebugMode) return;
    if (skippedRows > 0) {
      log(
        'imported $table: inserted=$insertedRows '
        'skipped=$skippedRows source=$sourceRows',
      );
    } else {
      log('imported $table: rows=$insertedRows');
    }
  }

  static void logTableImportFailed({
    required String table,
    required Object error,
    StackTrace? stack,
  }) {
    logError('import failed for $table', error, stack);
  }

  static Future<void> logHealthCheck({
    required String canonicalSlug,
    required bool healthy,
  }) async {
    if (!kDebugMode) return;

    final path = await LocalDb.databasePathForOrg(canonicalSlug);
    log('health_check slug=$canonicalSlug path=$path healthy=$healthy');

    if (healthy) return;

    Database? db;
    try {
      if (!File(path).existsSync()) {
        log('  issue: database file missing');
        return;
      }

      db = await openDatabase(path, readOnly: true);

      for (final table in LocalBooksDatabaseHealth.coreTables) {
        final exists = await db.rawQuery(
          "SELECT 1 FROM sqlite_master WHERE type='table' AND name=? LIMIT 1",
          [table],
        );
        final count = exists.isEmpty
            ? -1
            : Sqflite.firstIntValue(
                  await db.rawQuery('SELECT COUNT(*) FROM "$table"'),
                ) ??
                0;
        if (exists.isEmpty) {
          log('  issue: missing table $table');
        } else if (count == 0 && table == 'Employee') {
          log('  issue: $table has 0 rows (login requires at least 1)');
        } else {
          log('  $table rows=$count');
        }
      }

      final slugRow = await db.query(
        'SingleValue',
        columns: ['value'],
        where: "parent = 'Organization' AND fieldname = 'organizationSlug'",
        limit: 1,
      );
      final dbSlug = slugRow.isEmpty
          ? '(missing)'
          : slugRow.first['value']?.toString() ?? '(empty)';
      log('  SingleValue organizationSlug=$dbSlug (canonical=$canonicalSlug)');

      final codeRow = await db.query(
        'SingleValue',
        columns: ['value'],
        where: "parent = 'Organization' AND fieldname = 'organizationCode'",
        limit: 1,
      );
      final code = codeRow.isEmpty
          ? '(missing)'
          : codeRow.first['value']?.toString() ?? '(empty)';
      log('  SingleValue organizationCode=$code');
    } catch (e, st) {
      logError('health_check probe failed', e, st);
    } finally {
      await db?.close();
    }
  }

  static void logFinalize({
    required String canonicalSlug,
    required String code,
    required String name,
    required String identitySlugFromDb,
  }) {
    if (!kDebugMode) return;
    log('finalize slug=$canonicalSlug code=$code name=$name');
    if (identitySlugFromDb != canonicalSlug) {
      log(
        '  note: DB had organizationSlug=$identitySlugFromDb '
        '(normalized to $canonicalSlug)',
      );
    }
  }

  static void logRestoreSuccess({
    required String slug,
    required String code,
    required String name,
  }) {
    if (!kDebugMode) return;
    log('── restore success slug=$slug code=$code name=$name ──');
  }

  static void logRestoreFailed(Object error, [StackTrace? stack]) {
    logError('── restore failed ──', error, stack);
  }

  static int _countRowsInPayload(String? raw) {
    if (raw == null || raw.isEmpty) return 0;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return 0;
      final rows = decoded['rows'];
      if (rows is! List) return 0;
      return rows.length;
    } catch (_) {
      return -1;
    }
  }
}
