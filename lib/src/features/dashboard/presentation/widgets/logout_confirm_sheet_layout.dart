import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/layout/device_layout.dart';

/// Responsive layout helpers for the logout confirmation sheet.
abstract final class LogoutConfirmSheetLayout {
  static bool isTablet(BuildContext context) =>
      DeviceLayout.isTablet(context);

  /// Logical px on tablet; ScreenUtil on phone.
  static double sz(BuildContext context, double tablet, double phone) {
    if (isTablet(context)) return tablet;
    return phone;
  }

  static double sp(BuildContext context, double tablet, double phone) {
    if (isTablet(context)) return tablet;
    return phone.sp;
  }

  static double messageTopPadding(BuildContext context) =>
      sz(context, 12, 12.h);

  static double messageBottomPadding(BuildContext context) =>
      sz(context, 20, 20.h);

  static double messageFontSize(BuildContext context) =>
      sp(context, 14, 14);

  static double buttonSpacing(BuildContext context) =>
      sz(context, 12, 12.w);

  static double buttonHeight(BuildContext context) =>
      sz(context, 52, 48);

  static double buttonRadius(BuildContext context) =>
      sz(context, 12, 8.r);
}
