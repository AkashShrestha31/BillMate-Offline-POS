/// A class containing security-related code length constants.
///
/// This class defines the standard lengths for different security codes
/// used in authentication and transactions.
class AppConstants {
  /// Use [AppLocalizations.platformAppDisplayName] / [defaultL10n] for user-visible app name.

  /// Keep in sync with `version` in pubspec.yaml (fallback when package_info fails).
  static const String appVersion = '1.0.0';

  /// Keep in sync with build number in pubspec.yaml (`1.0.0+N` → `N`).
  static const String appBuildNumber = '23';

  /// Full label used for force-update checks when [PackageInfo] is unavailable.
  static String get appVersionWithBuild => '$appVersion+$appBuildNumber';

  /// The required length for login authentication codes.
  ///
  /// This is typically used for passcode-based logins.
  static const int LOGIN_CODE_LENGTH = 5;

  /// App lock / quick-unlock PIN length (passcode keypad).
  static const int APP_LOCK_PIN_LENGTH = 4;

  /// Failed app-lock PIN attempts before sign-out to email/password login.
  static const int APP_LOCK_MAX_FAILED_ATTEMPTS = 3;

  /// The required length for transaction PINs.
  ///
  /// This defines the length of numeric PINs used for financial transactions.
  static const int TRANSACTION_PIN_LENGTH = 6;

  /// The required length for One-Time Passwords (OTP).
  ///
  /// This applies to OTPs sent via SMS, email, or other authentication methods.
  static const int OTP_LENGTH = 6;

  static const int MOBILE_NUMBER_LENGTH_MAX = 15;
  static const int RESEND_TIMER_TIME = 60;
  static String unAuthorized = 'unAuthorized';
  static var accessToken = 'accessToken';
  static var refreshToken = 'refreshToken';
  static var expiryTime = 'expiryTime';
  static var sessionToken = 'sessionToken';
  static var rememberMe = 'rememberMe';
  static var phoneNumber = 'phoneNumber';
  static var userId = 'userId';
  static var countryCode = 'countryCode';
  static var preferredLanguage = 'preferredLanguage';
  static var userName = 'username';
  static var rememberMeUserName = 'rememberMeUserName';
  static var hotel = 'hotel';
  static const String termsAndCondition = '';
  static const String errorDialog = 'errorDialog';
  static const String loadingDialog = 'loadingDialog';
  static const String successDialog = 'successDialog';

  static int expireTime(int? expireAt) {
    return DateTime.now().millisecondsSinceEpoch + 1000 * (expireAt ?? 60);
  }
}
