/// Tables that are transient, internal, or legacy — not backed up to Drive.
class BackupExcludedTables {
  BackupExcludedTables._();

  static const _excluded = {
    'backupchangelog',
    'erpnextsyncqueue',
    'fetchfromerpnextqueue',
    'integrationerrorlog',
    'employee_backup',
    'patchrun',
    'android_metadata',
  };

  static bool shouldSkip(String tableName) =>
      _excluded.contains(tableName.toLowerCase());
}
