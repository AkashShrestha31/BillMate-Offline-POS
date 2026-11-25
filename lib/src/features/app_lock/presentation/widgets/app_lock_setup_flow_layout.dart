import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/layout/device_layout.dart';

/// Responsive layout helpers for the app lock setup prompt sheet.
abstract final class AppLockSetupFlowLayout {
  static const double maxContentWidthTablet = 520;

  static bool isTablet(BuildContext context) =>
      DeviceLayout.isTablet(context);

  /// Logical px on tablet; ScreenUtil on phone.
  static double sz(BuildContext context, double tablet, double phone) {
    if (isTablet(context)) return tablet;
    return phone;
  }

  static double maxContentWidth(BuildContext context) =>
      isTablet(context) ? maxContentWidthTablet : double.infinity;

  static double sheetHorizontalMargin(BuildContext context) =>
      sz(context, 32, 0);

  static double sheetVerticalMargin(BuildContext context) =>
      sz(context, 24, 0);

  static double sheetHorizontalPadding(BuildContext context) =>
      sz(context, 24, 24.w);

  static double sheetTopPadding(
    BuildContext context, {
    required bool asBottomSheet,
  }) {
    if (asBottomSheet) return 0;
    return sz(context, 24, 0);
  }

  static double sheetBottomPadding(
    BuildContext context,
    double bottomInset, {
    required bool asBottomSheet,
  }) {
    if (asBottomSheet) return sz(context, 16, 12.h);
    return 24 + bottomInset;
  }

  static double sheetBorderRadius(BuildContext context) =>
      sz(context, 20, 20.r);

  static double spacingAfterTitle(BuildContext context) =>
      sz(context, 8, 8.h);

  static double spacingBeforeButtons(BuildContext context) =>
      sz(context, 24, 20.h);

  static double spacingBetweenButtons(BuildContext context) =>
      sz(context, 10, 8.h);

  static double primaryButtonHeight(BuildContext context) =>
      sz(context, 52, 48);

  static double secondaryButtonHeight(BuildContext context) =>
      sz(context, 52, 42);

  static double buttonRadius(BuildContext context) =>
      sz(context, 12, 8.r);
}
