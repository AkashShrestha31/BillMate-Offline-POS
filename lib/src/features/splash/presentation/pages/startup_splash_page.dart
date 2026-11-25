import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/app_constants.dart';
import 'package:hotel/src/core/l10n/app_locale_service.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/helpers/post_auth_navigation.dart';
import 'package:hotel/src/core/config/app_billing_config.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/billing/subscription_service.dart';
import 'package:hotel/src/core/services/force_update/force_update_result.dart';
import 'package:hotel/src/core/services/force_update/force_update_service.dart';
import 'package:hotel/src/core/config/app_platform_config.dart';
import 'package:hotel/src/core/widget/force_update_dialog.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/features/backup/domain/auto_backup_coordinator.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/token_storage.dart';
import 'package:hotel/src/features/org/domain/organization_database_service.dart';
import 'package:hotel/src/features/setup/domain/default_books_single_values.dart';
import 'package:hotel/src/features/setup/domain/local_books_schema_ensurer.dart';
import 'package:hotel/src/features/setup/domain/test_data_login_service.dart';
import 'package:hotel/src/features/onboarding/domain/app_walkthrough_storage.dart';
import 'package:hotel/src/features/org/presentation/org_navigation.dart';
import 'package:hotel/src/features/setup/domain/local_setup_service.dart';
import 'package:hotel/src/features/permission/presentation/cubit/user_permissions_cubit.dart';

/// First screen (`/`). Restores offline session from saved login email and loads permissions.
@RoutePage()
class StartupSplashPage extends StatefulWidget {
  const StartupSplashPage({super.key});

  @override
  State<StartupSplashPage> createState() => _StartupSplashPageState();
}

class _StartupSplashPageState extends State<StartupSplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  Future<ForceUpdateResult> _checkForceUpdate() async {
    try {
      // Debug: short RC timeout for fast iteration. Release/profile: full fetch
      // + RTDB fallback so prod builds reliably load published Remote Config.
      return await getIt<ForceUpdateService>().check(fastStart: kDebugMode);
    } catch (e, st) {
      log('Force update check skipped: $e', stackTrace: st);
      return ForceUpdateResult.notRequired(
        currentVersion: AppConstants.appVersionWithBuild,
      );
    }
  }

  Future<void> _leaveSplash(Future<void> Function() navigate) async {
    FlutterNativeSplash.remove();
    await navigate();
  }

  Future<void> _bootstrap() async {
    // Run network + local routing checks in parallel so splash is not sequential.
    final forceUpdateFuture = _checkForceUpdate();
    final routingFuture = Future.wait<bool>([
      AppLocaleService.isPreferenceSaved(),
      AppWalkthroughStorage.shouldShow(),
      TokenStorage.hasActiveSession(),
    ]);

    if (AppBillingConfig.requiresPremium) {
      unawaited(getIt<SubscriptionService>().initializeIfNeeded());
    }

    final forceUpdate = await forceUpdateFuture;
    if (!mounted) return;
    if (forceUpdate.isForceUpdateRequired) {
      // Wait for the route overlay so [showDialog] can attach.
      await Future<void>.delayed(Duration.zero);
      if (!mounted) return;
      FlutterNativeSplash.remove();
      await ForceUpdateDialog.show(context, forceUpdate);
      return;
    }

    final routing = await routingFuture;
    final needsLanguageSelection = !routing[0];
    final needsWalkthrough = routing[1];
    final isLoggedIn = routing[2];

    if (needsLanguageSelection) {
      if (!mounted) return;
      await _leaveSplash(() => context.router.replace(const LanguageSelectionRoute()));
      return;
    }

    if (needsWalkthrough && !isLoggedIn) {
      if (!mounted) return;
      await _leaveSplash(() => context.router.replace(const AppWalkthroughRoute()));
      return;
    }

    if (!isLoggedIn) {
      if (await LocalSetupService.needsSetup()) {
        if (!mounted) return;
        await _leaveSplash(() => context.router.replace(const LocalSetupRoute()));
        return;
      }
      await _leaveSplash(() => navigateToLoginGate(context.router));
      return;
    }

    if (!await OrgStorage.hasOrgSlug()) {
      if (!mounted) return;
      await _leaveSplash(() => navigateToLoginGate(context.router));
      return;
    }

    var dbUsable = await OrganizationDatabaseService.isActiveOrganizationUsable();
    if (!dbUsable) {
      dbUsable =
          await OrganizationDatabaseService.tryRepairActiveDatabaseHealth();
    }

    if (!dbUsable) {
      debugPrint(
        '[Startup] organization database is not usable — sign in again',
      );
      await SessionHelper.clearSessionData();
      LocalBooksSchemaEnsurer.resetSessionCache();
      await getIt<LocalDb>().resetConnection();
      if (!mounted) return;
      await _leaveSplash(() => navigateToLoginGate(context.router));
      return;
    }

    try {
      await TestDataLoginService().ensureActiveOrganizationDatabase();
      if (await LocalDb.databaseFileExists()) {
        unawaited(
          DefaultBooksSingleValues.ensureMissingDefaults(getIt<LocalDb>()).catchError(
            (Object e, StackTrace st) {
              debugPrint('[Startup] ensureMissingDefaults skipped: $e\n$st');
            },
          ),
        );
      }
    } catch (e, st) {
      debugPrint('[Startup] database bootstrap failed: $e\n$st');
      await SessionHelper.clearSessionData();
      LocalBooksSchemaEnsurer.resetSessionCache();
      await getIt<LocalDb>().resetConnection();
      if (!mounted) return;
      await _leaveSplash(() => navigateToLoginGate(context.router));
      return;
    }

    final emailForPermissions =
        (await TokenStorage.getUserLoginEmail())?.trim().toLowerCase() ?? '';

    if (!mounted) return;

    await context
        .read<UserPermissionsCubit>()
        .fetchUserPermissions(userId: emailForPermissions);

    if (!mounted) return;
    unawaited(getIt<AutoBackupCoordinator>().maybeRunOnAppStart());
    await _leaveSplash(() => navigateToHomeOrPaywall(context.router));
  }

  @override
  Widget build(BuildContext context) {
    // Native launch screen stays visible via FlutterNativeSplash.preserve().
    // Keep this frame the same white splash on both platforms so Android
    // does not flash a second logo after the native splash is removed.
    return const Material(
      color: Color(AppPlatformConfig.splashBackgroundColor),
      child: SizedBox.shrink(),
    );
  }
}
