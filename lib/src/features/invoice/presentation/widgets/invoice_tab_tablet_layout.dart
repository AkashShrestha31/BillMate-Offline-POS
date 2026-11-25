import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/notched_bottom_nav_bar.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_list_chrome.dart';

/// Tablet layout helpers for Sales / Purchase invoice tabs.
abstract final class InvoiceTabTabletLayout {
  static bool isTablet(BuildContext context) =>
      DeviceLayout.isTablet(context);

  static EdgeInsets contentPadding(
    BuildContext context, {
    required bool shellTab,
  }) {
    final tablet = isTablet(context);
    final horizontal = tablet ? 32.0 : 12.0;
    final top = tablet ? 16.0 : 12.0;
    final bottom = shellTab
        ? NotchedBottomNavBar.bottomInset(context) +
            NotchedBottomNavBar.shellTabListBottomGap(context) +
            (tablet ? 24 : 12)
        : (tablet ? 16.0 : 12.0);
    return EdgeInsets.fromLTRB(horizontal, top, horizontal, bottom);
  }

  static bool isTabletLandscape(BuildContext context) =>
      isTablet(context) && DeviceLayout.isLandscape(context);

  /// Max height for the invoice list when split beside the calendar on tablet.
  static double invoicePanelMaxHeight(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    final top = MediaQuery.paddingOf(context).top + kToolbarHeight + 16;
    final bottom = NotchedBottomNavBar.bottomInset(context) +
        NotchedBottomNavBar.shellTabListBottomGap(context) +
        16;
    return (media.height - top - bottom).clamp(280.0, media.height);
  }

  static double invoiceListSeparatorHeight(BuildContext context) =>
      sz(context, 10, 6.h);

  /// Date summary card shown above the invoice list for a selected day.
  static Widget daySummaryCard({
    required BuildContext context,
    required IconData icon,
    required String dateLabel,
    required String countLabel,
    required String totalLabel,
    required BoxDecoration decoration,
  }) {
    return Container(
      padding: EdgeInsets.all(sz(context, 16, 16.w)),
      decoration: decoration,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(sz(context, 10, 8.r)),
            decoration: BoxDecoration(
              color: InvoiceListChrome.subtleFill(context),
              borderRadius: BorderRadius.circular(sz(context, 10, 8.r)),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: sz(context, 20, 16.r),
            ),
          ),
          SizedBox(width: sz(context, 14, 12.w)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.interStyle(
                    fontSize: sp(context, 15, 12),
                    fontWeight: FontWeight.w600,
                    color: InvoiceListChrome.primaryText(context),
                  ),
                ),
                SizedBox(height: sz(context, 4, 2.h)),
                Text(
                  countLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.interStyle(
                    fontSize: sp(context, 13, 11),
                    color: InvoiceListChrome.mutedText(context),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: sz(context, 12, 8.w)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: sz(context, 14, 12.w),
              vertical: sz(context, 8, 6.h),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(sz(context, 8, 5.r)),
            ),
            child: Text(
              totalLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.interStyle(
                fontSize: sp(context, 14, 12),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Logical px on tablet; ScreenUtil on phone.
  static double sz(BuildContext context, double tablet, double phone) {
    if (isTablet(context)) return tablet;
    return phone;
  }

  static double sp(BuildContext context, double tablet, double phone) {
    if (isTablet(context)) return tablet;
    return phone.sp;
  }

  static double calendarGridSpacing(BuildContext context) =>
      sz(context, 6, 4.w);

  static double calendarMainSpacing(BuildContext context) =>
      sz(context, 6, 4.h);

  static double calendarDayFontSize(BuildContext context) => sp(context, 15, 14);

  static double calendarDayRadius(BuildContext context) => sz(context, 8, 5.r);

  static Color calendarDayTextColor(
    BuildContext context, {
    required bool isFutureDate,
    required bool isSelected,
    required bool isToday,
    required bool hasInvoices,
  }) {
    final scheme = Theme.of(context).colorScheme;
    if (isSelected) return scheme.onPrimary;
    if (isFutureDate) {
      return InvoiceListChrome.mutedText(context).withValues(
        alpha: isTablet(context) ? 0.78 : 0.58,
      );
    }
    if (isToday) return scheme.primary;
    if (hasInvoices) return scheme.primary;
    return InvoiceListChrome.primaryText(context);
  }

  /// Calendar left, day invoices right on tablet landscape.
  static Widget calendarWithInvoices({
    required BuildContext context,
    required Widget calendar,
    required Widget invoices,
  }) {
    if (isTabletLandscape(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: calendar),
          const SizedBox(width: 20),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: invoicePanelMaxHeight(context),
              child: invoices,
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        calendar,
        invoices,
      ],
    );
  }
}
