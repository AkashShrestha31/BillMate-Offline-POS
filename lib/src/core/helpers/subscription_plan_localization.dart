import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/config/app_billing_config.dart';
import 'package:hotel/src/core/services/billing/subscription_plan.dart';

extension SubscriptionPlanL10n on AppLocalizations {
  String planTitle(SubscriptionPlanKind kind) {
    return switch (kind) {
      SubscriptionPlanKind.monthly => premiumPlanMonthly,
      SubscriptionPlanKind.yearly => premiumPlanYearly,
      SubscriptionPlanKind.lifetime => premiumPlanLifetime,
    };
  }

  String planSubtitle(SubscriptionPlanKind kind) {
    return switch (kind) {
      SubscriptionPlanKind.monthly => premiumPlanMonthlySubtitle,
      SubscriptionPlanKind.yearly =>
        premiumPlanYearlySubtitle(AppBillingConfig.yearlySavingsPercent),
      SubscriptionPlanKind.lifetime => premiumPlanLifetimeSubtitle,
    };
  }

  String? planBadge(SubscriptionPlanKind kind) {
    return switch (kind) {
      SubscriptionPlanKind.yearly => premiumPlanPopular,
      _ => null,
    };
  }

  String? planPricePerMonthLabel(SubscriptionPlanKind kind) {
    return switch (kind) {
      SubscriptionPlanKind.yearly => null,
      SubscriptionPlanKind.lifetime => premiumOneTimePurchase,
      SubscriptionPlanKind.monthly => null,
    };
  }

  String planDisplayLabel(SubscriptionPlanKind kind) => planTitle(kind);
}
