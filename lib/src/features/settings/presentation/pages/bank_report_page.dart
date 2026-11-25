import 'package:flutter/material.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/features/settings/domain/bank_account.dart';
import 'package:hotel/src/features/settings/domain/bank_account_service.dart';

class BankReportPage extends StatefulWidget {
  const BankReportPage({super.key, required this.bankName});

  final String bankName;

  @override
  State<BankReportPage> createState() => _BankReportPageState();
}

class _BankReportPageState extends State<BankReportPage> {
  BankReport? _report;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final report =
          await getIt<BankAccountService>().reportFor(widget.bankName);
      if (!mounted) return;
      setState(() {
        _report = report;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      context.showKiiSnackBarError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final report = _report;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(widget.bankName),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : report == null
              ? Center(child: Text(l10n.banksReportEmpty))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    children: [
                      if (report.bank.accountNumber != null ||
                          report.bank.accountHolder != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            [
                              if (report.bank.accountNumber != null)
                                report.bank.accountNumber,
                              if (report.bank.accountHolder != null)
                                report.bank.accountHolder,
                            ].join(' · '),
                            style: AppFonts.interStyle(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: _SummaryCard(
                              label: l10n.banksReportIn,
                              value: AppCurrencyFormatter.format(report.incoming),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _SummaryCard(
                              label: l10n.banksReportOut,
                              value: AppCurrencyFormatter.format(report.outgoing),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _SummaryCard(
                              label: l10n.banksReportNet,
                              value: AppCurrencyFormatter.format(report.net),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        l10n.banksReportActivity,
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (report.lines.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            l10n.banksReportEmpty,
                            style: AppFonts.interStyle(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        )
                      else
                        ...report.lines.map((line) {
                          final incoming = line.isIncoming;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Material(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: scheme.outlineVariant
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            line.party?.isNotEmpty == true
                                                ? line.party!
                                                : line.paymentMethod,
                                            style: context
                                                .theme.textTheme.titleSmall
                                                ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            [
                                              line.date,
                                              line.paymentMethod,
                                              if (line.referenceId != null)
                                                line.referenceId,
                                            ].join(' · '),
                                            style: AppFonts.interStyle(
                                              fontSize: 12,
                                              color: scheme.onSurfaceVariant,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${incoming ? '+' : '-'}${AppCurrencyFormatter.format(line.amount)}',
                                      style: context.theme.textTheme.titleSmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: incoming
                                            ? scheme.primary
                                            : scheme.error,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    ],
                  ),
                ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppFonts.interStyle(
              fontSize: 12,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
