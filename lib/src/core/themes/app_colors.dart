import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Same palette on Android and iOS.
  static bool get _isIOS => true;

  // Android — Green (#14A05F)
  static const Color _androidPrimary = Color(0xFF14A05F);
  static const Color _androidPrimaryLight = Color(0xFF45B882);
  static const Color _androidPrimaryDark = Color(0xFF0F8049);
  static const Color _androidSecondary = Color(0xFF128A55);

  // iOS — Deep Teal (#006B6B) + Emerald Green (#18C98B)
  static const Color _iosPrimary = Color(0xFF006B6B);
  static const Color _iosPrimaryLight = Color(0xFF008F8F);
  static const Color _iosPrimaryDark = Color(0xFF004F4F);
  static const Color _iosSecondary = Color(0xFF18C98B);

  static Color get _primary => _isIOS ? _iosPrimary : _androidPrimary;

  static Color get _primaryLight =>
      _isIOS ? _iosPrimaryLight : _androidPrimaryLight;

  static Color get _primaryDark =>
      _isIOS ? _iosPrimaryDark : _androidPrimaryDark;

  static Color get _secondary => _isIOS ? _iosSecondary : _androidSecondary;

  // Light Mode Color Scheme (Android default)
  static const _androidLightColorScheme = ColorScheme(
    brightness: Brightness.light,

    primary: _androidPrimary,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD4EDE3),
    onPrimaryContainer: Color(0xFF052E1A),
    primaryFixed: Color(0xFFD4EDE3),
    primaryFixedDim: Color(0xFFB8E0CE),
    onPrimaryFixed: Color(0xFF052E1A),
    onPrimaryFixedVariant: Color(0xFF0F8049),

    secondary: _androidSecondary,
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE3F5EC),
    onSecondaryContainer: Color(0xFF052E1A),
    secondaryFixed: Color(0xFFE3F5EC),
    secondaryFixedDim: Color(0xFFC8E8D8),
    onSecondaryFixed: Color(0xFF052E1A),
    onSecondaryFixedVariant: Color(0xFF0F8049),

    tertiary: Color(0xFF0A5C38),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFC8E8D8),
    onTertiaryContainer: Color(0xFF002114),
    tertiaryFixed: Color(0xFFC8E8D8),
    tertiaryFixedDim: Color(0xFFA8DCC4),
    onTertiaryFixed: Color(0xFF002114),
    onTertiaryFixedVariant: Color(0xFF084A2E),

    error: Color(0xFFDC2626),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    surface: Color(0xFFFAFAFC),
    onSurface: Color(0xFF1A1B1E),
    surfaceTint: _androidPrimary,

    surfaceDim: Color(0xFFE8E8EC),
    surfaceBright: Color(0xFFFAFAFC),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF5F5F7),
    surfaceContainer: Color(0xFFF0F0F2),
    surfaceContainerHigh: Color(0xFFEBEBEE),
    surfaceContainerHighest: Color(0xFFE5E5EA),

    inverseSurface: Color(0xFF2F3034),
    onInverseSurface: Color(0xFFF2F1F6),
    inversePrimary: _androidPrimaryLight,

    outline: Color(0xFF8B85A8),
    outlineVariant: Color(0xFFE4E1EC),

    onSurfaceVariant: Color(0xFF49454F),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  static const _iosLightColorScheme = ColorScheme(
    brightness: Brightness.light,

    primary: _iosPrimary,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFB2E4E4),
    onPrimaryContainer: Color(0xFF002020),
    primaryFixed: Color(0xFFB2E4E4),
    primaryFixedDim: Color(0xFF96D4D4),
    onPrimaryFixed: Color(0xFF002020),
    onPrimaryFixedVariant: Color(0xFF004F4F),

    secondary: _iosSecondary,
    onSecondary: Color(0xFF002114),
    secondaryContainer: Color(0xFFD4F8EA),
    onSecondaryContainer: Color(0xFF002114),
    secondaryFixed: Color(0xFFD4F8EA),
    secondaryFixedDim: Color(0xFFB8F0DC),
    onSecondaryFixed: Color(0xFF002114),
    onSecondaryFixedVariant: Color(0xFF006B6B),

    tertiary: Color(0xFF004F4F),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFF96D4D4),
    onTertiaryContainer: Color(0xFF001818),
    tertiaryFixed: Color(0xFF96D4D4),
    tertiaryFixedDim: Color(0xFF7AC4C4),
    onTertiaryFixed: Color(0xFF001818),
    onTertiaryFixedVariant: Color(0xFF003838),

    error: Color(0xFFDC2626),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    surface: Color(0xFFFAFAFC),
    onSurface: Color(0xFF1A1B1E),
    surfaceTint: _iosPrimary,

    surfaceDim: Color(0xFFE8E8EC),
    surfaceBright: Color(0xFFFAFAFC),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF5F5F7),
    surfaceContainer: Color(0xFFF0F0F2),
    surfaceContainerHigh: Color(0xFFEBEBEE),
    surfaceContainerHighest: Color(0xFFE5E5EA),

    inverseSurface: Color(0xFF2F3034),
    onInverseSurface: Color(0xFFF2F1F6),
    inversePrimary: _iosPrimaryLight,

    outline: Color(0xFF8B85A8),
    outlineVariant: Color(0xFFE4E1EC),

    onSurfaceVariant: Color(0xFF49454F),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  static ColorScheme get lightColorScheme =>
      _isIOS ? _iosLightColorScheme : _androidLightColorScheme;

  // Dark Mode Color Scheme (Android default)
  static const _androidDarkColorScheme = ColorScheme(
    brightness: Brightness.dark,

    primary: _androidPrimary,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: _androidPrimaryDark,
    onPrimaryContainer: Color(0xFFD4EDE3),
    primaryFixed: Color(0xFFD4EDE3),
    primaryFixedDim: Color(0xFFB8E0CE),
    onPrimaryFixed: Color(0xFF052E1A),
    onPrimaryFixedVariant: Color(0xFF0F8049),

    secondary: Color(0xFF5CC48E),
    onSecondary: Color(0xFF052E1A),
    secondaryContainer: Color(0xFF0A4D30),
    onSecondaryContainer: Color(0xFFC8E8D8),
    secondaryFixed: Color(0xFFE3F5EC),
    secondaryFixedDim: Color(0xFFC8E8D8),
    onSecondaryFixed: Color(0xFF052E1A),
    onSecondaryFixedVariant: Color(0xFF0F8049),

    tertiary: Color(0xFF7AD4A8),
    onTertiary: Color(0xFF002114),
    tertiaryContainer: Color(0xFF084A2E),
    onTertiaryContainer: Color(0xFFA8DCC4),
    tertiaryFixed: Color(0xFFC8E8D8),
    tertiaryFixedDim: Color(0xFFA8DCC4),
    onTertiaryFixed: Color(0xFF002114),
    onTertiaryFixedVariant: Color(0xFF084A2E),

    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),

    surface: Color(0xFF1C1C1E),
    onSurface: Color(0xFFF2F2F3),
    surfaceTint: _androidPrimary,

    surfaceDim: Color(0xFF0E0E10),
    surfaceBright: Color(0xFF2C2C30),
    surfaceContainerLowest: Color(0xFF101012),
    surfaceContainerLow: Color(0xFF141416),
    surfaceContainer: Color(0xFF1A1A1E),
    surfaceContainerHigh: Color(0xFF222226),
    surfaceContainerHighest: Color(0xFF2A2A2E),

    inverseSurface: Color(0xFFF0F0F0),
    onInverseSurface: Color(0xFF1A1A1A),
    inversePrimary: _androidPrimary,

    outline: Color(0xFF6B6B6B),
    outlineVariant: Color(0xFF3A3A3A),

    onSurfaceVariant: Color(0xFFC4C4C8),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  static const _iosDarkColorScheme = ColorScheme(
    brightness: Brightness.dark,

    primary: _iosPrimary,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: _iosPrimaryDark,
    onPrimaryContainer: Color(0xFFB2E4E4),
    primaryFixed: Color(0xFFB2E4E4),
    primaryFixedDim: Color(0xFF96D4D4),
    onPrimaryFixed: Color(0xFF002020),
    onPrimaryFixedVariant: Color(0xFF004F4F),

    secondary: _iosSecondary,
    onSecondary: Color(0xFF002114),
    secondaryContainer: Color(0xFF005C40),
    onSecondaryContainer: Color(0xFFD4F8EA),
    secondaryFixed: Color(0xFFD4F8EA),
    secondaryFixedDim: Color(0xFFB8F0DC),
    onSecondaryFixed: Color(0xFF002114),
    onSecondaryFixedVariant: Color(0xFF004F4F),

    tertiary: Color(0xFF7AD4D4),
    onTertiary: Color(0xFF001818),
    tertiaryContainer: Color(0xFF003838),
    onTertiaryContainer: Color(0xFF96D4D4),
    tertiaryFixed: Color(0xFF96D4D4),
    tertiaryFixedDim: Color(0xFF7AC4C4),
    onTertiaryFixed: Color(0xFF001818),
    onTertiaryFixedVariant: Color(0xFF003838),

    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),

    surface: Color(0xFF1C1C1E),
    onSurface: Color(0xFFF2F2F3),
    surfaceTint: _iosPrimary,

    surfaceDim: Color(0xFF0E0E10),
    surfaceBright: Color(0xFF2C2C30),
    surfaceContainerLowest: Color(0xFF101012),
    surfaceContainerLow: Color(0xFF141416),
    surfaceContainer: Color(0xFF1A1A1E),
    surfaceContainerHigh: Color(0xFF222226),
    surfaceContainerHighest: Color(0xFF2A2A2E),

    inverseSurface: Color(0xFFF0F0F0),
    onInverseSurface: Color(0xFF1A1A1A),
    inversePrimary: _iosPrimary,

    outline: Color(0xFF6B6B6B),
    outlineVariant: Color(0xFF3A3A3A),

    onSurfaceVariant: Color(0xFFC4C4C8),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  static ColorScheme get darkColorScheme =>
      _isIOS ? _iosDarkColorScheme : _androidDarkColorScheme;

  static Color get primaryColor => _primary;

  static LinearGradient get primaryGradient => LinearGradient(
        colors: _isIOS
            ? const [Color(0xFF006B6B), Color(0xFF18C98B)]
            : const [Color(0xFF14A05F), Color(0xFF128A55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get primaryGradientReverse => LinearGradient(
        colors: _isIOS
            ? const [Color(0xFF18C98B), Color(0xFF006B6B)]
            : const [Color(0xFF128A55), Color(0xFF14A05F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static const Color successColor = Color(0xFF10B981);
  static const Color successBackground = Color(0xFFD1FAE5);
  static const Color onSuccess = Color(0xFFFFFFFF);

  static const Color warningColor = Color(0xFFF59E0B);
  static const Color warningBackground = Color(0xFFFEF3C7);
  static const Color onWarning = Color(0xFF000000);

  static const Color infoColor = Color(0xFF667EEA);
  static const Color infoBackground = Color(0xFFE0E7FF);
  static const Color onInfo = Color(0xFFFFFFFF);

  static const Color transparent = Color(0x00FFFFFF);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);

  static Color get secondaryColor => _secondary;
  static Color get midPurple => _primary;

  static const Color greyColor = Color(0xFF939393);
  static const Color lightGrey = Color(0xFFC6C5D2);

  static const Color borderLight = Color(0xFFE3E2EC);
  static const Color borderDark = Color(0xFF343539);
  static const Color inputBackground = Color(0xFFF5F4F9);
  static const Color inputBackgroundDark = Color(0xFF1E1F23);
  static const Color errorInputBorderColor = Color(0xFFDC2626);

  static const Color textPrimary = Color(0xFF1A1B1E);
  static const Color textSecondary = Color(0xFF46464F);
  static const Color textMuted = Color(0xFF767680);
  static const Color textPrimaryDark = Color(0xFFE4E3E8);
  static const Color textSecondaryDark = Color(0xFFC6C5D2);
  static const Color textMutedDark = Color(0xFF90909A);

  static Color get ringColor => _primary;
  static Color get ringColorDark => _primaryLight;
}

extension AppColorsExtension on ColorScheme {
  Color get success => AppColors.successColor;
  Color get successColor => AppColors.successColor;
  Color get successBackground => brightness == Brightness.light
      ? AppColors.successBackground
      : const Color(0xFF064E3B);
  Color get onSuccess => AppColors.onSuccess;

  Color get warning => AppColors.warningColor;
  Color get warningBackground => brightness == Brightness.light
      ? AppColors.warningBackground
      : const Color(0xFF78350F);
  Color get onWarning => AppColors.onWarning;

  Color get info => AppColors.infoColor;
  Color get infoBackground => brightness == Brightness.light
      ? AppColors.infoBackground
      : const Color(0xFF1E3A8A);
  Color get onInfo => AppColors.onInfo;

  Color get whiteColor => AppColors.whiteColor;
  Color get blackColor => AppColors.blackColor;
  Color get primaryColor => AppColors.primaryColor;
  Color get secondaryColor => AppColors.secondaryColor;
  Color get midPurple => AppColors.midPurple;
  Color get greyColor => AppColors.greyColor;
  Color get lightGrey => AppColors.lightGrey;
  Color get errorInputBorderColor => AppColors.errorInputBorderColor;
  Color get transparent => AppColors.transparent;

  Color get border => brightness == Brightness.light
      ? AppColors.borderLight
      : AppColors.borderDark;
  Color get inputBackground => brightness == Brightness.light
      ? AppColors.inputBackground
      : AppColors.inputBackgroundDark;

  Color get textPrimary => brightness == Brightness.light
      ? AppColors.textPrimary
      : AppColors.textPrimaryDark;
  Color get textSecondary => brightness == Brightness.light
      ? AppColors.textSecondary
      : AppColors.textSecondaryDark;
  Color get textMuted => brightness == Brightness.light
      ? AppColors.textMuted
      : AppColors.textMutedDark;

  Color get ring => brightness == Brightness.light
      ? AppColors.ringColor
      : AppColors.ringColorDark;

  Color get card => brightness == Brightness.light
      ? AppColors.whiteColor
      : const Color(0xFF1E1F23);
  Color get cardForeground => onSurface;

  Color get muted => brightness == Brightness.light
      ? const Color(0xFFF5F4F9)
      : const Color(0xFF292A2E);
  Color get mutedForeground => textMuted;

  Color get accent => secondaryContainer;
  Color get accentForeground => onSecondaryContainer;

  Color get destructive => error;
  Color get destructiveForeground => onError;

  Color get gray500 => const Color(0xFF6B7280);
  Color get gray200 => const Color(0xFFD9DBE0);
  Color get cfaColor => const Color(0xFF767680);
  Color get barrierColor => Colors.black54;
  Color get boxBackground => brightness == Brightness.light
      ? const Color(0xFFF5F4F9)
      : const Color(0xFF1E1F23);

  LinearGradient get primaryGradient => AppColors.primaryGradient;
  LinearGradient get primaryGradientReverse => AppColors.primaryGradientReverse;
}
