import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Shared BillMate branding. Android keeps its own application id.
abstract final class AppPlatformConfig {
  static bool get isIOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  static String get appName => 'BillMate';

  /// Prefix for exported login credential PDF filenames.
  static String get credentialsFilePrefix => 'billmate';

  static String get brandPrefix => 'Bill';

  static String get brandSuffix => 'Mate';

  /// In-app logo PNG (same artwork as the iOS home-screen icon).
  static String get logoAsset => 'assets/images/logo_ios.png';

  /// Full splash illustration used on iOS and Android.
  static String? get splashAsset => 'assets/images/splash_ios.png';

  /// Native / in-app splash background (matches the iOS launch screen).
  static const int splashBackgroundColor = 0xFFFFFFFF;

  /// BillMate hosted site (FAQ, legal pages).
  static const billmateWebBaseUrl = 'https://billmate-woad.vercel.app/';

  /// Hosted privacy policy for BillMate (App Store / Play compliance).
  static const privacyPolicyUrl = billmateWebBaseUrl;

  static const billmatePrivacyPolicyUrl = privacyPolicyUrl;

  static const billmateFaqUrl = billmateWebBaseUrl;

  /// Apple Standard EULA for auto-renewable subscriptions (App Store metadata).
  static const appleStandardEulaUrl =
      'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/';

  static String? get externalPrivacyPolicyUrl => privacyPolicyUrl;

  static String? get externalTermsOfUseUrl =>
      isIOS ? appleStandardEulaUrl : null;

  static String? get externalFaqUrl => isIOS ? billmateFaqUrl : null;
}
