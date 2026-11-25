import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DriveBackupStateStorage {
  DriveBackupStateStorage._();

  static const _accountEmailKey = 'drive_backup_account_email_v1';
  static const _lastBackupAtKey = 'drive_backup_last_at_v1';
  static const _lastBackupSlugKey = 'drive_backup_last_slug_v1';
  static const _lastBackupOrgNameKey = 'drive_backup_last_org_name_v1';
  static const _lastBackupTableCountKey = 'drive_backup_last_table_count_v1';
  static const _lastBackupRecordCountKey = 'drive_backup_last_record_count_v1';
  static const _lastBackupErrorKey = 'drive_backup_last_error_v1';
  static const _deviceIdKey = 'drive_backup_device_id_v1';
  static const _folderCachePrefix = 'drive_folder_cache_v1_';

  static Future<String> getOrCreateDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_deviceIdKey)?.trim();
    if (existing != null && existing.isNotEmpty) return existing;

    final id = const Uuid().v4();
    await prefs.setString(_deviceIdKey, id);
    return id;
  }

  static Future<String?> getAccountEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accountEmailKey);
  }

  static Future<void> saveAccountEmail(String? email) async {
    final prefs = await SharedPreferences.getInstance();
    if (email == null || email.trim().isEmpty) {
      await prefs.remove(_accountEmailKey);
      return;
    }
    await prefs.setString(_accountEmailKey, email.trim());
  }

  static Future<DateTime?> getLastBackupAt() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_lastBackupAtKey);
    if (raw == null || raw.isEmpty) return null;
    return DateTime.tryParse(raw);
  }

  static Future<String?> getLastBackupSlug() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastBackupSlugKey);
  }

  static Future<String?> getLastBackupOrgName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastBackupOrgNameKey);
  }

  static Future<int?> getLastBackupTableCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_lastBackupTableCountKey);
  }

  static Future<int?> getLastBackupRecordCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_lastBackupRecordCountKey);
  }

  static Future<String?> getLastBackupError() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastBackupErrorKey);
  }

  static Future<void> saveLastBackup({
    required String slug,
    required String orgName,
    required DateTime at,
    required int tableCount,
    required int recordCount,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastBackupAtKey, at.toUtc().toIso8601String());
    await prefs.setString(_lastBackupSlugKey, slug);
    await prefs.setString(_lastBackupOrgNameKey, orgName);
    await prefs.setInt(_lastBackupTableCountKey, tableCount);
    await prefs.setInt(_lastBackupRecordCountKey, recordCount);
    await prefs.remove(_lastBackupErrorKey);
  }

  static Future<void> saveLastBackupError(String message) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastBackupErrorKey, message.trim());
  }

  static Future<String?> getFolderCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('$_folderCachePrefix$key');
  }

  static Future<void> setFolderCache(String key, String folderId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_folderCachePrefix$key', folderId);
  }

  static Future<void> clearFolderCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where(
      (key) => key.startsWith(_folderCachePrefix),
    );
    for (final key in keys) {
      await prefs.remove(key);
    }
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await clearFolderCache();
    await prefs.remove(_accountEmailKey);
    await prefs.remove(_lastBackupAtKey);
    await prefs.remove(_lastBackupSlugKey);
    await prefs.remove(_lastBackupOrgNameKey);
    await prefs.remove(_lastBackupTableCountKey);
    await prefs.remove(_lastBackupRecordCountKey);
    await prefs.remove(_lastBackupErrorKey);
  }
}
