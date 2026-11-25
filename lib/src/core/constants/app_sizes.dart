/// A utility class that contains various size constants for use in the application.
/// These sizes are used for icon sizes and font sizes to maintain consistency across the UI.
library;

import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSizes {
  /// Icon sizes used for UI elements.
  /// These constants define the standard icon sizes used across the application.

  /// Extra small icon size (16 pixels).
  static double iconXSmall = 16.h;

  /// Small icon size (20 pixels).
  static double iconSmall = 20.h;

  /// Medium icon size (24 pixels).
  static double iconMedium = 24.h;

  /// Large icon size (32 pixels).
  static double iconLarge = 32.h;

  /// Extra large icon size (48 pixels).
  static double iconXLarge = 48.h;

  /// Font sizes used for text elements in the UI.
  /// These constants define the standard font sizes used throughout the application.

  /// Small font size (12 pixels).
  static double fontSmall = 12.sp;

  /// Medium font size (14 pixels).
  static double fontMedium = 14.sp;

  /// Large font size (16 pixels).
  static double fontLarge = 16.sp;

  /// Extra large font size (18 pixels).
  static double fontXLarge = 18.sp;
}
