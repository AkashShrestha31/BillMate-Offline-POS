import 'dart:convert';

import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/org/saved_organization.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// All organizations the user has connected on this device.
class OrgRegistryStorage {
  OrgRegistryStorage._();

  static const _listKey = 'org_registry_v1';

  static Future<List<SavedOrganization>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_listKey)) {
      await registerFromCurrentOrgStorage();
    }
    return _readList(prefs);
  }

  static Future<List<SavedOrganization>> _readList(SharedPreferences prefs) async {
    final raw = prefs.getString(_listKey);
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => SavedOrganization.fromJson(Map<String, dynamic>.from(e as Map)))
          .where((o) => o.isValid)
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> addOrUpdate(SavedOrganization org) async {
    if (!org.isValid) return;
    final prefs = await SharedPreferences.getInstance();
    final all = await _readList(prefs);
    final updated = [
      org,
      ...all.where((o) => o.slug != org.slug && o.code != org.code),
    ];
    await prefs.setString(
      _listKey,
      jsonEncode(updated.map((o) => o.toJson()).toList()),
    );
  }

  static Future<void> removeByCodes(Iterable<String> codes) async {
    final removeSet = codes.map((c) => c.trim().toUpperCase()).where((c) => c.isNotEmpty).toSet();
    if (removeSet.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final all = await _readList(prefs);
    final kept = all.where((o) => !removeSet.contains(o.code.toUpperCase())).toList();
    await prefs.setString(
      _listKey,
      jsonEncode(kept.map((o) => o.toJson()).toList()),
    );
  }

  static Future<void> registerFromCurrentOrgStorage() async {
    final slug = await OrgStorage.getOrgSlug();
    final code = await OrgStorage.getOrgCode();
    final name = await OrgStorage.getOrgName();
    if (slug == null || slug.isEmpty || code == null || code.isEmpty) return;
    final businessType = await OrgStorage.getBusinessType();
    await addOrUpdate(
      SavedOrganization(
        slug: slug,
        code: code,
        name: name ?? slug,
        businessType: businessType,
      ),
    );
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_listKey);
  }
}
