import 'package:hotel/src/core/services/local/single_value_upsert.dart';
import 'package:hotel/src/features/backup/domain/backup_change_log_service.dart';
import 'package:hotel/src/features/backup/domain/backup_change_log_storage.dart';
import 'package:hotel/src/features/setup/domain/local_setup_storage.dart';
import 'package:sqflite/sqflite.dart';

/// Marks the device provisioned after a successful Google Drive restore.
abstract final class DriveRestoreFinalizer {
  static Future<void> markDeviceReadyAfterRestore(Database db) async {
    await _upsertSetupComplete(db);
    await LocalSetupStorage.markLegacyMigrated();
  }

  /// Imported rows must not appear as pending incremental backup changes.
  static Future<void> resetChangeLogAfterRestore(
    Database db,
    String orgSlug,
  ) async {
    final maxLogId = await BackupChangeLogService.maxLogId(db);
    if (maxLogId > 0) {
      await BackupChangeLogService.pruneThrough(db, maxLogId);
    }
    await BackupChangeLogStorage.setCheckpoint(orgSlug.trim(), maxLogId);
  }

  /// Keeps on-device SQLite file slug aligned with [OrgStorage] / registry.
  static Future<void> ensureOrganizationSlug(
    Database db,
    String slug,
  ) async {
    await SingleValueUpsert.upsert(
      db,
      parent: 'Organization',
      fieldname: 'organizationSlug',
      value: slug.trim(),
      preferredName: 'Organization-organizationSlug',
    );
  }

  static Future<void> _upsertSetupComplete(Database db) async {
    await SingleValueUpsert.upsert(
      db,
      parent: 'AccountingSettings',
      fieldname: 'setupComplete',
      value: '1',
      preferredName: 'AccountingSettings-setupComplete',
    );
  }
}
