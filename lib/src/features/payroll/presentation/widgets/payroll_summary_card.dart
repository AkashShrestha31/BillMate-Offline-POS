import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

class PayrollSummaryCard extends StatelessWidget {
  const PayrollSummaryCard({
    super.key,
    required this.totalGrossPay,
    required this.totalDeductions,
    required this.totalNetPay,
    required this.currencyFormat,
  });

  final double totalGrossPay;
  final double totalDeductions;
  final double totalNetPay;
  final NumberFormat currencyFormat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payroll summary',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _Metric(
                    label: 'Gross',
                    value: currencyFormat.format(totalGrossPay),
                    onPrimary: theme.colorScheme.onPrimary,
                  ),
                ),
                Container(
                  width: 1,
                  height: 36.h,
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.25),
                ),
                Expanded(
                  child: _Metric(
                    label: 'Deductions',
                    value: currencyFormat.format(totalDeductions),
                    onPrimary: theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.payments_outlined,
                    size: 20.r,
                    color: theme.colorScheme.onPrimary,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Net pay',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    currencyFormat.format(totalNetPay),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
    required this.onPrimary,
  });

  final String label;
  final String value;
  final Color onPrimary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppFonts.interStyle(
            fontSize: 12.sp,
            color: onPrimary.withValues(alpha: 0.75),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFonts.interStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: onPrimary,
          ),
        ),
      ],
    );
  }
}
