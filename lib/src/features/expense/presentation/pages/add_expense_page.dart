import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel/src/core/constants/margin_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/expense/data/models/request/create_expense_request_params.dart';
import 'package:hotel/src/features/expense/presentation/cubits/create_expense/create_expense_cubit.dart';
import 'package:hotel/src/features/payment_methods/presentation/cubit/payment_methods_cubit.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

@RoutePage()
class AddExpensePage extends StatefulWidget implements AutoRouteWrapper {
  final VoidCallback? onComplete;

  const AddExpensePage({super.key, this.onComplete});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.instance<CreateExpenseCubit>()),
        BlocProvider(create: (_) => GetIt.instance<PaymentMethodsCubit>()..load()),
      ],
      child: this,
    );
  }
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  final _expenseNumberController = TextEditingController(text: '1');
  final _dateController = TextEditingController();
  final _notesController = TextEditingController();

  final ValueNotifier<ExpenseCategory> _categoryNotifier = ValueNotifier<ExpenseCategory>(ExpenseCategory.food);
  final ValueNotifier<String> _paymentModeNotifier = ValueNotifier<String>('Cash');
  final ValueNotifier<List<ExpenseItemRow>> _itemsNotifier = ValueNotifier<List<ExpenseItemRow>>([]);
  final ValueNotifier<double> _totalNotifier = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _dateController.text = _formatDate(DateTime.now());
    _itemsNotifier.addListener(_recalculateTotal);
  }

  String _formatDate(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  void _recalculateTotal() {
    double t = 0;
    for (final item in _itemsNotifier.value) {
      t += item.amount;
    }
    _totalNotifier.value = t;
  }

  @override
  void dispose() {
    _expenseNumberController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    _categoryNotifier.dispose();
    _paymentModeNotifier.dispose();
    for (final item in _itemsNotifier.value) {
      item.dispose();
    }
    _itemsNotifier.dispose();
    _totalNotifier.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      _dateController.text = _formatDate(picked);
    }
  }

  void _showCategoryPicker() {
    final theme = Theme.of(context);
    const sheetMargin = EdgeInsets.only(left: 16, right: 16, bottom: 16);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: Container(
          margin: sheetMargin,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Expense Category',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalMarginSmall,
                const Divider(),
                ...ExpenseCategory.values.map(
                  (c) => _buildSheetOption(
                    ctx,
                    label: _categoryLabel(c),
                    onTap: () {
                      _categoryNotifier.value = c;
                      Navigator.pop(ctx);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPaymentModePicker() {
    final theme = Theme.of(context);
    final api = context.read<PaymentMethodsCubit>().state.paymentMethodNames();
    final modes = api.isNotEmpty ? api : const ['Cash', 'Transfer'];
    const sheetMargin = EdgeInsets.only(left: 16, right: 16, bottom: 16);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: Container(
          margin: sheetMargin,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Mode',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalMarginSmall,
                const Divider(),
                ...modes.map(
                  (mode) => _buildSheetOption(
                    ctx,
                    label: mode,
                    onTap: () {
                      _paymentModeNotifier.value = mode;
                      Navigator.pop(ctx);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSheetOption(BuildContext context, {required String label, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _categoryLabel(ExpenseCategory c) {
    switch (c) {
      case ExpenseCategory.food:
        return 'Food';
      case ExpenseCategory.medicine:
        return 'Medicine';
      case ExpenseCategory.inventory:
        return 'Inventory';
      case ExpenseCategory.others:
        return 'Others';
    }
  }

  String _categoryValue(ExpenseCategory c) {
    switch (c) {
      case ExpenseCategory.food:
        return 'food';
      case ExpenseCategory.medicine:
        return 'medicine';
      case ExpenseCategory.inventory:
        return 'inventory';
      case ExpenseCategory.others:
        return 'others';
    }
  }

  void _addExpenseItem() {
    final list = List<ExpenseItemRow>.from(_itemsNotifier.value);
    final newRow = ExpenseItemRow();
    newRow.amountController.addListener(_recalculateTotal);
    list.add(newRow);
    _itemsNotifier.value = list;
  }

  void _removeExpenseItem(int index) {
    final list = List<ExpenseItemRow>.from(_itemsNotifier.value);
    list[index].dispose();
    list.removeAt(index);
    _itemsNotifier.value = list;
  }

  void _save() {
    if (_expenseNumberController.text.trim().isEmpty) {
      context.showKiiSnackBarError('Enter expense number');
      return;
    }
    if (_itemsNotifier.value.isEmpty) {
      context.showKiiSnackBarError('Add at least one expense item');
      return;
    }
    _showSaveConfirmDialog();
  }

  void _submitExpense() {
    final items = _itemsNotifier.value
        .map((e) => CreateExpenseItemParams(
              description: e.descriptionController.text.trim().isEmpty ? 'Item' : e.descriptionController.text.trim(),
              amount: e.amount,
            ))
        .toList();
    final params = CreateExpenseRequestParams(
      expenseNumber: _expenseNumberController.text.trim(),
      date: _dateController.text.trim().isEmpty ? _formatDate(DateTime.now()) : _dateController.text.trim(),
      category: _categoryValue(_categoryNotifier.value),
      items: items,
      totalAmount: _totalNotifier.value,
      paymentMode: _paymentModeNotifier.value,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
    );
    context.read<CreateExpenseCubit>().createExpense(params: params);
  }

  void _showSaveConfirmDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Save Expense'),
        content: Text(
          'Are you sure you want to save this expense? Total: Rs. ${_totalNotifier.value.toStringAsFixed(0)}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _submitExpense();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF22C55E),
              foregroundColor: Colors.white,
            ),
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseCubit, CreateExpenseState>(
      listener: (context, state) {
        switch (state) {
          case CreateExpenseLoading():
            AppLoadingOverlay.of(context).show();
            break;
          case CreateExpenseSuccess(:final response):
            AppLoadingOverlay.of(context).hide();
            context.showKiiSnackBarSuccess(response.message);
            widget.onComplete?.call();
            context.router.maybePop();
            break;
          case CreateExpenseError(:final message):
            AppLoadingOverlay.of(context).hide();
            context.showKiiSnackBarError(message);
            break;
          case CreateExpenseNoInternet():
            AppLoadingOverlay.of(context).hide();
            context.showKiiSnackBarError('No internet connection');
            break;
          default:
            break;
        }
      },
      child: BlocListener<PaymentMethodsCubit, PaymentMethodsState>(
        listenWhen: (prev, next) =>
            prev.paymentMethodNames().join('\u0001') != next.paymentMethodNames().join('\u0001'),
        listener: (context, state) {
          final names = state.paymentMethodNames();
          final effective = names.isNotEmpty ? names : const ['Cash', 'Transfer'];
          if (effective.isNotEmpty && !effective.contains(_paymentModeNotifier.value)) {
            _paymentModeNotifier.value = effective.first;
          }
        },
        child: Scaffold(
        appBar: AppBar(
          leading: AppBarIosBackButton(
            onPressed: () => context.router.maybePop(),
          ),
          title: Text('Add Expense'),
          backgroundColor: context.theme.colorScheme.surface,
          foregroundColor: context.theme.colorScheme.onSurface,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.all(context.theme.appTheme.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildExpenseDetailsCard(),
                verticalMarginMedium,
                _buildCategoryCard(),
                verticalMarginMedium,
                _buildAddExpenseItemButton(),
                verticalMarginSmall,
                ValueListenableBuilder<List<ExpenseItemRow>>(
                  valueListenable: _itemsNotifier,
                  builder: (context, items, _) {
                    if (items.isEmpty) return const SizedBox.shrink();
                    return Column(
                      children: List.generate(items.length, (i) {
                        return _buildExpenseItemRow(i, items[i]);
                      }),
                    );
                  },
                ),
                verticalMarginMedium,
                _buildSummaryCard(),
                verticalMarginMedium,
                CustomTextFormField(
                  controller: _notesController,
                  labelText: 'Notes or Remarks',
                  hint: 'Notes or Remarks',
                  maxLines: 8,
                ),
                verticalMarginMedium,
                _buildAddImagesButton(),
                verticalMarginLarge,
                CustomButtonWidget(
                  width: double.infinity,
                  onPressed: _save,
                  title: 'Save',
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildExpenseDetailsCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  verticalMarginMedium,
                  CustomTextFormField(
                    controller: _dateController,
                    hint: 'Select date',
                    readOnly: true,
                    onTap: _selectDate,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: _selectDate,
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

  Widget _buildCategoryCard() {
    return ValueListenableBuilder<ExpenseCategory>(
      valueListenable: _categoryNotifier,
      builder: (context, category, _) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: context.theme.colorScheme.primary.withValues(alpha: 0.2),
              child: Icon(Icons.account_balance_wallet_outlined, color: context.theme.colorScheme.primary),
            ),
            title: Text(
              _categoryLabel(category),
              style: context.theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            trailing: TextButton.icon(
              onPressed: _showCategoryPicker,
              icon: Icon(Icons.refresh),
              label: Text('Change'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddExpenseItemButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _addExpenseItem,
        icon: Icon(Icons.add, color: context.theme.colorScheme.primary),
        label: Text(
          'Add Expense Item',
          style: AppFonts.interStyle(color: context.theme.colorScheme.primary),
        ).pOnly(bottom: context.theme.appTheme.spacing12,top:context.theme.appTheme.spacing12),
        style: OutlinedButton.styleFrom(
          foregroundColor: context.theme.colorScheme.primary,
          side: BorderSide(color: context.theme.colorScheme.primary),
        ),
      ),
    );
  }

  Widget _buildExpenseItemRow(int index, ExpenseItemRow row) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: CustomTextFormField(
                controller: row.descriptionController,
                hint: 'Description',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomTextFormField(
                controller: row.amountController,
                hint: 'Amount',
                keyboardType: TextInputType.number,
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle_outline, color: Colors.red),
              onPressed: () => _removeExpenseItem(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return ValueListenableBuilder<double>(
      valueListenable: _totalNotifier,
      builder: (context, total, _) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Rs. ${total.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                ValueListenableBuilder<String>(
                  valueListenable: _paymentModeNotifier,
                  builder: (context, mode, _) {
                    return InkWell(
                      onTap: _showPaymentModePicker,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Mode',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Row(
                            children: [
                              Text(mode),
                              const SizedBox(width: 4),
                              Icon(Icons.chevron_right, color: Colors.grey[600]),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddImagesButton() {
    return InkWell(
      onTap: () {
        // TODO: image picker
        context.showKiiSnackBarSuccess('Add images – coming soon');
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.add_photo_alternate_outlined, color: Color(0xFF22C55E)),
          ),
          const SizedBox(width: 12),
          Text('Add Images'),
        ],
      ),
    );
  }
}

class ExpenseItemRow {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  double get amount => double.tryParse(amountController.text) ?? 0.0;

  void dispose() {
    descriptionController.dispose();
    amountController.dispose();
  }
}
