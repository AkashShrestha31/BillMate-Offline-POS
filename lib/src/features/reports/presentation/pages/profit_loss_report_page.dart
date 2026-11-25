import 'dart:math' as math;
import 'package:hotel/constants.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/extensions/extensions/localization_extension.dart';
import 'package:hotel/src/features/reports/data/models/request/profit_loss_report_request.dart';
import 'package:hotel/src/features/reports/data/models/response/profit_loss_report_response.dart';
import 'package:hotel/src/core/helpers/dynamic_json_parse.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/features/reports/presentation/bloc/profit_loss_report/profit_loss_report_cubit.dart';
import 'package:hotel/src/features/reports/presentation/widgets/reports_chrome.dart';
import 'package:intl/intl.dart';

@immutable
class ProfitLossReportPage extends StatefulWidget {
  const ProfitLossReportPage({super.key});

  @override
  State<ProfitLossReportPage> createState() => _ProfitLossReportPageState();
}

class _ProfitLossReportPageState extends State<ProfitLossReportPage> {
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final NumberFormat _currency = NumberFormat('#,##0.00');
  final NumberFormat _compactCurrency = NumberFormat.compact();

  // Semantic chart / KPI accents
  static const Color _accent = ReportsChrome.accent;
  static const Color _positive = ReportsChrome.positive;
  static const Color _negative = ReportsChrome.negative;

  ColorScheme get _cs => Theme.of(context).colorScheme;
  Color get _surface => ReportsChrome.pageBackground(context);
  Color get _panelBg => ReportsChrome.panelBackground(context);
  Color get _segmentTrack => ReportsChrome.segmentedTrack(context);
  Color get _border => ReportsChrome.border(context);
  Color get _ink => ReportsChrome.primaryText(context);
  Color get _inkSoft => ReportsChrome.mutedText(context);
  Color get _tooltipBg => ReportsChrome.tooltipBackground(context);

  String _mode = 'year';
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  int _monthFrom = 1;
  int _monthTo = DateTime.now().month;
  DateTimeRange _customRange = DateTimeRange(
    start: DateTime(DateTime.now().year, 1, 1),
    end: DateTime.now(),
  );

  /// Last successful API bundle; updated from [ProfitLossReportState.success].
  ProfitLossReportResponse? _bundle;

  Map<String, dynamic> get _pnlSummary => _bundle?.summary ?? const {};
  Map<String, dynamic> get _pnlTrend => _bundle?.trend ?? const {};
  Map<String, dynamic> get _pnlStatement => _bundle?.statement ?? const {};
  Map<String, dynamic> get _pnlExpense => _bundle?.expense ?? const {};
  Map<String, dynamic> get _pnlRevenue => _bundle?.revenue ?? const {};

  // ---------- UI interactivity state ----------
  String _trendChartType = 'bar'; // 'bar' or 'line'
  int? _hoveredBarIndex;
  int _touchedPieIndex = -1;
  bool _showStatementDetails = true;

  ProfitLossReportRequest _toRequest() => ProfitLossReportRequest(
        mode: _mode,
        year: _year,
        month: _month,
        monthFrom: _monthFrom,
        monthTo: _monthTo,
        customStart: _customRange.start,
        customEnd: _customRange.end,
      );

  Future<void> _reload() async {
    await context.read<ProfitLossReportCubit>().load(_toRequest());
  }

  String _formatMoney(double value, {bool withParensForNegative = false}) {
    if (withParensForNegative && value < 0) {
      return '($currencySymbol ${_currency.format(value.abs())})';
    }
    return '$currencySymbol ${_currency.format(value)}';
  }

  String _moneyCompact(double value) =>
      '$currencySymbol ${_compactCurrency.format(value)}';

  String _periodLabel() {
    switch (_mode) {
      case 'month':
        return '${DateFormat('MMM').format(DateTime(_year, _month))} $_year';
      case 'month_range':
        return '${DateFormat('MMM').format(DateTime(_year, _monthFrom))} - ${DateFormat('MMM').format(DateTime(_year, _monthTo))} $_year';
      case 'custom':
        return '${_dateFormat.format(_customRange.start)} to ${_dateFormat.format(_customRange.end)}';
      case 'year':
      default:
        return '$_year';
    }
  }

  // ---------- Data helpers ----------

  List<Map<String, dynamic>> _revenueItems() {
    final byCategory = safeMapList(_pnlRevenue['by_category']);
    if (byCategory.isNotEmpty) {
      return byCategory
          .map(
            (e) => <String, dynamic>{
              'account': safeText(e['category']),
              'amount': safeDouble(e['total']),
            },
          )
          .toList();
    }
    return const <Map<String, dynamic>>[];
  }

  List<Map<String, dynamic>> _expenseItems() {
    final statementRoot = _pnlStatement['statement'];
    final fromStatement = statementRoot is Map
        ? Map<String, dynamic>.from(statementRoot['expenses'] as Map? ?? {})
        : <String, dynamic>{};
    final items = safeMapList(fromStatement['lines']);
    if (items.isNotEmpty) {
      return items
          .map(
            (e) => <String, dynamic>{
              'account': safeText(e['label']),
              'amount': safeDouble(e['amount']),
            },
          )
          .toList();
    }
    final byCategory = safeMapList(_pnlExpense['by_category']);
    return byCategory
        .map(
          (e) => <String, dynamic>{
            'account': safeText(e['category']),
            'amount': safeDouble(e['total']),
          },
        )
        .toList();
  }

  double _statementRevenueTotal() {
    final revenueSummary = _pnlRevenue['summary'];
    if (revenueSummary is Map && revenueSummary['total_revenue'] != null) {
      return safeDouble(revenueSummary['total_revenue']);
    }
    final statementRoot = _pnlStatement['statement'];
    final fromStatement = statementRoot is Map
        ? Map<String, dynamic>.from(statementRoot['revenue'] as Map? ?? {})
        : <String, dynamic>{};
    if (fromStatement['subtotal'] != null) {
      return safeDouble(fromStatement['subtotal']);
    }
    final summaryRevenue = _pnlSummary['revenue'];
    if (summaryRevenue is Map && summaryRevenue['total'] != null) {
      return safeDouble(summaryRevenue['total']);
    }
    return safeDouble(_pnlSummary['total_revenue']);
  }

  double _statementExpenseTotal() {
    final statementRoot = _pnlStatement['statement'];
    final fromStatement = statementRoot is Map
        ? Map<String, dynamic>.from(statementRoot['expenses'] as Map? ?? {})
        : <String, dynamic>{};
    if (fromStatement['subtotal'] != null) {
      return safeDouble(fromStatement['subtotal']);
    }
    if (_pnlExpense['total_expenses'] != null) {
      return safeDouble(_pnlExpense['total_expenses']);
    }
    final summaryExpense = _pnlSummary['expenses'];
    if (summaryExpense is Map && summaryExpense['total'] != null) {
      return safeDouble(summaryExpense['total']);
    }
    return safeDouble(_pnlSummary['total_expenses']);
  }

  // ---------- Visual helpers ----------

  IconData _kpiIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains('revenue')) return Icons.trending_up_rounded;
    if (t.contains('expense')) return Icons.trending_down_rounded;
    if (t.contains('profit')) return Icons.account_balance_wallet_rounded;
    if (t.contains('margin')) return Icons.percent_rounded;
    return Icons.insights_rounded;
  }


  BoxDecoration _panelDecoration() => ReportsChrome.panelDecoration(context);

  Widget _sectionTitle(String title, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 10, top: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppFonts.interStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  // ---------- Filters: simple pill segmented + inline pickers ----------

  Widget _filterCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      padding: const EdgeInsets.all(12),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _segmentedPeriodPicker(),
          const SizedBox(height: 10),
          _inlinePeriodControls(),
        ],
      ),
    );
  }

  Widget _segmentedPeriodPicker() {
    final l10n = context.l10n;
    final modes = <Map<String, String>>[
      {'value': 'year', 'label': l10n.reportPeriodYear},
      {'value': 'month', 'label': l10n.reportPeriodMonth},
      {'value': 'month_range', 'label': l10n.reportPeriodRange},
    ];
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: _segmentTrack,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: modes.map((m) {
          final selected = _mode == m['value'];
          return Expanded(
            child: GestureDetector(
              onTap: () async {
                if (_mode == m['value']) return;
                setState(() => _mode = m['value']!);
                await _reload();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? _panelBg : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: selected ? Border.all(color: _border) : null,
                ),
                child: Center(
                  child: Text(
                    m['label']!,
                    style: AppFonts.interStyle(
                      color: selected ? _ink : _inkSoft,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _inlinePeriodControls() {
    final l10n = context.l10n;
    final years = List.generate(8, (i) => DateTime.now().year - i);
    final months = List.generate(12, (i) => i + 1);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _miniPicker<int>(
          label: l10n.reportPeriodYear,
          value: _year,
          items: years.map((y) => DropdownMenuItem(value: y, child: Text('$y'))).toList(),
          onChanged: (v) async {
            if (v == null) return;
            setState(() => _year = v);
            await _reload();
          },
        ),
        if (_mode == 'month')
          _miniPicker<int>(
            label: l10n.reportPeriodMonth,
            value: _month,
            items: months
                .map((m) => DropdownMenuItem(
                      value: m,
                      child: Text(DateFormat('MMM').format(DateTime(_year, m))),
                    ))
                .toList(),
            onChanged: (v) async {
              if (v == null) return;
              setState(() => _month = v);
              await _reload();
            },
          ),
        if (_mode == 'month_range') ...[
          _miniPicker<int>(
            label: l10n.reportPeriodFrom,
            value: _monthFrom,
            items: months
                .map((m) => DropdownMenuItem(
                      value: m,
                      child: Text(DateFormat('MMM').format(DateTime(_year, m))),
                    ))
                .toList(),
            onChanged: (v) async {
              if (v == null) return;
              setState(() {
                _monthFrom = v;
                if (_monthTo < _monthFrom) _monthTo = _monthFrom;
              });
              await _reload();
            },
          ),
          _miniPicker<int>(
            label: l10n.reportPeriodTo,
            value: _monthTo,
            items: months
                .map((m) => DropdownMenuItem(
                      value: m,
                      child: Text(DateFormat('MMM').format(DateTime(_year, m))),
                    ))
                .toList(),
            onChanged: (v) async {
              if (v == null) return;
              setState(() {
                _monthTo = v;
                if (_monthFrom > _monthTo) _monthFrom = _monthTo;
              });
              await _reload();
            },
          ),
        ],
      ],
    );
  }

  Widget _miniPicker<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: _panelBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label:',
            style: AppFonts.interStyle(fontSize: 12, color: _inkSoft, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 4),
          DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              icon: Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: _inkSoft),
              style: AppFonts.interStyle(
                fontSize: 13,
                color: _ink,
                fontWeight: FontWeight.w600,
              ),
              items: items,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- KPI cards: simple white cards with accent left bar ----------

  Widget _kpiGrid({
    required double revenue,
    required double expenses,
    required double profit,
    required double margin,
  }) {
    final l10n = context.l10n;
    final isWide = MediaQuery.of(context).size.width > 900;
    final cards = [
      _KpiData(l10n.revenue, _periodLabel(), revenue, isPercent: false, accentColor: _positive),
      _KpiData(l10n.reportExpensesKpi, l10n.reportAllPurchases, expenses, isPercent: false, accentColor: _negative),
      _KpiData(l10n.profit, l10n.reportBeforeTax, profit, isPercent: false, accentColor: _accent),
      _KpiData(l10n.reportMarginKpi, l10n.reportRevenueRetained, margin, isPercent: true, accentColor: const Color(0xFF7C3AED)),
    ];

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: isWide ? 4 : 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: isWide ? 2.1 : 1.55,
      children: cards.map(_kpiCard).toList(),
    );
  }

  Widget _kpiCard(_KpiData data) {
    final accent = data.accentColor;
    return Container(
      decoration: BoxDecoration(
        color: _panelBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Slim accent stripe
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(_kpiIcon(data.title), size: 14, color: accent),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          data.title,
                          style: AppFonts.interStyle(
                            color: _inkSoft,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: data.value),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    builder: (context, val, _) => FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data.isPercent ? '${val.toStringAsFixed(1)}%' : _formatMoney(val),
                        style: AppFonts.interStyle(
                          color: _ink,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.subtitle,
                    style: AppFonts.interStyle(color: _inkSoft, fontSize: 11.5),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Trend / chart helpers ----------

  List<String> _labelsFromTrend(Map<String, dynamic> trend) {
    final data = safeMapList(trend['data']);
    if (data.isNotEmpty) {
      return data
          .map((e) => safeText(e['period_label'], fallback: safeText(e['period'])))
          .toList();
    }
    final labelsRaw = trend['labels'];
    if (labelsRaw is List) {
      return labelsRaw.map((e) => e.toString()).toList();
    }
    return const <String>[];
  }

  List<double> _valuesFromTrend(Map<String, dynamic> trend, String key) {
    final data = safeMapList(trend['data']);
    if (data.isNotEmpty) {
      return data.map((e) => safeDouble(e[key])).toList();
    }
    final raw = trend[key];
    if (raw is List) {
      return raw.map((e) => safeDouble(e)).toList();
    }
    return const <double>[];
  }

  // ---------- Statement card (simple) ----------

  Widget _statementCard() {
    final l10n = context.l10n;
    final statementRoot = _pnlStatement['statement'];
    final revenueItems = _revenueItems();
    final expenseItems = _expenseItems();
    final totalRevenue = _statementRevenueTotal();
    final totalExpenses = _statementExpenseTotal();
    final grossProfitSection = statementRoot is Map
        ? Map<String, dynamic>.from(statementRoot['gross_profit'] as Map? ?? {})
        : const {};
    final grossProfit = safeDouble(grossProfitSection['amount'],
        fallback: totalRevenue - totalExpenses);
    final grossMargin = safeDouble(
      grossProfitSection['margin_percent'],
      fallback: totalRevenue == 0 ? 0 : (grossProfit / totalRevenue) * 100,
    );

    double discountContra = 0;
    final revenueSection = statementRoot is Map
        ? Map<String, dynamic>.from(statementRoot['revenue'] as Map? ?? {})
        : <String, dynamic>{};
    final revenueLines = safeMapList(revenueSection['lines']);
    for (final line in revenueLines) {
      final label = safeText(line['label']).toLowerCase();
      final amount = safeDouble(line['amount']);
      final isContra = line['is_contra'] == true;
      if (isContra || label.contains('discount')) {
        discountContra += amount;
      }
    }
    final salesRows = <Map<String, dynamic>>[];
    for (final item in revenueItems) {
      final account = safeText(item['label'], fallback: safeText(item['account'])).toLowerCase();
      if (account.contains('discount')) continue;
      salesRows.add(item);
    }
    final netRevenue = revenueSection['subtotal'] != null
        ? safeDouble(revenueSection['subtotal'])
        : totalRevenue + discountContra;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Revenue heading
          Row(
            children: [
              Text(
                l10n.revenue,
                style: AppFonts.interStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  letterSpacing: 0.4,
                  color: _ink,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => _showStatementDetails = !_showStatementDetails),
                child: Row(
                  children: [
                    Text(
                      _showStatementDetails ? l10n.reportHideDetails : l10n.reportShowDetails,
                      style: AppFonts.interStyle(
                        color: _accent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      _showStatementDetails
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: _accent,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _moneyRow(label: l10n.reportSalesRevenue, amount: totalRevenue, bold: true),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState: _showStatementDetails
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.only(left: 8, top: 2),
              child: Column(
                children: salesRows
                    .map((item) => _moneyRow(
                          label: safeText(item['label'],
                              fallback: safeText(item['account'], fallback: '—')),
                          amount: safeDouble(item['amount']),
                          subtle: true,
                        ))
                    .toList(),
              ),
            ),
            secondChild: const SizedBox.shrink(),
          ),
          if (discountContra != 0)
            _moneyRow(label: l10n.reportDiscountsGiven, amount: discountContra, contra: true),
          Divider(height: 18, color: _border),
          _moneyRow(
              label: l10n.reportNetRevenue,
              amount: netRevenue,
              bold: true,
              positiveHighlight: true),
          const SizedBox(height: 16),
          // Expenses
          Text(
            l10n.reportOperatingExpenses,
            style: AppFonts.interStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              letterSpacing: 0.4,
              color: _ink,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState: _showStatementDetails
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                children: expenseItems
                    .map((item) => _moneyRow(
                          label: safeText(item['label'],
                              fallback: safeText(item['account'], fallback: '—')),
                          amount: safeDouble(item['amount']),
                          expenseStyle: true,
                          subtle: true,
                        ))
                    .toList(),
              ),
            ),
            secondChild: const SizedBox.shrink(),
          ),
          _moneyRow(
              label: l10n.reportTotalExpenses,
              amount: totalExpenses,
              bold: true,
              expenseStyle: true),
          Divider(height: 18, color: _border),
          // Gross profit summary - simple row
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.reportGrossProfit,
                  style: AppFonts.interStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (grossProfit >= 0 ? _positive : _negative).withOpacity(0.10),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${grossMargin.toStringAsFixed(1)}%',
                  style: AppFonts.interStyle(
                    color: grossProfit >= 0 ? _positive : _negative,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _formatMoney(grossProfit),
                style: AppFonts.interStyle(
                  color: grossProfit >= 0 ? _positive : _negative,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            safeText(
              statementRoot is Map ? statementRoot['note'] : null,
              fallback: l10n.reportOperatingPlDisclaimer,
            ),
            style: AppFonts.interStyle(color: _inkSoft, fontSize: 11.5, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _moneyRow({
    required String label,
    required double amount,
    bool bold = false,
    bool contra = false,
    bool positiveHighlight = false,
    bool expenseStyle = false,
    bool subtle = false,
  }) {
    Color valueColor = _ink;
    if (positiveHighlight) valueColor = _positive;
    if (expenseStyle) valueColor = _negative;
    if (contra) valueColor = _negative;
    if (subtle && !contra && !expenseStyle && !positiveHighlight) valueColor = _ink;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: AppFonts.interStyle(
                      fontSize: subtle ? 12.5 : 14,
                      fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                      color: subtle ? _inkSoft : _ink,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (contra) ...[
                  const SizedBox(width: 6),
                  Text(context.l10n.reportContraLabel,
                      style: AppFonts.interStyle(fontSize: 10, color: _negative, fontWeight: FontWeight.w600)),
                ],
              ],
            ),
          ),
          Text(
            _formatMoney(amount, withParensForNegative: contra),
            style: AppFonts.interStyle(
              fontSize: subtle ? 12.5 : 14,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Charts (simple, interactive) ----------

  Widget _chartShell({
    required String title,
    required Widget child,
    Widget? trailing,
    double height = 220,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppFonts.interStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(height: height, child: child),
        ],
      ),
    );
  }

  Widget _noChartData() {
    return Center(
      child: Text(
        context.l10n.reportNoDataForPeriod,
        style: AppFonts.interStyle(color: _inkSoft, fontSize: 12.5),
      ),
    );
  }

  Widget _trendChartTypeToggle() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: _segmentTrack,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          _miniToggle(
            icon: Icons.bar_chart_rounded,
            selected: _trendChartType == 'bar',
            onTap: () => setState(() => _trendChartType = 'bar'),
          ),
          _miniToggle(
            icon: Icons.show_chart_rounded,
            selected: _trendChartType == 'line',
            onTap: () => setState(() => _trendChartType = 'line'),
          ),
        ],
      ),
    );
  }

  Widget _miniToggle({required IconData icon, required bool selected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? _panelBg : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: selected ? Border.all(color: _border) : null,
        ),
        child: Icon(icon, size: 14, color: selected ? _accent : _inkSoft),
      ),
    );
  }

  Widget _legendDot({required Color color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: AppFonts.interStyle(fontSize: 11.5, color: _inkSoft, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _monthlyRevenueVsExpensesChart() {
    final l10n = context.l10n;
    final trend = _pnlTrend;
    final labels = _labelsFromTrend(trend);
    final revenue = _valuesFromTrend(trend, 'revenue');
    final expenses = _valuesFromTrend(trend, 'expenses');
    if (labels.isEmpty || revenue.isEmpty || expenses.isEmpty) {
      return _chartShell(
        title: l10n.reportRevenueVsExpenses,
        trailing: _trendChartTypeToggle(),
        child: _noChartData(),
      );
    }
    final maxPos = [...revenue, ...expenses].fold<double>(0, (p, c) => c > p ? c : p);
    final maxY = maxPos == 0 ? 100.0 : maxPos * 1.2;

    Widget chart;
    if (_trendChartType == 'bar') {
      chart = BarChart(
        BarChartData(
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY / 4,
            getDrawingHorizontalLine: (value) =>
                FlLine(color: _border, strokeWidth: 1, dashArray: [4, 4]),
          ),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipRoundedRadius: 6,
              getTooltipColor: (_) => _tooltipBg,
              tooltipPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final label = labels[group.x.toInt()];
                final type = rodIndex == 0 ? l10n.revenue : l10n.reportExpensesKpi;
                return BarTooltipItem(
                  '$label\n',
                  AppFonts.interStyle(color: Colors.white70, fontSize: 11),
                  children: [
                    TextSpan(
                      text: '$type: ${_moneyCompact(rod.toY)}',
                      style: AppFonts.interStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              },
            ),
            touchCallback: (event, response) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    response == null ||
                    response.spot == null) {
                  _hoveredBarIndex = null;
                  return;
                }
                _hoveredBarIndex = response.spot!.touchedBarGroupIndex;
              });
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, _) => Text(
                  _compactCurrency.format(value),
                  style: AppFonts.interStyle(fontSize: 9.5, color: _inkSoft),
                ),
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 26,
                getTitlesWidget: (value, _) {
                  final i = value.toInt();
                  if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      labels[i],
                      style: AppFonts.interStyle(fontSize: 10.5, color: _inkSoft),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(labels.length, (i) {
            final highlighted = _hoveredBarIndex == i;
            return BarChartGroupData(
              x: i,
              barsSpace: 3,
              barRods: [
                BarChartRodData(
                  toY: i < revenue.length ? revenue[i] : 0,
                  width: highlighted ? 13 : 10,
                  borderRadius: BorderRadius.circular(3),
                  color: _positive,
                ),
                BarChartRodData(
                  toY: i < expenses.length ? expenses[i] : 0,
                  width: highlighted ? 13 : 10,
                  borderRadius: BorderRadius.circular(3),
                  color: _negative,
                ),
              ],
            );
          }),
        ),
      );
    } else {
      chart = LineChart(
        LineChartData(
          minY: 0,
          maxY: maxY,
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => _tooltipBg,
              tooltipRoundedRadius: 6,
              getTooltipItems: (spots) => spots.map((spot) {
                final type = spot.barIndex == 0 ? l10n.revenue : l10n.reportExpensesKpi;
                return LineTooltipItem(
                  '$type\n${_moneyCompact(spot.y)}',
                  AppFonts.interStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
                );
              }).toList(),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY / 4,
            getDrawingHorizontalLine: (value) =>
                FlLine(color: _border, strokeWidth: 1, dashArray: [4, 4]),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, _) => Text(
                  _compactCurrency.format(value),
                  style: AppFonts.interStyle(fontSize: 9.5, color: _inkSoft),
                ),
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 26,
                getTitlesWidget: (value, _) {
                  final i = value.toInt();
                  if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      labels[i],
                      style: AppFonts.interStyle(fontSize: 10.5, color: _inkSoft),
                    ),
                  );
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                  revenue.length, (i) => FlSpot(i.toDouble(), revenue[i])),
              isCurved: true,
              color: _positive,
              barWidth: 2.5,
              dotData: const FlDotData(show: false),
            ),
            LineChartBarData(
              spots: List.generate(
                  expenses.length, (i) => FlSpot(i.toDouble(), expenses[i])),
              isCurved: true,
              color: _negative,
              barWidth: 2.5,
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
      );
    }

    return _chartShell(
      title: l10n.reportRevenueVsExpenses,
      trailing: _trendChartTypeToggle(),
      child: Column(
        children: [
          Row(
            children: [
              _legendDot(color: _positive, label: l10n.revenue),
              const SizedBox(width: 14),
              _legendDot(color: _negative, label: l10n.reportExpensesKpi),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(child: chart),
        ],
      ),
    );
  }

  Widget _grossProfitByPeriodChart() {
    final l10n = context.l10n;
    final trend = _pnlTrend;
    final labels = _labelsFromTrend(trend);
    final revenue = _valuesFromTrend(trend, 'revenue');
    final expenses = _valuesFromTrend(trend, 'expenses');
    if (labels.isEmpty || revenue.isEmpty || expenses.isEmpty) {
      return _chartShell(title: l10n.reportGrossProfitChart, child: _noChartData());
    }
    final profits = List<double>.generate(labels.length, (i) {
      final rev = i < revenue.length ? revenue[i] : 0.0;
      final exp = i < expenses.length ? expenses[i] : 0.0;
      return rev - exp;
    });
    final maxAbs = profits.fold<double>(0, (p, c) => c.abs() > p ? c.abs() : p);
    final bound = maxAbs == 0 ? 100.0 : maxAbs * 1.2;
    return _chartShell(
      title: l10n.reportGrossProfitChart,
      child: BarChart(
        BarChartData(
          minY: -bound,
          maxY: bound,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: bound / 2,
            getDrawingHorizontalLine: (value) =>
                FlLine(color: _border, strokeWidth: 1, dashArray: [4, 4]),
          ),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipRoundedRadius: 6,
              getTooltipColor: (_) => _tooltipBg,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${labels[group.x.toInt()]}\n',
                  AppFonts.interStyle(color: Colors.white70, fontSize: 11),
                  children: [
                    TextSpan(
                      text: _moneyCompact(rod.toY),
                      style: AppFonts.interStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, _) => Text(
                  _compactCurrency.format(value),
                  style: AppFonts.interStyle(fontSize: 9.5, color: _inkSoft),
                ),
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 26,
                getTitlesWidget: (value, _) {
                  final i = value.toInt();
                  if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(labels[i],
                        style: AppFonts.interStyle(fontSize: 10.5, color: _inkSoft)),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(
            profits.length,
            (i) => BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: profits[i],
                  width: 14,
                  borderRadius: BorderRadius.circular(3),
                  color: profits[i] >= 0 ? _positive : _negative,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _expenseBreakdownChart() {
    final l10n = context.l10n;
    final expenseItems = _expenseItems();
    if (expenseItems.isEmpty) {
      return _chartShell(title: l10n.reportExpenseBreakdown, child: _noChartData());
    }
    final colors = <Color>[
      _accent,
      _positive,
      _negative,
      const Color(0xFFF59E0B),
      const Color(0xFF7C3AED),
      const Color(0xFF0EA5E9),
    ];
    final total = expenseItems.fold<double>(0, (sum, e) => sum + safeDouble(e['amount']));
    if (total <= 0) return const SizedBox.shrink();
    final visible = expenseItems.length.clamp(0, 6);

    return _chartShell(
      title: l10n.reportExpenseBreakdown,
      height: 240,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 36,
                sectionsSpace: 2,
                pieTouchData: PieTouchData(
                  touchCallback: (event, response) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          response == null ||
                          response.touchedSection == null) {
                        _touchedPieIndex = -1;
                        return;
                      }
                      _touchedPieIndex = response.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                sections: List.generate(visible, (i) {
                  final isTouched = i == _touchedPieIndex;
                  final amount = safeDouble(expenseItems[i]['amount']);
                  final pct = total == 0 ? 0 : (amount / total * 100);
                  return PieChartSectionData(
                    value: amount,
                    color: colors[i % colors.length],
                    radius: isTouched ? 46 : 38,
                    title: '${pct.toStringAsFixed(0)}%',
                    titleStyle: AppFonts.interStyle(
                      fontSize: isTouched ? 13 : 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(visible, (i) {
                  final amount = safeDouble(expenseItems[i]['amount']);
                  final pct = total == 0 ? 0 : (amount / total * 100);
                  final isTouched = i == _touchedPieIndex;
                  return GestureDetector(
                    onTap: () => setState(
                        () => _touchedPieIndex = isTouched ? -1 : i),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              color: colors[i % colors.length],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  safeText(expenseItems[i]['account'],
                                      fallback: l10n.reportExpenseFallback),
                                  style: AppFonts.interStyle(
                                    fontSize: 11.5,
                                    fontWeight: isTouched
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: _ink,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${pct.toStringAsFixed(1)}% • ${_moneyCompact(amount)}',
                                  style: AppFonts.interStyle(
                                      fontSize: 10.5, color: _inkSoft),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _marginTrendChart() {
    final l10n = context.l10n;
    final trend = _pnlTrend;
    final labels = _labelsFromTrend(trend);
    final revenue = _valuesFromTrend(trend, 'revenue');
    final expenses = _valuesFromTrend(trend, 'expenses');
    if (labels.isEmpty || revenue.isEmpty || expenses.isEmpty) {
      return _chartShell(title: l10n.reportGrossMarginPercent, child: _noChartData());
    }
    final margins = List<double>.generate(labels.length, (i) {
      final rev = i < revenue.length ? revenue[i] : 0.0;
      final exp = i < expenses.length ? expenses[i] : 0.0;
      if (rev == 0) return 0;
      return ((rev - exp) / rev) * 100;
    });
    final maxV = margins.fold<double>(-100, (p, c) => c > p ? c : p);
    final minV = margins.fold<double>(100, (p, c) => c < p ? c : p);
    final top = (maxV < 60 ? 60.0 : maxV) + 5.0;
    final bottom = math.min(0.0, minV) - 5.0;

    return _chartShell(
      title: l10n.reportGrossMarginPercent,
      child: LineChart(
        LineChartData(
          minY: bottom,
          maxY: top,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: ((top - bottom) / 4).clamp(1, double.infinity),
            getDrawingHorizontalLine: (value) =>
                FlLine(color: _border, strokeWidth: 1, dashArray: [4, 4]),
          ),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => _tooltipBg,
              tooltipRoundedRadius: 6,
              getTooltipItems: (spots) => spots.map((spot) {
                return LineTooltipItem(
                  '${labels[spot.x.toInt()]}\n${spot.y.toStringAsFixed(1)}%',
                  AppFonts.interStyle(
                      color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
                );
              }).toList(),
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, _) => Text(
                  '${value.toStringAsFixed(0)}%',
                  style: AppFonts.interStyle(fontSize: 9.5, color: _inkSoft),
                ),
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 26,
                getTitlesWidget: (value, _) {
                  final i = value.toInt();
                  if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(labels[i],
                        style: AppFonts.interStyle(fontSize: 10.5, color: _inkSoft)),
                  );
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                  margins.length, (i) => FlSpot(i.toDouble(), margins[i])),
              isCurved: true,
              color: _accent,
              barWidth: 2.5,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 3,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: _accent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Segment summary ----------

  Widget _roomVsFbSummary() {
    final l10n = context.l10n;
    final summary = _pnlRevenue['summary'];
    final room = summary is Map ? safeDouble(summary['room_revenue']) : 0.0;
    final fb = summary is Map ? safeDouble(summary['fnb_revenue']) : 0.0;
    final roomPct = summary is Map ? safeDouble(summary['room_percent']) : 0.0;
    final fbPct = summary is Map ? safeDouble(summary['fnb_percent']) : 0.0;
    if (room == 0 && fb == 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.reportRoomVsFnB,
            style: AppFonts.interStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _ink),
          ),
          const SizedBox(height: 12),
          // Simple stacked split bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (context, t, _) {
                final total = (room + fb).clamp(1, double.infinity);
                final roomFlex = ((room / total) * 100 * t).round().clamp(0, 100);
                final fbFlex = (100 - roomFlex).clamp(0, 100);
                return Row(
                  children: [
                    if (roomFlex > 0)
                      Expanded(
                        flex: roomFlex,
                        child: Container(height: 10, color: _accent),
                      ),
                    if (fbFlex > 0)
                      Expanded(
                        flex: fbFlex,
                        child: Container(
                            height: 10, color: const Color(0xFFF59E0B)),
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _segmentTile(
                  label: l10n.reportSegmentRoom,
                  amount: room,
                  pct: roomPct,
                  color: _accent,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _segmentTile(
                  label: l10n.reportSegmentFnB,
                  amount: fb,
                  pct: fbPct,
                  color: const Color(0xFFF59E0B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _segmentTile({
    required String label,
    required double amount,
    required double pct,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppFonts.interStyle(
                  fontSize: 12,
                  color: _inkSoft,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              _formatMoney(amount),
              style: AppFonts.interStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),
          ),
          Text(
            context.l10n.reportPercentOfRevenue(pct.toStringAsFixed(1)),
            style: AppFonts.interStyle(fontSize: 11, color: _inkSoft),
          ),
        ],
      ),
    );
  }

  // ---------- Build ----------

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfitLossReportCubit, ProfitLossReportState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (response) => setState(() => _bundle = response),
          orElse: () {},
        );
      },
      builder: (context, state) {
        final l10n = context.l10n;
        final summary = _pnlSummary;
        final revenue = safeDouble((summary['revenue'] as Map?)?['total']);
        final expenses = safeDouble((summary['expenses'] as Map?)?['total']);
        final profit = safeDouble((summary['profit'] as Map?)?['gross_profit']);
        final margin = safeDouble((summary['profit'] as Map?)?['gross_margin_percent']);

        final err = state.maybeWhen(error: (message) => message, orElse: () => null);
        final noNet = state.maybeWhen(noInternet: () => true, orElse: () => false);
        final showBlockingLoader = _bundle == null &&
            state.maybeWhen(
              initial: () => true,
              loading: () => true,
              orElse: () => false,
            );

        return Scaffold(
          backgroundColor: _surface,
          appBar: AppBar(
            leading: AppBarIosBackButton(color: _ink),
            title: Text(
              l10n.profitAndLoss,
              style: AppFonts.interStyle(fontWeight: FontWeight.w700, color: _ink, fontSize: 16),
            ),
            backgroundColor: _panelBg,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            foregroundColor: _ink,
            iconTheme: IconThemeData(color: _ink),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(height: 1, color: _border),
            ),
          ),
          body: Column(
            children: [
              _filterCard(),
              Expanded(
                child: noNet
                    ? _noInternetState()
                    : err != null
                        ? _errorState(err)
                        : showBlockingLoader
                            ? Center(
                                child: SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: _accent,
                                  ),
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: _reload,
                                color: _accent,
                                child: SingleChildScrollView(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _sectionTitle(
                                        l10n.reportKeyMetrics,
                                        trailing: Text(
                                          _periodLabel(),
                                          style: AppFonts.interStyle(
                                            fontSize: 11.5,
                                            color: _inkSoft,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      _kpiGrid(
                                        revenue: revenue,
                                        expenses: expenses,
                                        profit: profit,
                                        margin: margin,
                                      ),
                                      const SizedBox(height: 16),
                                      _sectionTitle(l10n.reportIncomeStatement),
                                      _statementCard(),
                                      const SizedBox(height: 16),
                                      _sectionTitle(l10n.reportChartsSection),
                                      LayoutBuilder(
                                        builder: (context, constraints) {
                                          final twoCols = constraints.maxWidth > 850;
                                          final halfWidth = twoCols
                                              ? (constraints.maxWidth - 12) / 2
                                              : constraints.maxWidth;
                                          return Wrap(
                                            spacing: 12,
                                            runSpacing: 12,
                                            children: [
                                              SizedBox(
                                                  width: halfWidth,
                                                  child: _monthlyRevenueVsExpensesChart()),
                                              SizedBox(
                                                  width: halfWidth,
                                                  child: _grossProfitByPeriodChart()),
                                              SizedBox(
                                                  width: halfWidth,
                                                  child: _expenseBreakdownChart()),
                                              SizedBox(
                                                  width: halfWidth,
                                                  child: _marginTrendChart()),
                                            ],
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      _sectionTitle(l10n.reportSegmentSummary),
                                      _roomVsFbSummary(),
                                    ],
                                  ),
                                ),
                              ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _noInternetState() {
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded, color: _inkSoft.withOpacity(0.8), size: 36),
            const SizedBox(height: 12),
            Text(
              l10n.noInternetConnection,
              style: AppFonts.interStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _ink),
            ),
            const SizedBox(height: 14),
            OutlinedButton.icon(
              onPressed: _reload,
              icon: Icon(Icons.refresh_rounded, size: 16),
              label: Text(l10n.retry),
              style: OutlinedButton.styleFrom(
                foregroundColor: _accent,
                side: const BorderSide(color: _accent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _errorState(String error) {
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, color: _negative, size: 32),
            const SizedBox(height: 12),
            Text(
              l10n.reportFailedToLoad,
              style: AppFonts.interStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _ink),
            ),
            const SizedBox(height: 4),
            Text(
              error,
              textAlign: TextAlign.center,
              style: AppFonts.interStyle(fontSize: 12.5, color: _inkSoft),
            ),
            const SizedBox(height: 14),
            OutlinedButton.icon(
              onPressed: _reload,
              icon: Icon(Icons.refresh_rounded, size: 16),
              label: Text(l10n.retry),
              style: OutlinedButton.styleFrom(
                foregroundColor: _accent,
                side: const BorderSide(color: _accent),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KpiData {
  final String title;
  final String subtitle;
  final double value;
  final bool isPercent;
  final Color accentColor;

  const _KpiData(
    this.title,
    this.subtitle,
    this.value, {
    this.isPercent = false,
    required this.accentColor,
  });
}
