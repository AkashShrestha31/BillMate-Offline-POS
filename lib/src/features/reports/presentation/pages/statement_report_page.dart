import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/extensions/extensions/localization_extension.dart';
import 'package:hotel/src/features/reports/data/models/request/statement_report_request.dart';
import 'package:hotel/src/features/reports/data/models/response/statement_report_response.dart';
import 'package:hotel/src/core/helpers/dynamic_json_parse.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/features/reports/presentation/bloc/statement_report/statement_report_cubit.dart';
import 'package:hotel/src/features/reports/presentation/widgets/reports_chrome.dart';
import 'package:intl/intl.dart';
import 'package:hotel/constants.dart';

class StatementReportPage extends StatefulWidget {
  const StatementReportPage({super.key});

  @override
  State<StatementReportPage> createState() => _StatementReportPageState();
}

class _StatementReportPageState extends State<StatementReportPage> {
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final NumberFormat _currency = NumberFormat('#,##0.00');
  final NumberFormat _compactCurrency = NumberFormat.compact();

  // Semantic chart / KPI accents
  static const Color _accent = ReportsChrome.accent;
  static const Color _positive = ReportsChrome.positive;
  static const Color _negative = ReportsChrome.negative;

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
  DateTime _day = DateTime.now();

  /// Last successful API bundle; updated from [StatementReportState.success].
  StatementReportResponse? _bundle;

  Map<String, dynamic> get _ov => _bundle?.overview ?? const {};
  Map<String, dynamic> get _csum => _bundle?.cashSummary ?? const {};
  Map<String, dynamic> get _ctrend => _bundle?.cashTrend ?? const {};
  Map<String, dynamic> get _bsum => _bundle?.bankSummary ?? const {};
  Map<String, dynamic> get _btrend => _bundle?.bankTrend ?? const {};
  Map<String, dynamic> get _dsum => _bundle?.dailySummary ?? const {};
  Map<String, dynamic> get _dtrend => _bundle?.dailyTrend ?? const {};

  StatementReportRequest _toRequest() => StatementReportRequest(
        mode: _mode,
        year: _year,
        month: _month,
        monthFrom: _monthFrom,
        monthTo: _monthTo,
        day: _day,
      );

  Future<void> _reload() async {
    await context.read<StatementReportCubit>().load(_toRequest());
  }

  String _money(double v) => AppCurrencyFormatter.format(v, decimals: 2);

  String _periodLabel() {
    switch (_mode) {
      case 'day':
        return _dateFormat.format(_day);
      case 'month':
        return '${DateFormat('MMM').format(DateTime(_year, _month))} $_year';
      case 'month_range':
        return '${DateFormat('MMM').format(DateTime(_year, _monthFrom))} - ${DateFormat('MMM').format(DateTime(_year, _monthTo))} $_year';
      case 'year':
      default:
        return '$_year';
    }
  }

  // ---------- helpers ----------

  BoxDecoration _panel() => ReportsChrome.panelDecoration(context);

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

  // ---------- Filter ----------

  Widget _filterCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      padding: const EdgeInsets.all(12),
      decoration: _panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _segmentedPeriodPicker(),
          const SizedBox(height: 10),
          _inlineControls(),
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
      {'value': 'day', 'label': l10n.reportPeriodDay},
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

  Widget _inlineControls() {
    final l10n = context.l10n;
    final years = List.generate(8, (i) => DateTime.now().year - i);
    final months = List.generate(12, (i) => i + 1);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (_mode != 'day')
          _miniPicker<int>(
            label: l10n.reportPeriodYear,
            value: _year,
            items: years
                .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
                .toList(),
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
        if (_mode == 'day')
          GestureDetector(
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
                  Icon(Icons.calendar_today_rounded, size: 14, color: _inkSoft),
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
          ),
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
            style: AppFonts.interStyle(
                fontSize: 12, color: _inkSoft, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 4),
          DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              icon: Icon(Icons.keyboard_arrow_down_rounded,
                  size: 18, color: _inkSoft),
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

  // ---------- Overview cards ----------

  Widget _overviewCards() {
    final l10n = context.l10n;
    final overview = _ov;
    final totals = (overview['totals'] is Map)
        ? Map<String, dynamic>.from(overview['totals'] as Map)
        : <String, dynamic>{};
    // Try nested keys first (current API), then fall back to flat keys.
    final cash = safeDouble(
      totals['total_cash_balance'] ?? overview['cash_balance'],
    );
    final bank = safeDouble(
      totals['total_bank_balance'] ?? overview['bank_balance'],
    );
    final total = safeDouble(
      totals['total_balance'] ?? overview['total_balance'],
    );
    final isWide = MediaQuery.of(context).size.width > 700;
    final cards = [
      _OverviewItem(l10n.reportOverviewCash, cash, _positive, Icons.payments_rounded),
      _OverviewItem(l10n.reportOverviewBank, bank, _accent, Icons.account_balance_rounded),
      _OverviewItem(l10n.total, total, const Color(0xFF7C3AED),
          Icons.account_balance_wallet_rounded),
    ];
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: isWide ? 3 : 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: isWide ? 2.4 : 1.4,
      children: cards.map(_overviewCard).toList(),
    );
  }

  Widget _overviewCard(_OverviewItem item) {
    return Container(
      decoration: BoxDecoration(
        color: _panelBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: item.color,
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
                      Icon(item.icon, size: 14, color: item.color),
                      const SizedBox(width: 6),
                      Text(
                        item.label,
                        style: AppFonts.interStyle(
                          fontSize: 12,
                          color: _inkSoft,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: item.value),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    builder: (context, val, _) => FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _money(val),
                        style: AppFonts.interStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _ink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Summary KV card ----------

  Widget _summaryCard(String title, Map<String, dynamic>? summary) {
    // The API wraps numbers in a "summary" sub-object. Prefer that, but
    // fall back to the top level if a flat shape is ever returned.
    final src = summary ?? const <String, dynamic>{};
    final inner = (src['summary'] is Map)
        ? Map<String, dynamic>.from(src['summary'] as Map)
        : src;
    final entries = inner.entries
        .where((e) => e.value is num || e.value is String)
        .toList();
    if (entries.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: _panel(),
        child: Row(
          children: [
            Text(title,
                style: AppFonts.interStyle(
                    fontWeight: FontWeight.w700, fontSize: 13, color: _ink)),
            const Spacer(),
            Text('—', style: AppFonts.interStyle(color: _inkSoft)),
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
          Text(
            title,
            style: AppFonts.interStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: _ink,
            ),
          ),
          const SizedBox(height: 10),
          ...entries.map((e) {
            final isNum = e.value is num;
            final label = _humanize(e.key);
            final display = isNum
                ? _money((e.value as num).toDouble())
                : (e.value?.toString() ?? '—');
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: AppFonts.interStyle(
                        fontSize: 12.5,
                        color: _inkSoft,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    display,
                    style: AppFonts.interStyle(
                      fontSize: 13,
                      color: _ink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _humanize(String key) {
    final s = key.replaceAll('_', ' ');
    return s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
  }

  bool get _showsMonthlyOpeningBalances =>
      _mode == 'year' || _mode == 'month' || _mode == 'month_range';

  List<Map<String, dynamic>> _monthlyOpeningBalances() {
    final fromSummary = safeMapList(_dsum['monthly_opening_balances']);
    if (fromSummary.isNotEmpty) return fromSummary;

    if (!_showsMonthlyOpeningBalances) return const [];

    final trendRows = safeMapList(_dtrend['data']);
    return trendRows
        .where((row) => row['opening_balance'] != null)
        .map(
          (row) => <String, dynamic>{
            'period': row['period'],
            'period_label': safeText(
              row['period_label'],
              fallback: safeText(row['period']),
            ),
            'opening_balance': row['opening_balance'],
            'has_data': true,
          },
        )
        .toList();
  }

  Widget _monthlyOpeningBalanceCard() {
    final l10n = context.l10n;
    final rows = _monthlyOpeningBalances();
    if (!_showsMonthlyOpeningBalances || rows.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: _panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.reportMonthlyOpeningBalance,
            style: AppFonts.interStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: _ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.reportOpeningBalanceHint,
            style: AppFonts.interStyle(
              fontSize: 11.5,
              color: _inkSoft,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          ...rows.map((row) {
            final hasData = row['has_data'] == true;
            final label = safeText(
              row['period_label'],
              fallback: safeText(row['period']),
            );
            final amount = row['opening_balance'];
            final display = hasData && amount is num
                ? _money(amount.toDouble())
                : '—';
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: AppFonts.interStyle(
                        fontSize: 12.5,
                        color: _inkSoft,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    display,
                    style: AppFonts.interStyle(
                      fontSize: 13,
                      color: hasData ? _ink : _inkSoft,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ---------- Chart shell + chart ----------

  Widget _chartShell({
    required String title,
    required Widget child,
    Widget? trailing,
    double height = 220,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _panel(),
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
            style: AppFonts.interStyle(
                fontSize: 11.5, color: _inkSoft, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _trendChart({
    required String title,
    required List<String> labels,
    required List<double> first,
    required List<double> second,
    required Color firstColor,
    required Color secondColor,
    required String firstLegend,
    required String secondLegend,
  }) {
    if (labels.isEmpty || (first.isEmpty && second.isEmpty)) {
      return _chartShell(title: title, child: _noChartData());
    }
    final maxY = [...first, ...second].fold<double>(0, (p, c) => c > p ? c : p);
    final yMax = maxY == 0 ? 100.0 : maxY * 1.2;
    return _chartShell(
      title: title,
      child: Column(
        children: [
          Row(
            children: [
              _legendDot(color: firstColor, label: firstLegend),
              const SizedBox(width: 14),
              _legendDot(color: secondColor, label: secondLegend),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: yMax,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => _tooltipBg,
                    tooltipRoundedRadius: 6,
                    getTooltipItems: (spots) => spots.map((spot) {
                      final type = spot.barIndex == 0 ? firstLegend : secondLegend;
                      return LineTooltipItem(
                        '$type\n${AppCurrencyFormatter.format(spot.y, decimals: 2)}',
                        AppFonts.interStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: yMax / 4,
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
                  rightTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 26,
                      interval: labels.length > 12 ? 2 : 1,
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
                        first.length, (i) => FlSpot(i.toDouble(), first[i])),
                    isCurved: true,
                    color: firstColor,
                    barWidth: 2.5,
                    dotData: const FlDotData(show: false),
                  ),
                  LineChartBarData(
                    spots: List.generate(
                        second.length, (i) => FlSpot(i.toDouble(), second[i])),
                    isCurved: true,
                    color: secondColor,
                    barWidth: 2.5,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Trend extraction ----------

  ({List<String> labels, List<double> first, List<double> second}) _extractTrend(
    Map<String, dynamic>? trend,
    String firstKey,
    String secondKey,
  ) {
    final t = trend ?? const <String, dynamic>{};
    List<String> labels;
    final dataList = safeMapList(t['data']);
    if (dataList.isNotEmpty) {
      labels = dataList
          .map((e) => safeText(e['period_label'], fallback: safeText(e['period'])))
          .toList();
      final first = dataList.map((e) => safeDouble(e[firstKey])).toList();
      final second = dataList.map((e) => safeDouble(e[secondKey])).toList();
      return (labels: labels, first: first, second: second);
    }
    labels = (t['labels'] is List)
        ? (t['labels'] as List).map((e) => e.toString()).toList()
        : <String>[];
    final first = (t[firstKey] is List)
        ? (t[firstKey] as List).map((e) => safeDouble(e)).toList()
        : <double>[];
    final second = (t[secondKey] is List)
        ? (t[secondKey] as List).map((e) => safeDouble(e)).toList()
        : <double>[];
    return (labels: labels, first: first, second: second);
  }

  // ---------- Build ----------

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatementReportCubit, StatementReportState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (response) => setState(() => _bundle = response),
          orElse: () {},
        );
      },
      builder: (context, state) {
        // API returns `total_in`/`total_out` for cash & bank trends, and
        // `total_cash`/`total_qr` for the daily trend. Keep the fallbacks in
        // _extractTrend's secondary keys for older shapes.
        final cashTrend = _extractTrend(_ctrend, 'total_in', 'total_out');
        final bankTrend = _extractTrend(_btrend, 'total_in', 'total_out');
        final dailyTrend = _extractTrend(_dtrend, 'total_cash', 'total_qr');

        final l10n = context.l10n;
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
              l10n.statementReport,
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
                                        l10n.reportOverview,
                                        trailing: Text(
                                          _periodLabel(),
                                          style: AppFonts.interStyle(
                                            fontSize: 11.5,
                                            color: _inkSoft,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      _overviewCards(),
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
                                                child: _trendChart(
                                                  title: l10n.reportCashInOut,
                                                  labels: cashTrend.labels,
                                                  first: cashTrend.first,
                                                  second: cashTrend.second,
                                                  firstColor: _positive,
                                                  secondColor: _negative,
                                                  firstLegend: l10n.reportCashIn,
                                                  secondLegend: l10n.reportCashOut,
                                                ),
                                              ),
                                              SizedBox(
                                                width: halfWidth,
                                                child: _trendChart(
                                                  title: l10n.reportBankReceiptsPayments,
                                                  labels: bankTrend.labels,
                                                  first: bankTrend.first,
                                                  second: bankTrend.second,
                                                  firstColor: _accent,
                                                  secondColor: const Color(0xFFF59E0B),
                                                  firstLegend: l10n.reportReceipts,
                                                  secondLegend: l10n.reportPayments,
                                                ),
                                              ),
                                              SizedBox(
                                                width: halfWidth,
                                                child: _trendChart(
                                                  title: l10n.reportDailyCashVsQr,
                                                  labels: dailyTrend.labels,
                                                  first: dailyTrend.first,
                                                  second: dailyTrend.second,
                                                  firstColor: _positive,
                                                  secondColor: const Color(0xFF7C3AED),
                                                  firstLegend: l10n.reportOverviewCash,
                                                  secondLegend: l10n.paymentQr,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      _sectionTitle(l10n.reportSummariesSection),
                                      if (_showsMonthlyOpeningBalances) ...[
                                        _monthlyOpeningBalanceCard(),
                                        const SizedBox(height: 12),
                                      ],
                                      LayoutBuilder(
                                        builder: (context, constraints) {
                                          final twoCols = constraints.maxWidth > 700;
                                          final halfWidth = twoCols
                                              ? (constraints.maxWidth - 12) / 2
                                              : constraints.maxWidth;
                                          return Wrap(
                                            spacing: 12,
                                            runSpacing: 12,
                                            children: [
                                              SizedBox(
                                                  width: halfWidth,
                                                  child: _summaryCard(l10n.reportCashSummary, _csum)),
                                              SizedBox(
                                                  width: halfWidth,
                                                  child: _summaryCard(l10n.reportBankSummary, _bsum)),
                                              SizedBox(
                                                  width: halfWidth,
                                                  child: _summaryCard(l10n.reportDailySummary, _dsum)),
                                            ],
                                          );
                                        },
                                      ),
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

class _OverviewItem {
  final String label;
  final double value;
  final Color color;
  final IconData icon;
  const _OverviewItem(this.label, this.value, this.color, this.icon);
}
