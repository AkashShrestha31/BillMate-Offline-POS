import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Persists whether demo / test data is loaded on this device.
class TestDataStorage {
  TestDataStorage._();

  static const _enabledKey = 'biztrack_test_data_enabled_v1';
  static const _extraOrgCodesKey = 'biztrack_test_extra_org_codes_v1';
  static const _orgTestLoginKey = 'biztrack_test_data_org_login_v1';

  static Future<bool> isEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enabledKey) ?? false;
  }

  static Future<void> setEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, enabled);
  }

  static Future<List<String>> getExtraOrgCodes() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_extraOrgCodesKey);
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.map((e) => e.toString()).where((c) => c.isNotEmpty).toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> setExtraOrgCodes(List<String> codes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_extraOrgCodesKey, jsonEncode(codes));
  }

  static Future<void> clearExtraOrgCodes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_extraOrgCodesKey);
  }

  /// Set when the user signed in via **Login with test data** on the org code page
  /// (fresh demo install — not manual setup + test data toggle).
  static Future<void> setProvisionedViaOrgTestLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value) {
      await prefs.setBool(_orgTestLoginKey, true);
    } else {
      await prefs.remove(_orgTestLoginKey);
    }
  }

  static Future<bool> isProvisionedViaOrgTestLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_orgTestLoginKey) ?? false;
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_enabledKey);
    await prefs.remove(_extraOrgCodesKey);
    await prefs.remove(_orgTestLoginKey);
  }
}
