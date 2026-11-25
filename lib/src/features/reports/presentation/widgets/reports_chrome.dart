import 'package:flutter/material.dart';

/// Theme-aware colors and decorations for report pages (P&L, Statement, Analytics).
abstract final class ReportsChrome {
  static ColorScheme scheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  static Color pageBackground(BuildContext context) =>
      scheme(context).surfaceContainerLow;

  static Color panelBackground(BuildContext context) => scheme(context).surface;

  static Color segmentedTrack(BuildContext context) =>
      scheme(context).surfaceContainerHighest;

  static Color border(BuildContext context) =>
      scheme(context).outlineVariant.withValues(alpha: 0.6);

  static Color primaryText(BuildContext context) => scheme(context).onSurface;

  static Color mutedText(BuildContext context) =>
      scheme(context).onSurfaceVariant;

  static Color tooltipBackground(BuildContext context) =>
      scheme(context).inverseSurface;

  static Color tooltipText(BuildContext context) =>
      scheme(context).onInverseSurface;

  /// Chart / KPI semantic accents — readable on light and dark surfaces.
  static const Color accent = Color(0xFF2563EB);
  static const Color positive = Color(0xFF16A34A);
  static const Color negative = Color(0xFFDC2626);
  static const Color amber = Color(0xFFF59E0B);
  static const Color violet = Color(0xFF7C3AED);

  static BoxDecoration panelDecoration(
    BuildContext context, {
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
    Color? color,
  }) {
    return BoxDecoration(
      color: color ?? panelBackground(context),
      borderRadius: borderRadius,
      border: Border.all(color: border(context)),
    );
  }
}
