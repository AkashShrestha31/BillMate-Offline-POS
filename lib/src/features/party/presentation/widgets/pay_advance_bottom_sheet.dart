import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/invoice/data/models/request/create_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/create_invoice/create_invoice_cubit.dart';
import 'package:hotel/src/features/party/domain/employee_advance_constants.dart';

/// Records a salary advance as a submitted purchase invoice for an employee party.
class PayAdvanceBottomSheet extends StatefulWidget {
  const PayAdvanceBottomSheet({
    super.key,
    required this.partyName,
    required this.employeeDisplayName,
  });

  final String partyName;
  final String employeeDisplayName;

  static Future<Object?> show(
    BuildContext context, {
    required String partyName,
    required String employeeDisplayName,
  }) {
    return showModalBottomSheet<Object?>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BlocProvider(
        create: (_) => getIt<CreateInvoiceCubit>(),
        child: PayAdvanceBottomSheet(
          partyName: partyName,
          employeeDisplayName: employeeDisplayName,
        ),
      ),
    );
  }

  @override
  State<PayAdvanceBottomSheet> createState() => _PayAdvanceBottomSheetState();
}

class _PayAdvanceBottomSheetState extends State<PayAdvanceBottomSheet> {
  final _dateController = TextEditingController();
  final _amountController = TextEditingController();
  final _amountFocusNode = FocusNode();
  final _amountNotifier = ValueNotifier<String>('');
  final _scrollController = ScrollController();

  DateTime? _advanceDate;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _advanceDate = today;
    _dateController.text = _formatDate(today);
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatRs(double value) => '$currencySymbol ${value.toStringAsFixed(1)}';

  bool _validate() {
    if (_advanceDate == null) {
      context.showKiiSnackBarError('Date is required');
      return false;
    }
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      context.showKiiSnackBarError('Amount is required');
      return false;
    }
    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      context.showKiiSnackBarError('Enter an amount greater than 0');
      return false;
    }
    return true;
  }

  void _submit() {
    if (!_validate()) return;

    final amount = double.parse(_amountController.text.trim());
    final dateStr = _formatDate(_advanceDate!);
    final actor = context.employeeData?.email?.trim();
    final createdBy = (actor != null && actor.isNotEmpty) ? actor : 'system';

    final params = CreateInvoiceRequestParams(
      invoiceType: InvoiceType.purchase,
      party: widget.partyName.trim(),
      account: 'Creditors',
      date: dateStr,
      setDiscountAmount: false,
      createdBy: createdBy,
      modifiedBy: createdBy,
      items: [
        CreateInvoiceItem(
          item: kAdvanceSalaryItemName,
          rate: amount,
          quantity: 1,
          account: 'Salary',
          setItemDiscountAmount: false,
        ),
      ],
      paymentMode: true,
      payment: [
        CreateInvoicePaymentLine(
          amount: amount,
          paymentMethod: 'Cash',
          paymentDate: dateStr,
        ),
      ],
    );

    FocusScope.of(context).unfocus();
    context.read<CreateInvoiceCubit>().createInvoice(params: params);
  }

  @override
  void dispose() {
    _dateController.dispose();
    _amountController.dispose();
    _amountFocusNode.dispose();
    _amountNotifier.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final imeBottom = media.viewInsets.bottom;
    final screenH = media.size.height;
    const sheetChromeApprox = 168.0;
    final bodyMaxHeight =
        (screenH * 0.92 - sheetChromeApprox - imeBottom).clamp(120.0, screenH);

    return BlocListener<CreateInvoiceCubit, CreateInvoiceState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loading: () => AppLoadingOverlay.of(context).show(),
          error: (message) {
            AppLoadingOverlay.of(context).hide();
            context.showKiiSnackBarError(message);
          },
          noInternet: () {
            AppLoadingOverlay.of(context).hide();
            context.showKiiSnackBarError('No internet connection');
          },
          success: (response) {
            AppLoadingOverlay.of(context).hide();
            context.showKiiSnackBarSuccess(response.message);
            Navigator.of(context).pop(response);
          },
        );
      },
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: imeBottom),
        child: SafeArea(
          top: true,
          bottom: false,
          child: Container(
            constraints: BoxConstraints(maxHeight: screenH * 0.92),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: scheme.outlineVariant,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pay Advance',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: scheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.employeeDisplayName,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: scheme.onSurface,
                                height: 1.25,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: scheme.primaryContainer.withOpacity(0.45),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: scheme.outlineVariant.withOpacity(0.5),
                                ),
                              ),
                              child: Text(
                                'Employee',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: scheme.onPrimaryContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close_rounded),
                        onPressed: () => Navigator.of(context).pop(),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: bodyMaxHeight),
                  child: ListView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.manual,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    children: [
                      _dateField(context),
                      const SizedBox(height: 14),
                      CustomTextFormField(
                        hint: 'Amount',
                        controller: _amountController,
                        focusNode: _amountFocusNode,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.none,
                        scrollPadding: EdgeInsets.only(bottom: imeBottom + 160),
                        onChanged: (v) => _amountNotifier.value = v,
                        validating: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Amount is required';
                          }
                          final amount = double.tryParse(value.trim());
                          if (amount == null || amount <= 0) {
                            return 'Enter an amount greater than 0';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Items',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder<String>(
                        valueListenable: _amountNotifier,
                        builder: (context, amountText, _) {
                          final amount = double.tryParse(amountText.trim()) ?? 0;
                          return _AdvanceSalaryItemRow(
                            amountLabel: amount > 0
                                ? _formatRs(amount)
                                : '$currencySymbol —',
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      ValueListenableBuilder<String>(
                        valueListenable: _amountNotifier,
                        builder: (context, amountText, _) {
                          return CustomButtonWidget(
                            width: MediaQuery.sizeOf(context).width,
                            title: 'Pay Advance',
                            onPressed: amountText.trim().isEmpty
                                ? null
                                : () {
                                    FocusScope.of(context).unfocus();
                                    _submit();
                                  },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateField(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final borderColor = scheme.outlineVariant.withValues(alpha: 0.6);
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _advanceDate ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (date != null) {
          setState(() {
            _advanceDate = date;
            _dateController.text = _formatDate(date);
          });
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: _dateController,
          decoration: InputDecoration(
            labelText: 'Date',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: scheme.primary, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            labelStyle: AppFonts.interStyle(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.calendar_today_rounded,
                color: scheme.onSurfaceVariant,
                size: 18,
              ),
            ),
            filled: true,
            fillColor: scheme.surfaceContainerHighest,
          ),
          style: AppFonts.interStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class _AdvanceSalaryItemRow extends StatelessWidget {
  const _AdvanceSalaryItemRow({required this.amountLabel});

  final String amountLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: scheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.lock_outline_rounded,
              color: scheme.primary.withOpacity(0.8),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kAdvanceSalaryItemName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Qty 1',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amountLabel,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
