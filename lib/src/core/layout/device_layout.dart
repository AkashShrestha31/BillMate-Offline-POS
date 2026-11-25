import 'package:flutter/material.dart';

/// Shared phone vs tablet / iPad breakpoints.
abstract final class DeviceLayout {
  static const double tabletBreakpoint = 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).shortestSide >= tabletBreakpoint;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.landscape;
}
