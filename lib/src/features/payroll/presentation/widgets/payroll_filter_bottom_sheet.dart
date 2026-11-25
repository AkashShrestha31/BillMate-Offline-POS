import 'package:flutter/material.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:intl/intl.dart';
import '../../data/models/request/payroll_query_params.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

class PayrollFilterBottomSheet extends StatefulWidget {
  const PayrollFilterBottomSheet({
    super.key,
    required this.currentParams,
    required this.onApply,
  });

  final PayrollQueryParams currentParams;
  final Function(PayrollQueryParams) onApply;

  @override
  State<PayrollFilterBottomSheet> createState() => _PayrollFilterBottomSheetState();
}

class _PayrollFilterBottomSheetState extends State<PayrollFilterBottomSheet> {
  late int? _employeeId;
  late String? _payrollMonth;
  late String? _paymentStatus;
  late int? _year;

  final List<String> _paymentStatuses = ['PENDING', 'PAID', 'CANCELLED'];
  final List<int> _years = List.generate(5, (index) => DateTime.now().year - index);

  @override
  void initState() {
    super.initState();
    _employeeId = widget.currentParams.employeeId;
    _payrollMonth = widget.currentParams.payrollMonth;
    _paymentStatus = widget.currentParams.paymentStatus;
    _year = widget.currentParams.year;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    return Container(
      decoration: AppBottomSheetTheme.topSheetDecoration(context).copyWith(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            AppBottomSheetTheme.dragHandle(context),

            // Header
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Text(
                    'Filter Payrolls',
                    style: AppFonts.interStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: _clearFilters,
                    child: Text('Clear All'),
                  ),
                ],
              ),
            ),

            Divider(height: 1),

            // Filters
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Month Picker
                  _buildSectionTitle('Payroll Month'),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: _selectMonth,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month_rounded, color: scheme.onSurfaceVariant, size: 20.r),
                          SizedBox(width: 12.w),
                          Text(
                            _payrollMonth ?? 'Select month',
                            style: AppFonts.interStyle(
                              fontSize: 14.sp,
                              color: _payrollMonth != null ? scheme.onSurface : scheme.onSurfaceVariant,
                            ),
                          ),
                          Spacer(),
                          if (_payrollMonth != null)
                            GestureDetector(
                              onTap: () => setState(() => _payrollMonth = null),
                              child: Icon(Icons.close_rounded, size: 20.r, color: scheme.onSurfaceVariant),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Payment Status
                  _buildSectionTitle('Payment Status'),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    children: _paymentStatuses.map((status) {
                      final isSelected = _paymentStatus == status;
                      return FilterChip(
                        selected: isSelected,
                        label: Text(status),
                        onSelected: (selected) {
                          setState(() {
                            _paymentStatus = selected ? status : null;
                          });
                        },
                        backgroundColor: scheme.surfaceContainerHighest,
                        selectedColor: scheme.primary.withValues(alpha: 0.2),
                        checkmarkColor: scheme.primary,
                        labelStyle: AppFonts.interStyle(
                          color: isSelected ? scheme.primary : scheme.onSurfaceVariant,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20.h),

                  // Year Filter
                  _buildSectionTitle('Year'),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    children: _years.map((yearValue) {
                      final isSelected = _year == yearValue;
                      return FilterChip(
                        selected: isSelected,
                        label: Text(yearValue.toString()),
                        onSelected: (selected) {
                          setState(() {
                            _year = selected ? yearValue : null;
                          });
                        },
                        backgroundColor: scheme.surfaceContainerHighest,
                        selectedColor: scheme.primary.withValues(alpha: 0.2),
                        checkmarkColor: scheme.primary,
                        labelStyle: AppFonts.interStyle(
                          color: isSelected ? scheme.primary : scheme.onSurfaceVariant,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24.h),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _applyFilters,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                        foregroundColor: scheme.onPrimary,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Apply Filters',
                        style: AppFonts.interStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppFonts.interStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: context.colorScheme.onSurfaceVariant,
      ),
    );
  }

  void _selectMonth() async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _payrollMonth != null ? DateTime.parse('$_payrollMonth-01') : now,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        _payrollMonth = DateFormat('yyyy-MM').format(picked);
      });
    }
  }

  void _clearFilters() {
    setState(() {
      _employeeId = null;
      _payrollMonth = null;
      _paymentStatus = null;
      _year = null;
    });
  }

  void _applyFilters() {
    widget.onApply(
      PayrollQueryParams(
        employeeId: _employeeId,
        payrollMonth: _payrollMonth,
        paymentStatus: _paymentStatus,
        year: _year,
      ),
    );
  }
}
