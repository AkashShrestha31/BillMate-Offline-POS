import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/closing/data/models/request/hotel_summary_request_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/response/daily_cash_summary_response_model.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/org/domain/organization_business_type_reader.dart';

@RoutePage()
class OpeningAmountPage extends StatefulWidget {
  final DailyCashSummaryResponseModel response;

  const OpeningAmountPage({
    super.key,
    required this.response,
  });

  @override
  State<OpeningAmountPage> createState() => _OpeningAmountPageState();
}

class _OpeningAmountPageState extends State<OpeningAmountPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController amountController;
  late final TextEditingController totalAmountController;
  late final TextEditingController payQrGetCashExchange;
  late final TextEditingController payCashGetQrExchange;
  late final ValueNotifier<bool> saveReportNotifier;
  late final ValueNotifier<DateTime> dateNotifier;
  String? _businessType;

  @override
  void initState() {
    super.initState();
    _loadBusinessType();
    amountController = TextEditingController();
    totalAmountController = TextEditingController();
    payQrGetCashExchange = TextEditingController();
    payCashGetQrExchange = TextEditingController();
    saveReportNotifier = ValueNotifier(false);
    dateNotifier = ValueNotifier(DateTime.now());

    dateNotifier.addListener(() {
      _populateFieldsWithExistingData(_getSelectedDateStr());
    });

    final String initialDateStr = _getSelectedDateStr();
    _populateFieldsWithExistingData(initialDateStr);
  }

  Future<void> _loadBusinessType() async {
    final type = await OrganizationBusinessTypeReader.current();
    if (!mounted) return;
    setState(() => _businessType = type);
  }

  @override
  void dispose() {
    amountController.dispose();
    totalAmountController.dispose();
    payQrGetCashExchange.dispose();
    payCashGetQrExchange.dispose();
    saveReportNotifier.dispose();
    dateNotifier.dispose();
    super.dispose();
  }

  String? _validateRequiredOpeningAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.closeEnterOpeningAmount;
    }
    return _validateOptionalNonNegativeAmount(value);
  }

  String? _validateOptionalNonNegativeAmount(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    final parsed = double.tryParse(value.trim());
    if (parsed == null) {
      return context.l10n.closeEnterValidAmount;
    }
    if (parsed < 0) {
      return context.l10n.closeAmountCannotBeNegative;
    }
    return null;
  }

  void _handleContinue() {
    if (_formKey.currentState?.validate() != true) return;

    final String selectedDateStr = _getSelectedDateStr();
    final amount = amountController.text.trim();

    context.router.push(HotelSummaryRoute(
      hotelSummaryRequestParams: HotelSummaryRequestParams(
        date: selectedDateStr,
        openingAmount: amount,
        totalAvailableAmount: totalAmountController.text.trim().isEmpty
            ? '0'
            : totalAmountController.text.trim(),
        payQrGetCashExchange: payQrGetCashExchange.text.trim().isEmpty
            ? '0'
            : payQrGetCashExchange.text.trim(),
        payCashGetQrExchange: payCashGetQrExchange.text.trim().isEmpty
            ? '0'
            : payCashGetQrExchange.text.trim(),
        save: saveReportNotifier.value,
      ),
    ));
    Navigator.of(context).pop();
  }

  void _populateFieldsWithExistingData(String selectedDateStr) {
    final matchingData = widget.response.summaries?.where((summary) => summary.date == selectedDateStr).toList() ?? [];

    if (matchingData.isNotEmpty) {
      final existingData = matchingData.first;
      amountController.text = existingData.openingBalance?.toString() ?? '';
      payQrGetCashExchange.text = existingData.payQrGetCashExchange?.toString() ?? '0';
      payCashGetQrExchange.text = existingData.payCashGetQrExchange?.toString() ?? '0';
    } else {
      amountController.clear();
      totalAmountController.clear();
      payQrGetCashExchange.clear();
      payCashGetQrExchange.clear();
    }
  }

  String _getSelectedDateStr() {
    final selectedDate = dateNotifier.value;
    return '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateNotifier.value,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateNotifier.value = picked;
    }
  }

  Widget _buildAmountField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validating,
    TextInputAction textInputAction = TextInputAction.next,
  }) {
    return CustomTextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: textInputAction,
      style: AppFonts.interStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      labelText: label,
      hint: label,
      prefixText: '$currencySymbol ',
      textCapitalization: TextCapitalization.characters,
      validating: validating,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLow,
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(context.l10n.closing),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(DailyCashSummaryRoute());
            },
            icon: Icon(Icons.history),
          ),
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder<DateTime>(
          valueListenable: dateNotifier,
          builder: (context, selectedDate, child) {
            final String selectedDateStr = _getSelectedDateStr();
            final bool dataExists =
                widget.response.summaries?.any((summary) => summary.date == selectedDateStr) ?? false;
            final businessLabel =
                context.l10n.businessTypeLabel(_businessType);
            final payQrGetCashHint =
                context.l10n.closeExchangePayQrGetCashHint(businessLabel);
            final payCashGetQrHint =
                context.l10n.closeExchangePayCashGetQrHint(businessLabel);

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                  GestureDetector(
                    onTap: _selectDate,
                    child: Container(
                      padding: EdgeInsets.all(context.theme.appTheme.spacing12),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: scheme.shadow.withValues(alpha: 0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(context.theme.appTheme.spacing8),
                            decoration: BoxDecoration(
                              color: context.theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.calendar_today,
                              color: context.theme.colorScheme.primary,
                              size: context.theme.appTheme.spacing12,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              context.l10n.localizeDigits(selectedDateStr),
                              style: AppFonts.interStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (dataExists)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: scheme.primaryContainer,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                context.l10n.closeExists,
                                style: AppFonts.interStyle(
                                  color: scheme.onPrimaryContainer,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          Icon(Icons.keyboard_arrow_right, color: scheme.onSurfaceVariant),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (dataExists)
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: scheme.primary, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              context.l10n.closeExistingDataInfo,
                              style: AppFonts.interStyle(
                                fontSize: 14,
                                color: scheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  _buildAmountField(
                    controller: amountController,
                    label: context.l10n.closeOpeningAmount,
                    validating: _validateRequiredOpeningAmount,
                  ),
                  const SizedBox(height: 16),
                  _buildAmountField(
                    controller: totalAmountController,
                    label: context.l10n.closeCurrentAmount,
                    validating: _validateOptionalNonNegativeAmount,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        payQrGetCashHint,
                        style: AppFonts.interStyle(
                          fontSize: 12,
                          color: scheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildAmountField(
                        controller: payQrGetCashExchange,
                        label: context.l10n.closePayQrGetCash,
                        validating: _validateOptionalNonNegativeAmount,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        payCashGetQrHint,
                        style: AppFonts.interStyle(
                          fontSize: 12,
                          color: scheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildAmountField(
                        controller: payCashGetQrExchange,
                        label: context.l10n.closePayCashGetQr,
                        validating: _validateOptionalNonNegativeAmount,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<bool>(
                    valueListenable: saveReportNotifier,
                    builder: (context, saveReport, child) {
                      return Container(
                        decoration: BoxDecoration(
                          color: scheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
                          boxShadow: [
                            BoxShadow(
                              color: scheme.shadow.withValues(alpha: 0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: CheckboxListTile(
                          title: Text(
                            context.l10n.closeSaveReport,
                            style: AppFonts.interStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: scheme.onSurface,
                            ),
                          ),
                          value: saveReport,
                          onChanged: (value) => saveReportNotifier.value = value ?? false,
                          activeColor: scheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomButtonWidget(
                    width: context.width,
                    title: dataExists
                        ? context.l10n.closeUpdateSummary
                        : context.l10n.continueAction,
                    onPressed: _handleContinue,
                  ),
                ],
              ),
            ),
            );
          },
        ),
      ),
    );
  }
}
