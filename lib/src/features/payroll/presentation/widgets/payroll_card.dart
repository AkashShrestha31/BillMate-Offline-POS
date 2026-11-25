import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../data/models/response/payroll_model.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';

class PayrollCard extends StatelessWidget {
  const PayrollCard({
    super.key,
    required this.payroll,
    required this.currencyFormat,
    required this.onTap,
    this.onMarkAsPaid,
    this.onDelete,
    this.onExportPdf,
  });

  final PayrollModel payroll;
  final NumberFormat currencyFormat;
  final VoidCallback onTap;
  final VoidCallback? onMarkAsPaid;
  final VoidCallback? onDelete;
  final VoidCallback? onExportPdf;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isPaid = payroll.paymentStatus == 'PAID';
    final isPending = payroll.paymentStatus == 'PENDING';
    final periodLabel = _formatPeriod(payroll);

    return Material(
      color: theme.cardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    backgroundColor: primary.withValues(alpha: 0.12),
                    child: Text(
                      _initial(payroll.employeeName),
                      style: AppFonts.interStyle(
                        color: primary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          payroll.employeeName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (_subtitle(payroll).isNotEmpty) ...[
                          SizedBox(height: 2.h),
                          Text(
                            _subtitle(payroll),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  _StatusActionsRow(
                    status: payroll.paymentStatus,
                    isPaid: isPaid,
                    onExportPdf: onExportPdf,
                    primary: primary,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14.r,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    payroll.payrollMonth,
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (periodLabel.isNotEmpty) ...[
                    Text(
                      ' · ',
                      style: AppFonts.interStyle(color: theme.colorScheme.onSurfaceVariant),
                    ),
                    Expanded(
                      child: Text(
                        periodLabel,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  _MiniStat(
                    label: 'Present',
                    value: '${payroll.daysPresent ?? 0}/${payroll.totalWorkingDays ?? 0}',
                  ),
                  SizedBox(width: 8.w),
                  _MiniStat(
                    label: 'Hours',
                    value: '${payroll.totalHoursWorked?.toStringAsFixed(0) ?? '0'}',
                  ),
                  SizedBox(width: 8.w),
                  _MiniStat(
                    label: 'OT',
                    value: '${payroll.overtimeHours?.toStringAsFixed(0) ?? '0'}',
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Divider(height: 1, color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
              SizedBox(height: 12.h),
              _AmountRow(
                label: 'Gross',
                amount: currencyFormat.format(payroll.grossPay ?? 0),
                theme: theme,
              ),
              SizedBox(height: 6.h),
              _AmountRow(
                label: 'Deductions',
                amount: '- ${currencyFormat.format(payroll.totalDeductions ?? 0)}',
                theme: theme,
                amountColor: theme.colorScheme.error,
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Net pay',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    currencyFormat.format(payroll.netPay ?? 0),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: primary,
                    ),
                  ),
                ],
              ),
              if (isPending && (onMarkAsPaid != null || onDelete != null)) ...[
                SizedBox(height: 14.h),
                Row(
                  children: [
                    if (onMarkAsPaid != null)
                      Expanded(
                        child: FilledButton.tonal(
                          onPressed: onMarkAsPaid,
                          style: FilledButton.styleFrom(
                            backgroundColor: primary.withValues(alpha: 0.12),
                            foregroundColor: primary,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Mark paid',
                            style: AppFonts.interStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    if (onMarkAsPaid != null && onDelete != null) SizedBox(width: 8.w),
                    if (onDelete != null)
                      IconButton(
                        onPressed: onDelete,
                        icon: AppDeleteIcon(
                          color: theme.colorScheme.error,
                          size: 22.r,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor:
                              theme.colorScheme.error.withValues(alpha: 0.08),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static String _initial(String name) {
    final t = name.trim();
    if (t.isEmpty) return '?';
    return t.substring(0, 1).toUpperCase();
  }

  static String _subtitle(PayrollModel payroll) {
    if (payroll.department.isNotEmpty && payroll.position.isNotEmpty) {
      return '${payroll.department} · ${payroll.position}';
    }
    if (payroll.employeeCode.isNotEmpty) return payroll.employeeCode;
    return '';
  }

  static String _formatPeriod(PayrollModel payroll) {
    try {
      if (payroll.payPeriodStart.isEmpty || payroll.payPeriodEnd.isEmpty) {
        return '';
      }
      final start = DateTime.parse(payroll.payPeriodStart);
      final end = DateTime.parse(payroll.payPeriodEnd);
      return '${DateFormat('MMM d').format(start)} – ${DateFormat('MMM d, y').format(end)}';
    } catch (_) {
      return '';
    }
  }
}

class _StatusActionsRow extends StatelessWidget {
  const _StatusActionsRow({
    required this.status,
    required this.isPaid,
    required this.primary,
    this.onExportPdf,
  });

  final String status;
  final bool isPaid;
  final Color primary;
  final VoidCallback? onExportPdf;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (onExportPdf != null) ...[
          Material(
            color: primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.r),
            child: InkWell(
              onTap: onExportPdf,
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.all(6.w),
                child: Icon(
                  Icons.picture_as_pdf_outlined,
                  size: 18.r,
                  color: primary,
                ),
              ),
            ),
          ),
          SizedBox(width: 6.w),
        ],
        _StatusChip(status: status, isPaid: isPaid),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.isPaid});

  final String status;
  final bool isPaid;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = isPaid
        ? theme.colorScheme.primary.withValues(alpha: 0.12)
        : theme.colorScheme.tertiaryContainer.withValues(alpha: 0.5);
    final fg = isPaid ? theme.colorScheme.primary : theme.colorScheme.onTertiaryContainer;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status,
        style: AppFonts.interStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: fg,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow({
    required this.label,
    required this.amount,
    required this.theme,
    this.amountColor,
  });

  final String label;
  final String amount;
  final ThemeData theme;
  final Color? amountColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          amount,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: amountColor ?? theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
