import 'dart:io';

import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel/src/core/config/app_platform_config.dart';

/// Platform billing flags and App Store / Play product identifiers.
abstract final class AppBillingConfig {
  static const _defaultMonthlyId = 'ai.billmate.monthly';
  static const _defaultYearlyId = 'ai.billmate.annually';
  static const _defaultLifetimeId = 'ai.billmate.pro';

  /// Fallback USD prices shown before the store returns localized amounts.
  static const monthlyUsd = 2.99;
  static const yearlyUsd = 19.99;
  static const lifetimeUsd = 29.99;

  static bool _bool(String key, {bool defaultValue = false}) {
    final raw = dotenv.env[key]?.trim().toLowerCase();
    if (raw == null || raw.isEmpty) return defaultValue;
    return raw == 'true' || raw == '1' || raw == 'yes';
  }

  static String _productId(String key, String fallback) {
    final raw = dotenv.env[key]?.trim();
    if (raw == null || raw.isEmpty) return fallback;
    return raw;
  }

  static bool get androidBillingEnabled =>
      _bool('ANDROID_BILLING_ENABLED', defaultValue: false);

  static bool get iosBillingEnabled =>
      _bool('IOS_BILLING_ENABLED', defaultValue: true);

  /// Debug-only bypass so iOS builds can run without App Store products.
  static bool get devBypass =>
      kDebugMode && _bool('IOS_BILLING_DEV_BYPASS', defaultValue: false);

  static bool get requiresPremium {
    if (devBypass) return false;
    if (AppPlatformConfig.isIOS) return iosBillingEnabled;
    if (!kIsWeb && Platform.isAndroid) return androidBillingEnabled;
    return false;
  }

  /// Show subscription UI in settings and paywall entry points.
  static bool get showBillingUi => requiresPremium;

  static bool get iapEnabled => requiresPremium && !kIsWeb;

  static String get monthlyProductId =>
      _productId('IOS_PRODUCT_MONTHLY', _defaultMonthlyId);

  static String get yearlyProductId =>
      _productId('IOS_PRODUCT_YEARLY', _defaultYearlyId);

  static String get lifetimeProductId =>
      _productId('IOS_PRODUCT_LIFETIME', _defaultLifetimeId);

  static String get androidMonthlyProductId =>
      _productId('ANDROID_PRODUCT_MONTHLY', _defaultMonthlyId);

  static String get androidYearlyProductId =>
      _productId('ANDROID_PRODUCT_YEARLY', _defaultYearlyId);

  static String get androidLifetimeProductId =>
      _productId('ANDROID_PRODUCT_LIFETIME', _defaultLifetimeId);

  static Set<String> get productIds {
    if (AppPlatformConfig.isIOS) {
      return {monthlyProductId, yearlyProductId, lifetimeProductId};
    }
    if (!kIsWeb && Platform.isAndroid) {
      return {
        androidMonthlyProductId,
        androidYearlyProductId,
        androidLifetimeProductId,
      };
    }
    return {};
  }

  static bool isLifetimeProduct(String productId) {
    return productId == lifetimeProductId ||
        productId == androidLifetimeProductId;
  }

  static bool isPremiumProduct(String productId) => productIds.contains(productId);

  /// Yearly plan saves vs paying monthly for 12 months.
  static int get yearlySavingsPercent {
    final monthlyTotal = monthlyUsd * 12;
    if (monthlyTotal <= 0) return 0;
    return (((monthlyTotal - yearlyUsd) / monthlyTotal) * 100).round();
  }
}
