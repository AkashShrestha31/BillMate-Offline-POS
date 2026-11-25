import 'package:flutter/material.dart';
import 'package:hotel/src/core/layout/device_layout.dart';

/// Layout helpers for onboarding screens (language selection, walkthrough).
abstract final class OnboardingLayout {
  static const double tabletBreakpoint = DeviceLayout.tabletBreakpoint;

  static bool isTablet(BuildContext context) => DeviceLayout.isTablet(context);

  static bool isLandscape(BuildContext context) =>
      DeviceLayout.isLandscape(context);
}
