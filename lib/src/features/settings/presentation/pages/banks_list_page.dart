import 'package:flutter/material.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/action_bottom_sheet.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/settings/domain/bank_account.dart';
import 'package:hotel/src/features/settings/domain/bank_account_service.dart';
import 'package:hotel/src/features/settings/presentation/pages/bank_report_page.dart';
import 'package:hotel/src/features/setup/domain/setup_field_limits.dart';

class BanksListPage extends StatefulWidget {
  const BanksListPage({super.key});

  @override
  State<BanksListPage> createState() => _BanksListPageState();
}

class _BanksListPageState extends State<BanksListPage> {
  final _service = getIt<BankAccountService>();
  List<BankAccount> _banks = const [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    setState(() => _loading = true);
    try {
      final banks = await _service.listBanks();
      if (!mounted) return;
      setState(() {
        _banks = banks;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      context.showKiiSnackBarError(e.toString());
    }
  }

  Future<void> _openForm({BankAccount? existing}) async {
    await showAppBottomSheet<void>(
      context: context,
      title: existing == null
          ? context.l10n.banksAddTitle
          : context.l10n.banksEditTitle,
      shrinkWrap: true,
      compactHeader: true,
      bodyBuilder: (sheetContext) => _BankFormBody(
        existing: existing,
        onSave: (name, number, holder) async {
          try {
            if (existing == null) {
              await _service.addBank(
                name: name,
                accountNumber: number,
                accountHolder: holder,
                makeDefault: _banks.isEmpty,
              );
            } else {
              await _service.updateBank(
                originalName: existing.name,
                name: name,
                accountNumber: number,
                accountHolder: holder,
              );
            }
            if (sheetContext.mounted) Navigator.pop(sheetContext);
            if (mounted) {
              context.showKiiSnackBarSuccess(context.l10n.banksSaved);
              await _reload();
            }
          } catch (e) {
            if (mounted) {
              context.showKiiSnackBarError(
                e.toString().replaceFirst(RegExp(r'^Exception:\s*'), ''),
              );
            }
          }
        },
      ),
    );
  }

  Future<void> _setDefault(BankAccount bank) async {
    await _service.setDefault(bank.name);
    if (!mounted) return;
    context.showKiiSnackBarSuccess(context.l10n.banksSelected(bank.name));
    await _reload();
  }

  Future<void> _delete(BankAccount bank) async {
    try {
      await _service.deleteBank(bank.name);
      if (!mounted) return;
      context.showKiiSnackBarSuccess(context.l10n.banksDeleted);
      await _reload();
    } catch (e) {
      if (!mounted) return;
      final message = e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
      context.showKiiSnackBarError(
        message.contains('At least one bank')
            ? context.l10n.banksAtLeastOne
            : message,
      );
    }
  }

  void _openReport(BankAccount bank) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BankReportPage(bankName: bank.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(l10n.banksSettingsTitle),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _banks.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.account_balance_outlined,
                          size: 48,
                          color: scheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.banksEmpty,
                          textAlign: TextAlign.center,
                          style: AppFonts.interStyle(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
                  itemCount: _banks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final bank = _banks[index];
                    final subtitle = [
                      if (bank.accountNumber != null) bank.accountNumber,
                      if (bank.accountHolder != null) bank.accountHolder,
                      if (bank.isDefault) l10n.banksSelectedBadge,
                    ].join(' · ');
                    return Material(
                      color: scheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () => _openReport(bank),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 10, 4, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: scheme.outlineVariant.withValues(alpha: 0.6),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_balance_outlined,
                                color: scheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bank.name,
                                      style: context.theme.textTheme.titleMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (subtitle.isNotEmpty)
                                      Text(
                                        subtitle,
                                        style: AppFonts.interStyle(
                                          fontSize: 13,
                                          color: scheme.onSurfaceVariant,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.more_vert),
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                constraints: const BoxConstraints.tightFor(
                                  width: 36,
                                  height: 36,
                                ),
                                onPressed: () => _showActions(bank),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  void _showActions(BankAccount bank) {
    final l10n = context.l10n;
    const deleteColor = Color(0xFFEF4444);
    ActionBottomSheet.show(
      context,
      title: bank.name,
      items: [
        ActionSheetItem(
          icon: Icons.receipt_long_outlined,
          title: l10n.banksViewReport,
          onTap: () => _openReport(bank),
        ),
        if (!bank.isDefault)
          ActionSheetItem(
            icon: Icons.check_circle_outline,
            title: l10n.banksUseSelected,
            onTap: () => _setDefault(bank),
          ),
        ActionSheetItem(
          icon: Icons.edit_outlined,
          title: l10n.edit,
          onTap: () => _openForm(existing: bank),
        ),
        if (_banks.length > 1)
          ActionSheetItem(
            icon: Icons.delete_outline,
            iconWidget: const AppDeleteIcon(color: deleteColor, size: 22),
            title: l10n.delete,
            color: deleteColor,
            onTap: () => _delete(bank),
          ),
      ],
    );
  }
}

class _BankFormBody extends StatefulWidget {
  const _BankFormBody({
    required this.onSave,
    this.existing,
  });

  final BankAccount? existing;
  final Future<void> Function(
    String name,
    String? accountNumber,
    String? accountHolder,
  ) onSave;

  @override
  State<_BankFormBody> createState() => _BankFormBodyState();
}

class _BankFormBodyState extends State<_BankFormBody> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _numberController;
  late final TextEditingController _holderController;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _nameController = TextEditingController(text: existing?.name ?? '');
    _numberController =
        TextEditingController(text: existing?.accountNumber ?? '');
    _holderController =
        TextEditingController(text: existing?.accountHolder ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _holderController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) return;
    setState(() => _saving = true);
    await widget.onSave(
      _nameController.text.trim(),
      _numberController.text.trim(),
      _holderController.text.trim(),
    );
    if (mounted) setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isEdit = widget.existing != null;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            controller: _nameController,
            labelText: l10n.setupBankName,
            hint: l10n.setupBankName,
            readOnly: isEdit,
            textCapitalization: TextCapitalization.words,
            validating: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.fieldRequired(l10n.setupBankName);
              }
              if (value.trim().length > SetupFieldLimits.maxBankNameLength) {
                return l10n.fieldMaxLength(
                  l10n.setupBankName,
                  SetupFieldLimits.maxBankNameLength,
                );
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: _numberController,
            labelText: l10n.banksAccountNumber,
            hint: l10n.banksOptional,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: _holderController,
            labelText: l10n.banksAccountHolder,
            hint: l10n.banksOptional,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomButtonWidget.outlined(
                  onPressed: _saving ? null : () => Navigator.pop(context),
                  title: l10n.cancel,
                  width: double.infinity,
                  height: 48,
                  borderRadius: 12,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButtonWidget(
                  onPressed: _saving ? null : _submit,
                  title: isEdit ? l10n.save : l10n.createAction,
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
