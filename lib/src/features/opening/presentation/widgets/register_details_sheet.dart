import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/extensions/extensions/localization_extension.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/features/closing/data/models/response/hotel_summary_response_model.dart';
import 'package:hotel/src/features/closing/presentation/bloc/hotel_summary_cubit.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_register_model.dart';
import 'package:hotel/src/features/opening/data/models/response/denomination_model.dart';
import 'package:intl/intl.dart';
import 'package:hotel/constants.dart';

class RegisterDetailsSheet extends StatelessWidget {
  const RegisterDetailsSheet({
    super.key,
    required this.register,
  });

  final CashRegisterModel register;

  static void show({
    required BuildContext context,
    required CashRegisterModel register,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(ctx).bottom,
        ),
        child: RegisterDetailsSheet(register: register),
      ),
    );
  }

  String? get _shiftDate {
    if (register.shiftDate != null && register.shiftDate!.trim().isNotEmpty) {
      return register.shiftDate!.trim();
    }
    final opening = register.openingTime ?? '';
    if (opening.contains('T')) return opening.split('T').first;
    return opening.isNotEmpty ? opening : null;
  }

  String _formatShiftDate(String date) {
    try {
      return DateFormat('d MMM yyyy').format(DateTime.parse(date));
    } catch (_) {
      return date;
    }
  }

  String _formatMoney(num value) => NumberFormat('#,##0').format(value);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = register;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.88;
    final isOpen = r.status == 'open';
    final statusColor = isOpen ? Colors.green.shade700 : theme.colorScheme.onSurfaceVariant;
    final statusBg = isOpen
        ? Colors.green.withValues(alpha: 0.12)
        : theme.colorScheme.surfaceContainerHighest;

    return Container(
      height: maxHeight,
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r.name,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (_shiftDate != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          _formatShiftDate(_shiftDate!),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isOpen ? 'OPEN' : 'CLOSED',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<HotelSummaryCubit, HotelSummaryState>(
              buildWhen: (prev, curr) => curr != prev,
              builder: (context, state) {
                return state.whenOrNull(
                      loaded: (response) => _MetricsChipRow(
                        openingAmount: r.openingAmount ?? 0,
                        totalSales: response.data.summary.totalSales,
                        totalExpenses: response.data.summary.totalExpenses,
                        formatMoney: _formatMoney,
                      ),
                      loading: () => _MetricsChipRow(
                        openingAmount: r.openingAmount ?? 0,
                        loading: true,
                        formatMoney: _formatMoney,
                      ),
                      initial: () => _MetricsChipRow(
                        openingAmount: r.openingAmount ?? 0,
                        loading: true,
                        formatMoney: _formatMoney,
                      ),
                    ) ??
                    _MetricsChipRow(
                      openingAmount: r.openingAmount ?? 0,
                      formatMoney: _formatMoney,
                    );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionTitle(title: 'Register details'),
                      verticalMarginSmall,
                      _DetailRow(
                        label: 'Status',
                        value: r.status,
                        valueColor: isOpen ? Colors.green.shade700 : null,
                      ),
                      if (r.shiftDate != null && r.shiftDate!.isNotEmpty)
                        _DetailRow(label: 'Shift date', value: r.shiftDate!),
                      if (r.closingTime != null)
                        _DetailRow(label: 'Closing time', value: r.closingTime!),
                      _DetailRow(
                        label: 'Opening amount',
                        value: '$currencySymbol ${r.openingAmount?.toStringAsFixed(2) ?? '0.00'}',
                      ),
                      if (r.openingNote != null && r.openingNote!.isNotEmpty)
                        _DetailRow(label: 'Opening note', value: r.openingNote!),
                      if (r.closingNote != null && r.closingNote!.isNotEmpty)
                        _DetailRow(label: 'Closing note', value: r.closingNote!),
                      if (r.closedBy != null)
                        _DetailRow(label: 'Closed by', value: r.closedBy!),
                      verticalMarginMedium,
                      BlocBuilder<HotelSummaryCubit, HotelSummaryState>(
                        buildWhen: (prev, curr) => curr != prev,
                        builder: (context, state) {
                          return state.whenOrNull(
                                loading: () => const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 24),
                                    child: SizedBox(
                                      height: 28,
                                      width: 28,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  ),
                                ),
                                initial: () => const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 24),
                                    child: SizedBox(
                                      height: 28,
                                      width: 28,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  ),
                                ),
                                error: (message) => Text(
                                  message,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.error,
                                  ),
                                ),
                                loaded: (response) => _PaymentSummarySection(
                                  summary: response.data.summary,
                                ),
                              ) ??
                              const SizedBox.shrink();
                        },
                      ),
                      if (r.openingDenominations != null &&
                          r.openingDenominations!.isNotEmpty) ...[
                        verticalMarginMedium,
                        const _SectionTitle(title: 'Opening denominations'),
                        verticalMarginSmall,
                        ...r.openingDenominations!.map((d) => _DenomLine(d)),
                      ],
                      if (r.closingDenominations != null &&
                          r.closingDenominations!.isNotEmpty) ...[
                        verticalMarginMedium,
                        const _SectionTitle(title: 'Closing denominations'),
                        verticalMarginSmall,
                        ...r.closingDenominations!.map((d) => _DenomLine(d)),
                      ],
                      if (r.cashMovements != null && r.cashMovements!.isNotEmpty) ...[
                        verticalMarginMedium,
                        const _SectionTitle(title: 'Cash movements'),
                        verticalMarginSmall,
                        ...r.cashMovements!.map(
                          (m) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              '${m.movementType}: $currencySymbol ${m.amount.toStringAsFixed(2)}'
                              '${m.reason != null && m.reason!.isNotEmpty ? ' — ${m.reason}' : ''}',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _MetricsChipRow extends StatelessWidget {
  const _MetricsChipRow({
    required this.openingAmount,
    required this.formatMoney,
    this.totalSales,
    this.totalExpenses,
    this.loading = false,
  });

  final num openingAmount;
  final int? totalSales;
  final int? totalExpenses;
  final bool loading;
  final String Function(num) formatMoney;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const SizedBox(
        height: 32,
        child: Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 34,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.hardEdge,
        child: Row(
        children: [
          _MetricChip(
            label: 'Opening',
            value: '$currencySymbol ${formatMoney(openingAmount)}',
          ),
          if (totalSales != null) ...[
            const SizedBox(width: 8),
            _MetricChip(
              label: 'Sales',
              value: '$currencySymbol ${formatMoney(totalSales!)}',
            ),
          ],
          if (totalExpenses != null) ...[
            const SizedBox(width: 8),
            _MetricChip(
              label: 'Expenses',
              value: '$currencySymbol ${formatMoney(totalExpenses!)}',
            ),
          ],
        ],
        ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Text(
        '$label: $value',
        style: theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DenomLine extends StatelessWidget {
  const _DenomLine(this.d);

  final DenominationModel d;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        '${d.denomination.toStringAsFixed(d.denomination >= 1 ? 0 : 2)} $currencySymbol × ${d.quantity} = ${d.amount.toStringAsFixed(2)} $currencySymbol (${d.type})',
        style: theme.textTheme.bodySmall,
      ),
    );
  }
}

class _PaymentSummarySection extends StatelessWidget {
  const _PaymentSummarySection({required this.summary});

  final SalesSummary summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'Payment summary'),
        verticalMarginSmall,
        _DetailRow(
          label: 'Opening balance',
          value: '$currencySymbol ${summary.openingBalance}',
        ),
        _DetailRow(
          label: 'Total sales',
          value: '$currencySymbol ${summary.totalSales}',
        ),
        _DetailRow(
          label: 'Sales (QR)',
          value: '$currencySymbol ${summary.salesQrAmount}',
        ),
        _DetailRow(
          label: 'Sales (cash)',
          value: '$currencySymbol ${summary.salesCashAmount}',
        ),
        _DetailRow(
          label: 'Total discount',
          value: '$currencySymbol ${summary.totalDiscount}',
        ),
        _DetailRow(
          label: 'Total expenses',
          value: '$currencySymbol ${summary.totalExpenses}',
        ),
        _DetailRow(
          label: 'Expenses (cash)',
          value: '$currencySymbol ${summary.totalExpensesCash}',
        ),
        _DetailRow(
          label: 'Expenses (QR)',
          value: '$currencySymbol ${summary.totalExpensesQr}',
        ),
        _DetailRow(
          label: 'Expenses (transfer)',
          value: '$currencySymbol ${summary.totalExpensesTransfer}',
        ),
        _DetailRow(
          label: 'Unpaid amount',
          value: '$currencySymbol ${summary.unpaidAmount}',
        ),
        _DetailRow(
          label: 'Credit (cash)',
          value: '$currencySymbol ${summary.creditCash}',
        ),
        _DetailRow(
          label: 'Credit (QR)',
          value: '$currencySymbol ${summary.creditQr}',
        ),
        if (summary.extraAmount > 0)
          _DetailRow(
            label: 'Extra amount',
            value: '$currencySymbol ${summary.extraAmount}',
            valueColor: Colors.green,
          ),
        _DetailRow(
          label: 'Closing balance',
          value: '$currencySymbol ${summary.closingBalance}',
        ),
        if (summary.payQrGetCashExchange != null &&
            summary.payQrGetCashExchange! > 0)
          _DetailRow(
            label: context.l10n.closePayQrGetCashDetail,
            value: '$currencySymbol ${summary.payQrGetCashExchange!.toStringAsFixed(0)}',
          ),
        if (summary.payCashGetQrExchange != null &&
            summary.payCashGetQrExchange! > 0)
          _DetailRow(
            label: context.l10n.closePayCashGetQrDetail,
            value: '$currencySymbol ${summary.payCashGetQrExchange!.toStringAsFixed(0)}',
          ),
      ],
    );
  }
}
