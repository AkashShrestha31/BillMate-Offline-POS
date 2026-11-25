import 'package:shared_preferences/shared_preferences.dart';

/// Per-organization checkpoint for [BackupChangeLog] incremental backup.
class BackupChangeLogStorage {
  BackupChangeLogStorage._();

  static const _triggerMigrationVersion = 3;
  static const _triggerMigrationKey = 'backup_changelog_trigger_version';

  static String _checkpointKey(String orgSlug) =>
      'backup_changelog_checkpoint_${orgSlug.trim()}';

  static Future<int> getCheckpoint(String orgSlug) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_checkpointKey(orgSlug)) ?? 0;
  }

  static Future<void> setCheckpoint(String orgSlug, int changeLogId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_checkpointKey(orgSlug), changeLogId);
  }

  static Future<void> clearCheckpoint(String orgSlug) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_checkpointKey(orgSlug));
  }

  /// True once per app install when [triggerMigrationVersion] bumps.
  static Future<bool> consumeTriggerMigrationIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final applied = prefs.getInt(_triggerMigrationKey) ?? 0;
    if (applied >= _triggerMigrationVersion) return false;
    await prefs.setInt(_triggerMigrationKey, _triggerMigrationVersion);
    return true;
  }
}
