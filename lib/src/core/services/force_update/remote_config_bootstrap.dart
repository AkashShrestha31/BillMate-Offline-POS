import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:hotel/src/core/services/firebase_bootstrap.dart';

/// Fetches and activates the Remote Config **client** template.
///
/// Do not call [FirebaseRemoteConfig.setDefaults] for force-update keys here.
/// In-app defaults with the same keys as the server template prevent you from
/// seeing published values (everything stays [ValueSource.valueDefault]).
abstract final class RemoteConfigBootstrap {
  /// When [fastStart] is true, use a short network timeout so cold start is not
  /// blocked waiting for Remote Config (cached values are used on timeout).
  static Future<FirebaseRemoteConfig> ensureReady({
    bool fastStart = false,
  }) async {
    await FirebaseBootstrap.ensureInitialized();

    final app = Firebase.app();
    final remoteConfig = FirebaseRemoteConfig.instanceFor(app: app);
    await remoteConfig.ensureInitialized();

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: fastStart
            ? (kDebugMode
                ? const Duration(seconds: 2)
                : const Duration(seconds: 8))
            : kDebugMode
                ? const Duration(seconds: 5)
                : const Duration(seconds: 12),
        minimumFetchInterval: kDebugMode
            ? Duration.zero
            : const Duration(hours: 1),
      ),
    );

    await _fetchAndActivate(remoteConfig);

    return remoteConfig;
  }

  static Future<void> _fetchAndActivate(
    FirebaseRemoteConfig remoteConfig,
  ) async {
    StreamSubscription<RemoteConfigUpdate>? realtimeSub;

    if (!kIsWeb) {
      realtimeSub = remoteConfig.onConfigUpdated.listen((event) async {
        if (kDebugMode) {
          debugPrint(
            'RemoteConfigBootstrap: onConfigUpdated keys=${event.updatedKeys}',
          );
        }
        try {
          await remoteConfig.activate();
        } catch (e) {
          if (kDebugMode) {
            debugPrint('RemoteConfigBootstrap: activate on update failed: $e');
          }
        }
      });
    }

    try {
      final updated = await remoteConfig.fetchAndActivate();
      if (kDebugMode) {
        debugPrint(
          'RemoteConfigBootstrap: fetchAndActivate updated=$updated '
          'status=${remoteConfig.lastFetchStatus}',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(
          'RemoteConfigBootstrap: fetch skipped ($e) — '
          'using cached Remote Config / local fallbacks',
        );
      }
      try {
        await remoteConfig.activate();
      } catch (_) {
        // No cached template — [ForceUpdateConfigLoader] uses RTDB/HTTP/asset.
      }
    } finally {
      await realtimeSub?.cancel();
    }
  }
}
