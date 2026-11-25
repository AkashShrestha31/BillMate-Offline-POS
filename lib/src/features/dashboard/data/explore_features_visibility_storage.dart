import 'dart:convert';

import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Per-organization dashboard preference: which Explore Features tiles are hidden.
class ExploreFeaturesVisibilityStorage {
  ExploreFeaturesVisibilityStorage._();

  static const _prefsPrefix = 'explore_features_hidden_';

  static Future<Set<String>> getHiddenIds({String? orgSlug}) async {
    final slug = await _resolveSlug(orgSlug);
    if (slug == null) return {};

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_prefsPrefix$slug');
    if (raw == null || raw.isEmpty) return {};

    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.map((e) => e.toString()).toSet();
    } catch (_) {
      return {};
    }
  }

  static Future<void> setHiddenIds(
    Set<String> hiddenIds, {
    String? orgSlug,
  }) async {
    final slug = await _resolveSlug(orgSlug);
    if (slug == null) return;

    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(hiddenIds.toList()..sort());
    await prefs.setString('$_prefsPrefix$slug', encoded);
  }

  static Future<String?> _resolveSlug(String? orgSlug) async {
    final slug = orgSlug ?? await OrgStorage.getOrgSlug();
    if (slug == null || slug.trim().isEmpty) return null;
    return slug.trim();
  }
}
