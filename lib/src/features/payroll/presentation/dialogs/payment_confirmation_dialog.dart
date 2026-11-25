import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:intl/intl.dart';
import '../../data/models/request/update_payment_request.dart';
import '../../data/models/response/payroll_model.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

class PaymentConfirmationDialog extends StatefulWidget {
  const PaymentConfirmationDialog({
    super.key,
    required this.payroll,
    required this.currencyFormat,
    required this.onConfirm,
  });

  final PayrollModel payroll;
  final NumberFormat currencyFormat;
  final Function(UpdatePaymentRequest) onConfirm;

  @override
  State<PaymentConfirmationDialog> createState() => _PaymentConfirmationDialogState();
}

class _PaymentConfirmationDialogState extends State<PaymentConfirmationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _bankReferenceController = TextEditingController();
  final _notesController = TextEditingController();

  String _paymentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _paymentMethod = 'BANK_TRANSFER';

  final List<String> _paymentMethods = [
    'BANK_TRANSFER',
    'CASH',
    'CHEQUE',
    'MOBILE_PAYMENT',
  ];

  @override
  void dispose() {
    _bankReferenceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Dialog(
      insetPadding: EdgeInsets.all(context.theme.appTheme.spacing12),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 17.r,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Mark as Paid',
                        style: AppFonts.interStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close_rounded, size: 24.r),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Payroll Summary
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Summary',
                        style: AppFonts.interStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _buildSummaryRow('Employee', widget.payroll.employeeName),
                      _buildSummaryRow('Employee Code', widget.payroll.employeeCode),
                      _buildSummaryRow('Month', widget.payroll.payrollMonth),
                      Divider(height: 20.h),
                      _buildSummaryRow(
                        'Net Pay',
                        widget.currencyFormat.format(widget.payroll.netPay),
                        bold: true,
                        valueColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                // Payment Date
                Text(
                  'Payment Date *',
                  style: AppFonts.interStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: _selectPaymentDate,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: scheme.outlineVariant),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today_rounded, color: scheme.onSurfaceVariant, size: 20.r),
                        SizedBox(width: 12.w),
                        Text(
                          DateFormat('MMM dd, yyyy').format(DateTime.parse(_paymentDate)),
                          style: AppFonts.interStyle(
                            fontSize: 14.sp,
                            color: scheme.onSurface,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_drop_down_rounded, color: scheme.onSurfaceVariant),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Payment Method
                Text(
                  'Payment Method *',
                  style: AppFonts.interStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 8.h),
                DropdownButtonFormField<String>(
                  value: _paymentMethod,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.payment_rounded, size: 20.r),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  ),
                  items: _paymentMethods.map((method) {
                    return DropdownMenuItem(
                      value: method,
                      child: Text(
                        method.replaceAll('_', ' '),
                        style: AppFonts.interStyle(fontSize: 14.sp),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _paymentMethod = value;
                      });
                    }
                  },
                ),
                SizedBox(height: 16.h),

                // Bank Reference
                Text(
                  'Bank Reference',
                  style: AppFonts.interStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _bankReferenceController,
                  decoration: InputDecoration(
                    hintText: 'Enter transaction reference',
                    prefixIcon: Icon(Icons.confirmation_number_rounded, size: 20.r),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  ),
                ),
                SizedBox(height: 16.h),

                // Notes
                Text(
                  'Notes',
                  style: AppFonts.interStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Add payment notes (optional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    contentPadding: EdgeInsets.all(16.w),
                  ),
                ),
                SizedBox(height: 24.h),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          side: BorderSide(color: scheme.outlineVariant),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppFonts.interStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _handleConfirm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Confirm Payment',
                          style: AppFonts.interStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool bold = false, Color? valueColor}) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppFonts.interStyle(
              fontSize: 13.sp,
              color: scheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: AppFonts.interStyle(
              fontSize: 13.sp,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
              color: valueColor ?? scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  void _selectPaymentDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(_paymentDate),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _paymentDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _handleConfirm() {
    if (_formKey.currentState!.validate()) {
      final request = UpdatePaymentRequest(
        payrollId: widget.payroll.id,
        paymentDate: _paymentDate,
        paymentMethod: _paymentMethod,
        bankReference: _bankReferenceController.text.isNotEmpty ? _bankReferenceController.text : null,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      widget.onConfirm(request);
    }
  }
}
