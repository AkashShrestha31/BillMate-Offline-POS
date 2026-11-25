import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/layout/device_layout.dart';

/// Responsive layout helpers for the login screen.
abstract final class LoginPageLayout {
  static const double maxContentWidthTablet = 480;

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

  static double maxContentWidth(BuildContext context) =>
      isTablet(context) ? maxContentWidthTablet : double.infinity;

  static double horizontalPadding(BuildContext context) =>
      sz(context, 32, 16.w);

  static double contentInnerPadding(BuildContext context) =>
      sz(context, 28, 0);

  static double scrollTopPadding(BuildContext context) =>
      sz(context, 24, 16.h);

  static double scrollBottomExtra(BuildContext context) =>
      sz(context, 24, 24.h);

  static double splashLogoSize(BuildContext context) =>
      sz(context, 140, 168.r);

  static double appLogoSize(BuildContext context) =>
      sz(context, 96, 112.r);

  static double appLogoErrorIconSize(BuildContext context) =>
      sz(context, 56, 48.r);

  /// Vertical shift for welcome text (negative pulls it closer to the logo).
  static double welcomeBackTopOffset(BuildContext context) =>
      sz(context, -4, -12.h);

  static double spacingAfterLogo(BuildContext context) =>
      sz(context, 16, 12.h);

  static double spacingAfterHeader(BuildContext context) =>
      sz(context, 24, 16.h);

  static double spacingBetweenFields(BuildContext context) =>
      sz(context, 14, 12.h);

  static double spacingBeforeButton(BuildContext context) =>
      sz(context, 28, 24.h);

  static double spacingAfterButton(BuildContext context) =>
      sz(context, 16, 16.h);

  static double brandFontSize(BuildContext context) =>
      sp(context, 24, 22);

  static double titleFontSize(BuildContext context) =>
      sp(context, 26, 24);

  static double subtitleFontSize(BuildContext context) =>
      sp(context, 17, 16);

  static double buttonHeight(BuildContext context) =>
      sz(context, 52, 48);

  static double buttonRadius(BuildContext context) =>
      sz(context, 12, 8.r);

  static double fieldRadius(BuildContext context) =>
      sz(context, 12, 12.r);

  static double fieldFocusedBorderWidth(BuildContext context) =>
      sz(context, 1.5, 1.5.w);

  static double fieldIconSize(BuildContext context) =>
      sp(context, 18, 18);

  static double passwordVisibilityIconSize(BuildContext context) =>
      sp(context, 20, 18);

  static EdgeInsets languageSwitchPadding(BuildContext context) =>
      EdgeInsets.only(
        top: sz(context, 12, 8.h),
        right: sz(context, 16, 8.w),
      );
}
