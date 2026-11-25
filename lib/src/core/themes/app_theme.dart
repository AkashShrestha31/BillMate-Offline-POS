import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/enums/app_enums.dart';
import 'package:hotel/src/core/extensions/extensions/app_theme_extension.dart';
import 'package:hotel/src/core/themes/app_colors.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/themes/app_text_styles.dart';

/// A utility class that provides theming configurations for the app.
///
/// It defines and configures light and dark themes based on [ColorScheme]
/// and [ThemeEnum]. The themes are built using Material Design 3 principles.
///
/// Usage:
/// ```dart
/// ThemeData lightTheme = AppTheme.lightThemeData;
/// ThemeData darkTheme = AppTheme.darkThemeData;
/// ```
class AppTheme {
  /// ThemeData for the light theme.
  static final ThemeData lightThemeData =
  _themeData(AppColors.lightColorScheme, ThemeEnum.light);

  /// ThemeData for the dark theme.
  static final ThemeData darkThemeData =
  _themeData(AppColors.darkColorScheme, ThemeEnum.dark);

  /// Generates a [ThemeData] based on the provided [ColorScheme] and [ThemeEnum].
  ///
  /// - [colorScheme]: The [ColorScheme] to use for the theme.
  /// - [theme]: The theme type, either [ThemeEnum.light] or [ThemeEnum.dark].
  ///
  /// Returns a [ThemeData] object configured with the specified colors and settings.
  static ThemeData _themeData(ColorScheme colorScheme, ThemeEnum theme) {
    return ThemeData(
      useMaterial3: true,
      brightness: theme == ThemeEnum.light ? Brightness.light : Brightness.dark,
      scaffoldBackgroundColor: colorScheme.surfaceContainerLow,
      tabBarTheme: _tabBarTheme(colorScheme),
      appBarTheme: _appBarTheme(colorScheme, theme),
      colorScheme: colorScheme,
      buttonTheme: _buttonTheme(colorScheme),
      bottomAppBarTheme: const BottomAppBarThemeData(),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(colorScheme),
      canvasColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.surfaceContainerHighest,
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: AppFonts.interStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        subtitleTextStyle: AppFonts.interStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurfaceVariant,
        ),
        iconColor: colorScheme.primary,
      ),

      // Inter is bundled locally (see pubspec `flutter.fonts`).
      fontFamily: AppFonts.inter,
      fontFamilyFallback: const ['sans-serif'],
      textTheme: AppTextStyles.textTheme,
      primaryTextTheme: AppTextStyles.textTheme,

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: AppFonts.interStyle(
          color: colorScheme.onInverseSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        closeIconColor: colorScheme.onInverseSurface,
        actionTextColor: colorScheme.primary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: colorScheme.surfaceContainerHigh,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.55),
        thickness: 1,
      ),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),

      // Apply Inter font to buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: AppFonts.interStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: AppFonts.interStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: AppFonts.interStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          textStyle: AppFonts.interStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      extensions: [
        AppThemeExtension.defaultTokens(),
      ],
    );
  }

  /// Configures the TabBar theme using the provided [ColorScheme].
  ///
  /// - [colorScheme]: The [ColorScheme] for styling the TabBar.
  ///
  /// Returns a [TabBarTheme] object.
  static TabBarThemeData _tabBarTheme(ColorScheme colorScheme) {
    return TabBarThemeData(
      labelColor: colorScheme.primary,
      unselectedLabelColor: colorScheme.onSurfaceVariant,
      labelPadding: allSmall,
      indicatorColor: colorScheme.primary,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: AppFonts.interStyle(
        fontSize: AppTextStyles.textTheme.titleSmall?.fontSize,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: AppFonts.interStyle(
        fontSize: AppTextStyles.textTheme.titleSmall?.fontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Configures the AppBar theme using the provided [ColorScheme] and [ThemeEnum].
  ///
  /// - [colorScheme]: The [ColorScheme] for styling the AppBar.
  /// - [theme]: The theme type for setting status bar properties.
  ///
  /// Returns an [AppBarTheme] object.
  static AppBarTheme _appBarTheme(ColorScheme colorScheme, ThemeEnum theme) {
    final isDark = theme == ThemeEnum.dark;
    return AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: colorScheme.surfaceContainerLow,
        statusBarBrightness:
        isDark ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
        isDark ? Brightness.light : Brightness.dark,
      ),
      backgroundColor: colorScheme.surfaceContainerHigh,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      titleTextStyle: AppFonts.interStyle(
        fontSize: AppTextStyles.textTheme.titleLarge?.fontSize ?? 20,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
    );
  }

  /// Configures the BottomNavigationBar theme using the provided [ColorScheme].
  ///
  /// - [colorScheme]: The [ColorScheme] for styling the BottomNavigationBar.
  ///
  /// Returns a [BottomNavigationBarThemeData] object.
  static BottomNavigationBarThemeData _bottomNavigationBarTheme(
      ColorScheme colorScheme) {
    return BottomNavigationBarThemeData(
      backgroundColor: colorScheme.surfaceContainerHigh,
      selectedIconTheme: IconThemeData(color: colorScheme.primary),
      unselectedIconTheme: IconThemeData(color: colorScheme.onSurface),
      selectedLabelStyle: AppFonts.interStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: AppFonts.interStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Configures the InputDecoration theme using the provided [ColorScheme].
  ///
  /// - [colorScheme]: The [ColorScheme] for styling input fields.
  ///
  /// Returns an [InputDecorationTheme] object.
  static InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: AppFonts.interStyle(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: AppFonts.interStyle(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
      ),
      hintStyle: AppFonts.interStyle(color: colorScheme.onSurfaceVariant),
      helperStyle: AppFonts.interStyle(fontSize: 12),
      errorStyle: AppFonts.interStyle(fontSize: 12),
      border: OutlineInputBorder(
        borderRadius: allRadiusExtraSmall,
        borderSide: BorderSide(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: allRadiusExtraSmall,
        borderSide: BorderSide(
          width: 1,
          color: colorScheme.outlineVariant,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: allRadiusExtraSmall,
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: allRadiusExtraSmall,
        borderSide: BorderSide(
          width: 1,
          color: colorScheme.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: allRadiusExtraSmall,
        borderSide: BorderSide(
          width: 1,
          color: colorScheme.error,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sSemiMedium,
        vertical: AppSpacing.sSemiMedium,
      ),
    );
  }

  /// Configures the Button theme using the provided [ColorScheme].
  ///
  /// - [colorScheme]: The [ColorScheme] for styling buttons.
  ///
  /// Returns a [ButtonThemeData] object.
  static ButtonThemeData _buttonTheme(ColorScheme colorScheme) {
    return ButtonThemeData(
      buttonColor: colorScheme.primary,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}