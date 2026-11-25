import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/core/services/currency/app_currency_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/widget/action_bottom_sheet.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/features/party/data/datasources/party_statement_service.dart';
import 'package:hotel/src/features/party/domain/models/party_statement_model.dart';
import 'package:hotel/src/features/party/presentation/utils/party_statement_pdf_exporter.dart';
import 'package:intl/intl.dart';

@RoutePage()
class PartyStatementPage extends StatefulWidget {
  const PartyStatementPage({
    super.key,
    required this.partyName,
  });

  final String partyName;

  @override
  State<PartyStatementPage> createState() => _PartyStatementPageState();
}

class _PartyStatementPageState extends State<PartyStatementPage> {
  final _displayDate = DateFormat('MMM dd, yyyy');
  late final PartyStatementService _service;
  late final AppCurrencyService _currencyService;

  late DateTime _dateFrom;
  late DateTime _dateTo;

  PartyStatementModel? _statement;
  bool _loading = true;
  String? _error;
  final Set<int> _expandedTxn = {};

  @override
  void initState() {
    super.initState();
    _service = PartyStatementService(getIt<LocalDb>());
    _currencyService = getIt<AppCurrencyService>();
    _currencyService.addListener(_onCurrencyChanged);
    final now = DateTime.now();
    _dateFrom = DateTime(now.year, 1, 1);
    _dateTo = DateTime(now.year, 12, 31);
    _load();
  }

  @override
  void dispose() {
    _currencyService.removeListener(_onCurrencyChanged);
    super.dispose();
  }

  void _onCurrencyChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
      _expandedTxn.clear();
    });
    try {
      final statement = await _service.buildSupplierStatement(
        partyName: widget.partyName,
        dateFrom: _dateFrom,
        dateTo: _dateTo,
      );
      if (!mounted) return;
      setState(() {
        _statement = statement;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  String _money(double? value) =>
      AppCurrencyFormatter.format(value ?? 0, decimals: 2);

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2015),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: DateTimeRange(start: _dateFrom, end: _dateTo),
    );
    if (picked == null) return;
    setState(() {
      _dateFrom = picked.start;
      _dateTo = picked.end;
    });
    await _load();
  }

  void _showExportSheet() {
    final theme = Theme.of(context);
    ActionBottomSheet.show(
      context,
      title: 'Download statement',
      items: [
        ActionSheetItem(
          icon: Icons.picture_as_pdf,
          title: 'Export as PDF',
          color: theme.colorScheme.primary,
          onTap: _exportPdf,
        ),
        ActionSheetItem(
          icon: Icons.share,
          title: 'Share PDF',
          color: theme.colorScheme.primary,
          onTap: _sharePdf,
        ),
      ],
    );
  }

  Future<void> _exportPdf() async {
    final statement = _statement;
    if (statement == null) return;
    try {
      final pdf = await PartyStatementPdfExporter.buildDocument(statement);
      final file = await PartyStatementPdfExporter.saveToDownloads(
        pdf,
        widget.partyName,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved to ${file.path}')),
      );
      await PartyStatementPdfExporter.openPdf(file);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    }
  }

  Future<void> _sharePdf() async {
    final statement = _statement;
    if (statement == null) return;
    try {
      final pdf = await PartyStatementPdfExporter.buildDocument(statement);
      final file = await PartyStatementPdfExporter.saveToDownloads(
        pdf,
        widget.partyName,
      );
      await PartyStatementPdfExporter.sharePdf(file, widget.partyName);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Share failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final statement = _statement;

    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      appBar: AppBar(
        leading: AppBarIosBackButton(color: scheme.onSurface),
        title: Text(
          'Party statement',
          style: AppFonts.interStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: scheme.onSurface,
          ),
        ),
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        actions: [
          if (statement != null)
            IconButton(
              onPressed: _showExportSheet,
              icon: const Icon(Icons.download_rounded),
              tooltip: 'Download',
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _errorView(scheme)
              : statement == null
                  ? const SizedBox.shrink()
                  : RefreshIndicator(
                      onRefresh: _load,
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                        children: [
                          _headerCard(scheme, statement),
                          const SizedBox(height: 12),
                          _periodPicker(scheme),
                          const SizedBox(height: 12),
                          _summaryGrid(scheme, statement.summary),
                          const SizedBox(height: 16),
                          Text(
                            'Ledger',
                            style: AppFonts.interStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: scheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (statement.openingEntry != null)
                            _openingTile(scheme, statement.openingEntry!),
                          ...List.generate(statement.transactions.length, (i) {
                            final txn = statement.transactions[i];
                            return _transactionTile(scheme, txn, i);
                          }),
                          if (statement.transactions.isEmpty &&
                              statement.openingEntry == null)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Center(
                                child: Text(
                                  'No transactions in this period',
                                  style: AppFonts.interStyle(
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
    );
  }

  Widget _errorView(ColorScheme scheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error ?? 'Error', textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }

  Widget _headerCard(ColorScheme scheme, PartyStatementModel statement) {
    final info = statement.partyInfo;
    return Card(
      elevation: 0,
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              info.name,
              style: AppFonts.interStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              info.role,
              style: AppFonts.interStyle(
                fontSize: 12,
                color: scheme.onSurfaceVariant,
              ),
            ),
            if ((info.phone ?? '').isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(info.phone!, style: AppFonts.interStyle(fontSize: 12)),
            ],
            const SizedBox(height: 8),
            Text(
              'Outstanding: ${_money(info.outstandingAmount)}',
              style: AppFonts.interStyle(
                fontWeight: FontWeight.w600,
                color: scheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _periodPicker(ColorScheme scheme) {
    return InkWell(
      onTap: _pickDateRange,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Row(
          children: [
            Icon(Icons.date_range_rounded, size: 18, color: scheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${_displayDate.format(_dateFrom)} – ${_displayDate.format(_dateTo)}',
                style: AppFonts.interStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: scheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  Widget _summaryGrid(ColorScheme scheme, PartyStatementSummary summary) {
    final items = [
      ('Opening', summary.openingBalance),
      ('Purchases', summary.totalPurchases),
      ('Money out', summary.moneyOut),
      ('Closing', summary.closingBalance),
    ];
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 2.2,
      physics: const NeverScrollableScrollPhysics(),
      children: items.map((e) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                e.$1,
                style: AppFonts.interStyle(
                  fontSize: 11,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  _money(e.$2),
                  style: AppFonts.interStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _openingTile(ColorScheme scheme, PartyStatementOpeningEntry entry) {
    return _ledgerRow(
      scheme: scheme,
      date: entry.date,
      title: entry.particulars,
      subtitle: null,
      total: entry.total,
      paid: entry.recPaidAmt,
      due: entry.due,
      balance: entry.runningBalance,
      items: const [],
      expandable: false,
      expanded: false,
      onToggle: null,
    );
  }

  Widget _transactionTile(
    ColorScheme scheme,
    PartyStatementTransaction txn,
    int index,
  ) {
    final hasItems = (txn.items?.isNotEmpty ?? false);
    final expanded = _expandedTxn.contains(index);
    return _ledgerRow(
      scheme: scheme,
      date: txn.date,
      title: txn.particulars,
      subtitle: txn.reference ?? txn.remarks,
      total: txn.total,
      paid: txn.recPaidAmt > 0 ? txn.recPaidAmt : null,
      due: txn.due,
      balance: txn.runningBalance,
      items: txn.items ?? const [],
      expandable: hasItems,
      expanded: expanded,
      onToggle: hasItems
          ? () => setState(() {
                if (expanded) {
                  _expandedTxn.remove(index);
                } else {
                  _expandedTxn.add(index);
                }
              })
          : null,
    );
  }

  Widget _ledgerRow({
    required ColorScheme scheme,
    required String date,
    required String title,
    String? subtitle,
    required double total,
    double? paid,
    double? due,
    required double balance,
    required List<PartyStatementItem> items,
    required bool expandable,
    required bool expanded,
    VoidCallback? onToggle,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.7)),
      ),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          date,
                          style: AppFonts.interStyle(
                            fontSize: 11,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          title,
                          style: AppFonts.interStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        if ((subtitle ?? '').isNotEmpty)
                          Text(
                            subtitle!,
                            style: AppFonts.interStyle(
                              fontSize: 11,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (expandable)
                    Icon(
                      expanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: scheme.onSurfaceVariant,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _amountChip(scheme, 'Total', _money(total)),
                  const SizedBox(width: 8),
                  _amountChip(
                    scheme,
                    'Paid',
                    paid != null ? _money(paid) : '—',
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  _amountChip(
                    scheme,
                    'Due',
                    due != null && due > 0 ? _money(due) : '—',
                  ),
                  const Spacer(),
                  Text(
                    'Bal ${_money(balance)}',
                    style: AppFonts.interStyle(
                      fontWeight: FontWeight.w700,
                      color: scheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              if (expanded && items.isNotEmpty) ...[
                const Divider(height: 16),
                ...items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.item,
                            style: AppFonts.interStyle(fontSize: 12),
                          ),
                        ),
                        Text(
                          '${item.quantity} ${item.unit}',
                          style: AppFonts.interStyle(
                            fontSize: 11,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _money(item.total),
                          style: AppFonts.interStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _amountChip(ColorScheme scheme, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.interStyle(
            fontSize: 10,
            color: scheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: AppFonts.interStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
