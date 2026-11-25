import 'package:flutter/foundation.dart';

/// Debug logging for demo / test-data import (filter logcat for `TestDataSeed`).
abstract final class TestDataSeedLog {
  static void step(String message) {
    debugPrint('[TestDataSeed] $message');
  }

  static void error(String message, [Object? error, StackTrace? stack]) {
    debugPrint('[TestDataSeed] ERROR: $message');
    if (error != null) debugPrint('[TestDataSeed]   $error');
    if (stack != null) debugPrint('[TestDataSeed]   $stack');
  }
}
