import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_method_item.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_method_request.dart';
import 'package:hotel/src/features/payment_methods/presentation/cubit/payment_method_manage_cubit.dart';
import 'package:hotel/src/features/payment_methods/presentation/utils/payment_method_visuals.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/features/settings/domain/bank_account.dart';
import 'package:hotel/src/features/settings/domain/bank_account_service.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/widget/freemium_access_scope.dart';
import 'package:hotel/src/core/widget/freemium_record_gate.dart';

const _paymentTypes = ['Cash', 'Bank', 'QR', 'Transfer', 'Cheque'];

@RoutePage()
class PaymentMethodsListPage extends StatefulWidget {
  const PaymentMethodsListPage({super.key});

  @override
  State<PaymentMethodsListPage> createState() => _PaymentMethodsListPageState();
}

class _PaymentMethodsListPageState extends State<PaymentMethodsListPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reload(BuildContext context) {
    final q = _searchController.text.trim();
    context.read<PaymentMethodManageCubit>().load(
          search: q.isEmpty ? null : q,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PaymentMethodManageCubit>()..load(),
      child: BlocConsumer<PaymentMethodManageCubit, PaymentMethodManageState>(
        listener: (context, state) {
          if (state is PaymentMethodManageLoaded && state.successMessage != null) {
            context.showKiiSnackBarSuccess(state.successMessage!);
          } else if (state is PaymentMethodManageError) {
            context.showKiiSnackBarError(state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is PaymentMethodManageLoading;
          final methods = switch (state) {
            PaymentMethodManageLoaded(:final methods) => methods,
            _ => const <PaymentMethodItem>[],
          };

          return Scaffold(
            appBar: AppBar(
              leading: const AppBarIosBackButton(),
              title: Text('Payment methods'),
              actions: [
                TextButton(
                  child: Text('Add'),
                  onPressed: isLoading ? null : () => _showFormSheet(context),
                ),
              ],
            ),
            body: FreemiumAccessHost(
              feature: FreemiumFeature.paymentMethod,
              child: Column(
              children: [
                CustomTextFormField(
                  controller: _searchController,
                  onFieldSubmitted: (_) => _reload(context),
                  hint: 'Search',
                  prefixIcon: AppSearchIcon.inputDecoration(),

                ),
                verticalMarginMedium,
                Expanded(
                  child: isLoading && methods.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : methods.isEmpty
                          ? Center(
                              child: Text(
                                'No payment methods. Tap + to add.',
                                style: AppFonts.interStyle(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async => _reload(context),
                              child: ListView.separated(
                                itemCount: methods.length,
                                separatorBuilder: (_, __) => const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  final item = methods[index];
                                  return FreemiumRecordGate(
                                    recordKey: item.name,
                                    child: _PaymentMethodCard(
                                    key: ValueKey(item.name),
                                    item: item,
                                    onMenu: () => _showActionsSheet(context, item),
                                    onTap: () => _showFormSheet(context, existing: item),
                                  ),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ).padAll(context.theme.appTheme.spacing16),
            ),
          );
        },
      ),
    );
  }

  void _showActionsSheet(BuildContext context, PaymentMethodItem item) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit_outlined),
              title: Text('Edit'),
              onTap: () {
                Navigator.pop(ctx);
                _showFormSheet(context, existing: item);
              },
            ),
            ListTile(
              leading: AppDeleteIcon(color: Colors.red[400], size: 24),
              title: Text('Delete', style: AppFonts.interStyle(color: Colors.red[400])),
              onTap: () {
                Navigator.pop(ctx);
                _confirmDeleteInSheet(context, item);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteInSheet(BuildContext context, PaymentMethodItem item) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Delete payment method',
              style: AppFonts.interStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text('Delete "${item.name}"?'),
            const SizedBox(height: 20),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(ctx);
                context.read<PaymentMethodManageCubit>().delete(item.name);
              },
              child: Text('Delete'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  void _showFormSheet(BuildContext context, {PaymentMethodItem? existing}) {
    final isEdit = existing != null;
    showAppBottomSheet<void>(
      context: context,
      title: isEdit ? 'Edit payment method' : 'New payment method',
      shrinkWrap: true,
      compactHeader: true,
      bodyBuilder: (sheetContext) => _PaymentMethodFormBody(
        existing: existing,
        onSave: (request, originalName) {
          Navigator.pop(sheetContext);
          final cubit = context.read<PaymentMethodManageCubit>();
          if (originalName != null) {
            cubit.update(originalName: originalName, request: request);
          } else {
            cubit.create(request);
          }
        },
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  const _PaymentMethodCard({
    super.key,
    required this.item,
    required this.onMenu,
    required this.onTap,
  });

  final PaymentMethodItem item;
  final VoidCallback onMenu;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final visual = paymentMethodVisual(name: item.name, type: item.type);
    final subtitle = item.account != null && item.account!.trim().isNotEmpty
        ? '${item.type} · ${item.account}'
        : item.type;

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.fromLTRB(16.sp, 6.sp, 4.sp, 6.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
          ),
          child: Row(
            children: [
              Icon(visual.icon, color: visual.color, size: 28),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style:  context.theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600
                      ),
                    ),

                    Text(
                      subtitle,
                      style: AppFonts.interStyle(fontSize: 13, color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: onMenu,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints.tightFor(width: 36, height: 36),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentMethodFormBody extends StatefulWidget {
  const _PaymentMethodFormBody({
    required this.onSave,
    this.existing,
  });

  final PaymentMethodItem? existing;
  final void Function(PaymentMethodRequest request, String? originalName) onSave;

  @override
  State<_PaymentMethodFormBody> createState() => _PaymentMethodFormBodyState();
}

class _PaymentMethodFormBodyState extends State<_PaymentMethodFormBody> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final List<String> _typeOptions;
  late String _selectedType;
  List<BankAccount> _banks = const [];
  String? _selectedBank;

  bool get _needsBank => _selectedType.trim().toLowerCase() != 'cash';

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _nameController = TextEditingController(text: e?.name ?? '');
    _typeOptions = List<String>.from(_paymentTypes);
    _selectedType = e?.type ?? _typeOptions.first;
    if (!_typeOptions.contains(_selectedType)) {
      _typeOptions.add(_selectedType);
    }
    _selectedBank = e?.account;
    _loadBanks();
  }

  Future<void> _loadBanks() async {
    if (!getIt.isRegistered<BankAccountService>()) return;
    final banks = await getIt<BankAccountService>().listBanks();
    if (!mounted) return;
    setState(() {
      _banks = banks;
      if (_selectedBank == null ||
          !_banks.any((bank) => bank.name == _selectedBank)) {
        _selectedBank = banks
            .cast<BankAccount?>()
            .firstWhere((bank) => bank?.isDefault == true, orElse: () => null)
            ?.name ??
            (banks.isNotEmpty ? banks.first.name : null);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    if (_needsBank && (_selectedBank == null || _selectedBank!.isEmpty)) {
      context.showKiiSnackBarError(context.l10n.banksNoBanksYet);
      return;
    }
    widget.onSave(
      PaymentMethodRequest(
        name: _nameController.text.trim(),
        type: _selectedType,
        account: _needsBank ? _selectedBank : 'Cash',
      ),
      widget.existing?.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isEdit = widget.existing != null;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            controller: _nameController,
            labelText: 'Name',
            hint: 'Name',
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            validating: (v) =>
                v == null || v.trim().isEmpty ? 'Name is required' : null,
          ),
          const SizedBox(height: 16),
          Text(
            'Type',
            style: AppFonts.interStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _typeOptions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 3.1,
            ),
            itemBuilder: (context, index) {
              final type = _typeOptions[index];
              final visual = paymentMethodVisual(name: type, type: type);
              final selected = type == _selectedType;
              return Material(
                color: selected
                    ? scheme.primaryContainer
                    : scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () => setState(() => _selectedType = type),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? scheme.primary
                            : scheme.outlineVariant.withValues(alpha: 0.6),
                        width: selected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(visual.icon, color: visual.color, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            type,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppFonts.interStyle(
                              fontSize: 14,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: scheme.onSurface,
                            ),
                          ),
                        ),
                        if (selected)
                          Icon(
                            Icons.check_rounded,
                            size: 18,
                            color: scheme.primary,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          if (_needsBank) ...[
            const SizedBox(height: 16),
            Text(
              context.l10n.banksLinkedAccount,
              style: AppFonts.interStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            if (_banks.isEmpty)
              Text(
                context.l10n.banksNoBanksYet,
                style: AppFonts.interStyle(color: scheme.onSurfaceVariant),
              )
            else
              DropdownButtonFormField<String>(
                value: _banks.any((bank) => bank.name == _selectedBank)
                    ? _selectedBank
                    : _banks.first.name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: scheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                items: _banks
                    .map(
                      (bank) => DropdownMenuItem(
                        value: bank.name,
                        child: Text(bank.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _selectedBank = value),
              ),
          ],
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomButtonWidget.outlined(
                  onPressed: () => Navigator.pop(context),
                  title: 'Cancel',
                  width: double.infinity,
                  height: 48,
                  borderRadius: 12,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButtonWidget(
                  onPressed: _submit,
                  title: isEdit ? 'Save' : 'Create',
                  width: double.infinity,
                  height: 48,
                  borderRadius: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
