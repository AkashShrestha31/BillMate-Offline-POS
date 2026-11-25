import 'package:flutter/material.dart';
import 'package:hotel/src/core/constants/app_constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/l10n/default_l10n.dart';
import 'package:hotel/src/core/navigation/root_navigator.dart';
import 'package:hotel/src/core/routes/app_router.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_coordinator.dart';
import 'package:hotel/src/features/app_lock/domain/app_lock_service.dart';

/// Tracks consecutive failed PIN entries for app lock screens.
class AppPinFailureTracker {
  AppPinFailureTracker({
    this.maxAttempts = AppConstants.APP_LOCK_MAX_FAILED_ATTEMPTS,
  });

  final int maxAttempts;
  int _failedAttempts = 0;

  int get remainingAttempts =>
      (maxAttempts - _failedAttempts).clamp(0, maxAttempts);

  bool recordFailure() {
    _failedAttempts++;
    return _failedAttempts >= maxAttempts;
  }

  void reset() => _failedAttempts = 0;
}

/// Clears app PIN and optionally signs out to the login screen.
Future<void> handleAppPinLockout(
  BuildContext context, {
  AppLockService? appLockService,
  bool signOut = true,
}) async {
  final service = appLockService ?? AppLockService();
  if (signOut) {
    await service.lockOutFromActiveSession();
  } else {
    await service.clearPinAfterLockout();
  }

  AppLockCoordinator.markSessionUnlocked();
  AppLockCoordinator.requestEvaluation();

  if (signOut) {
    await getIt<AppRouter>().replaceAll([const LoginRoute()]);
  }

  final message = context.mounted
      ? context.l10n.appPinLockoutMessage
      : defaultL10n.appPinLockoutMessage;
  final snackContext = RootNavigator.context;
  if (snackContext != null && snackContext.mounted) {
    snackContext.showKiiSnackBarWarning(message);
  } else if (context.mounted) {
    context.showKiiSnackBarWarning(message);
  }
}
