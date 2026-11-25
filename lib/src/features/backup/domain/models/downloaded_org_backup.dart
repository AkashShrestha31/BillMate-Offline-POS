import 'package:hotel/src/features/backup/domain/models/backup_manifest.dart';
import 'package:hotel/src/features/backup/domain/models/organization_backup_meta.dart';

class DownloadedOrgBackup {
  const DownloadedOrgBackup({
    required this.meta,
    required this.manifest,
    required this.tableFiles,
  });

  final OrganizationBackupMeta meta;
  final BackupManifest manifest;
  final Map<String, String> tableFiles;
}
