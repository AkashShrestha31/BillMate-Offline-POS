import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists app lock settings and PIN hashes for this device.
class AppLockStorage {
  AppLockStorage._();

  static const _deviceScope = 'device';
  static const _settingsPrefix = 'app_lock_settings_v1_';
  static const _pinHashPrefix = 'app_lock_pin_hash_v1_';
  static const _quickUnlockEmailKey = 'app_lock_quick_unlock_email_v1';
  static const _migrationDoneKey = 'app_lock_device_scope_migration_v1_done';

  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<void> _markDeviceScopeMigrationDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_migrationDoneKey, true);
  }

  static Future<void> _clearLegacyScopedData() async {
    final legacyScope = await _legacyUserScopeKey();
    if (legacyScope == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_settingsPrefix$legacyScope');
    await _secureStorage.delete(key: '$_pinHashPrefix$legacyScope');
  }

  static Future<void> _migrateLegacyUserScopedDataIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_migrationDoneKey) == true) return;

    final deviceSettingsKey = '$_settingsPrefix$_deviceScope';
    // Device settings already exist (including after PIN removal) — do not
    // restore legacy org/user scoped PIN data over the user's choice.
    if (prefs.containsKey(deviceSettingsKey)) {
      await _markDeviceScopeMigrationDone();
      return;
    }

    final legacyScope = await _legacyUserScopeKey();
    if (legacyScope == null) {
      await _markDeviceScopeMigrationDone();
      return;
    }

    final legacySettings = prefs.getString('$_settingsPrefix$legacyScope');
    if (legacySettings != null && legacySettings.isNotEmpty) {
      await prefs.setString(deviceSettingsKey, legacySettings);
    }

    final legacyHash =
        await _secureStorage.read(key: '$_pinHashPrefix$legacyScope');
    if (legacyHash != null && legacyHash.isNotEmpty) {
      await _secureStorage.write(
        key: '$_pinHashPrefix$_deviceScope',
        value: legacyHash,
      );
      final legacyEmail = _emailFromLegacyScope(legacyScope);
      if (legacyEmail != null) {
        await saveQuickUnlockEmail(legacyEmail);
      }
    }

    await _markDeviceScopeMigrationDone();
  }

  static Future<String?> _legacyUserScopeKey() async {
    final orgSlug = (await OrgStorage.getOrgSlug())?.trim().toLowerCase();
    final email = await SessionHelper.getLoggedInEmail();
    if (orgSlug == null ||
        orgSlug.isEmpty ||
        email == null ||
        email.trim().isEmpty) {
      return null;
    }
    return '${orgSlug}__${email.trim().toLowerCase()}';
  }

  static Future<AppLockSettings> load() async {
    await _migrateLegacyUserScopedDataIfNeeded();

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_settingsPrefix$_deviceScope');
    if (raw == null || raw.isEmpty) return AppLockSettings.defaults;

    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final settings = AppLockSettings(
        pinEnabled: map['pinEnabled'] == true,
        biometricEnabled: map['biometricEnabled'] == true,
      );
      if (!settings.pinEnabled && await hasPin(skipMigration: true)) {
        await clearPin();
      }
      return settings;
    } catch (_) {
      return AppLockSettings.defaults;
    }
  }

  static Future<void> save(AppLockSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '$_settingsPrefix$_deviceScope',
      jsonEncode({
        'pinEnabled': settings.pinEnabled,
        'biometricEnabled': settings.biometricEnabled,
      }),
    );
    await _markDeviceScopeMigrationDone();
    if (!settings.pinEnabled) {
      await _clearLegacyScopedData();
    }
  }

  static Future<bool> hasPin({bool skipMigration = false}) async {
    if (!skipMigration) {
      await _migrateLegacyUserScopedDataIfNeeded();
    }
    final hash = await _secureStorage.read(key: '$_pinHashPrefix$_deviceScope');
    return hash != null && hash.isNotEmpty;
  }

  static Future<void> savePinHash(String pin) async {
    final hash = sha256.convert(utf8.encode(pin.trim())).toString();
    await _secureStorage.write(
      key: '$_pinHashPrefix$_deviceScope',
      value: hash,
    );
  }

  static Future<bool> verifyPin(String pin) async {
    await _migrateLegacyUserScopedDataIfNeeded();
    final stored = await _secureStorage.read(key: '$_pinHashPrefix$_deviceScope');
    if (stored == null || stored.isEmpty) return false;
    final hash = sha256.convert(utf8.encode(pin.trim())).toString();
    return stored == hash;
  }

  static Future<void> clearPin() async {
    await _secureStorage.delete(key: '$_pinHashPrefix$_deviceScope');
    await clearQuickUnlockEmail();
    await _clearLegacyScopedData();
    await _markDeviceScopeMigrationDone();
  }

  static String? _emailFromLegacyScope(String legacyScope) {
    final separator = legacyScope.indexOf('__');
    if (separator < 0 || separator >= legacyScope.length - 2) return null;
    final email = legacyScope.substring(separator + 2).trim().toLowerCase();
    return email.isEmpty ? null : email;
  }

  static Future<void> saveQuickUnlockEmail(String email) async {
    final normalized = email.trim().toLowerCase();
    if (normalized.isEmpty) return;
    await _secureStorage.write(
      key: _quickUnlockEmailKey,
      value: normalized,
    );
  }

  static Future<String?> getQuickUnlockEmail() async {
    final email = await _secureStorage.read(key: _quickUnlockEmailKey);
    if (email == null || email.trim().isEmpty) return null;
    return email.trim().toLowerCase();
  }

  static Future<void> clearQuickUnlockEmail() async {
    await _secureStorage.delete(key: _quickUnlockEmailKey);
  }
}
