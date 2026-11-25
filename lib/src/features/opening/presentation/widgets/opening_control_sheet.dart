import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/above_sheet_snack.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/opening/data/models/request/denomination_request_item.dart';
import 'package:hotel/src/features/opening/data/models/request/open_register_request.dart';
import 'package:hotel/src/features/opening/data/models/request/close_register_request.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_register_model.dart';
import 'package:hotel/src/features/opening/presentation/widgets/coins_notes_sheet.dart';
import 'package:hotel/constants.dart';

class OpeningControlSheet extends StatefulWidget {
  const OpeningControlSheet({
    super.key,
    required this.onOpen,
    required this.openedBy,
    this.isClosing = false,
    this.register,
    this.onClose,
    this.closedBy,
    this.getCounterForDate,
    this.onRequestCloseRegister,
  });

  final void Function(OpenRegisterRequest request) onOpen;
  final String openedBy;
  final bool isClosing;
  final CashRegisterModel? register;
  final void Function(CloseRegisterRequest request)? onClose;
  final String? closedBy;

  /// Check if a counter already exists for the given date (yyyy-MM-dd). Returns it if so.
  final Future<CashRegisterModel?> Function(String shiftDate)? getCounterForDate;

  /// When user chooses to close an existing counter from the "already exists" dialog.
  final void Function(CashRegisterModel existing)? onRequestCloseRegister;

  static void show({
    required BuildContext context,
    required void Function(OpenRegisterRequest request) onOpen,
    required String openedBy,
    String? closedBy,
    Future<CashRegisterModel?> Function(String shiftDate)? getCounterForDate,
    void Function(CashRegisterModel existing)? onRequestCloseRegister,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => OpeningControlSheet(
        onOpen: onOpen,
        openedBy: openedBy,
        closedBy: closedBy,
        getCounterForDate: getCounterForDate,
        onRequestCloseRegister: onRequestCloseRegister,
      ),
    );
  }

  static void showClose({
    required BuildContext context,
    required CashRegisterModel register,
    required void Function(CloseRegisterRequest request) onClose,
    required String closedBy,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => OpeningControlSheet(
        onOpen: (_) {},
        openedBy: '',
        isClosing: true,
        register: register,
        onClose: onClose,
        closedBy: closedBy,
      ),
    );
  }

  @override
  State<OpeningControlSheet> createState() => _OpeningControlSheetState();
}

class _OpeningControlSheetState extends State<OpeningControlSheet> {
  final _amountController = TextEditingController(text: '0.00');
  final _noteController = TextEditingController();
  final _denominationsNotifier = ValueNotifier<Map<double, int>>({for (final d in kDenominationValues) d: 0});
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _denominationsNotifier.dispose();
    super.dispose();
  }

  void _openCoinsNotes() {
    CoinsNotesSheet.show(
      context: context,
      initialQuantities: _denominationsNotifier.value,
      onConfirm: (total, quantities) {
        _denominationsNotifier.value = Map.from(quantities);
        _amountController.text = total.toStringAsFixed(2);
        setState(() {});
      },
    );
  }

  List<DenominationRequestItem> _buildDenominationList() {
    return _denominationsNotifier.value.entries
        .where((e) => e.value > 0)
        .map((e) => DenominationRequestItem(
              denomination: e.key,
              quantity: e.value,
              type: e.key >= 5 ? 'note' : 'coin',
            ))
        .toList();
  }

  String get _shiftDateStr => DateFormat('yyyy-MM-dd').format(_selectedDate);

  Future<void> _submitOpen() async {
    final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
    if (amount <= 0) {
      AboveSheetSnack.showError(
        context,
        'Enter opening amount (greater than 0)',
      );
      return;
    }
    final list = _buildDenominationList();
    final check = widget.getCounterForDate;
    if (check != null) {
      final existing = await check(_shiftDateStr);
      if (existing != null && mounted) {
        _showCounterExistsDialog(existing);
        return;
      }
    }
    if (!mounted) return;
    widget.onOpen(OpenRegisterRequest(
      registerName: 'Main Counter',
      shiftDate: _shiftDateStr,
      openingAmount: amount,
      openingNote: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
      openedBy: widget.openedBy,
      denominations: list.isNotEmpty ? list : null,
    ));
    Navigator.pop(context);
  }

  void _showCounterExistsDialog(CashRegisterModel existing) {
    final dateStr = DateFormat('MMM dd, yyyy').format(_selectedDate);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        final scheme = Theme.of(ctx).colorScheme;
        return SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AppBottomSheetTheme.dragHandle(ctx),
              ),
              const SizedBox(height: 16),
              Text(
                'Counter already exists',
                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'A counter for $dateStr is already active for this date.',
                style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoLine('Counter', existing.name),
                    const SizedBox(height: 6),
                    _infoLine('Status', existing.status.toUpperCase()),
                    const SizedBox(height: 6),
                    _infoLine(
                      'Opening amount',
                      '$currencySymbol ${existing.openingAmount?.toStringAsFixed(2) ?? '-'}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Only one counter is allowed per date.',
                style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: CustomButtonWidget.outlined(
                      onPressed: () => Navigator.pop(ctx),
                      title: 'Cancel',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButtonWidget(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _selectDifferentDate();
                      },
                      title: 'Change date',
                    ),
                  ),
                ],
              ),
              if (existing.status == 'open') ...[
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CustomButtonWidget(
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pop(context);
                      widget.onRequestCloseRegister?.call(existing);
                    },
                    title: 'Close this counter',
                  ),
                ),
              ],
            ],
          ),
        ),
      );
      },
    );
  }

  Widget _infoLine(String label, String value) {
    final onSurfaceVariant = Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: AppFonts.interStyle(
              fontSize: 13,
              color: onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppFonts.interStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDifferentDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && mounted) setState(() => _selectedDate = picked);
  }

  void _submitClose() {
    final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
    final reg = widget.register;
    if (reg == null || widget.onClose == null) return;
    if (amount <= 0) {
      AboveSheetSnack.showError(
        context,
        'Enter available amount (greater than 0)',
      );
      return;
    }
    final shiftDate = reg.shiftDate ??
        (reg.openingTime != null && reg.openingTime!.isNotEmpty
            ? DateFormat('yyyy-MM-dd').format(DateTime.tryParse(reg.openingTime!) ?? DateTime.now())
            : DateFormat('yyyy-MM-dd').format(DateTime.now()));
    final list = _buildDenominationList();
    widget.onClose!(CloseRegisterRequest(
      registerId: reg.id,
      shiftDate: shiftDate,
      closingAmount: amount,
      closingNote: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
      closedBy: widget.closedBy ?? '',
      denominations: list.isNotEmpty ? list : null,
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isClosing = widget.isClosing;
    final viewInsetsBottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
        padding: EdgeInsets.only(bottom: viewInsetsBottom + 16),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, top: 20, right: 24, bottom: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    isClosing ? 'Closing Control' : 'Opening Control',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  verticalMarginMedium,
                  if (!isClosing) ...[
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Date'),
                      subtitle: Text(DateFormat('MMM dd, yyyy').format(_selectedDate)),
                      trailing: Icon(Icons.calendar_today),
                      onTap: _selectDifferentDate,
                    ),
                    verticalMarginMedium,
                  ],
                  CustomTextFormField(
                    controller: _amountController,
                    labelText: isClosing
                        ? 'Available amount ($currencySymbol)'
                        : 'Opening cash ($currencySymbol)',
                    hint: '0.00',
                    readOnly: false,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => setState(() {}),
                    suffixIcon: _amountController.text != '0.00' && _amountController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _denominationsNotifier.value = {for (final d in kDenominationValues) d: 0};
                              _amountController.text = '0.00';
                              setState(() {});
                            },
                          )
                        : null,
                  ),
                  verticalMarginSmall,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Total from breakdown: $currencySymbol ${_buildDenominationList().fold<double>(0.0, (sum, e) => sum + (e.denomination * e.quantity)).toStringAsFixed(2)}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.money, size: context.theme.appTheme.spacing24),
                        onPressed: _openCoinsNotes,
                        tooltip: 'Add coins/notes',
                      ),
                    ],
                  ),
                  verticalMarginMedium,
                  CustomTextFormField(
                    controller: _noteController,
                    labelText: isClosing ? 'Closing note' : 'Opening note',
                    hint: 'Add an opening note...',
                    maxLines: 3,
                  ),
                  verticalMarginLarge,
                  Row(
                    children: [
                      Expanded(
                        child: CustomButtonWidget.outlined(
                          onPressed: () => Navigator.pop(context),
                          title: 'Discard',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: CustomButtonWidget(
                          title: isClosing ? 'Close Register' : 'Open Register',
                          onPressed: isClosing ? _submitClose : _submitOpen,
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
}
