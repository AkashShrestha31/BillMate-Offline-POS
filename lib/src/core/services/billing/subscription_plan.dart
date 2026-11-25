import 'package:hotel/src/core/config/app_billing_config.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

enum SubscriptionPlanKind { monthly, yearly, lifetime }

class SubscriptionPlan {
  const SubscriptionPlan({
    required this.kind,
    required this.productId,
    required this.title,
    required this.subtitle,
    required this.fallbackPriceLabel,
    this.badge,
    this.storeProduct,
  });

  final SubscriptionPlanKind kind;
  final String productId;
  final String title;
  final String subtitle;
  final String fallbackPriceLabel;
  final String? badge;
  final ProductDetails? storeProduct;

  String get priceLabel => storeProduct?.price ?? fallbackPriceLabel;

  String? get pricePerMonthLabel {
    return switch (kind) {
      SubscriptionPlanKind.monthly => null,
      SubscriptionPlanKind.yearly => _perMonthFromYearly(yearlyUsd: AppBillingConfig.yearlyUsd),
      SubscriptionPlanKind.lifetime => 'One-time purchase',
    };
  }

  static String _perMonthFromYearly({required double yearlyUsd}) {
    final perMonth = yearlyUsd / 12;
    return '\$${perMonth.toStringAsFixed(2)}/mo';
  }

  static List<SubscriptionPlan> catalog() {
    return [
      SubscriptionPlan(
        kind: SubscriptionPlanKind.monthly,
        productId: AppBillingConfig.monthlyProductId,
        title: 'Monthly',
        subtitle: 'Flexible — cancel anytime',
        fallbackPriceLabel: '\$${AppBillingConfig.monthlyUsd.toStringAsFixed(2)}/mo',
      ),
      SubscriptionPlan(
        kind: SubscriptionPlanKind.yearly,
        productId: AppBillingConfig.yearlyProductId,
        title: 'Yearly',
        subtitle: 'Best value — save ${AppBillingConfig.yearlySavingsPercent}%',
        fallbackPriceLabel: '\$${AppBillingConfig.yearlyUsd.toStringAsFixed(2)}/yr',
        badge: 'Popular',
      ),
      SubscriptionPlan(
        kind: SubscriptionPlanKind.lifetime,
        productId: AppBillingConfig.lifetimeProductId,
        title: 'Lifetime',
        subtitle: 'Pay once, keep forever',
        fallbackPriceLabel: '\$${AppBillingConfig.lifetimeUsd.toStringAsFixed(2)}',
      ),
    ];
  }

  SubscriptionPlan copyWithProduct(ProductDetails? product) {
    return SubscriptionPlan(
      kind: kind,
      productId: productId,
      title: title,
      subtitle: subtitle,
      fallbackPriceLabel: fallbackPriceLabel,
      badge: badge,
      storeProduct: product ?? storeProduct,
    );
  }

  /// Maps a store product id to monthly / yearly / lifetime.
  static SubscriptionPlanKind? kindForProductId(String? productId) {
    if (productId == null || productId.isEmpty) return null;
    if (AppBillingConfig.isLifetimeProduct(productId)) {
      return SubscriptionPlanKind.lifetime;
    }
    if (productId == AppBillingConfig.yearlyProductId ||
        productId == AppBillingConfig.androidYearlyProductId) {
      return SubscriptionPlanKind.yearly;
    }
    if (productId == AppBillingConfig.monthlyProductId ||
        productId == AppBillingConfig.androidMonthlyProductId) {
      return SubscriptionPlanKind.monthly;
    }
    return null;
  }

  static String displayLabelForKind(SubscriptionPlanKind kind) {
    return switch (kind) {
      SubscriptionPlanKind.monthly => 'Monthly',
      SubscriptionPlanKind.yearly => 'Yearly',
      SubscriptionPlanKind.lifetime => 'Lifetime',
    };
  }

  static SubscriptionPlanKind? kindForPlanLabel(String? label) {
    return switch (label?.trim().toLowerCase()) {
      'monthly' => SubscriptionPlanKind.monthly,
      'yearly' => SubscriptionPlanKind.yearly,
      'lifetime' => SubscriptionPlanKind.lifetime,
      _ => null,
    };
  }
}
