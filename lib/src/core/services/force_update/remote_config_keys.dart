/// Firebase Remote Config parameter names for app update policy.
///
/// **Publish to Firebase (required):** Console → Remote Config → **Client**
/// template → ⋮ → **Publish from file** →
/// `remote_config/firebase_remote_config_template.json` → **Publish**.
///
/// Do **not** upload `remote_config_force_update.json` (flat JSON) — Firebase
/// rejects that format. The flat file is only a human-readable reference.
///
/// Alternative: one String parameter [policyJson] whose value is the full JSON
/// object (same shape as `remote_config_force_update.json`).
abstract final class RemoteConfigKeys {
  /// Optional single JSON blob (String) containing all force-update fields.
  static const policyJson = 'force_update_policy';
  /// When false, no force-update check is applied.
  static const forceUpdateEnabled = 'force_update_enabled';

  /// Minimum app version (e.g. `1.0.0`). Users below this must update.
  static const minRequiredVersion = 'min_required_version';

  /// Optional Android-only minimum (overrides [minRequiredVersion] on Android when set).
  static const minRequiredVersionAndroid = 'min_required_version_android';

  /// Optional iOS-only minimum (overrides [minRequiredVersion] on iOS when set).
  static const minRequiredVersionIos = 'min_required_version_ios';

  static const forceUpdateTitle = 'force_update_title';
  static const forceUpdateMessage = 'force_update_message';

  static const androidStoreUrl = 'android_store_url';
  static const iosStoreUrl = 'ios_store_url';
}
