import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/features/reports/data/models/request/analytics_report_request.dart';
import 'package:hotel/src/features/reports/data/models/response/analytics_report_response.dart';
import 'package:hotel/src/core/helpers/dynamic_json_parse.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/features/reports/presentation/bloc/analytics_report/analytics_report_cubit.dart';
import 'package:hotel/src/features/reports/presentation/widgets/reports_chrome.dart';
import 'package:intl/intl.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';

class AnalyticsReportPage extends StatefulWidget {
  const AnalyticsReportPage({super.key});

  @override
  State<AnalyticsReportPage> createState() => _AnalyticsReportPageState();
}

class _AnalyticsReportPageState extends State<AnalyticsReportPage> {
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final NumberFormat _currency = NumberFormat('#,##0.00');
  final NumberFormat _compact = NumberFormat.compact();

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

  // 0=purchase, 1=sales, 2=dashboard
  int _tabIndex = 0;

  // Period
  String _mode = 'year';
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  DateTime _day = DateTime.now();

  /// Last successful API bundle; updated from [AnalyticsReportState.success].
  AnalyticsReportResponse? _bundle;

  Map<String, dynamic> get _anDash => _bundle?.dashboard ?? const {};
  Map<String, dynamic> get _anSummary => _bundle?.summary ?? const {};
  Map<String, dynamic> get _anTrend => _bundle?.trend ?? const {};
  Map<String, dynamic> get _anItems => _bundle?.items ?? const {};
  Map<String, dynamic> get _anCategories => _bundle?.categories ?? const {};
  Map<String, dynamic> get _anParties => _bundle?.parties ?? const {};

  AnalyticsReportRequest _toRequest() => AnalyticsReportRequest(
        tabIndex: _tabIndex,
        mode: _mode,
        year: _year,
        month: _month,
        day: _day,
      );

  Future<void> _reload() async {
    await context.read<AnalyticsReportCubit>().load(_toRequest());
  }

  String _modeDescriptor() {
    final l10n = context.l10n;
    switch (_mode) {
      case 'day':
        return l10n.reportSingleDayTrend;
      case 'month':
        return l10n.reportMonthYearDailyTrend(
          DateFormat('MMM').format(DateTime(_year, _month)),
          '$_year',
        );
      case 'year':
      default:
        return l10n.reportFullYearTrend;
    }
  }

  String _periodLabel() {
    final l10n = context.l10n;
    switch (_mode) {
      case 'day':
        return _dateFormat.format(_day);
      case 'month':
        return '${DateFormat('MMM').format(DateTime(_year, _month))} $_year';
      case 'year':
      default:
        return l10n.reportYearLabel('$_year');
    }
  }

  String _periodSubLabel() {
    final l10n = context.l10n;
    switch (_mode) {
      case 'day':
        return DateFormat('dd MMM yyyy').format(_day);
      case 'month':
        return '${DateFormat('MMM').format(DateTime(_year, _month))} $_year';
      case 'year':
      default:
        return l10n.reportJanDec('$_year');
    }
  }

  // ----------------------------- helpers -----------------------------

  String _money(num v) => '$currencySymbol ${_currency.format(v)}';
  String _moneyCompact(num v) => '$currencySymbol ${_compact.format(v)}';

  BoxDecoration _panel({Color? color}) => ReportsChrome.panelDecoration(
        context,
        color: color,
      );

  // Read a value from a map, trying the alternative keys in order.
  Object? _pick(Map<String, dynamic> m, List<String> keys) {
    for (final k in keys) {
      if (m.containsKey(k) && m[k] != null) return m[k];
    }
    return null;
  }

  // Unwrap a possibly-wrapped summary response. The API often returns
  // `{ summary: {...} }`. Fall back to the top-level map otherwise.
  Map<String, dynamic> _unwrapSummary(Map<String, dynamic>? raw) {
    if (raw == null) return const {};
    if (raw['summary'] is Map) {
      return Map<String, dynamic>.from(raw['summary'] as Map);
    }
    return raw;
  }

  List<Map<String, dynamic>> _listFrom(Map<String, dynamic>? raw) {
    if (raw == null) return const [];
    final candidates = <Object?>[
      raw['data'],
      raw['results'],
      raw['items'],
      raw['list'],
    ];
    for (final c in candidates) {
      if (c is List) return safeMapList(c);
    }
    return const [];
  }

  // --------------------------- header ---------------------------

  Widget _topBar() {
    final years = List.generate(8, (i) => DateTime.now().year - i);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: _panelBg,
        border: Border(bottom: BorderSide(color: _border)),
      ),
      child: Row(
        children: [
          AppBarIosBackButton(
            color: _ink,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.l10n.analytics,
                style: AppFonts.interStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _ink,
                ),
              ),
            ),
          ),
          // Year picker (visible whenever year is part of the query)
          if (_mode != 'day') ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _border),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _year,
                  isDense: true,
                  icon: Icon(Icons.keyboard_arrow_down_rounded,
                      size: 18, color: _inkSoft),
                  style: AppFonts.interStyle(
                      fontSize: 13, color: _ink, fontWeight: FontWeight.w600),
                  items: years
                      .map((y) =>
                          DropdownMenuItem(value: y, child: Text('$y')))
                      .toList(),
                  onChanged: (v) async {
                    if (v == null) return;
                    setState(() => _year = v);
                    await _reload();
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // --------------------------- tabs ---------------------------
  /// Text + primary underline (same pattern as Customers / Suppliers / Employees).

  Widget _tabsRow() {
    final l10n = context.l10n;
    final labels = [l10n.reportTabPurchase, l10n.reportTabSales, l10n.reportTabDashboard];
    return Row(
      children: [
        for (var i = 0; i < 3; i++) ...[
          if (i != 0) const SizedBox(width: 4),
          Expanded(child: _analyticsUnderlineTab(index: i, label: labels[i])),
        ],
      ],
    );
  }

  Widget _analyticsUnderlineTab({required int index, required String label}) {
    final primary = Theme.of(context).colorScheme.primary;
    final selected = _tabIndex == index;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          if (_tabIndex == index) return;
          HapticFeedback.selectionClick();
          setState(() => _tabIndex = index);
          await _reload();
        },
        splashFactory: InkRipple.splashFactory,
        splashColor: primary.withOpacity(0.10),
        highlightColor: primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.interStyle(
                    color: selected ? primary : _inkSoft,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                height: 2.5,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: selected ? primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------ period card ------------------------

  Widget _periodCard() {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: _panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                l10n.reportPeriod,
                style: AppFonts.interStyle(
                  fontSize: 12,
                  color: _inkSoft,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: _periodModePill('year', l10n.reportPeriodYear)),
                    const SizedBox(width: 6),
                    Expanded(child: _periodModePill('month', l10n.reportPeriodMonth)),
                    const SizedBox(width: 6),
                    Expanded(child: _periodModePill('day', l10n.reportPeriodDay)),
                    if (_mode == 'month') ...[
                      const SizedBox(width: 8),
                      _monthPicker(),
                    ],
                    if (_mode == 'day') ...[
                      const SizedBox(width: 8),
                      _dayPicker(),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _inkSoft,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _modeDescriptor(),
                  style: AppFonts.interStyle(fontSize: 12, color: _inkSoft),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _periodModePill(String mode, String label) {
    final selected = _mode == mode;
    final primary = Theme.of(context).colorScheme.primary;
    return Material(
      color: selected ? primary : _segmentTrack,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          if (_mode == mode) return;
          HapticFeedback.selectionClick();
          setState(() => _mode = mode);
          await _reload();
        },
        borderRadius: BorderRadius.circular(8),
        splashColor: primary.withOpacity(0.2),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? primary : _border,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.interStyle(
              color: selected ? _cs.onPrimary : _ink,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _monthPicker() {
    final months = List.generate(12, (i) => i + 1);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: _panelBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _month,
          isDense: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              size: 18, color: _inkSoft),
          style: AppFonts.interStyle(
              fontSize: 13, color: _ink, fontWeight: FontWeight.w600),
          items: months
              .map((m) => DropdownMenuItem(
                    value: m,
                    child: Text(
                        DateFormat('MMM').format(DateTime(_year, m))),
                  ))
              .toList(),
          onChanged: (v) async {
            if (v == null) return;
            setState(() => _month = v);
            await _reload();
          },
        ),
      ),
    );
  }

  Widget _dayPicker() {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _day,
          firstDate: DateTime(2015),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() => _day = picked);
          await _reload();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: _panelBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today_rounded,
                size: 14, color: _inkSoft),
            const SizedBox(width: 6),
            Text(
              _dateFormat.format(_day),
              style: AppFonts.interStyle(
                fontSize: 13,
                color: _ink,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------- KPI ---------------------------

  Widget _kpiCard({
    required String label,
    required String value,
    String? sub,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppFonts.interStyle(
                  fontSize: 12, color: _inkSoft, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: AppFonts.interStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: _ink,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(sub ?? '',
              style: AppFonts.interStyle(fontSize: 11.5, color: _inkSoft)),
        ],
      ),
    );
  }

  Widget _kpiGrid() {
    final l10n = context.l10n;
    final s = _unwrapSummary(_anSummary);
    final isPurchase = _tabIndex == 0;
    final totalLabel = isPurchase ? l10n.reportTotalPurchases : l10n.reportTotalSales;

    final total = safeDouble(_pick(s, [
      isPurchase ? 'total_purchases' : 'total_sales',
      'total_amount',
      'total',
      'amount',
      'grand_total',
    ]));
    final invoices = safeInt(_pick(s, [
      'total_invoices',
      'invoice_count',
      'count',
      'txn_count',
      'invoices',
    ]));
    final outstanding = safeDouble(_pick(s, [
      'outstanding',
      'unpaid',
      'unpaid_balance',
      'due',
      'balance_due',
    ]));
    final avgInvoice = invoices > 0
        ? total / invoices
        : safeDouble(_pick(s, [
            'avg_invoice',
            'average_invoice',
            'avg_per_invoice',
            'average',
          ]));

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 720;
        final cardWidth = wide
            ? (constraints.maxWidth - 30) / 4
            : (constraints.maxWidth - 10) / 2;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            SizedBox(
              width: cardWidth,
              child: _kpiCard(
                label: totalLabel,
                value: _moneyCompact(total),
                sub: _money(total),
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _kpiCard(
                label: l10n.reportTotalInvoices,
                value: '$invoices',
                sub: _periodSubLabel(),
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _kpiCard(
                label: l10n.unpaid,
                value: _moneyCompact(outstanding),
                sub: l10n.reportUnpaidBalance,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _kpiCard(
                label: l10n.reportAvgPerInvoice,
                value: _moneyCompact(avgInvoice),
                sub: l10n.reportPerTransaction,
              ),
            ),
          ],
        );
      },
    );
  }

  // --------------------------- charts ---------------------------

  ({List<String> labels, List<double> values, List<int> counts})
      _trendSeries() {
    final raw = _anTrend;
    final list = _listFrom(raw);
    if (list.isNotEmpty) {
      final labels = list
          .map((e) => safeText(
                _pick(e, ['period_label', 'label', 'month_label']),
                fallback: safeText(_pick(e, ['period', 'month', 'date'])),
              ))
          .toList();
      final values = list
          .map((e) => safeDouble(_pick(e, [
                'amount',
                'spend',
                'total',
                'value',
                'total_amount',
                'total_spend',
                'total_purchases',
                'total_sales',
              ])))
          .toList();
      final counts = list
          .map((e) => safeInt(_pick(e, [
                'invoice_count',
                'count',
                'txn_count',
                'invoices',
              ])))
          .toList();
      return (labels: labels, values: values, counts: counts);
    }
    final labels = (raw['labels'] is List)
        ? (raw['labels'] as List).map((e) => e.toString()).toList()
        : <String>[];
    final values = (raw['amount'] is List)
        ? (raw['amount'] as List).map(safeDouble).toList()
        : <double>[];
    final counts = (raw['count'] is List)
        ? (raw['count'] as List).map(safeInt).toList()
        : <int>[];
    return (labels: labels, values: values, counts: counts);
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4, left: 2),
      child: Text(
        text.toUpperCase(),
        style: AppFonts.interStyle(
          fontSize: 11.5,
          color: _inkSoft,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _spendBarChart() {
    final l10n = context.l10n;
    final t = _trendSeries();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel(_tabIndex == 0
              ? l10n.reportMonthlySpend(currencySymbol)
              : l10n.reportMonthlySalesChart(currencySymbol)),
          SizedBox(
            height: 220,
            child: t.labels.isEmpty || t.values.isEmpty
                ? _empty()
                : _buildBarChart(t.labels, t.values),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(List<String> labels, List<double> values) {
    final barColor = Theme.of(context).colorScheme.primary;
    final maxY = values.fold<double>(0, (p, c) => c > p ? c : p);
    final yMax = maxY == 0 ? 100.0 : maxY * 1.2;
    return BarChart(
      BarChartData(
        maxY: yMax,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: yMax / 4,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: _border, strokeWidth: 1, dashArray: [4, 4]),
        ),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => _tooltipBg,
            tooltipRoundedRadius: 6,
            getTooltipItem: (group, _, rod, __) => BarTooltipItem(
              _moneyCompact(rod.toY),
              AppFonts.interStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              getTitlesWidget: (v, _) => Text(
                _compact.format(v),
                style: AppFonts.interStyle(fontSize: 9.5, color: _inkSoft),
              ),
            ),
          ),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i < 0 || i >= labels.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(labels[i],
                      style: AppFonts.interStyle(fontSize: 10.5, color: _inkSoft)),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < values.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: values[i],
                  width: 22,
                  color: barColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _invoiceCountChart() {
    final t = _trendSeries();
    final hasCounts = t.counts.any((c) => c > 0);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel(context.l10n.reportInvoiceCountByMonth),
          SizedBox(
            height: 220,
            child: !hasCounts || t.labels.isEmpty
                ? _empty()
                : _buildLineChart(
                    t.labels, t.counts.map((e) => e.toDouble()).toList()),
          ),
        ],
      ),
    );
  }

  Widget _buildLineChart(List<String> labels, List<double> values) {
    final maxY = values.fold<double>(0, (p, c) => c > p ? c : p);
    final yMax = maxY == 0 ? 10.0 : maxY * 1.2;
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: yMax,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: yMax / 4,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: _border, strokeWidth: 1, dashArray: [4, 4]),
        ),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => _tooltipBg,
            tooltipRoundedRadius: 6,
            getTooltipItems: (spots) => spots
                .map((s) => LineTooltipItem(
                      '${s.y.toInt()}',
                      AppFonts.interStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ))
                .toList(),
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              getTitlesWidget: (v, _) => Text(
                v.toInt().toString(),
                style: AppFonts.interStyle(fontSize: 10, color: _inkSoft),
              ),
            ),
          ),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i < 0 || i >= labels.length) {
                  return const SizedBox.shrink();
                }
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
                values.length, (i) => FlSpot(i.toDouble(), values[i])),
            isCurved: true,
            color: _positive,
            barWidth: 2.5,
            dotData: FlDotData(
              show: true,
              getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                radius: 3,
                color: Colors.white,
                strokeWidth: 2,
                strokeColor: _positive,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------- top items bars -----------------------

  static const List<Color> _palette = [
    Color(0xFF3B82F6),
    Color(0xFF10B981),
    Color(0xFFEF4444),
    Color(0xFFF59E0B),
    Color(0xFF8B5CF6),
    Color(0xFF6B7280),
    Color(0xFFEC4899),
    Color(0xFF06B6D4),
    Color(0xFF84CC16),
    Color(0xFFD97706),
  ];

  Widget _topItemsBars() {
    final l10n = context.l10n;
    final list = _listFrom(_anItems).take(10).toList();
    if (list.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: _panel(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel(l10n.reportTopItemsBySpend(currencySymbol)),
            SizedBox(height: 60, child: _empty()),
          ],
        ),
      );
    }
    final values = list
        .map((e) => safeDouble(
            _pick(e, ['amount', 'total', 'spend', 'value', 'total_amount'])))
        .toList();
    final maxV = values.fold<double>(0, (p, c) => c > p ? c : p);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel(l10n.reportTopItemsBySpend(currencySymbol)),
          for (var i = 0; i < list.length; i++)
            _topRow(
              name: safeText(
                _pick(list[i], ['item', 'name', 'item_name', 'title']),
                fallback: '—',
              ),
              value: values[i],
              max: maxV == 0 ? 1 : maxV,
              color: _palette[i % _palette.length],
            ),
        ],
      ),
    );
  }

  Widget _topRow({
    required String name,
    required double value,
    required double max,
    required Color color,
  }) {
    final ratio = (value / max).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: AppFonts.interStyle(
                fontSize: 12,
                color: _ink,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LayoutBuilder(
              builder: (context, c) {
                final w = c.maxWidth * ratio;
                return Stack(
                  children: [
                    Container(
                      height: 22,
                      decoration: BoxDecoration(
                        color: _segmentTrack,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      height: 22,
                      width: w,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '$currencySymbol ${_compact.format(value)}',
                            style: AppFonts.interStyle(
                              fontSize: 11.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --------------------- categories donut ---------------------

  Widget _categoryDonut() {
    final l10n = context.l10n;
    final list = _listFrom(_anCategories);
    if (list.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: _panel(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel(l10n.reportSpendByCategory),
            SizedBox(height: 100, child: _empty()),
          ],
        ),
      );
    }
    final entries = list.map((e) {
      return _CategoryEntry(
        label: safeText(_pick(e, ['category', 'name', 'label']),
            fallback: l10n.reportOtherCategory),
        value: safeDouble(
            _pick(e, ['amount', 'total', 'value', 'total_amount'])),
      );
    }).where((e) => e.value > 0).toList();
    if (entries.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: _panel(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel(l10n.reportSpendByCategory),
            SizedBox(height: 100, child: _empty()),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel(l10n.reportSpendByCategory),
          Wrap(
            spacing: 12,
            runSpacing: 6,
            children: [
              for (var i = 0; i < entries.length; i++)
                _legendDot(
                  color: _palette[i % _palette.length],
                  label: entries[i].label,
                ),
            ],
          ),
          const SizedBox(height: 14),
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                  sections: [
                    for (var i = 0; i < entries.length; i++)
                      PieChartSectionData(
                        value: entries[i].value,
                        color: _palette[i % _palette.length],
                        radius: 40,
                        showTitle: false,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendDot({required Color color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppFonts.interStyle(
              fontSize: 11.5, color: _ink, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // ---------------------- parties table ----------------------

  Widget _partiesTable() {
    final l10n = context.l10n;
    final isPurchase = _tabIndex == 0;
    final title = isPurchase ? l10n.reportSuppliers : l10n.reportParties;
    final list = _listFrom(_anParties).take(10).toList();
    if (list.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: _panel(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel(title),
            SizedBox(height: 100, child: _empty()),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel(title),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    isPurchase ? l10n.reportTableSupplier : l10n.reportParties,
                    style: AppFonts.interStyle(
                        fontSize: 11.5,
                        color: _inkSoft,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    l10n.reportTableAmount,
                    textAlign: TextAlign.right,
                    style: AppFonts.interStyle(
                        fontSize: 11.5,
                        color: _inkSoft,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 50,
                  child: Text(
                    l10n.reportTableBills,
                    textAlign: TextAlign.right,
                    style: AppFonts.interStyle(
                        fontSize: 11.5,
                        color: _inkSoft,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: _border),
          for (final r in list)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      safeText(
                        _pick(r, [
                          isPurchase ? 'supplier' : 'party',
                          'name',
                          'title',
                        ]),
                        fallback: '—',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.interStyle(
                          fontSize: 12.5,
                          color: _ink,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      _money(safeDouble(_pick(r, [
                        'amount',
                        'total',
                        'total_amount',
                        'value',
                      ]))),
                      textAlign: TextAlign.right,
                      style: AppFonts.interStyle(
                          fontSize: 12.5,
                          color: _ink,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 50,
                    child: Text(
                      '${safeInt(_pick(r, [
                            'bills',
                            'count',
                            'invoice_count',
                            'txn_count',
                          ]))}',
                      textAlign: TextAlign.right,
                      style: AppFonts.interStyle(
                          fontSize: 12.5,
                          color: _inkSoft,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ---------------------- dashboard view ----------------------

  Widget _dashboardView() {
    final l10n = context.l10n;
    final raw = _anDash;
    final sales = raw['sales'] is Map
        ? Map<String, dynamic>.from(raw['sales'] as Map)
        : <String, dynamic>{};
    final purchase = raw['purchase'] is Map
        ? Map<String, dynamic>.from(raw['purchase'] as Map)
        : <String, dynamic>{};

    final salesTotal = safeDouble(_pick(sales, [
      'total',
      'total_amount',
      'total_sales',
      'amount',
    ]));
    final purchaseTotal = safeDouble(_pick(purchase, [
      'total',
      'total_amount',
      'total_purchases',
      'amount',
    ]));
    final gross = safeDouble(_pick(raw, [
      'gross_profit',
      'profit',
      'net',
    ]));
    final margin = safeDouble(_pick(raw, [
      'gross_margin_percent',
      'gross_margin',
      'margin_percent',
    ]));

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 720;
        final cardWidth = wide
            ? (constraints.maxWidth - 30) / 4
            : (constraints.maxWidth - 10) / 2;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            SizedBox(
              width: cardWidth,
              child: _kpiCard(
                label: l10n.reportSalesTotal,
                value: _moneyCompact(salesTotal),
                sub: _money(salesTotal),
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _kpiCard(
                label: l10n.reportPurchaseTotal,
                value: _moneyCompact(purchaseTotal),
                sub: _money(purchaseTotal),
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _kpiCard(
                label: l10n.reportGrossProfit,
                value: _moneyCompact(gross),
                sub: gross >= 0 ? l10n.reportPositiveMargin : l10n.reportNegativeMargin,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _kpiCard(
                label: l10n.reportGrossMargin,
                value: '${margin.toStringAsFixed(1)}%',
                sub: l10n.reportOfTotalSales,
              ),
            ),
          ],
        );
      },
    );
  }

  // -------------------------- empty --------------------------

  Widget _empty() {
    return Center(
      child: Text(
        context.l10n.reportNoDataForPeriod,
        style: AppFonts.interStyle(color: _inkSoft, fontSize: 12.5),
      ),
    );
  }

  // -------------------------- build --------------------------

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnalyticsReportCubit, AnalyticsReportState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (response) => setState(() => _bundle = response),
          orElse: () {},
        );
      },
      builder: (context, state) {
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
          body: SafeArea(
            child: Column(
              children: [
                _topBar(),
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
                                        strokeWidth: 2.5, color: _accent),
                                  ),
                                )
                              : RefreshIndicator(
                                  color: _accent,
                                  onRefresh: _reload,
                                  child: SingleChildScrollView(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 12, 12, 24),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(14),
                                          decoration: _panel(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              _tabsRow(),
                                              const SizedBox(height: 12),
                                              _periodCard(),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 2),
                                          child: Text(
                                            _periodLabel(),
                                            style: AppFonts.interStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        if (_tabIndex == 2)
                                          _dashboardView()
                                        else ...[
                                          _kpiGrid(),
                                          const SizedBox(height: 14),
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              final wide = constraints.maxWidth > 760;
                                              final w = wide
                                                  ? (constraints.maxWidth - 12) / 2
                                                  : constraints.maxWidth;
                                              return Wrap(
                                                spacing: 12,
                                                runSpacing: 12,
                                                children: [
                                                  SizedBox(
                                                      width: w, child: _spendBarChart()),
                                                  SizedBox(
                                                      width: w,
                                                      child: _invoiceCountChart()),
                                                ],
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 14),
                                          _topItemsBars(),
                                          const SizedBox(height: 14),
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              final wide = constraints.maxWidth > 760;
                                              final w = wide
                                                  ? (constraints.maxWidth - 12) / 2
                                                  : constraints.maxWidth;
                                              return Wrap(
                                                spacing: 12,
                                                runSpacing: 12,
                                                children: [
                                                  SizedBox(
                                                      width: w, child: _categoryDonut()),
                                                  SizedBox(
                                                      width: w,
                                                      child: _partiesTable()),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                ),
              ],
            ),
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
            Icon(Icons.error_outline_rounded,
                color: _negative, size: 32),
            const SizedBox(height: 12),
            Text(
              l10n.reportFailedToLoadAnalytics,
              style: AppFonts.interStyle(
                  fontSize: 14, fontWeight: FontWeight.w700, color: _ink),
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

class _CategoryEntry {
  final String label;
  final double value;
  const _CategoryEntry({required this.label, required this.value});
}
