import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel/src/core/services/force_update/force_update_policy.dart';
import 'package:hotel/src/core/services/force_update/remote_config_bootstrap.dart';

/// Loads force-update policy from Remote Config, then fallbacks.
abstract final class ForceUpdateConfigLoader {
  static const _assetPath = 'assets/config/force_update_policy.json';
  static const _rtdbPath = 'app_settings/force_update';
  static const _biztrackDatabaseUrl =
      'https://biztrack-1f8db-default-rtdb.firebaseio.com';

  static Future<({ForceUpdatePolicy policy, String source})> load({
    bool fastStart = false,
  }) async {
    FirebaseRemoteConfig? remoteConfig;
    try {
      remoteConfig = await RemoteConfigBootstrap.ensureReady(
        fastStart: fastStart,
      );
      _logRemoteConfig(remoteConfig);

      if (ForceUpdatePolicy.hasFetchedFromServer(remoteConfig)) {
        return (
          policy: ForceUpdatePolicy.fromRemoteConfig(remoteConfig),
          source: 'remote_config',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ForceUpdateConfig: Remote Config unavailable: $e');
      }
    }

    if (fastStart) {
      if (remoteConfig != null &&
          ForceUpdatePolicy.hasFetchedFromServer(remoteConfig)) {
        return (
          policy: ForceUpdatePolicy.fromRemoteConfig(remoteConfig),
          source: 'cached',
        );
      }

      // RC fetch timed out or template empty — RTDB works in prod too.
      final rtdb = await _loadFromRtdb();
      if (rtdb != null) {
        log('ForceUpdateConfig: using RTDB fallback on fastStart');
        return (policy: rtdb, source: 'firebase_database');
      }

      if (remoteConfig != null) {
        return (
          policy: ForceUpdatePolicy.fromRemoteConfig(remoteConfig),
          source: 'cached',
        );
      }
      return (
        policy: ForceUpdatePolicy.fromJsonMap(const {
          'force_update_enabled': false,
        })!,
        source: 'unavailable',
      );
    }

    final rtdb = await _loadFromRtdb();
    if (rtdb != null) {
      return (policy: rtdb, source: 'firebase_database');
    }

    final http = await _loadFromHttp();
    if (http != null) {
      return (policy: http, source: 'http');
    }

    if (kDebugMode) {
      final asset = await _loadFromAsset();
      if (asset != null) {
        return (policy: asset, source: 'debug_asset');
      }
    }

    if (remoteConfig != null) {
      return (
        policy: ForceUpdatePolicy.fromRemoteConfig(remoteConfig),
        source: 'empty',
      );
    }

    return (
      policy: ForceUpdatePolicy.fromJsonMap(const {
        'force_update_enabled': false,
      })!,
      source: 'unavailable',
    );
  }

  static void _logRemoteConfig(FirebaseRemoteConfig remoteConfig) {
    if (!kDebugMode) return;
    try {
      final app = Firebase.app();
      debugPrint(
        'ForceUpdateConfig: project=${app.options.projectId} '
        'appId=${app.options.appId} '
        'lastStatus=${remoteConfig.lastFetchStatus} '
        'lastFetchTime=${remoteConfig.lastFetchTime}',
      );
    } catch (_) {}

    final all = remoteConfig.getAll();
    debugPrint('ForceUpdateConfig: RC keys (${all.length} total):');
    if (all.isEmpty) {
      debugPrint(
        '  (none) — Client template is empty on the server. '
        'Firebase Console → Remote Config → Client → Parameters must list '
        'your keys, then Publish. Or set RTDB path $_rtdbPath.',
      );
      return;
    }
    for (final e in all.entries) {
      debugPrint(
        '  ${e.key}="${e.value.asString()}" source=${e.value.source}',
      );
    }
  }

  static Future<ForceUpdatePolicy?> _loadFromRtdb() async {
    try {
      final db = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: _biztrackDatabaseUrl,
      );
      final snap = await db.ref(_rtdbPath).get();
      if (!snap.exists || snap.value == null) return null;
      final map = _normalizeMap(snap.value);
      if (map == null) return null;
      if (kDebugMode) {
        debugPrint('ForceUpdateConfig: loaded from RTDB $_rtdbPath');
      }
      return ForceUpdatePolicy.fromJsonMap(map);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ForceUpdateConfig: RTDB fallback skipped: $e');
      }
      return null;
    }
  }

  static Future<ForceUpdatePolicy?> _loadFromHttp() async {
    final url = dotenv.env['FORCE_UPDATE_CONFIG_URL']?.trim() ?? '';
    if (url.isEmpty) return null;
    try {
      final response = await Dio().get<String>(
        url,
        options: Options(responseType: ResponseType.plain),
      );
      final decoded = jsonDecode(response.data ?? '');
      final map = _normalizeMap(decoded);
      if (map == null) return null;
      if (kDebugMode) {
        debugPrint('ForceUpdateConfig: loaded from $url');
      }
      return ForceUpdatePolicy.fromJsonMap(map);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ForceUpdateConfig: HTTP fallback skipped: $e');
      }
      return null;
    }
  }

  static Future<ForceUpdatePolicy?> _loadFromAsset() async {
    try {
      final raw = await rootBundle.loadString(_assetPath);
      final decoded = jsonDecode(raw);
      final map = _normalizeMap(decoded);
      if (map == null) return null;
      return ForceUpdatePolicy.fromJsonMap(map);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ForceUpdateConfig: asset load failed: $e');
      }
      return null;
    }
  }

  static Map<String, dynamic>? _normalizeMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }
}
