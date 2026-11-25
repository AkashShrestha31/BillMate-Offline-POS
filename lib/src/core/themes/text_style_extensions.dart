import 'package:flutter/material.dart';
import 'package:hotel/src/core/constants/app_font_weights.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

extension TextStyleExtensions on TextStyle? {
  TextStyle? _withAppWeight(FontWeight weight) {
    final style = this;
    if (style == null) return null;
    return AppFonts.withWeight(style, weight);
  }

  TextStyle? get fontWeightXLarge => _withAppWeight(AppFontWeights.xLarge);
  TextStyle? get fontWeightLarge => _withAppWeight(AppFontWeights.large);
  TextStyle? get fontWeightMedium => _withAppWeight(AppFontWeights.medium);
  TextStyle? get fontWeightSmall => _withAppWeight(AppFontWeights.small);
}
