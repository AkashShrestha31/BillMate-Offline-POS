import 'package:flutter/material.dart';

/// Theme-aware colors and decorations for sales / purchase invoice list pages.
abstract final class InvoiceListChrome {
  static ColorScheme scheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  static Color surface(BuildContext context) => scheme(context).surface;

  static Color subtleFill(BuildContext context) =>
      scheme(context).surfaceContainerLow;

  static Color elevatedFill(BuildContext context) =>
      scheme(context).surfaceContainerHighest;

  static Color border(BuildContext context) =>
      scheme(context).outlineVariant.withValues(alpha: 0.6);

  static Color mutedText(BuildContext context) =>
      scheme(context).onSurfaceVariant;

  static Color primaryText(BuildContext context) => scheme(context).onSurface;

  static BoxDecoration cardDecoration(
    BuildContext context, {
    required BorderRadius borderRadius,
    Color? color,
    Color? borderColor,
    double borderWidth = 1,
  }) {
    return BoxDecoration(
      color: color ?? surface(context),
      borderRadius: borderRadius,
      border: Border.all(
        color: borderColor ?? border(context),
        width: borderWidth,
      ),
    );
  }
}
