import 'dart:io';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/features/backup/domain/backup_change_log_service.dart';
import 'package:hotel/src/features/backup/domain/backup_change_log_storage.dart';
import 'package:hotel/src/features/setup/domain/local_books_schema_ensurer.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Singleton local SQLite database.
///
/// On-device books SQLite (created during first-time setup from bundled
/// `assets/data/books_schema.sql`, then seeded with org-specific data).
@lazySingleton
class LocalDb {
  Database? _db;
  String? _openPath;
  String? _pinnedOrgSlug;
  int _serializedDepth = 0;
  Future<void> _operationChain = Future<void>.value();

  static const String legacyDbFileName = 'hotel_local.db';

  /// @deprecated Use [legacyDbFileName].
  static const String dbFileName = legacyDbFileName;

  static String sanitizeSlug(String slug) =>
      slug.replaceAll(RegExp(r'[^\w\-\.]'), '_');

  static String dbFileNameForOrg(String slug) =>
      'hotel_org_${sanitizeSlug(slug)}.db';

  static Future<String> legacyDatabasePath() async {
    final docsDir = await getApplicationDocumentsDirectory();
    return join(docsDir.path, legacyDbFileName);
  }

  static Future<String> databasePathForOrg(String slug) async {
    final docsDir = await getApplicationDocumentsDirectory();
    return join(docsDir.path, dbFileNameForOrg(slug));
  }

  static Future<bool> databaseExistsForOrg(String slug) async {
    return File(await databasePathForOrg(slug)).existsSync();
  }

  static Future<String> databasePath({String? forceSlug}) async {
    final pinned = forceSlug?.trim();
    if (pinned != null && pinned.isNotEmpty) {
      return databasePathForOrg(pinned);
    }

    final orgSlug = (await OrgStorage.getOrgSlug())?.trim();
    final activeSlug = (await OrgStorage.getActiveDatabaseSlug())?.trim();

    // Signed-in org wins over a stale activeDatabaseSlug left by demo provisioning.
    if (orgSlug != null && orgSlug.isNotEmpty) {
      final orgPath = await databasePathForOrg(orgSlug);
      if (File(orgPath).existsSync()) {
        if (activeSlug == null ||
            activeSlug.isEmpty ||
            activeSlug == orgSlug) {
          return orgPath;
        }
        final activePath = await databasePathForOrg(activeSlug);
        if (!File(activePath).existsSync()) {
          return orgPath;
        }
        return orgPath;
      }
    }

    if (activeSlug != null && activeSlug.isNotEmpty) {
      final activePath = await databasePathForOrg(activeSlug);
      if (File(activePath).existsSync()) return activePath;
    }

    final legacyPath = await legacyDatabasePath();
    if (File(legacyPath).existsSync()) return legacyPath;

    if (orgSlug != null && orgSlug.isNotEmpty) {
      return databasePathForOrg(orgSlug);
    }
    return legacyPath;
  }

  static Future<bool> databaseFileExists() async {
    final path = await databasePath();
    return File(path).existsSync();
  }

  /// Slug for the SQLite file [database] / [databasePath] would open.
  ///
  /// Matches [databasePath] resolution: signed-in org wins over a stale
  /// [OrgStorage.activeDatabaseSlug] (e.g. after demo provisioning).
  static Future<String?> resolveOpenSlug() async {
    final orgSlug = (await OrgStorage.getOrgSlug())?.trim();
    final activeSlug = (await OrgStorage.getActiveDatabaseSlug())?.trim();

    if (orgSlug != null && orgSlug.isNotEmpty) {
      if (await databaseExistsForOrg(orgSlug)) {
        return orgSlug;
      }
    }

    if (activeSlug != null && activeSlug.isNotEmpty) {
      if (await databaseExistsForOrg(activeSlug)) {
        return activeSlug;
      }
    }

    final trimmedOrg = orgSlug?.isNotEmpty == true ? orgSlug : null;
    final trimmedActive = activeSlug?.isNotEmpty == true ? activeSlug : null;
    return trimmedOrg ?? trimmedActive;
  }

  Future<T> _runSerialized<T>(Future<T> Function() action) {
    // Reentrant: [runForOrganizationSlug] already holds the chain; nested
    // [run]/[transaction] must execute inline or the import hangs forever.
    if (_serializedDepth > 0) {
      return action();
    }

    final run = _operationChain.then((_) async {
      _serializedDepth++;
      try {
        return await action();
      } finally {
        _serializedDepth--;
      }
    });
    _operationChain = run.then((_) {}, onError: (_) {});
    return run;
  }

  /// Prefer [run] / [transaction] so work is not interrupted by [resetConnection].
  Future<Database> get database => run((db) async => db);

  /// Runs [action] while holding the DB lock (safe across [resetConnection]).
  Future<T> run<T>(Future<T> Function(Database db) action) {
    return _runSerialized(() async {
      final db = await _ensureOpen();
      return action(db);
    });
  }

  /// Opens [slug]'s SQLite file for [action], without changing [OrgStorage].
  Future<T> runForOrganizationSlug<T>(
    String slug,
    Future<T> Function() action,
  ) {
    return _runSerialized(() async {
      final previous = _pinnedOrgSlug;
      _pinnedOrgSlug = slug.trim();
      try {
        await _closeDatabaseUnlocked();
        return await action();
      } finally {
        _pinnedOrgSlug = previous;
        await _closeDatabaseUnlocked();
      }
    });
  }

  /// Runs a SQLite transaction under the DB lock.
  Future<T> transaction<T>(
    Future<T> Function(Transaction txn) action, {
    bool? exclusive,
  }) {
    return run((db) => db.transaction(action, exclusive: exclusive));
  }

  /// Like [transaction] but disables FK checks on the connection first.
  ///
  /// PRAGMA must run on [Database], not inside [Transaction] (flaky on Android).
  Future<T> transactionIgnoringForeignKeys<T>(
    Future<T> Function(Transaction txn) action,
  ) {
    return run((db) async {
      await db.execute('PRAGMA foreign_keys = OFF');
      try {
        return await db.transaction(action);
      } finally {
        try {
          await db.execute('PRAGMA foreign_keys = ON');
        } catch (_) {}
      }
    });
  }

  Future<Database> _ensureOpen() async {
    final path = await databasePath(forceSlug: _pinnedOrgSlug);
    if (_db != null && _openPath == path && _db!.isOpen) {
      return _db!;
    }

    await _closeDatabaseUnlocked();
    if (!File(path).existsSync()) {
      throw StateError(
        'Local database is not initialized. Complete setup to continue.',
      );
    }

    _openPath = path;
    _db = await openDatabase(path, readOnly: false);
    await LocalBooksSchemaEnsurer.ensureAllTables(_db!, databasePath: path);
    await BackupChangeLogService.ensureInstalled(_db!, databasePath: path);
    await _migrateStaleBackupChangeLogNoise(_db!, databasePath: path);
    return _db!;
  }

  /// One-time reset after trigger upgrade (old noisy rows / stale triggers).
  static Future<void> _migrateStaleBackupChangeLogNoise(
    Database db, {
    required String databasePath,
  }) async {
    if (!await BackupChangeLogStorage.consumeTriggerMigrationIfNeeded()) {
      return;
    }

    await BackupChangeLogService.dropAllTriggers(db);
    BackupChangeLogService.resetSessionCache();
    await BackupChangeLogService.ensureInstalled(
      db,
      databasePath: databasePath,
    );

    final maxLogId = await BackupChangeLogService.maxLogId(db);
    if (maxLogId <= 0) return;

    final slug = await resolveOpenSlug();
    if (slug == null || slug.isEmpty) return;

    await BackupChangeLogStorage.setCheckpoint(slug, maxLogId);
    await BackupChangeLogService.pruneThrough(db, maxLogId);
  }

  /// True when this process already has [path] open.
  ///
  /// A second `openDatabase` on the same file can fail while the app is in use,
  /// which made organization health checks drop the current organization.
  bool isOpenAtPath(String path) {
    final open = _db;
    final openPath = _openPath;
    return open != null && open.isOpen && openPath != null && openPath == path;
  }

  Future<void> resetConnection() => _runSerialized(() async {
        await _closeDatabaseUnlocked();
        LocalBooksSchemaEnsurer.resetSessionCache();
        BackupChangeLogService.resetSessionCache();
      });

  Future<void> _closeDatabaseUnlocked() async {
    final db = _db;
    _db = null;
    _openPath = null;
    if (db != null && db.isOpen) {
      await db.close();
    }
  }

  /// Query with optional filters, ordering and pagination
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) {
    return run(
      (db) => db.query(
        table,
        where: where,
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      ),
    );
  }

  /// Raw SQL query
  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? args,
  ]) {
    return run((db) => db.rawQuery(sql, args));
  }

  /// Insert or replace a row
  Future<void> upsert(String table, Map<String, dynamic> row) {
    return run(
      (db) => db.insert(
        table,
        row,
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    );
  }

  /// Delete by id column
  Future<int> delete(String table, String id) {
    return run(
      (db) => db.delete(table, where: 'id = ?', whereArgs: [id]),
    );
  }

  /// Count rows matching optional where clause
  Future<int> count(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) {
    return run((db) async {
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM "$table"${where != null ? ' WHERE $where' : ''}',
        whereArgs,
      );
      return Sqflite.firstIntValue(result) ?? 0;
    });
  }
}
