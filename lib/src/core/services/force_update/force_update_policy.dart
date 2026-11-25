import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hotel/src/core/config/app_platform_config.dart';
import 'package:hotel/src/core/services/app_rating/app_rating_service.dart';
import 'package:hotel/src/core/services/force_update/remote_config_keys.dart';

/// Resolved force-update policy from Firebase Remote Config.
class ForceUpdatePolicy {
  const ForceUpdatePolicy({
    required this.enabled,
    required this.minRequiredVersion,
    required this.minRequiredVersionAndroid,
    required this.minRequiredVersionIos,
    required this.title,
    required this.message,
    required this.androidStoreUrl,
    required this.iosStoreUrl,
  });

  final bool enabled;
  final String minRequiredVersion;
  final String minRequiredVersionAndroid;
  final String minRequiredVersionIos;
  final String title;
  final String message;
  final String androidStoreUrl;
  final String iosStoreUrl;

  static ForceUpdatePolicy fromRemoteConfig(FirebaseRemoteConfig config) {
    final fromBlob = _fromJsonBlob(config);
    if (fromBlob != null) return fromBlob;
    final fromMisconfigured = _fromMisconfiguredSingleKey(config);
    if (fromMisconfigured != null) return fromMisconfigured;
    return _fromIndividualParameters(config);
  }

  /// True when activated template values are present (by content, not only
  /// [ValueSource.valueRemote] — the SDK often reports [ValueSource.valueDefault]
  /// even after a successful fetch).
  static bool hasFetchedFromServer(FirebaseRemoteConfig config) {
    if (config.getString(RemoteConfigKeys.policyJson).trim().isNotEmpty) {
      return true;
    }
    if (config.getString(RemoteConfigKeys.minRequiredVersionAndroid).trim().isNotEmpty) {
      return true;
    }
    if (config.getString(RemoteConfigKeys.minRequiredVersionIos).trim().isNotEmpty) {
      return true;
    }
    final min = config.getString(RemoteConfigKeys.minRequiredVersion).trim();
    if (min.isNotEmpty) return true;
    if (_policyMapFromJsonString(
          config.getString(RemoteConfigKeys.forceUpdateEnabled).trim(),
        ) !=
        null) {
      return true;
    }
    return _hasRemoteSource(config, RemoteConfigKeys.forceUpdateEnabled);
  }

  static ForceUpdatePolicy _fromIndividualParameters(FirebaseRemoteConfig config) {
    return ForceUpdatePolicy(
      enabled: _readBool(config, RemoteConfigKeys.forceUpdateEnabled),
      minRequiredVersion:
          config.getString(RemoteConfigKeys.minRequiredVersion).trim(),
      minRequiredVersionAndroid:
          config.getString(RemoteConfigKeys.minRequiredVersionAndroid).trim(),
      minRequiredVersionIos:
          config.getString(RemoteConfigKeys.minRequiredVersionIos).trim(),
      title: _stringOr(
        config.getString(RemoteConfigKeys.forceUpdateTitle),
        'Update required',
      ),
      message: _stringOr(
        config.getString(RemoteConfigKeys.forceUpdateMessage),
        Platform.isIOS
            ? 'A new version of ${AppPlatformConfig.appName} is available. Please update to continue.'
            : 'A new version of BizTrack is available. Please update to continue.',
      ),
      androidStoreUrl: _stringOr(
        config.getString(RemoteConfigKeys.androidStoreUrl),
        'https://play.google.com/store/apps/details?id=ai.biztrack',
      ),
      iosStoreUrl: _stringOr(
        config.getString(RemoteConfigKeys.iosStoreUrl),
        AppRatingService.appStoreListingUrl,
      ),
    );
  }

  static ForceUpdatePolicy? fromJsonMap(Map<String, dynamic> map) {
    return ForceUpdatePolicy(
      enabled: _readBoolFromDynamic(map['force_update_enabled']),
      minRequiredVersion: _string(map['min_required_version']),
      minRequiredVersionAndroid: _string(map['min_required_version_android']),
      minRequiredVersionIos: _string(map['min_required_version_ios']),
      title: _string(map['force_update_title']),
      message: _string(map['force_update_message']),
      androidStoreUrl: _string(map['android_store_url']),
      iosStoreUrl: _string(map['ios_store_url']),
    );
  }

  static ForceUpdatePolicy? _fromJsonBlob(FirebaseRemoteConfig config) {
    final raw = config.getString(RemoteConfigKeys.policyJson).trim();
    if (raw.isEmpty) return null;
    final map = _policyMapFromJsonString(raw);
    return map != null ? fromJsonMap(map) : null;
  }

  /// Recovers when the whole Firebase template JSON was pasted into one RC key
  /// (usually [RemoteConfigKeys.forceUpdateEnabled] as a String).
  static ForceUpdatePolicy? _fromMisconfiguredSingleKey(
    FirebaseRemoteConfig config,
  ) {
    for (final key in [
      RemoteConfigKeys.forceUpdateEnabled,
      RemoteConfigKeys.policyJson,
    ]) {
      final raw = config.getString(key).trim();
      if (raw.isEmpty) continue;
      final map = _policyMapFromJsonString(raw);
      if (map != null) {
        return fromJsonMap(map);
      }
    }
    return null;
  }

  /// Accepts flat policy JSON or Firebase's `{ "parameters": { ... } }` template.
  static Map<String, dynamic>? _policyMapFromJsonString(String raw) {
    if (!raw.startsWith('{')) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      final map = Map<String, dynamic>.from(decoded);

      final parameters = map['parameters'];
      if (parameters is Map) {
        final flat = <String, dynamic>{};
        for (final entry in parameters.entries) {
          final param = entry.value;
          if (param is! Map) continue;
          final defaultValue = param['defaultValue'];
          if (defaultValue is Map && defaultValue['value'] != null) {
            flat[entry.key.toString()] = defaultValue['value'];
          }
        }
        if (flat.isNotEmpty) return flat;
      }

      if (map.containsKey('force_update_enabled')) {
        return map;
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  static bool _hasRemoteSource(FirebaseRemoteConfig config, String key) {
    return config.getValue(key).source == ValueSource.valueRemote;
  }

  static bool _readBool(FirebaseRemoteConfig config, String key) {
    final value = config.getValue(key);
    try {
      if (value.asBool()) return true;
    } catch (_) {}
    if (_readBoolFromDynamic(value.asString())) return true;
    try {
      if (config.getBool(key)) return true;
    } catch (_) {}
    return _readBoolFromDynamic(config.getString(key));
  }

  static bool _readBoolFromDynamic(dynamic value) {
    if (value is bool) return value;
    final raw = value?.toString().trim().toLowerCase() ?? '';
    return raw == 'true' || raw == '1' || raw == 'yes';
  }

  static String _string(dynamic value) => value?.toString().trim() ?? '';

  static String _stringOr(String value, String fallback) {
    final v = value.trim();
    return v.isEmpty ? fallback : v;
  }
}
