import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/token_storage.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_settings.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_storage.dart';
import 'package:hotel/src/features/app_lock/domain/quick_unlock_import_gate.dart';
import 'package:local_auth/local_auth.dart';

enum AppLockBiometricKind {
  face,
  fingerprint,
  iris,
  generic,
  none,
}

/// Coordinates device-wide app lock settings, PIN verification, and biometrics.
class AppLockService {
  AppLockService({LocalAuthentication? localAuth})
      : _localAuth = localAuth ?? LocalAuthentication();

  final LocalAuthentication _localAuth;

  Future<bool> isSessionEligibleForLock() async {
    return TokenStorage.hasActiveSession();
  }

  Future<AppLockSettings> loadSettings() => AppLockStorage.load();

  Future<bool> isLockEnabled() async {
    if (!await isSessionEligibleForLock()) return false;
    final settings = await loadSettings();
    if (!settings.pinEnabled) return false;
    return AppLockStorage.hasPin();
  }

  Future<bool> isQuickUnlockConfigured() async {
    final settings = await loadSettings();
    if (!settings.pinEnabled) return false;
    return AppLockStorage.hasPin();
  }

  /// Login quick sign-in: local PIN must exist and match this email on device.
  Future<bool> isQuickUnlockConfiguredForEmail(String email) async {
    final normalized = email.trim().toLowerCase();
    if (normalized.isEmpty) return false;
    if (!await isQuickUnlockConfigured()) return false;

    final boundEmail = await AppLockStorage.getQuickUnlockEmail();
    if (boundEmail == null || boundEmail.isEmpty) return false;
    return boundEmail == normalized;
  }

  Future<void> saveSettings(AppLockSettings settings) =>
      AppLockStorage.save(settings);

  Future<bool> hasPin() => AppLockStorage.hasPin();

  Future<void> setPin(String pin, {String? email}) async {
    await AppLockStorage.savePinHash(pin);
    await _bindQuickUnlockEmail(email);
  }

  Future<void> _bindQuickUnlockEmail(String? email) async {
    final resolved = email?.trim().toLowerCase() ??
        (await SessionHelper.getLoggedInEmail())?.trim().toLowerCase() ??
        (await TokenStorage.getUserLoginEmail())?.trim().toLowerCase();
    if (resolved == null || resolved.isEmpty) return;

    await AppLockStorage.saveQuickUnlockEmail(resolved);
    final orgSlug = await OrgStorage.getOrgSlug();
    if (orgSlug != null && orgSlug.trim().isNotEmpty) {
      await QuickUnlockImportGate.clearForOrg(orgSlug);
    }
  }

  Future<bool> verifyPin(String pin) => AppLockStorage.verifyPin(pin);

  Future<void> removePin() => AppLockStorage.clearPin();

  Future<void> clearPinAfterLockout() async {
    await removePin();
    await saveSettings(AppLockSettings.defaults);
  }

  Future<void> lockOutFromActiveSession() async {
    await clearPinAfterLockout();
    await SessionHelper.clearSessionData();
  }

  Future<bool> canCheckBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  Future<bool> isDeviceSupported() async {
    try {
      return await _localAuth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<bool> isBiometricHardwareAvailable() async {
    return await isDeviceSupported() && await canCheckBiometrics();
  }

  Future<AppLockBiometricKind> resolveBiometricKind() async {
    try {
      if (!await isBiometricHardwareAvailable()) {
        return AppLockBiometricKind.none;
      }
      final types = await _localAuth.getAvailableBiometrics();
      if (types.isEmpty) return AppLockBiometricKind.none;
      if (types.contains(BiometricType.face)) {
        return AppLockBiometricKind.face;
      }
      if (types.contains(BiometricType.fingerprint)) {
        return AppLockBiometricKind.fingerprint;
      }
      if (types.contains(BiometricType.iris)) {
        return AppLockBiometricKind.iris;
      }
      return AppLockBiometricKind.generic;
    } catch (_) {
      return AppLockBiometricKind.none;
    }
  }

  /// Device has enrolled biometrics that can be used for unlock.
  Future<bool> isBiometricUnlockAvailable() async {
    final kind = await resolveBiometricKind();
    return kind != AppLockBiometricKind.none;
  }

  /// Settings flag plus live device support (ignores stale biometricEnabled).
  Future<bool> isBiometricUnlockEnabled() async {
    if (!await isBiometricUnlockAvailable()) return false;
    final settings = await loadSettings();
    return settings.biometricEnabled;
  }

  Future<bool> authenticateWithBiometrics({required String reason}) async {
    try {
      final supported = await isDeviceSupported();
      final canCheck = await canCheckBiometrics();
      if (!supported || !canCheck) return false;

      return _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }

  Future<bool> shouldOfferDevicePinSetup() async {
    if (await isQuickUnlockConfigured()) return false;
    if (await QuickUnlockImportGate.isActiveForCurrentOrg()) return false;
    final orgSlug = await OrgStorage.getOrgSlug();
    if (orgSlug == null || orgSlug.trim().isEmpty) return false;
    return true;
  }
}
