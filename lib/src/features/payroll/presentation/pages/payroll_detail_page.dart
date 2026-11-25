import 'package:auto_route/auto_route.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';
import 'package:intl/intl.dart';
import '../../data/models/response/payroll_model.dart';
import '../widgets/detail_section_widget.dart';
import '../widgets/detail_info_row.dart';
import 'package:hotel/constants.dart';

@RoutePage()
class PayrollDetailPage extends StatelessWidget {
  const PayrollDetailPage({
    super.key,
    required this.payroll,
  });

  final PayrollModel payroll;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = AppMoneyFormat.currency(currencySymbol);
    final isPaid = payroll.paymentStatus == 'PAID';
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      appBar: AppBar(
        leading: AppBarIosBackButton(color: scheme.onSurface),
        backgroundColor: scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text('Payroll Details'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: isPaid ? Colors.green : Colors.orange,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              payroll.paymentStatus,
              style: AppFonts.interStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmployeeInfoCard(context),
            SizedBox(height: 16.h),
            DetailSectionWidget(
              title: 'Attendance Summary',
              icon: Icons.calendar_today_rounded,
              iconColor: Colors.blue,
              children: [
                DetailInfoRow(
                  label: 'Total Working Days',
                  value: '${payroll.totalWorkingDays}',
                ),
                DetailInfoRow(
                  label: 'Days Present',
                  value: '${payroll.daysPresent}',
                  valueColor: Colors.green,
                ),
                DetailInfoRow(
                  label: 'Days Absent',
                  value: '${payroll.daysAbsent}',
                  valueColor: payroll.daysAbsent! > 0 ? Colors.red : null,
                ),
                DetailInfoRow(
                  label: 'Sick Days',
                  value: '${payroll.sickDays}',
                ),
                DetailInfoRow(
                  label: 'Vacation Days',
                  value: '${payroll.vacationDays}',
                ),
              ],
            ),
            SizedBox(height: 16.h),
            DetailSectionWidget(
              title: 'Hours Summary',
              icon: Icons.access_time_rounded,
              iconColor: Colors.purple,
              children: [
                DetailInfoRow(
                  label: 'Total Hours Worked',
                  value: '${payroll.totalHoursWorked?.toStringAsFixed(1)} hrs',
                  bold: true,
                ),
                DetailInfoRow(
                  label: 'Regular Hours',
                  value: '${payroll.regularHours?.toStringAsFixed(1)} hrs',
                ),
                DetailInfoRow(
                  label: 'Overtime Hours',
                  value: '${payroll.overtimeHours?.toStringAsFixed(1)} hrs',
                  valueColor: payroll.overtimeHours! > 0 ? Colors.orange : null,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            DetailSectionWidget(
              title: 'Earnings',
              icon: Icons.account_balance_wallet_rounded,
              iconColor: Colors.green,
              children: [
                DetailInfoRow(
                  label: 'Basic Salary',
                  value: currencyFormat.format(payroll.basicSalary),
                ),
                DetailInfoRow(
                  label: 'Overtime Pay',
                  value: currencyFormat.format(payroll.overtimePay),
                ),
                DetailInfoRow(
                  label: 'Allowances',
                  value: currencyFormat.format(payroll.allowances),
                ),
                DetailInfoRow(
                  label: 'Bonus',
                  value: currencyFormat.format(payroll.bonus),
                ),
                Divider(height: 24.h),
                DetailInfoRow(
                  label: 'Gross Pay',
                  value: currencyFormat.format(payroll.grossPay),
                  bold: true,
                  fontSize: 16.sp,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            DetailSectionWidget(
              title: 'Deductions',
              icon: Icons.money_off_rounded,
              iconColor: Colors.red,
              children: [
                DetailInfoRow(
                  label: 'Tax Deduction',
                  value: currencyFormat.format(payroll.taxDeduction),
                ),
                DetailInfoRow(
                  label: 'Insurance',
                  value: currencyFormat.format(payroll.insuranceDeduction),
                ),
                DetailInfoRow(
                  label: 'Provident Fund',
                  value: currencyFormat.format(payroll.providentFund),
                ),
                DetailInfoRow(
                  label: 'Other Deductions',
                  value: currencyFormat.format(payroll.otherDeductions),
                ),
                Divider(height: 24.h),
                DetailInfoRow(
                  label: 'Total Deductions',
                  value: currencyFormat.format(payroll.totalDeductions),
                  bold: true,
                  fontSize: 16.sp,
                  valueColor: Colors.red,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'NET PAY',
                    style: AppFonts.interStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    currencyFormat.format(payroll.netPay),
                    style: AppFonts.interStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            if (isPaid) ...[
              DetailSectionWidget(
                title: 'Payment Information',
                icon: Icons.payment_rounded,
                iconColor: Colors.green,
                children: [
                  DetailInfoRow(
                    label: 'Payment Date',
                    value: payroll.paymentDate ?? 'N/A',
                  ),
                  DetailInfoRow(
                    label: 'Payment Method',
                    value: payroll.paymentMethod,
                  ),
                  if (payroll.bankReference != null)
                    DetailInfoRow(
                      label: 'Bank Reference',
                      value: payroll.bankReference!,
                    ),
                  if (payroll.paidBy != null)
                    DetailInfoRow(
                      label: 'Paid By',
                      value: payroll.paidBy!,
                    ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
            if (payroll.notes != null && payroll.notes!.isNotEmpty) ...[
              DetailSectionWidget(
                title: 'Notes',
                icon: Icons.notes_rounded,
                iconColor: Colors.grey,
                children: [
                  Text(
                    payroll.notes!,
                    style: AppFonts.interStyle(
                      fontSize: 14.sp,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailInfoRow(
                    label: 'Generated On',
                    value: DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.parse(payroll.created)),
                    fontSize: 12.sp,
                  ),
                  if (payroll.generatedBy != null)
                    DetailInfoRow(
                      label: 'Generated By',
                      value: payroll.generatedBy!,
                      fontSize: 12.sp,
                    ),
                  if (payroll.approvedBy != null)
                    DetailInfoRow(
                      label: 'Approved By',
                      value: payroll.approvedBy!,
                      fontSize: 12.sp,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeInfoCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.blue.withOpacity(0.1),
                child: Text(
                  payroll.employeeName.substring(0, 1).toUpperCase(),
                  style: AppFonts.interStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payroll.employeeName,
                      style: AppFonts.interStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      payroll.employeeCode,
                      style: AppFonts.interStyle(
                        fontSize: 12.sp,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (payroll.department.isNotEmpty && payroll.position.isNotEmpty) ...[
            SizedBox(height: 16.h),
            const Divider(height: 1),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Department',
                        style: AppFonts.interStyle(
                          fontSize: 12.sp,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        payroll.department,
                        style: AppFonts.interStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Position',
                        style: AppFonts.interStyle(
                          fontSize: 12.sp,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        payroll.position,
                        style: AppFonts.interStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  size: 16.r,
                  color: Colors.blue,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Payroll Month: ${payroll.payrollMonth}',
                  style: AppFonts.interStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
