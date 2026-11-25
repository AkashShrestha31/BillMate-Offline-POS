import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/app_theme_extension.dart';

extension ThemeGettersExtension on ThemeData {
  AppThemeExtension get appTheme => extension<AppThemeExtension>()!;
}
