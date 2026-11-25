import 'package:flutter/foundation.dart';

/// Signals [AppLockGate] to re-check whether the PIN screen should show.
final class AppLockCoordinator {
  AppLockCoordinator._();

  static final ValueNotifier<int> evaluationTick = ValueNotifier(0);
  static final ValueNotifier<int> sessionUnlockTick = ValueNotifier(0);

  static void requestEvaluation() {
    evaluationTick.value++;
  }

  /// Skip the PIN overlay for the rest of this foreground session (e.g. right
  /// after the user creates a PIN during login).
  static void markSessionUnlocked() {
    sessionUnlockTick.value++;
  }
}
