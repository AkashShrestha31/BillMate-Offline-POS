import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/pdf_export_option_tile.dart';
import 'package:hotel/src/features/action/data/models/request/payment_analytics_request_model.dart';
import 'package:hotel/src/features/action/data/models/request/payment_request_model.dart';
import 'package:hotel/src/features/action/data/models/response/payment_analytics_response_model.dart';
import 'package:hotel/src/features/action/presentation/cubit/payment_analytics_cubit.dart';
import 'package:hotel/src/features/action/presentation/cubit/payment_cubit.dart';
import 'package:intl/intl.dart';

import '../../../invoice/data/models/response/invoice_sales_response_model.dart';

class PaymentEditPage extends StatefulWidget {
  final PaymentDetails? initialPayment;
  final VoidCallback? onSave;
  const PaymentEditPage({
    super.key,
    this.initialPayment,
    this.onSave,
  });

  @override
  State<PaymentEditPage> createState() => _PaymentEditPageState();
}

class _PaymentEditPageState extends State<PaymentEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Controllers for text fields
  // final _paymentNameController = TextEditingController();
  // final _partyController = TextEditingController();
  final _referenceIdController = TextEditingController();
  final _amountController = TextEditingController();
  final _paymentDateController = TextEditingController();
  final _paymentMethodDisplayController = TextEditingController();
  // final _paymentAccountController = TextEditingController();

  // ValueNotifiers for reactive state management
  // final ValueNotifier<String> _selectedPaymentType = ValueNotifier<String>('Receive');
  final ValueNotifier<String> _selectedMethod = ValueNotifier<String>('Cash');
  final ValueNotifier<DateTime> _selectedDate = ValueNotifier<DateTime>(DateTime.now());

  final _dateFormat = DateFormat('yyyy-MM-dd');

  // Dropdown options
  final List<String> _paymentTypes = ['Receive', 'Pay'];
  final List<String> _paymentMethods = ['Cash', 'Transfer', 'Cheque'];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    if (widget.initialPayment != null) {
      final payment = widget.initialPayment!;
      // _paymentNameController.text = payment.paymentName;
      // _partyController.text = payment.party;
      _referenceIdController.text = payment.referenceId ?? '';
      _amountController.text = payment.amount.toString();
      _selectedMethod.value = payment.paymentMethod.toString();
      _paymentMethodDisplayController.text = payment.paymentMethod.toString();
      // _paymentAccountController.text = payment.paymentAccount;
      // _selectedPaymentType.value = payment.paymentType;

      // Parse date
      try {
        _selectedDate.value = payment.date!;
        _paymentDateController.text = _dateFormat.format(payment.date!);
      } catch (e) {
        _selectedDate.value = DateTime.now();
        _paymentDateController.text = _dateFormat.format(DateTime.now());
      }
    } else {
      // Set default values for new payment
      // _paymentNameController.text = _generatePaymentName();
      // _selectedPaymentType.value = 'Receive'; // Default to Receive
      _selectedMethod.value = 'Cash'; // Default to Cash
      _paymentMethodDisplayController.text = 'Cash';
      _selectedDate.value = DateTime.now();
      _paymentDateController.text = _dateFormat.format(DateTime.now());
    }
  }

  String _generatePaymentName() {
    final now = DateTime.now();
    return 'PAY-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${now.millisecondsSinceEpoch.toString().substring(8)}';
  }

  @override
  void dispose() {
    // _paymentNameController.dispose();
    // _partyController.dispose();
    _referenceIdController.dispose();
    _amountController.dispose();
    _paymentDateController.dispose();
    _paymentMethodDisplayController.dispose();
    // _paymentAccountController.dispose();
    _scrollController.dispose();
    // _selectedPaymentType.dispose();
    _selectedMethod.dispose();
    _selectedDate.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Colors.blue[600],
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate.value) {
      _selectedDate.value = picked;
      _paymentDateController.text = _dateFormat.format(picked);
    }
  }

  void _savePayment() async {
    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }

    PaymentRequestModel payment = PaymentRequestModel(
      paymentName: widget.initialPayment?.paymentId,
      paymentMethod: _selectedMethod.value,
      amount: double.parse(_amountController.text.trim()),
      date: _dateFormat.format(_selectedDate.value),
      // party: _partyController.text.trim(),
      // paymentType: _selectedPaymentType.value,
      referenceId: _selectedMethod.value == 'Transfer'
          ? 'TXN-${DateTime.now().millisecondsSinceEpoch}'
          : (_referenceIdController.text.trim().isEmpty ? null : _referenceIdController.text.trim()),
      // paymentAccount: _paymentAccountController.text.trim(),
    );
    context.read<PaymentCubit>().updatePayment(payment);

    // Simulate save operation
    // await Future.delayed(const Duration(milliseconds: 500));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
    String? suffix,
  }) {
    return CustomTextFormField(
      controller: controller,
      keyboardType: keyboardType??TextInputType.text,
      maxLines: maxLines,
      inputFormatter: inputFormatters,
      validating: validator,
      labelText: label,
    );
  }

  Future<void> _showPaymentMethodBottomSheet() async {
    final theme = Theme.of(context);
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Select Payment Method',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                verticalMarginSmall,
                const Divider(),
                verticalMarginMedium,
                ..._paymentMethods.expand((method) => [
                      PdfExportOptionTile(
                        icon: _selectedMethod.value == method ? Icons.check_circle : Icons.radio_button_unchecked,
                        title: method,
                        color: _selectedMethod.value == method ? Colors.green : null,
                        onTap: () => Navigator.pop(ctx, method),
                      ),
                      verticalMarginLarge,
                    ]).toList()
                  ..removeLast(),
              ],
            ),
          ),
        ),
      ),
    );
    if (selected != null && mounted) {
      setState(() {
        _selectedMethod.value = selected;
        _paymentMethodDisplayController.text = selected;
      });
    }
  }

  Widget _buildDateField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: CustomTextFormField(
        controller: _paymentDateController,
        labelText: 'Payment Date',
        readOnly: true,
        onTap: _selectDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {
            state.maybeWhen(
              loading: () {
                AppLoadingOverlay.of(context).show();
              },
              loaded: (response) {
                AppLoadingOverlay.of(context).hide();
                context.showKiiSnackBarSuccess(response.message);
                widget.onSave!();
                Navigator.of(context).pop();
                // _loadItems();
              },
              error: (message) {
                AppLoadingOverlay.of(context).hide();
              },
              orElse: () {},
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: AppBarIosBackButton(color: Colors.grey.shade800),
          title: Text(
            widget.initialPayment != null ? 'Edit Payment' : 'New Payment',
            style: AppFonts.interStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey[800],
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Form Fields Card
                Column(
                  children: [
                    // _buildTextField(
                    //   controller: _paymentNameController,
                    //   label: 'Payment Name',
                    //   icon: Icons.receipt_long,
                    //   validator: (value) {
                    //     if (value == null || value.trim().isEmpty) {
                    //       return 'Payment name is required';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // _buildTextField(
                    //   controller: _partyController,
                    //   label: 'Party Name',
                    //   icon: Icons.person,
                    //   validator: (value) {
                    //     if (value == null || value.trim().isEmpty) {
                    //       return 'Party name is required';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // _buildDropdownField(
                    //   label: 'Payment Type',
                    //   valueNotifier: _selectedPaymentType,
                    //   items: _paymentTypes,
                    //   icon: Icons.swap_horiz,
                    // ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: CustomTextFormField(
                        controller: _paymentMethodDisplayController,
                        labelText: 'Payment Method *',
                        hint: 'Tap to select',
                        readOnly: true,
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                        onTap: _showPaymentMethodBottomSheet,
                        validating: (v) => (v?.trim().isEmpty ?? true) ? 'Please select payment method' : null,
                      ),
                    ),
                    // _buildTextField(
                    //   controller: _paymentAccountController,
                    //   label: 'Payment Account',
                    //   icon: Icons.account_balance,
                    //   validator: (value) {
                    //     if (value == null || value.trim().isEmpty) {
                    //       return 'Payment account is required';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    _buildDateField(),

                    _buildTextField(
                      controller: _amountController,
                      label: 'Amount',
                      icon: Icons.currency_rupee,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Amount is required';
                        }
                        final amount = double.tryParse(value.trim());
                        if (amount == null || amount <= 0) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                    ),
                    verticalMarginMedium,
                    _buildTextField(
                      controller: _referenceIdController,
                      label: 'Reference ID (Optional)',

                      icon: Icons.tag,
                    ),
                  ],
                ),

                SizedBox(height: 24),

                CustomButtonWidget(
                  title: 'Save Payment',
                  onPressed: () => _savePayment(),
                ),

                SizedBox(height: 16),
              ],
            ).padAll(context.theme.appTheme.spacing12),
          ),
        ),
      ),
    );
  }
}

// Usage example:
