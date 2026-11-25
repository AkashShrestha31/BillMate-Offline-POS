import 'package:auto_route/auto_route.dart';
import 'package:hotel/src/core/config/app_billing_config.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/billing/subscription_service.dart';

/// After login or cold-start session restore, open the main app (freemium on iOS).
Future<void> navigateToHomeOrPaywall(StackRouter router) async {
  if (AppBillingConfig.requiresPremium) {
    final billing = getIt<SubscriptionService>();
    await billing.initializeIfNeeded();
  }

  await router.replace(const MainRoute());
}
