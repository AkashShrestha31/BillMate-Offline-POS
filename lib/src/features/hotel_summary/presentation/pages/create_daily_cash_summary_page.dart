import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/extensions/extensions/localization_extension.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_request_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/response/daily_cash_summary_response_model.dart';
import 'package:hotel/src/features/hotel_summary/presentation/cubit/daily_cash_summary_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_list_chrome.dart';

@RoutePage()
class CreateDailyCashSummaryPage extends StatefulWidget {
  final DailyCashSummaryModel? summary; // Optional - for update mode

  const CreateDailyCashSummaryPage({
    super.key,
    this.summary,
  });

  @override
  State<CreateDailyCashSummaryPage> createState() => _CreateDailyCashSummaryPageState();
}

class _CreateDailyCashSummaryPageState extends State<CreateDailyCashSummaryPage> {
  final _formKey = GlobalKey<FormState>();
  late DailyCashSummaryCubit _cubit;

  // Controllers for form fields
  final _dateController = TextEditingController();
  final _openingBalanceController = TextEditingController();
  final _salesAmountController = TextEditingController();
  final _qrAmountController = TextEditingController();
  final _cashAmountController = TextEditingController();
  final _discountController = TextEditingController();
  final _expensesController = TextEditingController();
  final _unPaidController = TextEditingController();
  final _unPaidDiscountController = TextEditingController();
  final _creditPaidCashController = TextEditingController();
  final _creditQrController = TextEditingController();
  final _closingBalanceController = TextEditingController();
  final _lostMoneyController = TextEditingController();
  final _extraMoneyController = TextEditingController(); // New field
  final _payQrGetCashExchangeController = TextEditingController(); // New field
  final _payCashGetQrExchangeController = TextEditingController(); // New field
  final _createdByController = TextEditingController();

  // Check if this is update mode
  bool get isUpdateMode => widget.summary != null;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<DailyCashSummaryCubit>();
    _initializeFields();
  }

  void _initializeFields() {
    if (isUpdateMode) {
      // Populate fields with existing data for update
      _populateFieldsForUpdate();
    } else {
      // Set default values for create
      _setDefaultValues();
    }
  }

  void _populateFieldsForUpdate() {
    final summary = widget.summary!;
    _dateController.text = summary.date;
    _openingBalanceController.text = summary.openingBalance?.toString() ?? '';
    _salesAmountController.text = summary.salesAmount?.toString() ?? '';
    _qrAmountController.text = summary.qrAmount?.toString() ?? '';
    _cashAmountController.text = summary.cashAmount?.toString() ?? '';
    _discountController.text = summary.discount?.toString() ?? '';
    _expensesController.text = summary.expenses?.toString() ?? '';
    _unPaidController.text = summary.unPaid?.toString() ?? '';
    _unPaidDiscountController.text = summary.unPaidDiscount?.toString() ?? '';
    _creditPaidCashController.text = summary.creditPaidCash?.toString() ?? '';
    _creditQrController.text = summary.creditQr?.toString() ?? '';
    _closingBalanceController.text = summary.closingBalance?.toString() ?? '';
    _lostMoneyController.text = summary.lostMoney?.toString() ?? '';
    _extraMoneyController.text = summary.extraMoney?.toString() ?? ''; // New field
    _payQrGetCashExchangeController.text = summary.payQrGetCashExchange?.toString() ?? ''; // New field
    _payCashGetQrExchangeController.text = summary.payCashGetQrExchange?.toString() ?? ''; // New field
    _createdByController.text = "hotelroyalrestro@gmail.com"; // For update, use modifiedBy
  }

  void _setDefaultValues() {
    // Set default date to today
    _dateController.text = DateTime.now().toIso8601String().substring(0, 10);
    _createdByController.text = "hotelroyalrestro@gmail.com";
  }

  @override
  void dispose() {
    // Dispose all controllers
    _dateController.dispose();
    _openingBalanceController.dispose();
    _salesAmountController.dispose();
    _qrAmountController.dispose();
    _cashAmountController.dispose();
    _discountController.dispose();
    _expensesController.dispose();
    _unPaidController.dispose();
    _unPaidDiscountController.dispose();
    _creditPaidCashController.dispose();
    _creditQrController.dispose();
    _closingBalanceController.dispose();
    _lostMoneyController.dispose();
    _extraMoneyController.dispose(); // New field
    _payQrGetCashExchangeController.dispose(); // New field
    _payCashGetQrExchangeController.dispose(); // New field
    _createdByController.dispose();
    super.dispose();
  }

  // Validation Methods
  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Date is required';
    }

    try {
      DateTime.parse(value);

      // Check if date is not in the future
      final inputDate = DateTime.parse(value);
      final today = DateTime.now();
      final todayOnly = DateTime(today.year, today.month, today.day);
      final inputDateOnly = DateTime(inputDate.year, inputDate.month, inputDate.day);

      if (inputDateOnly.isAfter(todayOnly)) {
        return 'Date cannot be in the future';
      }

      return null;
    } catch (e) {
      return 'Please enter a valid date (YYYY-MM-DD)';
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? _validatePositiveNumber(String? value, String fieldName, {bool required = false}) {
    if (value == null || value.trim().isEmpty) {
      if (required) {
        return '$fieldName is required';
      }
      return null; // Optional field can be empty
    }

    final numValue = double.tryParse(value.trim());
    if (numValue == null) {
      return 'Please enter a valid number';
    }

    if (numValue < 0) {
      return '$fieldName cannot be negative';
    }

    // Check for reasonable limits (adjust as needed)
    if (numValue > 10000000) {
      // 10 million limit
      return '$fieldName seems too large';
    }

    return null;
  }

  String? _validateNumber(String? value, String fieldName, {bool required = false}) {
    if (value == null || value.trim().isEmpty) {
      if (required) {
        return '$fieldName is required';
      }
      return null; // Optional field can be empty
    }

    final numValue = double.tryParse(value.trim());
    if (numValue == null) {
      return 'Please enter a valid number';
    }

    // Check for reasonable limits
    if (numValue > 10000000) {
      // 10 million limit
      return '$fieldName seems too large';
    }

    if (numValue < -1000000) {
      // -1 million limit for negative values
      return '$fieldName seems too small';
    }

    return null;
  }

  // Cross-field validation
  String? _validateCashFlow() {
    final openingBalance = double.tryParse(_openingBalanceController.text.trim()) ?? 0;
    final salesAmount = double.tryParse(_salesAmountController.text.trim()) ?? 0;
    final cashAmount = double.tryParse(_cashAmountController.text.trim()) ?? 0;
    final qrAmount = double.tryParse(_qrAmountController.text.trim()) ?? 0;
    final discount = double.tryParse(_discountController.text.trim()) ?? 0;
    final expenses = double.tryParse(_expensesController.text.trim()) ?? 0;
    final lostMoney = double.tryParse(_lostMoneyController.text.trim()) ?? 0;
    final closingBalance = double.tryParse(_closingBalanceController.text.trim()) ?? 0;

    // Check if cash + qr amounts match sales amount (with some tolerance)
    // final totalPayments = cashAmount + qrAmount;
    // if (salesAmount > 0 && totalPayments > 0) {
    //   final difference = (salesAmount - totalPayments).abs();
    //   if (difference > salesAmount * 0.1) {
    //     // 10% tolerance
    //     return 'Cash + QR amounts should roughly equal Sales amount';
    //   }
    // }

    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Additional cross-field validation
      final crossValidationError = _validateCashFlow();
      if (crossValidationError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(crossValidationError),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
      if (isUpdateMode) {
        _updateSummary();
      } else {
        _createSummary();
      }
    } else {
      // Show validation error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fix the errors below'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _createSummary() {
    _cubit.createDailySummary(
      params: DailyCashSummaryRequestParams(
        date: _dateController.text.trim(),
        openingBalance: double.tryParse(_openingBalanceController.text.trim()),
        salesAmount: double.tryParse(_salesAmountController.text.trim()),
        qrAmount: double.tryParse(_qrAmountController.text.trim()),
        cashAmount: double.tryParse(_cashAmountController.text.trim()),
        discount: double.tryParse(_discountController.text.trim()),
        expenses: double.tryParse(_expensesController.text.trim()),
        unPaid: double.tryParse(_unPaidController.text.trim()),
        unPaidDiscount: double.tryParse(_unPaidDiscountController.text.trim()),
        creditPaidCash: double.tryParse(_creditPaidCashController.text.trim()),
        creditQr: double.tryParse(_creditQrController.text.trim()),
        closingBalance: double.tryParse(_closingBalanceController.text.trim()),
        lostMoney: double.tryParse(_lostMoneyController.text.trim()),
        extraMoney: double.tryParse(_extraMoneyController.text.trim()), // New field
        payQrGetCashExchange: double.tryParse(_payQrGetCashExchangeController.text.trim()), // New field
        payCashGetQrExchange: double.tryParse(_payCashGetQrExchangeController.text.trim()), // New field
        createdBy: _createdByController.text.trim(),
      ),
    );
  }

  void _updateSummary() {
    _cubit.updateDailySummary(
      params: DailyCashSummaryRequestParams(
        id: widget.summary!.id, // Required for update
        date: _dateController.text.trim(),
        openingBalance: _openingBalanceController.text.trim().isEmpty
            ? null
            : double.tryParse(_openingBalanceController.text.trim()),
        salesAmount: _salesAmountController.text.trim().isEmpty
            ? null
            : double.tryParse(_salesAmountController.text.trim()),
        qrAmount: _qrAmountController.text.trim().isEmpty
            ? null
            : double.tryParse(_qrAmountController.text.trim()),
        cashAmount: _cashAmountController.text.trim().isEmpty
            ? null
            : double.tryParse(_cashAmountController.text.trim()),
        discount: _discountController.text.trim().isEmpty
            ? null
            : double.tryParse(_discountController.text.trim()),
        expenses: _expensesController.text.trim().isEmpty
            ? null
            : double.tryParse(_expensesController.text.trim()),
        unPaid: _unPaidController.text.trim().isEmpty
            ? null
            : double.tryParse(_unPaidController.text.trim()),
        unPaidDiscount: _unPaidDiscountController.text.trim().isEmpty
            ? null
            : double.tryParse(_unPaidDiscountController.text.trim()),
        creditPaidCash: _creditPaidCashController.text.trim().isEmpty
            ? null
            : double.tryParse(_creditPaidCashController.text.trim()),
        creditQr: _creditQrController.text.trim().isEmpty
            ? null
            : double.tryParse(_creditQrController.text.trim()),
        closingBalance: _closingBalanceController.text.trim().isEmpty
            ? null
            : double.tryParse(_closingBalanceController.text.trim()),
        lostMoney: _lostMoneyController.text.trim().isEmpty
            ? null
            : double.tryParse(_lostMoneyController.text.trim()),

        extraMoney: _extraMoneyController.text.trim().isEmpty
            ? null
            : double.tryParse(_extraMoneyController.text.trim()), // New field
        payQrGetCashExchange: _payQrGetCashExchangeController.text.trim().isEmpty
            ? null
            : double.tryParse(_payQrGetCashExchangeController.text.trim()), // New field
        payCashGetQrExchange: _payCashGetQrExchangeController.text.trim().isEmpty
            ? null
            : double.tryParse(_payCashGetQrExchangeController.text.trim()), // New field
        modifiedBy: _createdByController.text.trim(), // Use as modifiedBy for updates
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: scheme.surface,
        elevation: 0,
        foregroundColor: scheme.onSurface,
        title: Text(
          isUpdateMode
              ? 'Update Summary - ${widget.summary!.date}'
              : 'Create Daily Summary',
          style: AppFonts.interStyle(
            color: scheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: AppBarIosBackButton(
          color: scheme.onSurfaceVariant,
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: BlocConsumer<DailyCashSummaryCubit, DailyCashSummaryState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            noInternet: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.wifi_off, color: Colors.white),
                      SizedBox(width: 8),
                      Text('No internet connection'),
                    ],
                  ),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            error: (message) {
              context.showKiiSnackBarError(message);
            },
            summaryCreated: (response) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(response.message ?? 'Summary created successfully'),
                    ],
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              context.router.maybePop(); // Navigate back to main page
            },
            summariesLoaded: (response) {},
            summaryUpdated: (response) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(response.message ?? 'Summary updated successfully'),
                    ],
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              context.router.maybePop(); // Navigate back to main page
            },
            summaryDeleted: (response) {},
          );
        },
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Info Banner for Update Mode
                      if (isUpdateMode) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: scheme.primaryContainer.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: scheme.primary, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Updating Summary ID: ${widget.summary!.id}',
                                      style: AppFonts.interStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: scheme.onSurface,
                                      ),
                                    ),
                                    Text(
                                      'Date: ${widget.summary!.date}',
                                      style: AppFonts.interStyle(
                                        fontSize: 12,
                                        color: scheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Header Card
                      _buildSectionCard(
                        title: 'Basic Information',
                        icon: Icons.info_outline,
                        children: [
                          _buildTextField(
                            controller: _dateController,
                            label: 'Date',
                            hint: 'YYYY-MM-DD',
                            isRequired: true,
                            isReadOnly: isUpdateMode, // Read-only for updates
                            keyboardType: TextInputType.datetime,
                            validator: _validateDate,
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _createdByController,
                            label: isUpdateMode ? 'Modified By' : 'Created By',
                            hint: 'Enter email address',
                            isRequired: true,
                            keyboardType: TextInputType.emailAddress,
                            validator: _validateEmail,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Cash Flow Card
                      _buildSectionCard(
                        title: 'Cash Flow',
                        icon: Icons.account_balance_wallet,
                        children: [
                          _buildTextField(
                            controller: _openingBalanceController,
                            label: 'Opening Balance',
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validatePositiveNumber(value, 'Opening Balance'),
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _closingBalanceController,
                            label: 'Closing Balance',
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validateNumber(value, 'Closing Balance'),
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _extraMoneyController,
                            label: 'Extra Money',
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validateNumber(value, 'Extra Money'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Sales & Revenue Card
                      _buildSectionCard(
                        title: 'Sales & Revenue',
                        icon: Icons.point_of_sale,
                        children: [
                          _buildTextField(
                            controller: _salesAmountController,
                            label: 'Sales Amount',
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validatePositiveNumber(value, 'Sales Amount'),
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _cashAmountController,
                            label: 'Cash Amount',
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validatePositiveNumber(value, 'Cash Amount'),
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _qrAmountController,
                            label: 'QR Amount',
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validatePositiveNumber(value, 'QR Amount'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Payment Exchange Card (New section for the new exchange fields)
                      _buildSectionCard(
                        title: context.l10n.closePaymentExchange,
                        icon: Icons.swap_horiz,
                        children: [
                          _buildTextField(
                            controller: _payQrGetCashExchangeController,
                            label: context.l10n.closePayQrGetCashExchangeLabel,
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validatePositiveNumber(
                              value,
                              context.l10n.closePayQrGetCashExchangeLabel,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _payCashGetQrExchangeController,
                            label: context.l10n.closePayCashGetQrExchangeLabel,
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validatePositiveNumber(
                              value,
                              context.l10n.closePayCashGetQrExchangeLabel,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Deductions Card
                      _buildSectionCard(
                        title: 'Deductions & Expenses',
                        icon: Icons.remove_circle_outline,
                        children: [
                          _buildTextField(
                            controller: _discountController,
                            label: 'Discount',
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validatePositiveNumber(value, 'Discount'),
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _expensesController,
                            label: 'Expenses',
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validatePositiveNumber(value, 'Expenses'),
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _lostMoneyController,
                            label: 'Lost Money',
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validatePositiveNumber(value, 'Lost Money'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Credit & Unpaid Card
                      _buildSectionCard(
                        title: 'Credit & Unpaid',
                        icon: Icons.credit_card,
                        children: [
                          _buildTextField(
                            controller: _unPaidController,
                            label: 'Unpaid Amount',
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validatePositiveNumber(value, 'Unpaid Amount'),
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _unPaidDiscountController,
                            label: 'Unpaid Discount',
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validatePositiveNumber(value, 'Unpaid Discount'),
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _creditPaidCashController,
                            label: 'Credit Paid (Cash)',
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validatePositiveNumber(value, 'Credit Paid (Cash)'),
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _creditQrController,
                            label: 'Credit Paid (QR)',
                            hint: '0.00',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (value) => _validatePositiveNumber(value, 'Credit Paid (QR)'),
                          ),
                        ],
                      ),
                      verticalMarginMedium,

                      CustomButtonWidget(
                        title: isUpdateMode ? "Update Summary" : "Create Summary",
                        onPressed: _submitForm,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Loading overlay
              if (state == const DailyCashSummaryState.loading())
                Container(
                  color: scheme.scrim.withValues(alpha: 0.45),
                  child: Center(
                    child: CircularProgressIndicator(color: scheme.primary),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: InvoiceListChrome.cardDecoration(
        context,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: scheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppFonts.interStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isRequired = false,
    bool isReadOnly = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppFonts.interStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: scheme.onSurface,
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: AppFonts.interStyle(color: scheme.error, fontWeight: FontWeight.bold),
              ),
            if (isReadOnly)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Read Only',
                  style: AppFonts.interStyle(
                    fontSize: 10,
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: isReadOnly,
          style: AppFonts.interStyle(color: scheme.onSurface),
          cursorColor: scheme.primary,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppFonts.interStyle(color: scheme.onSurfaceVariant.withValues(alpha: 0.75)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isReadOnly ? scheme.outlineVariant : scheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: scheme.error, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: scheme.error, width: 2),
            ),
            filled: true,
            fillColor: isReadOnly
                ? scheme.surfaceContainerLow
                : scheme.surfaceContainerHighest,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          validator: validator,
        ),
      ],
    );
  }
}