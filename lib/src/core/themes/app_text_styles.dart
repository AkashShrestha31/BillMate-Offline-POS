import 'package:flutter/material.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

// Defines the text styles for the light and dark themes with specific properties.
class AppTextStyles {
  AppTextStyles._();

  static final TextTheme textTheme = TextTheme(
    displayLarge: AppFonts.interStyle(
      fontSize: 57,
      height: 64 / 57,
      letterSpacing: -0.25,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: AppFonts.interStyle(
      fontSize: 45,
      height: 52 / 45,
      fontWeight: FontWeight.w500,
    ),
    displaySmall: AppFonts.interStyle(
      fontSize: 36,
      height: 44 / 36,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: AppFonts.interStyle(
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: AppFonts.interStyle(
      fontSize: 28,
      height: 36 / 28,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: AppFonts.interStyle(
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: AppFonts.interStyle(
      fontSize: 21,
      height: 28 / 22,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: AppFonts.interStyle(
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.15,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: AppFonts.interStyle(
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: AppFonts.interStyle(
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: AppFonts.interStyle(
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: AppFonts.interStyle(
      fontSize: 9,
      height: 16 / 11,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: AppFonts.interStyle(
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: AppFonts.interStyle(
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.25,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: AppFonts.interStyle(
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w400,
    ),
  );
}
