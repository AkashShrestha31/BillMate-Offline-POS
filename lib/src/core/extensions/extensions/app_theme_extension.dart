import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hotel/src/core/constants/app_sizes.dart';
import 'package:hotel/src/core/constants/app_spacing.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final double spacing2;
  final double spacing4;
  final double spacing8;
  final double spacing12;
  final double spacing16;
  final double spacing20;
  final double spacing18;
  final double spacing24;
  final double spacing32;
  final double spacing48;
  final double spacing120;
  final double spacing90;

  final double iconXSmall;
  final double iconSmall;
  final double iconMedium;
  final double iconLarge;
  final double iconXLarge;

  final double fontSmall;
  final double fontMedium;
  final double fontLarge;
  final double fontXLarge;

  const AppThemeExtension({
    required this.spacing2,
    required this.spacing4,
    required this.spacing8,
    required this.spacing12,
    required this.spacing16,
    required this.spacing20,
    required this.spacing18,
    required this.spacing24,
    required this.spacing32,
    required this.spacing48,
    required this.spacing120,
    required this.spacing90,
    required this.iconXSmall,
    required this.iconSmall,
    required this.iconMedium,
    required this.iconLarge,
    required this.iconXLarge,
    required this.fontSmall,
    required this.fontMedium,
    required this.fontLarge,
    required this.fontXLarge,
  });

  factory AppThemeExtension.defaultTokens() => AppThemeExtension(
        spacing2: AppSpacing.sTiny,
        spacing4: AppSpacing.sXSmall,
        spacing8: AppSpacing.sSmall,
        spacing16: AppSpacing.sMedium,
        spacing18: AppSpacing.spacing18,
        spacing20: AppSpacing.spacing20,
        spacing24: AppSpacing.sLarge,
        spacing32: AppSpacing.sXLarge,
        spacing48: AppSpacing.sXXLarge,
        spacing120: AppSpacing.sXXXXLarge,
        spacing12: AppSpacing.sSemiMedium,
        spacing90: AppSpacing.sTripleXLarge,
        iconXSmall: AppSizes.iconXSmall,
        iconSmall: AppSizes.iconMedium,
        iconMedium: AppSizes.iconMedium,
        iconLarge: AppSizes.iconLarge,
        iconXLarge: AppSizes.iconXLarge,
        fontSmall: AppSizes.fontSmall,
        fontMedium: AppSizes.fontMedium,
        fontLarge: AppSizes.fontLarge,
        fontXLarge: AppSizes.fontXLarge,
      );

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    double? spacing2,
    double? spacing4,
    double? spacing8,
    double? spacing12,
    double? spacing16,
    double? spacing18,
    double? spacing20,
    double? spacing24,
    double? spacing32,
    double? spacing48,
    double? spacing90,
    double? spacing120,
    double? iconXSmall,
    double? iconSmall,
    double? iconMedium,
    double? iconLarge,
    double? iconXLarge,
    double? fontSmall,
    double? fontMedium,
    double? fontLarge,
    double? fontXLarge,
  }) {
    return AppThemeExtension(
      spacing2: spacing2 ?? this.spacing2,
      spacing4: spacing4 ?? this.spacing4,
      spacing8: spacing8 ?? this.spacing8,
      spacing12: spacing12 ?? this.spacing12,
      spacing16: spacing16 ?? this.spacing16,
      spacing18: spacing18 ?? this.spacing18,
      spacing20: spacing20 ?? this.spacing20,
      spacing24: spacing24 ?? this.spacing24,
      spacing32: spacing32 ?? this.spacing32,
      spacing48: spacing48 ?? this.spacing48,
      spacing90: spacing90 ?? this.spacing90,
      spacing120: spacing120 ?? this.spacing120,
      iconXSmall: iconXSmall ?? this.iconXSmall,
      iconSmall: iconSmall ?? this.iconSmall,
      iconMedium: iconMedium ?? this.iconMedium,
      iconLarge: iconLarge ?? this.iconLarge,
      iconXLarge: iconXLarge ?? this.iconXLarge,
      fontSmall: fontSmall ?? this.fontSmall,
      fontMedium: fontMedium ?? this.fontMedium,
      fontLarge: fontLarge ?? this.fontLarge,
      fontXLarge: fontXLarge ?? this.fontXLarge,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) return this;

    return AppThemeExtension(
      // Spacing values
      spacing2: lerpDouble(spacing2, other.spacing2, t) ?? spacing2,
      spacing4: lerpDouble(spacing4, other.spacing4, t) ?? spacing4,
      spacing8: lerpDouble(spacing8, other.spacing8, t) ?? spacing8,
      spacing12: lerpDouble(spacing12, other.spacing12, t) ?? spacing12,
      spacing16: lerpDouble(spacing16, other.spacing16, t) ?? spacing16,
      spacing18: lerpDouble(spacing18, other.spacing18, t) ?? spacing18,
      spacing20: lerpDouble(spacing20, other.spacing20, t) ?? spacing20,
      spacing24: lerpDouble(spacing24, other.spacing24, t) ?? spacing24,
      spacing32: lerpDouble(spacing32, other.spacing32, t) ?? spacing32,
      spacing48: lerpDouble(spacing48, other.spacing48, t) ?? spacing48,
      spacing90: lerpDouble(spacing90, other.spacing90, t) ?? spacing90,
      spacing120: lerpDouble(spacing120, other.spacing120, t) ?? spacing120,

      // Icon sizes
      iconXSmall: lerpDouble(iconXSmall, other.iconXSmall, t) ?? iconXSmall,
      iconSmall: lerpDouble(iconSmall, other.iconSmall, t) ?? iconSmall,
      iconMedium: lerpDouble(iconMedium, other.iconMedium, t) ?? iconMedium,
      iconLarge: lerpDouble(iconLarge, other.iconLarge, t) ?? iconLarge,
      iconXLarge: lerpDouble(iconXLarge, other.iconXLarge, t) ?? iconXLarge,

      // Font sizes
      fontSmall: lerpDouble(fontSmall, other.fontSmall, t) ?? fontSmall,
      fontMedium: lerpDouble(fontMedium, other.fontMedium, t) ?? fontMedium,
      fontLarge: lerpDouble(fontLarge, other.fontLarge, t) ?? fontLarge,
      fontXLarge: lerpDouble(fontXLarge, other.fontXLarge, t) ?? fontXLarge,
    );
  }
}
