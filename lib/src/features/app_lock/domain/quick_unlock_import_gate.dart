import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Skips login quick-unlock prompts until the user sets a local PIN on device.
class QuickUnlockImportGate {
  QuickUnlockImportGate._();

  static const _prefix = 'quick_unlock_import_gate_v1_';

  static Future<void> markOrgImported(String orgSlug) async {
    final slug = orgSlug.trim().toLowerCase();
    if (slug.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_prefix$slug', true);
  }

  static Future<bool> isActiveForCurrentOrg() async {
    final orgSlug = (await OrgStorage.getOrgSlug())?.trim().toLowerCase();
    if (orgSlug == null || orgSlug.isEmpty) return false;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_prefix$orgSlug') ?? false;
  }

  static Future<void> clearForOrg(String orgSlug) async {
    final slug = orgSlug.trim().toLowerCase();
    if (slug.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefix$slug');
  }
}
