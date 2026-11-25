import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_report_response.dart';

const _shortColor = Color(0xFFDC2626);
const _overColor = Color(0xFF059669);
const _matchColor = Color(0xFFF59E0B);

void showReconciliationChartsSheet({
  required BuildContext context,
  required ReconciliationReportResponse data,
}) {
  showAppBottomSheet<void>(
    context: context,
    title: 'Summary charts',
    maxHeightFactor: 0.85,
    scrollableBody: true,
    child: ReconciliationChartsBody(data: data),
  );
}

/// Compact chart row for the reconciliation summary card.
class ReconciliationChartPreview extends StatelessWidget {
  const ReconciliationChartPreview({
    super.key,
    required this.summary,
  });

  final ReconciliationReportSummary summary;

  @override
  Widget build(BuildContext context) {
    final sections = _statusSections(summary);
    if (sections.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            height: 88,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 22,
                sections: sections
                    .map(
                      (s) => PieChartSectionData(
                        value: s.value,
                        color: s.color,
                        radius: 18,
                        showTitle: false,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final section in sections)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: _LegendRow(
                      color: section.color,
                      label: section.label,
                      value: section.value.toInt().toString(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReconciliationChartsBody extends StatelessWidget {
  const ReconciliationChartsBody({super.key, required this.data});

  final ReconciliationReportResponse data;

  @override
  Widget build(BuildContext context) {
    final summary = data.summary;
    final sections = _statusSections(summary);
    final topItems = _topVarianceItems(data.reconciliationDetails);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionTitle('Stock status'),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              for (final section in sections)
                _LegendRow(
                  color: section.color,
                  label: section.label,
                  value: section.value.toInt().toString(),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 48,
                  sections: sections
                      .map(
                        (s) => PieChartSectionData(
                          value: s.value,
                          color: s.color,
                          radius: 42,
                          title: s.value > 0 ? '${s.value.toInt()}' : '',
                          titleStyle: AppFonts.interStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _SectionTitle('Variance value ($currencySymbol)'),
          SizedBox(
            height: 180,
            child: _FinancialBarChart(
              shortValue: summary.totalShortValue.abs(),
              overValue: summary.totalOverValue.abs(),
            ),
          ),
          if (topItems.isNotEmpty) ...[
            const SizedBox(height: 20),
            _SectionTitle('Top items by variance'),
            SizedBox(
              height: 200,
              child: _ItemVarianceBarChart(items: topItems),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: AppFonts.interStyle(fontSize: 15, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.color,
    required this.label,
    required this.value,
  });

  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
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
          '$label ($value)',
          style: AppFonts.interStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _ChartSection {
  const _ChartSection({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;
}

List<_ChartSection> _statusSections(ReconciliationReportSummary summary) {
  final sections = <_ChartSection>[
    _ChartSection(
      label: 'Short',
      value: summary.shortStockItems.toDouble(),
      color: _shortColor,
    ),
    _ChartSection(
      label: 'Over',
      value: summary.overStockItems.toDouble(),
      color: _overColor,
    ),
    _ChartSection(
      label: 'Match',
      value: summary.matchingItems.toDouble(),
      color: _matchColor,
    ),
  ];
  return sections.where((s) => s.value > 0).toList();
}

List<ReconciliationReportDetail> _topVarianceItems(
  List<ReconciliationReportDetail> details,
) {
  final sorted = [...details]
    ..sort(
      (a, b) => b.varianceValue.abs().compareTo(a.varianceValue.abs()),
    );
  return sorted.take(5).toList();
}

class _FinancialBarChart extends StatelessWidget {
  const _FinancialBarChart({
    required this.shortValue,
    required this.overValue,
  });

  final double shortValue;
  final double overValue;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxY = [shortValue, overValue, 1.0].reduce((a, b) => a > b ? a : b) * 1.2;

    return BarChart(
      BarChartData(
        maxY: maxY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) => FlLine(
            color: scheme.outlineVariant.withValues(alpha: 0.5),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                final labels = ['Short', 'Over'];
                final i = value.toInt();
                if (i < 0 || i >= labels.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    labels[i],
                    style: AppFonts.interStyle(fontSize: 11, color: scheme.onSurfaceVariant),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: shortValue,
                width: 36,
                color: _shortColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: overValue,
                width: 36,
                color: _overColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemVarianceBarChart extends StatelessWidget {
  const _ItemVarianceBarChart({required this.items});

  final List<ReconciliationReportDetail> items;

  @override
  Widget build(BuildContext context) {
    final values = items.map((e) => e.varianceValue.abs()).toList();
    final maxY = values.fold<double>(0, (p, c) => c > p ? c : p);
    final yMax = maxY == 0 ? 1.0 : maxY * 1.2;
    final scheme = Theme.of(context).colorScheme;
    final primary = scheme.primary;

    return BarChart(
      BarChartData(
        maxY: yMax,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) => FlLine(
            color: scheme.outlineVariant.withValues(alpha: 0.5),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => scheme.inverseSurface,
            getTooltipItem: (group, _, rod, __) {
              final item = items[group.x];
              return BarTooltipItem(
                item.item,
                AppFonts.interStyle(
                  color: scheme.onInverseSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, _) {
                final i = value.toInt();
                if (i < 0 || i >= items.length) {
                  return const SizedBox.shrink();
                }
                final label = items[i].item;
                final short = label.length > 8 ? '${label.substring(0, 8)}…' : label;
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    short,
                    style: AppFonts.interStyle(fontSize: 9, color: scheme.onSurfaceVariant),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < items.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: values[i],
                  width: 20,
                  color: _statusColor(items[i].status, primary),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Color _statusColor(String status, Color fallback) {
    switch (status.toLowerCase()) {
      case 'short':
        return _shortColor;
      case 'over':
        return _overColor;
      case 'matching':
        return _matchColor;
      default:
        return fallback;
    }
  }
}
