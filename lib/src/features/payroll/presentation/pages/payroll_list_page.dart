import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:intl/intl.dart';
import '../../data/models/request/payroll_query_params.dart';
import '../../data/models/request/delete_payroll_request.dart';
import '../../data/models/response/payroll_model.dart';
import '../cubit/payroll_cubit.dart';
import '../widgets/payroll_card.dart';
import '../widgets/payroll_filter_bottom_sheet.dart';
import '../widgets/payroll_summary_card.dart';
import '../dialogs/payment_confirmation_dialog.dart';
import '../utils/payroll_pdf_exporter.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/widget/action_bottom_sheet.dart';

@RoutePage()
class PayrollListPage extends StatelessWidget {
  const PayrollListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PayrollCubit>()
        ..getPayrolls(
          params: PayrollQueryParams(
            payrollMonth: DateFormat('yyyy-MM').format(DateTime.now()),
          ),
        ),
      child: _PayrollListPageContent(),
    );
  }
}

class _PayrollListPageContent extends StatefulWidget {
  const _PayrollListPageContent();

  @override
  State<_PayrollListPageContent> createState() => _PayrollListPageContentState();
}

class _PayrollListPageContentState extends State<_PayrollListPageContent> {
  NumberFormat get _currencyFormat => AppMoneyFormat.currency(currencySymbol);
  PayrollQueryParams _currentParams = PayrollQueryParams(
    payrollMonth: DateFormat('yyyy-MM').format(DateTime.now()),
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayrollCubit, PayrollState>(
      listener: (context, state) {
        state.maybeWhen(
          generated: (response) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response.message),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
            _refreshPayrolls();
          },
          paymentUpdated: (response) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response.message),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
            _refreshPayrolls();
          },
          deleted: (response) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response.message),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
            _refreshPayrolls();
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final theme = Theme.of(context);
        return Scaffold(
          backgroundColor: theme.colorScheme.surfaceContainerLowest,
          appBar: AppBar(
            leading: AppBarIosBackButton(color: theme.colorScheme.onSurface),
            title: Text('Payroll'),
            centerTitle: false,
            backgroundColor: theme.colorScheme.surfaceContainerLowest,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                tooltip: 'Filter',
                icon: Icon(Icons.tune_rounded, size: 22.r),
                onPressed: _showFilterBottomSheet,
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: IconButton.filled(
                  tooltip: 'Generate payroll',
                  onPressed: _openGeneratePayrollPage,
                  icon: Icon(Icons.add_rounded, size: 22.r),
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          body: state.maybeWhen(
            loading: () => Center(child: CircularProgressIndicator()),
            loaded: (response) => _buildPayrollList(response.payrollRecords, response.summary),
            error: (message) => _buildErrorState(message),
            orElse: () => _buildEmptyState(),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final primary = scheme.primary;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_rounded,
                size: 56.r,
                color: primary.withValues(alpha: 0.85),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'No payroll records found',
              textAlign: TextAlign.center,
              style: AppFonts.interStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Generate payroll for your staff to get started',
              textAlign: TextAlign.center,
              style: AppFonts.interStyle(
                fontSize: 14.sp,
                height: 1.4,
                color: scheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 28.h),
            Material(
              color: primary,
              elevation: 0,
              shadowColor: primary.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(14.r),
              child: InkWell(
                onTap: _openGeneratePayrollPage,
                borderRadius: BorderRadius.circular(14.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_circle_rounded, color: theme.colorScheme.onPrimary, size: 22.r),
                      SizedBox(width: 10.w),
                      Text(
                        'Generate Payroll',
                        style: AppFonts.interStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onPrimary,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, size: 48.r, color: Colors.red[300]),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppFonts.interStyle(fontSize: 14.sp, color: scheme.onSurfaceVariant),
            ),
            SizedBox(height: 20.h),
            OutlinedButton(
              onPressed: _refreshPayrolls,
              child: Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayrollList(List<PayrollModel> payrolls, summary) {
    if (payrolls.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        PayrollSummaryCard(
          totalGrossPay: summary.totalGrossPay,
          totalDeductions: summary.totalDeductions,
          totalNetPay: summary.totalNetPay,
          currencyFormat: _currencyFormat,
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
            itemCount: payrolls.length,
            separatorBuilder: (_, __) => SizedBox(height: 10.h),
            itemBuilder: (context, index) {
              final payroll = payrolls[index];
              return PayrollCard(
                payroll: payroll,
                currencyFormat: _currencyFormat,
                onTap: () => _navigateToDetail(payroll),
                onMarkAsPaid: () => _showPaymentConfirmationDialog(payroll),
                onDelete: () => _showDeleteConfirmation(payroll),
                onExportPdf: () => _showPayrollPdfSheet(payroll),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showFilterBottomSheet() {
    final payrollCubit = context.read<PayrollCubit>(); // Get the cubit before opening bottom sheet

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => PayrollFilterBottomSheet(
        currentParams: _currentParams,
        onApply: (params) {
          setState(() {
            _currentParams = params;
          });
          payrollCubit.getPayrolls(params: params); // Use the cubit reference
          Navigator.pop(bottomSheetContext);
        },
      ),
    );
  }

  Future<void> _openGeneratePayrollPage() async {
    final result = await context.router.push<bool>(const GeneratePayrollRoute());
    if (!mounted || result != true) return;
    _refreshPayrolls();
  }

  void _showPaymentConfirmationDialog(PayrollModel payroll) {
    final payrollCubit = context.read<PayrollCubit>(); // Get the cubit before opening dialog

    showDialog(
      context: context,
      builder: (dialogContext) => PaymentConfirmationDialog(
        payroll: payroll,
        currencyFormat: _currencyFormat,
        onConfirm: (request) {
          payrollCubit.updatePaymentStatus(request: request); // Use the cubit reference
          Navigator.pop(dialogContext);
        },
      ),
    );
  }

  void _showDeleteConfirmation(PayrollModel payroll) {
    final payrollCubit = context.read<PayrollCubit>(); // Get the cubit before opening dialog

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Delete Payroll'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to delete this payroll?'),
            SizedBox(height: 12.h),
            Text(
              'Employee: ${payroll.employeeName}',
              style: AppFonts.interStyle(fontWeight: FontWeight.w600),
            ),
            Text('Month: ${payroll.payrollMonth}'),
            Text('Amount: ${_currencyFormat.format(payroll.netPay)}'),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_rounded, color: Colors.red, size: 20.r),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'This action cannot be undone',
                      style: AppFonts.interStyle(
                        color: Colors.red,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              payrollCubit.deletePayroll(
                // Use the cubit reference
                request: DeletePayrollRequest(payrollId: payroll.id),
              );
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _navigateToDetail(PayrollModel payroll) {
    context.router.push(PayrollDetailRoute(payroll: payroll));
  }

  void _showPayrollPdfSheet(PayrollModel payroll) {
    final theme = Theme.of(context);
    ActionBottomSheet.show(
      context,
      title: 'Export payroll',
      items: [
        ActionSheetItem(
          icon: Icons.picture_as_pdf,
          title: 'Export as PDF',
          color: theme.colorScheme.primary,
          onTap: () => _exportPayrollPdf(payroll),
        ),
        ActionSheetItem(
          icon: Icons.share,
          title: 'Share PDF',
          color: theme.colorScheme.primary,
          onTap: () => _sharePayrollPdf(payroll),
        ),
      ],
    );
  }

  Future<void> _exportPayrollPdf(PayrollModel payroll) async {
    try {
      await PayrollPdfExporter.openPdf(
        payroll: payroll,
        currencyFormat: _currencyFormat,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payroll PDF exported'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not export PDF: $e'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _sharePayrollPdf(PayrollModel payroll) async {
    try {
      await PayrollPdfExporter.sharePdf(
        payroll: payroll,
        currencyFormat: _currencyFormat,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not share PDF: $e'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _refreshPayrolls() {
    context.read<PayrollCubit>().getPayrolls(params: _currentParams);
  }
}
