import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_registry_storage.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/org/saved_organization.dart';
import 'package:hotel/src/features/backup/data/google_drive_api_client.dart';
import 'package:hotel/src/features/backup/data/google_drive_auth_service.dart';
import 'package:hotel/src/features/backup/domain/backup_org_identity.dart';
import 'package:hotel/src/features/backup/domain/books_data_importer.dart';
import 'package:hotel/src/features/backup/domain/drive_restore_debug.dart';
import 'package:hotel/src/features/backup/domain/drive_restore_finalizer.dart';
import 'package:hotel/src/features/backup/domain/restore_core_bootstrap.dart';
import 'package:hotel/src/features/backup/domain/restore_credentials_sync.dart';
import 'package:hotel/src/features/backup/domain/models/drive_org_backup_summary.dart';
import 'package:hotel/src/features/org/domain/organization_metadata_service.dart';
import 'package:hotel/src/features/app_lock/domain/quick_unlock_import_gate.dart';
import 'package:hotel/src/features/org/domain/org_switch_coordinator.dart';
import 'package:hotel/src/features/setup/domain/local_books_database_creator.dart';
import 'package:hotel/src/features/setup/domain/local_books_database_health.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

typedef DriveRestoreProgress = void Function(String step, double progress);

class GoogleDriveRestoreResult {
  const GoogleDriveRestoreResult({
    required this.orgSlug,
    required this.orgName,
    required this.orgCode,
  });

  final String orgSlug;
  final String orgName;
  final String orgCode;
}

@lazySingleton
class GoogleDriveRestoreService {
  GoogleDriveRestoreService(
    this._authService,
    this._driveClient,
    this._importer,
    this._db,
  );

  final GoogleDriveAuthService _authService;
  final GoogleDriveApiClient _driveClient;
  final BooksDataImporter _importer;
  final LocalDb _db;

  Future<List<DriveOrgBackupSummary>> listAvailableBackups() async {
    await _authService.ensureSignedIn();
    return _driveClient.listOrgBackups();
  }

  Future<List<DriveOrgBackupSummary>> listAvailableBackupsIfSignedIn() async {
    if (!await _authService.isSignedIn()) return const [];
    return _driveClient.listOrgBackups();
  }

  Future<bool> hasSignedInAccount() => _authService.isSignedIn();

  Future<void> signIn() => _authService.signIn();

  Future<GoogleDriveRestoreResult> restoreOrganization({
    required String orgSlug,
    DriveRestoreProgress? onProgress,
    bool replaceExisting = true,
  }) async {
    await getIt<FreemiumGateService>().assertCan(FreemiumFeature.backupSync);
    try {
      return await _restoreOrganization(
        orgSlug: orgSlug,
        onProgress: onProgress,
        replaceExisting: replaceExisting,
      );
    } catch (e, st) {
      DriveRestoreDebug.logRestoreFailed(e, st);
      rethrow;
    }
  }

  Future<GoogleDriveRestoreResult> _restoreOrganization({
    required String orgSlug,
    DriveRestoreProgress? onProgress,
    bool replaceExisting = true,
  }) async {
    await _authService.ensureSignedIn();

    onProgress?.call('download', 0.05);
    DriveRestoreDebug.log('download start folder=$orgSlug');
    final backup = await _driveClient.downloadOrganizationBackup(orgSlug);
    DriveRestoreDebug.log(
      'download done meta.slug=${backup.meta.slug} '
      'meta.code=${backup.meta.code} meta.name=${backup.meta.name}',
    );

    final canonicalSlug = _resolveCanonicalSlug(
      driveFolderSlug: orgSlug,
      metaSlug: backup.meta.slug,
    );
    final provisionalCode = backup.meta.code.trim();

    final tablesToImport = {
      ...backup.manifest.tables,
      ...backup.tableFiles.keys,
    }.toList();

    await DriveRestoreDebug.logRestoreStart(
      driveFolderSlug: orgSlug,
      metaSlug: backup.meta.slug,
      canonicalSlug: canonicalSlug,
      replaceExisting: replaceExisting,
      manifestTableCount: backup.manifest.tables.length,
      downloadedTableCount: backup.tableFiles.length,
      tablesToImportCount: tablesToImport.length,
    );

    final dbExists = await LocalDb.databaseExistsForOrg(canonicalSlug);
    if (dbExists && !replaceExisting) {
      throw StateError('Organization database already exists on this device.');
    }

    onProgress?.call('create_database', 0.15);
    DriveRestoreDebug.log('create_database start slug=$canonicalSlug');

    await _db.resetConnection();
    // Drop stale org pointers so import targets the restored database file.
    await OrgStorage.clear();
    await OrgStorage.saveActiveDatabaseSlug(canonicalSlug);

    await LocalBooksDatabaseCreator.createFresh(orgSlug: canonicalSlug);
    await _db.resetConnection();

    onProgress?.call('import', 0.25);
    DriveRestoreDebug.log('import start tables=${tablesToImport.length}');
    await _db.runForOrganizationSlug(canonicalSlug, () async {
      await _importer.importTables(
        tableFiles: backup.tableFiles,
        tables: tablesToImport,
        onProgress: (step, progress) =>
            onProgress?.call(step, 0.25 + progress * 0.65),
      );
    });
    DriveRestoreDebug.log('import done');

    onProgress?.call('finalize', 0.95);

    final dbPath = await LocalDb.databasePathForOrg(canonicalSlug);
    var healthy = await LocalBooksDatabaseHealth.isHealthyAtPath(dbPath);

    if (!healthy) {
      final bootstrapped = await _db.runForOrganizationSlug(
        canonicalSlug,
        () async {
          final db = await _db.database;
          return RestoreCoreBootstrap.applyIfNeeded(
            db: db,
            meta: backup.meta,
            canonicalSlug: canonicalSlug,
          );
        },
      );
      if (bootstrapped) {
        healthy = await LocalBooksDatabaseHealth.isHealthyAtPath(dbPath);
      }
    }

    await DriveRestoreDebug.logHealthCheck(
      canonicalSlug: canonicalSlug,
      healthy: healthy,
    );
    if (!healthy) {
      final employeeCount = await _readEmployeeCountAtPath(dbPath);
      final hasLogin = backup.meta.adminEmail?.trim().isNotEmpty == true &&
          backup.meta.adminPassword?.isNotEmpty == true;
      if (!hasLogin) {
        throw StateError(
          'Backup on Drive is partial ($tablesToImport tables only) and '
          'missing login credentials. On your original device open Backup & Sync '
          'and tap Backup Now to upload a full backup.',
        );
      }
      throw StateError(
        'Imported database is incomplete (employees: $employeeCount). '
        'Try restoring again or use a full backup.',
      );
    }

    final result = await _db.runForOrganizationSlug(canonicalSlug, () async {
      final db = await _db.database;

      final fromDatabase = await BackupOrgIdentityReader.readFromDatabase(
        db,
        fallbackSlug: canonicalSlug,
      );
      final identity = BackupOrgIdentityReader.merge(
        fromDatabase: fromDatabase,
        meta: backup.meta,
        fallbackSlug: canonicalSlug,
      );

      var resolvedCode = identity.code.isNotEmpty
          ? identity.code
          : provisionalCode.trim().toUpperCase();
      if (resolvedCode.isEmpty) {
        resolvedCode = fromDatabase.code.trim().toUpperCase();
      }
      if (resolvedCode.isEmpty) {
        throw StateError('Backup is missing organization code.');
      }

      final resolvedName =
          identity.name.isNotEmpty ? identity.name : canonicalSlug;

      DriveRestoreDebug.logFinalize(
        canonicalSlug: canonicalSlug,
        code: resolvedCode,
        name: resolvedName,
        identitySlugFromDb: fromDatabase.slug,
      );

      await DriveRestoreFinalizer.ensureOrganizationSlug(db, canonicalSlug);
      await RestoreCredentialsSync.applyAfterRestore(
        meta: backup.meta,
        db: db,
      );
      await DriveRestoreFinalizer.markDeviceReadyAfterRestore(db);
      await DriveRestoreFinalizer.resetChangeLogAfterRestore(db, canonicalSlug);
      final restoreActorEmail =
          backup.meta.adminEmail?.trim().toLowerCase() ?? 'restore@local';
      await RestoreCoreBootstrap.ensureTransactionalReferences(
        db,
        email: restoreActorEmail,
      );

      return (
        orgSlug: canonicalSlug,
        orgName: resolvedName,
        orgCode: resolvedCode,
        businessType: identity.businessType,
      );
    });

    await OrgStorage.saveOrganization(
      slug: result.orgSlug,
      code: result.orgCode,
      name: result.orgName,
      businessType: result.businessType,
    );
    await OrgStorage.saveActiveDatabaseSlug(result.orgSlug);

    final savedOrg = SavedOrganization(
      slug: result.orgSlug,
      code: result.orgCode,
      name: result.orgName,
      businessType: result.businessType,
    );
    await OrganizationMetadataService.applyActiveOrganization(savedOrg);
    await OrgRegistryStorage.addOrUpdate(savedOrg);
    await QuickUnlockImportGate.markOrgImported(savedOrg.slug);

    await _db.resetConnection();
    OrgSwitchCoordinator.notifier.value++;

    DriveRestoreDebug.logRestoreSuccess(
      slug: savedOrg.slug,
      code: savedOrg.code,
      name: savedOrg.name,
    );

    return GoogleDriveRestoreResult(
      orgSlug: savedOrg.slug,
      orgName: savedOrg.name,
      orgCode: savedOrg.code,
    );
  }

  static String _resolveCanonicalSlug({
    required String driveFolderSlug,
    required String metaSlug,
  }) {
    final drive = driveFolderSlug.trim();
    final meta = metaSlug.trim();
    if (drive.isNotEmpty) return drive;
    if (meta.isNotEmpty) return meta;
    throw StateError('Backup is missing organization slug.');
  }

  static Future<int> _readEmployeeCountAtPath(String path) async {
    Database? db;
    try {
      db = await openDatabase(path, readOnly: true);
      return Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM Employee'),
          ) ??
          0;
    } catch (_) {
      return 0;
    } finally {
      await db?.close();
    }
  }
}
