import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Last successful login email per organization (for quick unlock on login).
class LastLoginEmailStorage {
  LastLoginEmailStorage._();

  static const _prefix = 'last_login_email_v1_';

  static Future<void> save(String email) async {
    final orgSlug = (await OrgStorage.getOrgSlug())?.trim().toLowerCase();
    final trimmed = email.trim().toLowerCase();
    if (orgSlug == null || orgSlug.isEmpty || trimmed.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_prefix$orgSlug', trimmed);
  }

  static Future<String?> load() async {
    final orgSlug = (await OrgStorage.getOrgSlug())?.trim().toLowerCase();
    if (orgSlug == null || orgSlug.isEmpty) return null;

    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('$_prefix$orgSlug')?.trim().toLowerCase();
    return (email == null || email.isEmpty) ? null : email;
  }
}
