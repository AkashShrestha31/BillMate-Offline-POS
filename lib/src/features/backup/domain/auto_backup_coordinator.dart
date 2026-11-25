import 'package:flutter/foundation.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/internet/internet_info.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/features/backup/data/google_drive_api_client.dart';
import 'package:hotel/src/features/backup/data/google_drive_auth_service.dart';
import 'package:hotel/src/features/backup/domain/backup_settings_storage.dart';
import 'package:hotel/src/features/backup/domain/books_delta_exporter.dart';
import 'package:hotel/src/features/backup/domain/drive_backup_state_storage.dart';
import 'package:hotel/src/features/backup/domain/google_drive_backup_service.dart';
import 'package:hotel/src/features/backup/domain/google_drive_restore_service.dart';
import 'package:hotel/src/features/backup/domain/models/backup_settings.dart';
import 'package:injectable/injectable.dart';

/// Runs scheduled / on-startup Google Drive backup and restore per user settings.
@lazySingleton
class AutoBackupCoordinator {
  AutoBackupCoordinator(
    this._backupService,
    this._restoreService,
    this._authService,
    this._driveClient,
    this._internetInfo,
    this._db,
  );

  final GoogleDriveBackupService _backupService;
  final GoogleDriveRestoreService _restoreService;
  final GoogleDriveAuthService _authService;
  final GoogleDriveApiClient _driveClient;
  final InternetInfo _internetInfo;
  final LocalDb _db;

  bool _running = false;

  Future<BackupSettings> loadSettings() => BackupSettingsStorage.load();

  Future<void> saveSettings(BackupSettings settings) =>
      BackupSettingsStorage.save(settings);

  Future<AutoBackupRunResult?> getLastAutoRun() =>
      BackupSettingsStorage.getLastAutoRun();

  /// Called once after the app opens and the active org database is ready.
  Future<AutoBackupRunResult> maybeRunOnAppStart() =>
      _maybeRun(trigger: _AutoBackupTrigger.appStart);

  /// Called when the app returns to the foreground.
  Future<AutoBackupRunResult> maybeRunOnAppResume() =>
      _maybeRun(trigger: _AutoBackupTrigger.appResume);

  Future<AutoBackupRunResult> _maybeRun({
    required _AutoBackupTrigger trigger,
  }) async {
    if (_running) {
      return const AutoBackupRunResult(
        outcome: AutoBackupOutcome.skipped,
        message: 'Auto sync already running',
      );
    }

    _running = true;
    try {
      final settings = await BackupSettingsStorage.load();
      if (!settings.autoBackupEnabled) {
        return _finish(
          const AutoBackupRunResult(
            outcome: AutoBackupOutcome.skipped,
            message: 'Auto backup is off',
          ),
        );
      }

      if (!await OrgStorage.hasOrgSlug()) {
        return _finish(
          const AutoBackupRunResult(
            outcome: AutoBackupOutcome.skipped,
            message: 'No organization selected',
          ),
        );
      }

      if (!await LocalDb.databaseFileExists()) {
        return _finish(
          const AutoBackupRunResult(
            outcome: AutoBackupOutcome.skipped,
            message: 'Local database not ready',
          ),
        );
      }

      if (!await _internetInfo.isConnected) {
        return _finish(
          const AutoBackupRunResult(
            outcome: AutoBackupOutcome.skipped,
            message: 'No internet connection',
          ),
        );
      }

      if (settings.wifiOnly && !await _internetInfo.isOnWifi) {
        return _finish(
          const AutoBackupRunResult(
            outcome: AutoBackupOutcome.skipped,
            message: 'Waiting for Wi‑Fi',
          ),
        );
      }

      final account = await _authService.currentUser;
      if (account == null) {
        return _finish(
          const AutoBackupRunResult(
            outcome: AutoBackupOutcome.skipped,
            message: 'Not signed in to Google Drive',
          ),
        );
      }

      final slug = await LocalDb.resolveOpenSlug();
      if (slug == null || slug.isEmpty) {
        return _finish(
          const AutoBackupRunResult(
            outcome: AutoBackupOutcome.skipped,
            message: 'Organization slug missing',
          ),
        );
      }

      if (!(await getIt<FreemiumGateService>().check(FreemiumFeature.backupSync))
          .allowed) {
        return _finish(
          const AutoBackupRunResult(
            outcome: AutoBackupOutcome.skipped,
            message: 'Backup & sync requires Premium',
          ),
        );
      }

      final scheduleDue = await _isScheduleDue(settings);
      final pending =
          await BooksDeltaExporter.pendingChangesForActiveOrg(_db);

      if (settings.syncDirection.includesDownload &&
          (scheduleDue || trigger == _AutoBackupTrigger.appStart)) {
        final downloadResult = await _tryAutoDownload(
          orgSlug: slug,
          pendingChanges: pending,
        );
        if (downloadResult != null) return _finish(downloadResult);
      }

      if (settings.syncDirection.includesUpload &&
          (scheduleDue || pending > 0)) {
        final uploadResult = await _tryAutoUpload();
        return _finish(uploadResult);
      }

      return _finish(
        AutoBackupRunResult(
          outcome: AutoBackupOutcome.skipped,
          message: scheduleDue
              ? 'Nothing to sync'
              : 'Next backup not due yet',
        ),
      );
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[AutoBackup] failed: $e\n$st');
      }
      await DriveBackupStateStorage.saveLastBackupError(e.toString());
      return _finish(
        AutoBackupRunResult(
          outcome: AutoBackupOutcome.failed,
          message: e.toString(),
        ),
      );
    } finally {
      _running = false;
    }
  }

  Future<AutoBackupRunResult?> _tryAutoDownload({
    required String orgSlug,
    required int pendingChanges,
  }) async {
    if (pendingChanges > 0) {
      return null;
    }

    final remoteExportedAt = await _driveClient.fetchOrgBackupExportedAt(orgSlug);
    if (remoteExportedAt == null) return null;

    final localLastBackup = await DriveBackupStateStorage.getLastBackupAt();
    final shouldDownload = localLastBackup == null
        ? true
        : remoteExportedAt.isAfter(
            localLastBackup.toUtc().add(const Duration(minutes: 1)),
          );

    if (!shouldDownload) return null;

    await _restoreService.restoreOrganization(orgSlug: orgSlug);
    return const AutoBackupRunResult(
      outcome: AutoBackupOutcome.downloaded,
      message: 'Restored newer cloud backup',
    );
  }

  Future<AutoBackupRunResult> _tryAutoUpload() async {
    final result = await _backupService.backupActiveOrganization();
    if (result.skipped) {
      return const AutoBackupRunResult(
        outcome: AutoBackupOutcome.skipped,
        message: 'Already up to date',
      );
    }
    return AutoBackupRunResult(
      outcome: AutoBackupOutcome.uploaded,
      message: result.incremental
          ? 'Incremental backup (${result.recordCount} changes)'
          : 'Full backup uploaded',
    );
  }

  Future<bool> _isScheduleDue(BackupSettings settings) async {
    if (settings.frequency == BackupFrequency.off) {
      return false;
    }

    final lastRun = await BackupSettingsStorage.getLastAutoRunAt();
    final lastBackup = await DriveBackupStateStorage.getLastBackupAt();
    final anchor = _latest(lastRun, lastBackup);
    if (anchor == null) return true;

    final elapsed = DateTime.now().difference(anchor);
    return switch (settings.frequency) {
      BackupFrequency.daily => elapsed >= const Duration(hours: 24),
      BackupFrequency.weekly => elapsed >= const Duration(days: 7),
      BackupFrequency.monthly => elapsed >= const Duration(days: 30),
      BackupFrequency.off => false,
    };
  }

  DateTime? _latest(DateTime? a, DateTime? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a.isAfter(b) ? a : b;
  }

  Future<AutoBackupRunResult> _finish(AutoBackupRunResult result) async {
    if (result.didWork || result.outcome == AutoBackupOutcome.failed) {
      await BackupSettingsStorage.saveLastAutoRun(result);
    }
    if (kDebugMode) {
      debugPrint(
        '[AutoBackup] ${result.outcome.name}: ${result.message ?? ''}',
      );
    }
    return result;
  }

  /// Returns null when backup may proceed; otherwise a skip message.
  Future<String?> wifiGateMessage(BackupSettings settings) async {
    if (!settings.wifiOnly) return null;
    if (!await _internetInfo.isConnected) {
      return 'No internet connection';
    }
    if (!await _internetInfo.isOnWifi) {
      return 'Connect to Wi‑Fi or turn off "Back up over Wi‑Fi only"';
    }
    return null;
  }
}

enum _AutoBackupTrigger { appStart, appResume }
