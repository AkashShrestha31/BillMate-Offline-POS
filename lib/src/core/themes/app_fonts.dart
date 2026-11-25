import 'package:flutter/material.dart';

/// Bundled font families (see [pubspec.yaml] `flutter.fonts`).
///
/// Inter is registered as static upright + italic weights (400–800), so
/// `copyWith(fontWeight: …)` and `copyWith(fontStyle: FontStyle.italic)` work
/// without [fontVariations].
abstract final class AppFonts {
  static const String inter = 'Inter';
  static const String notoSansDevanagari = 'NotoSansDevanagari';

  static TextStyle interStyle({
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? height,
    double? letterSpacing,
    Color? color,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    Color? decorationColor,
    Color? backgroundColor,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? inter,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w400,
      fontStyle: fontStyle ?? FontStyle.normal,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
      shadows: shadows,
      decoration: decoration,
      decorationColor: decorationColor,
      backgroundColor: backgroundColor,
    );
  }

  /// Ensures [style] uses the bundled Inter family (e.g. after [TextStyle.copyWith]).
  static TextStyle ensureInter(TextStyle style) {
    if (style.fontFamily == inter) return style;
    return style.copyWith(fontFamily: inter);
  }

  static TextStyle withWeight(TextStyle base, FontWeight weight) {
    return ensureInter(base).copyWith(fontWeight: weight);
  }

  static TextStyle withItalic(TextStyle base) {
    return ensureInter(base).copyWith(fontStyle: FontStyle.italic);
  }
}
