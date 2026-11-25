import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/helpers/logged_in_profile_store.dart';
import 'package:hotel/src/core/services/currency/app_currency_service.dart';
import 'package:hotel/src/core/services/display_precision/app_display_precision_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/permission/presentation/cubit/user_permissions_cubit.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';

/// Notifies shell screens and clears cached bloc data after an organization switch.
class OrgSwitchCoordinator {
  OrgSwitchCoordinator._();

  static final notifier = ValueNotifier<int>(0);

  static Future<void> finishSwitch(
    BuildContext context, {
    required String email,
  }) async {
    await getIt<LocalDb>().resetConnection();
    await Future.wait([
      getIt<AppCurrencyService>().load(),
      getIt<AppDisplayPrecisionService>().load(),
      getIt<LiveStockTrackingService>().refreshCache(),
    ]);
    loggedInProfileStore.clear();

    await context
        .read<UserPermissionsCubit>()
        .fetchUserPermissions(userId: email);

    notifier.value++;
  }
}
