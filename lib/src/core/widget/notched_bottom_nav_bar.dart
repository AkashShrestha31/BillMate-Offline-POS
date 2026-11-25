import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/layout/device_layout.dart';

/// Fixed bottom navigation for the main shell (edge-to-edge, no floating notch).
class NotchedBottomNavBar extends StatelessWidget {
  const NotchedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.items,
    this.barColor,
    this.activeColor,
    this.inactiveColor,
  });

  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final List<NotchedNavTab> items;
  final Color? barColor;
  final Color? activeColor;
  final Color? inactiveColor;

  static const double barHeight = 56;

  static double fabSize(BuildContext context) =>
      DeviceLayout.isTablet(context) ? 48 : 56;

  /// Space occupied by the shell bottom bar (for list padding, etc.).
  static double bottomInset(BuildContext context) {
    return barHeight + MediaQuery.paddingOf(context).bottom;
  }

  /// Scroll padding so the last row clears the bottom bar.
  static double scrollBottomPadding(BuildContext context) => bottomInset(context);

  /// Home tab scroll padding.
  static double homeTabScrollBottomPadding(BuildContext context) =>
      bottomInset(context);

  /// Add FAB on Sales/Expenses — tab body ends above the shell nav ([extendBody] off).
  static double shellTabFabBottomLift(BuildContext context) {
    return kFloatingActionButtonMargin +
        (DeviceLayout.isTablet(context) ? 8 : 8.h);
  }

  /// Small gap under the invoice list so the last row clears the add FAB when scrolled.
  static double shellTabListBottomGap(BuildContext context) {
    return fabSize(context) + kFloatingActionButtonMargin;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final active = activeColor ?? scheme.primary;
    final inactive =
        inactiveColor ?? scheme.onSurfaceVariant.withValues(alpha: 0.55);
    final effectiveBarColor = barColor ?? scheme.surface;

    return Material(
      color: effectiveBarColor,
      child: SafeArea(
        top: false,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTabSelected,
          type: BottomNavigationBarType.fixed,
          backgroundColor: effectiveBarColor,
          elevation: 0,
          selectedItemColor: active,
          unselectedItemColor: inactive,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 22,
          items: items
              .map(
                (tab) => BottomNavigationBarItem(
                  icon: Icon(tab.icon, color: inactive),
                  activeIcon: Icon(tab.activeIcon, color: active),
                  label: tab.label ?? '',
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class NotchedNavTab {
  const NotchedNavTab({
    required this.index,
    required this.icon,
    required this.activeIcon,
    this.label,
  });

  final int index;
  final IconData icon;
  final IconData activeIcon;
  final String? label;
}
