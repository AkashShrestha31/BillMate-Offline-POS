import 'package:flutter/material.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

extension TextStyleExtensions on TextStyle? {
  /// Inter italic at the same weight as [this].
  TextStyle? get italic {
    final style = this;
    if (style == null) return null;
    return AppFonts.withItalic(style);
  }

  /// Inter bold (700).
  TextStyle? get bold {
    final style = this;
    if (style == null) return null;
    return AppFonts.withWeight(style, FontWeight.w700);
  }
}
