import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/l10n/app_localizations_x.dart';
import 'package:hotel/src/core/helpers/utility.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_response_model.dart';
import 'package:hotel/src/features/dashboard/presentation/bloc/dashboard_summary_page_cubit.dart';
import 'package:hotel/src/features/dashboard/presentation/pages/statstics_tab.dart' show YearView;
import 'package:hotel/src/features/permission/data/models/response/user_permissions_response_model.dart';
import 'package:hotel/src/features/permission/presentation/cubit/user_permissions_cubit.dart';
import 'package:intl/intl.dart';
import 'package:hotel/constants.dart';

class RevenueDetailsPage extends StatelessWidget {
  const RevenueDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardSummaryPageCubit>()
        ..getDashboardSummaryPage(
          params: DashboardSummaryPageRequestParams(
            dailyMonth: DateFormat('yyyy-MM').format(DateTime.now()),
          ),
        ),
      child: const _RevenueDetailsView(),
    );
  }
}

class _RevenueDetailsView extends StatefulWidget {
  const _RevenueDetailsView();

  @override
  State<_RevenueDetailsView> createState() => _RevenueDetailsViewState();
}

class _RevenueDetailsViewState extends State<_RevenueDetailsView> {
  late DateTime _selectedMonth;

  static const Color _salesGreen = Color(0xFF059669);
  static const Color _purchaseRed = Color(0xFFDC2626);

  Color _shellColor(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerLowest;

  Color _cardColor(BuildContext context) => Theme.of(context).colorScheme.surface;

  Color _cardBorderColor(BuildContext context) =>
      Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5);

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month, 1);
  }

  String _formatRs(double amount) => '$currencySymbol ${Utility.formatIndianNumber(amount.ceil())}';

  String _formatRsCompact(double amount) {
    if (amount >= 100000) return '$currencySymbol ${(amount / 100000).toStringAsFixed(1)}L';
    if (amount >= 1000) return '$currencySymbol ${(amount / 1000).toStringAsFixed(1)}K';
    return '$currencySymbol ${amount.toStringAsFixed(0)}';
  }

  void _showMonthPicker() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        final scheme = Theme.of(dialogContext).colorScheme;
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 420),
            decoration: BoxDecoration(
              color: _cardColor(dialogContext),
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 12.w, 16.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.statisticsSelectMonth,
                              style: Theme.of(dialogContext)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              context.l10n.statisticsFilterChartsSubtitle,
                              style: Theme.of(dialogContext)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        icon: Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: scheme.outlineVariant.withValues(alpha: 0.5)),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: YearView(
                      selectedMonth: _selectedMonth,
                      monthLabels: context.l10n.shortMonthLabels,
                      onMonthChanged: (month) {
                        setState(() => _selectedMonth = month);
                        context.read<DashboardSummaryPageCubit>().getDashboardSummaryPage(
                              params: DashboardSummaryPageRequestParams(
                                dailyMonth: DateFormat('yyyy-MM').format(_selectedMonth),
                              ),
                            );
                        Navigator.of(dialogContext).pop();
                      },
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

  Future<void> _onRefresh() async {
    context.read<DashboardSummaryPageCubit>().getDashboardSummaryPage(
          params: DashboardSummaryPageRequestParams(
            dailyMonth: DateFormat('yyyy-MM').format(_selectedMonth),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final primary = scheme.primary;
    final isManager = context.isSupervisorOrManager;

    return Scaffold(
      backgroundColor: _shellColor(context),
      appBar: AppBar(
        leading: AppBarIosBackButton(color: scheme.onSurface),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: _shellColor(context),
        surfaceTintColor: Colors.transparent,
        title: Text(
          isManager
              ? context.l10n.statisticsRevenueDetails
              : context.l10n.statisticsEmployeeDetails,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            tooltip: context.l10n.statisticsChangeMonth,
            onPressed: _showMonthPicker,
            icon: Icon(Icons.calendar_month_outlined, color: primary),
          ),
        ],
      ),
      body: BlocBuilder<DashboardSummaryPageCubit, DashboardSummaryPageState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loading: () => Center(
              child: CircularProgressIndicator(color: primary),
            ),
            success: (responseData) {
              final data = responseData.data;
              return RefreshIndicator(
                color: primary,
                onRefresh: _onRefresh,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 28.h),
                  children: [
                    _buildMonthChip(theme),
                    const SizedBox(height: 16),
                    _buildChartCard(context, data),
                    if (isManager) ...[
                      const SizedBox(height: 16),
                      _buildNetSummaryCard(context, data),
                    ] else ...[
                      const SizedBox(height: 16),
                      _buildEmployeeOverview(context, data),
                    ],
                    const SizedBox(height: 20),
                    _buildDailyBreakdownSection(context, data),
                  ],
                ),
              );
            },
            error: (message) => _buildErrorState(message, primary),
          );
        },
      ),
    );
  }

  Widget _buildMonthChip(ThemeData theme) {
    final scheme = theme.colorScheme;
    final label = DateFormat('MMMM yyyy').format(_selectedMonth);
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: _cardColor(context),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: _showMonthPicker,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today_outlined, size: 16, color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.expand_more_rounded, size: 20, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _card({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: _cardColor(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorderColor(context)),
      ),
      child: child,
    );
  }

  Widget _buildChartCard(BuildContext context, DashboardSummaryPageResponseModel data) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isManager = context.isSupervisorOrManager;

    return _card(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isManager
                ? context.l10n.statisticsDailyTrend
                : context.l10n.statisticsDailyActivity,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: _buildDailyChart(context, data),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyChart(BuildContext context, DashboardSummaryPageResponseModel data) {
    final scheme = context.theme.colorScheme;
    final primary = scheme.primary;
    final dailySales = data.monthDailySales;
    final sortedEntries = dailySales.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

    if (sortedEntries.isEmpty) {
      return Center(
        child: Text(
          context.l10n.statisticsNoDataForMonth,
          style: AppFonts.interStyle(color: scheme.onSurfaceVariant, fontSize: 14),
        ),
      );
    }

    final labels = sortedEntries.map((e) => DateTime.parse(e.key).day.toString()).toList();
    final values = sortedEntries.map((e) => e.value).toList();
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final maxY = maxValue == 0 ? 1000.0 : maxValue * 1.15;

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxY,
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: labels.length > 12 ? 2 : 1,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= labels.length) return const SizedBox.shrink();
                return Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: Text(
                    labels[index],
                    style: AppFonts.interStyle(fontSize: 11, color: scheme.onSurfaceVariant),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY / 4,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: scheme.outlineVariant.withValues(alpha: 0.45), strokeWidth: 1),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => primary,
            tooltipRoundedRadius: 8,
            getTooltipItems: (spots) => spots.map((spot) {
              return LineTooltipItem(
                context.l10n.statisticsDayTooltip(
                  labels[spot.x.toInt()],
                  _formatRsCompact(spot.y),
                ),
                AppFonts.interStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
              );
            }).toList(),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(values.length, (i) => FlSpot(i.toDouble(), values[i])),
            isCurved: true,
            curveSmoothness: 0.3,
            barWidth: 2.5,
            color: primary,
            belowBarData: BarAreaData(
              show: true,
              color: primary.withValues(alpha: 0.12),
            ),
            dotData: FlDotData(
              show: values.length <= 10,
              getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                radius: 3,
                color: scheme.surface,
                strokeWidth: 2,
                strokeColor: primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetSummaryCard(BuildContext context, DashboardSummaryPageResponseModel data) {
    final primary = context.theme.colorScheme.primary;
    final revenue = data.monthRevenueOverviewAmount;
    final expenses = data.monthExpenseOverviewAmount;
    final unpaidRevenue = data.monthUnpaidSales;
    final unpaidExpenses = data.monthUnpaidPurchase;
    final netProfit = revenue - expenses;
    final profitMargin = revenue > 0 ? (netProfit / revenue * 100) : 0.0;
    final outstanding = unpaidRevenue + unpaidExpenses;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primary,
            Color.lerp(primary, const Color(0xFF0D9488), 0.45) ?? primary,
          ],
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _summaryColumn(
                context.l10n.statisticsNetProfit,
                _formatRs(netProfit),
                context.l10n.statisticsProfitMargin(
                  profitMargin.toStringAsFixed(1),
                ),
              ),
            ),
            Container(
              width: 1,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              color: Colors.white.withValues(alpha: 0.25),
            ),
            Expanded(
              child: _summaryColumn(
                context.l10n.unpaid,
                _formatRs(outstanding),
                context.l10n.statisticsMonthReceivables,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryColumn(String title, String value, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.interStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.85),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppFonts.interStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: AppFonts.interStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.75)),
        ),
      ],
    );
  }

  Widget _buildEmployeeOverview(BuildContext context, DashboardSummaryPageResponseModel data) {
    return BlocBuilder<UserPermissionsCubit, UserPermissionsState>(
      builder: (context, permState) {
        final canRevenue = permState is UserPermissionsSuccess &&
            permState.data.hasFeaturePermission(PermissionApiKeys.monthRevenue, PermissionApiKeys.read);
        final canExpenses = permState is UserPermissionsSuccess &&
            permState.data.hasFeaturePermission(PermissionApiKeys.monthExpenses, PermissionApiKeys.read);

        if (!canRevenue && !canExpenses) return const SizedBox.shrink();

        return Row(
          children: [
            if (canRevenue)
              Expanded(
                child: _statTile(
                  context.l10n.statisticsMonthRevenueTitle(
                    data.monthRevenueOverviewTitle,
                  ),
                  _formatRs(data.monthRevenueOverviewAmount),
                  _salesGreen,
                  Icons.trending_up_rounded,
                ),
              ),
            if (canRevenue && canExpenses) const SizedBox(width: 12),
            if (canExpenses)
              Expanded(
                child: _statTile(
                  context.l10n.statisticsMonthExpenseTitle(
                    data.monthExpenseOverviewTitle,
                  ),
                  _formatRs(data.monthExpenseOverviewAmount),
                  _purchaseRed,
                  Icons.trending_down_rounded,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _statTile(String title, String value, Color accent, IconData icon) {
    final scheme = Theme.of(context).colorScheme;
    return _card(
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: accent),
          const SizedBox(height: 10),
          Text(title, style: AppFonts.interStyle(fontSize: 12, color: scheme.onSurfaceVariant)),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppFonts.interStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyBreakdownSection(BuildContext context, DashboardSummaryPageResponseModel data) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isManager = context.isSupervisorOrManager;
    final dailySales = data.monthDailySales;
    final dailyPurchase = data.monthDailyPurchase;

    final allDates = <String>{...dailySales.keys, ...dailyPurchase.keys}.toList()..sort();

    if (allDates.isEmpty) {
      return _card(
        child: Text(
          context.l10n.statisticsNoDailyEntries,
          style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isManager
              ? context.l10n.statisticsDailySalesBreakdown
              : context.l10n.statisticsDailyBreakdown,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        ...allDates.map((dateStr) {
          final date = DateTime.parse(dateStr);
          final sales = dailySales[dateStr] ?? 0.0;
          final purchase = dailyPurchase[dateStr] ?? 0.0;
          final profit = sales - purchase;
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: _buildDayCard(
              context,
              date: date,
              sales: sales,
              purchase: purchase,
              profit: profit,
              isManager: isManager,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDayCard(
    BuildContext context, {
    required DateTime date,
    required double sales,
    required double purchase,
    required double profit,
    required bool isManager,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final hasActivity = sales > 0 || purchase > 0;
    final profitColor = profit >= 0 ? _salesGreen : _purchaseRed;

    return _card(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  DateFormat('d/M/yyyy').format(date),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: hasActivity ? scheme.onSurface : scheme.onSurfaceVariant,
                  ),
                ),
              ),
              Text(
                _formatRs(profit),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: profitColor,
                ),
              ),
            ],
          ),
          if (hasActivity) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _dayMetric(
                    isManager ? context.l10n.sales : context.l10n.unpaid,
                    _formatRs(sales),
                    _salesGreen,
                  ),
                ),
                Expanded(
                  child: _dayMetric(
                    isManager ? context.l10n.purchase : context.l10n.statisticsAdvance,
                    _formatRs(purchase),
                    _purchaseRed,
                    alignEnd: true,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _dayMetric(String label, String value, Color color, {bool alignEnd = false}) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFonts.interStyle(fontSize: 12, color: scheme.onSurfaceVariant)),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppFonts.interStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message, Color primary) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off_outlined, size: 48, color: scheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              context.l10n.statisticsCouldNotLoadData,
              style: AppFonts.interStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppFonts.interStyle(color: scheme.onSurfaceVariant, fontSize: 14),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _onRefresh,
              icon: Icon(Icons.refresh_rounded, size: 20),
              label: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
