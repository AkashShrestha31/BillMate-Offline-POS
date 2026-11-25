import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/features/backup/data/google_drive_api_client.dart';
import 'package:hotel/src/features/backup/data/google_drive_auth_service.dart';
import 'package:hotel/src/features/backup/domain/backup_change_log_service.dart';
import 'package:hotel/src/features/backup/domain/books_data_exporter.dart';
import 'package:hotel/src/features/backup/domain/books_delta_exporter.dart';
import 'package:hotel/src/features/backup/domain/drive_backup_state_storage.dart';
import 'package:hotel/src/features/backup/domain/drive_restore_debug.dart';
import 'package:hotel/src/features/backup/domain/models/drive_last_sync_info.dart';
import 'package:injectable/injectable.dart';

class GoogleDriveBackupResult {
  const GoogleDriveBackupResult({
    required this.orgSlug,
    required this.orgName,
    required this.tableCount,
    required this.recordCount,
    required this.exportedAt,
    required this.accountEmail,
    this.incremental = false,
    this.skipped = false,
  });

  final String orgSlug;
  final String orgName;
  final int tableCount;
  final int recordCount;
  final DateTime exportedAt;
  final String accountEmail;

  /// Only changed tables/rows were uploaded.
  final bool incremental;

  /// No local changes since the last backup checkpoint.
  final bool skipped;
}

typedef DriveBackupProgress = void Function(String step, double progress);

@lazySingleton
class GoogleDriveBackupService {
  GoogleDriveBackupService(
    this._authService,
    this._exporter,
    this._deltaExporter,
    this._driveClient,
    this._db,
  );

  final GoogleDriveAuthService _authService;
  final BooksDataExporter _exporter;
  final BooksDeltaExporter _deltaExporter;
  final GoogleDriveApiClient _driveClient;
  final LocalDb _db;

  Future<String?> get linkedAccountEmail => DriveBackupStateStorage.getAccountEmail();

  Future<DateTime?> get lastBackupAt => DriveBackupStateStorage.getLastBackupAt();

  Future<DriveLastSyncInfo> loadSyncInfo() async {
    return DriveLastSyncInfo(
      accountEmail: await DriveBackupStateStorage.getAccountEmail(),
      syncedAt: await DriveBackupStateStorage.getLastBackupAt(),
      orgSlug: await DriveBackupStateStorage.getLastBackupSlug(),
      orgName: await DriveBackupStateStorage.getLastBackupOrgName(),
      tableCount: await DriveBackupStateStorage.getLastBackupTableCount(),
      recordCount: await DriveBackupStateStorage.getLastBackupRecordCount(),
      lastError: await DriveBackupStateStorage.getLastBackupError(),
      pendingChanges: await BooksDeltaExporter.pendingChangesForActiveOrg(_db),
    );
  }

  Future<GoogleDriveBackupResult> backupActiveOrganization({
    DriveBackupProgress? onProgress,
  }) async {
    await getIt<FreemiumGateService>().assertCan(FreemiumFeature.backupSync);
    try {
      final account = await _authService.ensureSignedIn();
      await DriveBackupStateStorage.saveAccountEmail(account.email);

      onProgress?.call('export', 0);

      final slug = await LocalDb.resolveOpenSlug();
      final orgName = (await OrgStorage.getOrgName())?.trim();
      final resolvedName =
          orgName != null && orgName.isNotEmpty ? orgName : (slug ?? '');

      final lastBackupAt = await DriveBackupStateStorage.getLastBackupAt();
      final pending = await BooksDeltaExporter.pendingChangesForActiveOrg(_db);

      final driveBaselineReady = slug != null &&
          slug.isNotEmpty &&
          await _driveClient.hasRestorableBaselineOnDrive(slug);

      // First backup, or Drive is missing core tables — always upload full DB.
      if (lastBackupAt == null || !driveBaselineReady) {
        if (!driveBaselineReady && lastBackupAt != null) {
          DriveRestoreDebug.log(
            'forcing full backup: Drive baseline incomplete for $slug',
          );
        }
        return _runFullBackup(
          accountEmail: account.email,
          onProgress: onProgress,
        );
      }

      if (pending == 0) {
        onProgress?.call('up_to_date', 1);
        return GoogleDriveBackupResult(
          orgSlug: slug!,
          orgName: resolvedName,
          tableCount: 0,
          recordCount: 0,
          exportedAt: lastBackupAt,
          accountEmail: account.email,
          skipped: true,
        );
      }

      if (pending <= BooksDeltaExporter.maxIncrementalChanges) {
        final delta = await _deltaExporter.tryExportActiveOrganizationDelta(
          onProgress: (step, progress) =>
              onProgress?.call(step, progress * 0.35),
        );

        if (delta != null) {
          await _driveClient.uploadIncrementalTableUpdates(
            orgSlug: delta.orgSlug,
            delta: delta,
            onProgress: (step, progress) =>
                onProgress?.call(step, 0.35 + progress * 0.65),
          );

          await _deltaExporter.advanceCheckpoint(
            delta.orgSlug,
            delta.maxChangeLogId,
          );

          final exportedAt = DateTime.parse(delta.meta.exportedAt).toLocal();
          await DriveBackupStateStorage.saveLastBackup(
            slug: delta.orgSlug,
            orgName: delta.meta.name,
            at: exportedAt,
            tableCount: delta.tableFiles.length,
            recordCount: delta.changeCount,
          );

          return GoogleDriveBackupResult(
            orgSlug: delta.orgSlug,
            orgName: delta.meta.name,
            tableCount: delta.tableFiles.length,
            recordCount: delta.changeCount,
            exportedAt: exportedAt,
            accountEmail: account.email,
            incremental: true,
          );
        }

        final db = await _db.database;
        final maxLogId = await BackupChangeLogService.maxLogId(db);
        await _deltaExporter.advanceCheckpoint(slug, maxLogId);
        onProgress?.call('up_to_date', 1);
        return GoogleDriveBackupResult(
          orgSlug: slug,
          orgName: resolvedName,
          tableCount: 0,
          recordCount: 0,
          exportedAt: lastBackupAt,
          accountEmail: account.email,
          skipped: true,
        );
      }

      return _runFullBackup(
        accountEmail: account.email,
        onProgress: onProgress,
      );
    } catch (e) {
      await DriveBackupStateStorage.saveLastBackupError(e.toString());
      rethrow;
    }
  }

  Future<GoogleDriveBackupResult> _runFullBackup({
    required String accountEmail,
    DriveBackupProgress? onProgress,
  }) async {
    DriveRestoreDebug.log('running full database backup to Google Drive');
    final bundle = await _exporter.exportActiveOrganization(
      onProgress: (step, progress) => onProgress?.call(step, progress * 0.35),
    );

    final registryJson = bundle.registry
        .map((org) => org.toJson())
        .toList(growable: false);

    await _driveClient.uploadOrganizationBackup(
      orgSlug: bundle.meta.slug,
      meta: bundle.meta.toJson(),
      manifest: bundle.manifest.toJson(),
      registry: {
        'organizations': registryJson,
        'updatedAt': DateTime.now().toUtc().toIso8601String(),
      },
      tableFiles: bundle.tableFiles,
      onProgress: (step, progress) =>
          onProgress?.call(step, 0.35 + progress * 0.65),
    );

    final db = await _db.database;
    final maxLogId = await BackupChangeLogService.maxLogId(db);
    await _deltaExporter.advanceCheckpoint(bundle.meta.slug, maxLogId);

    final exportedAt = DateTime.parse(bundle.meta.exportedAt).toLocal();
    final recordCount = bundle.manifest.recordCounts.values.fold<int>(
      0,
      (sum, count) => sum + count,
    );

    await DriveBackupStateStorage.saveLastBackup(
      slug: bundle.meta.slug,
      orgName: bundle.meta.name,
      at: exportedAt,
      tableCount: bundle.tableFiles.length,
      recordCount: recordCount,
    );

    return GoogleDriveBackupResult(
      orgSlug: bundle.meta.slug,
      orgName: bundle.meta.name,
      tableCount: bundle.tableFiles.length,
      recordCount: recordCount,
      exportedAt: exportedAt,
      accountEmail: accountEmail,
    );
  }

  Future<void> signIn() => _authService.signIn();

  Future<void> signOut() => _authService.signOut();
}
