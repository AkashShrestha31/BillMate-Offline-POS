import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:hotel/firebase_options.dart';

/// Ensures Firebase is initialized once per process (safe across hot restart).
abstract final class FirebaseBootstrap {
  static Future<void>? _initFuture;

  static Future<void> ensureInitialized() async {
    if (_hasDefaultApp) {
      return;
    }
    await (_initFuture ??= _initialize());
  }

  static bool get _hasDefaultApp {
    if (Firebase.apps.isNotEmpty) {
      return true;
    }
    try {
      Firebase.app();
      return true;
    } on FirebaseException {
      return false;
    }
  }

  static bool get hasFirebaseApp => _hasDefaultApp;

  static Future<void> _initialize() async {
    if (_hasDefaultApp) {
      return;
    }
    try {
      // Prefer native google-services.json / GoogleService-Info.plist on mobile.
      // Passing different [FirebaseOptions] in Dart can leave Remote Config with
      // an empty/static template (RC key count=1).
      final useNativeConfig = !kIsWeb &&
          (defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS);
      if (useNativeConfig) {
        await Firebase.initializeApp();
      } else {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
      if (kDebugMode) {
        final app = Firebase.app();
        log(
          'Firebase ready: project=${app.options.projectId} '
          'appId=${app.options.appId}',
        );
      }
    } on FirebaseException catch (e) {
      if (e.code == 'duplicate-app') {
        try {
          Firebase.app();
        } catch (_) {
          _logInitFailure(e);
        }
        return;
      }
      _logInitFailure(e);
    } catch (e, st) {
      _logInitFailure(e, st);
    }
  }

  static void _logInitFailure(Object e, [StackTrace? st]) {
    if (kDebugMode) {
      log(
        'Firebase init skipped: $e '
        '(use full restart, not hot restart, after native/plugin changes)',
        stackTrace: st,
      );
    }
  }
}
