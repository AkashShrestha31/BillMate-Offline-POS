import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/config/app_platform_config.dart';

extension PlatformAppLocalizations on AppLocalizations {
  /// User-visible app name (BillMate on iOS and Android).
  String get platformAppDisplayName => AppPlatformConfig.appName;

  /// Biometric prompt with the shared app name.
  String get platformBiometricUnlockReason =>
      biometricUnlockReason.replaceAll('BizTrack', AppPlatformConfig.appName);

  /// Rate-us subtitle with the shared app name and the platform store.
  String get platformRateUsSubtitle {
    final named = rateUsSubtitle.replaceAll('BizTrack', AppPlatformConfig.appName);
    if (!AppPlatformConfig.isIOS) return named;
    return named.replaceAll('Google Play', 'the App Store');
  }

  /// Replaces BizTrack with the shared app name in any user-visible string.
  String withPlatformAppName(String text) {
    return text.replaceAll('BizTrack', AppPlatformConfig.appName);
  }
}
