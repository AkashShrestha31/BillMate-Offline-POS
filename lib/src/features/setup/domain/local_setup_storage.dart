import 'package:shared_preferences/shared_preferences.dart';

/// Tracks whether the on-device books database has been provisioned.
class LocalSetupStorage {
  LocalSetupStorage._();

  static const _completedKey = 'local_books_setup_completed_v1';
  static const _adminEmailKey = 'local_setup_admin_email';
  static const _adminPasswordKey = 'local_setup_admin_password';

  static Future<bool> isCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_completedKey) ?? false;
  }

  static Future<void> markCompleted({
    required String adminEmail,
    required String adminPassword,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_completedKey, true);
    await prefs.setString(_adminEmailKey, adminEmail.trim().toLowerCase());
    await prefs.setString(_adminPasswordKey, adminPassword);
  }

  static Future<String?> getSavedAdminEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_adminEmailKey);
  }

  static Future<String?> getSavedAdminPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_adminPasswordKey);
  }

  /// Marks setup done without storing credentials (legacy DB migration).
  static Future<void> markLegacyMigrated() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_completedKey, true);
  }

  /// Dev / reinstall helper — clears setup flag only (not the db file).
  static Future<void> clearCompletedFlag() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_completedKey);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_completedKey);
    await prefs.remove(_adminEmailKey);
    await prefs.remove(_adminPasswordKey);
  }
}
