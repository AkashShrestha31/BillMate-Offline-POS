import 'package:flutter/material.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/routes/app_router.dart';
import 'package:hotel/src/core/services/token_storage.dart';

/// Resolves the auto_route root [NavigatorState] for global dialogs.
abstract final class RootNavigator {
  static NavigatorState? get state => getIt<AppRouter>().navigatorKey.currentState;

  static BuildContext? get context => state?.context;

  /// Shift reminders only after login/onboarding routes.
  static Future<bool> canShowGlobalDialog() async {
    if (!await TokenStorage.hasActiveSession()) return false;

    final router = getIt<AppRouter>();
    if (state?.context == null) return false;

    const blockedPaths = <String>{
      '/',
      '/login',
      '/walkthrough',
      '/local-setup',
      '/organization',
      '/language-selection',
    };
    return !blockedPaths.contains(router.current.path);
  }
}
