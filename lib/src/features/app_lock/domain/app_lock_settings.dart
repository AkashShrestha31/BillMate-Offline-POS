/// Per-organization, per-user app lock preferences.
class AppLockSettings {
  const AppLockSettings({
    required this.pinEnabled,
    required this.biometricEnabled,
  });

  final bool pinEnabled;
  final bool biometricEnabled;

  bool get isEnabled => pinEnabled;

  static const defaults = AppLockSettings(
    pinEnabled: false,
    biometricEnabled: false,
  );

  AppLockSettings copyWith({
    bool? pinEnabled,
    bool? biometricEnabled,
  }) {
    return AppLockSettings(
      pinEnabled: pinEnabled ?? this.pinEnabled,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
    );
  }
}
