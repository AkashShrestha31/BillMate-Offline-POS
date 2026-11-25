import 'package:shared_preferences/shared_preferences.dart';

/// Persists the logged-in user email (offline session — no JWT).
class TokenStorage {
  TokenStorage._();

  static const String _userLoginEmailKey = 'user_login_email';

  // Legacy keys — cleared on logout for installs that stored JWTs.
  static const String _legacyAccessTokenKey = 'access_token';
  static const String _legacyRefreshTokenKey = 'refresh_token';

  static Future<void> saveUserLoginEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final trimmed = email.trim();
    if (trimmed.isEmpty) return;
    await prefs.setString(_userLoginEmailKey, trimmed.toLowerCase());
  }

  static Future<String?> getUserLoginEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userLoginEmailKey);
  }

  static Future<bool> hasActiveSession() async {
    final email = await getUserLoginEmail();
    return email != null && email.trim().isNotEmpty;
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userLoginEmailKey);
    await prefs.remove(_legacyAccessTokenKey);
    await prefs.remove(_legacyRefreshTokenKey);
  }

  @Deprecated('Use clearSession')
  static Future<void> clearTokens() => clearSession();
}
