import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/constants/month_api_keys.dart';
import 'package:hotel/src/core/l10n/app_localizations_x.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/currency/app_currency_service.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/helpers/utility.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/themes/app_text_styles.dart';
import 'package:hotel/src/core/themes/themes.dart';
import 'package:hotel/src/core/widget/notched_bottom_nav_bar.dart';
import 'package:hotel/src/core/widget/scaffold_wrapper.dart';
import 'package:hotel/src/core/widget/tab_error_view.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_response_model.dart';
import 'package:hotel/src/features/dashboard/presentation/bloc/dashboard_summary_page_cubit.dart';
import 'package:hotel/src/features/dashboard/presentation/main_shell_tab_index.dart';
import 'package:hotel/src/features/dashboard/presentation/pages/operation_management_page.dart';
import 'package:hotel/src/features/dashboard/presentation/pages/reports_hub_page.dart';
import 'package:hotel/src/features/dashboard/presentation/pages/revenue_details_page.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/business_quick_access.dart';
import 'package:hotel/src/features/dashboard/presentation/widgets/dashboard_favorites_strip.dart';
import 'package:hotel/src/features/employee_management/presentation/bloc/employee_cubit.dart';
import 'package:hotel/src/features/hotel_summary/presentation/cubit/daily_cash_summary_cubit.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/presentation/pages/login/party_invoice_page.dart';
import 'package:intl/intl.dart';

/// [EmployeeCubit] was left in `loaded` (e.g. after another flow called [EmployeeCubit.getEmployees] on the
/// app-wide cubit). Home only renders on [EmployeeState.employeeDetail]; this one-shot refetch restores it.
class _RefetchProfileForDashboard extends StatefulWidget {
  const _RefetchProfileForDashboard();

  @override
  State<_RefetchProfileForDashboard> createState() =>
      _RefetchProfileForDashboardState();
}

class _RefetchProfileForDashboardState
    extends State<_RefetchProfileForDashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refetch());
  }

  Future<void> _refetch() async {
    if (!mounted) return;
    final userId = await SessionHelper.getUserId();
    if (!mounted || userId == null || userId.trim().isEmpty) return;
    context.read<EmployeeCubit>().getEmployeeById(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class StatisticsTab extends StatelessWidget {
  const StatisticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardSummaryPageCubit>()
        ..getDashboardSummaryPage(
          params: DashboardSummaryPageRequestParams(),
        ),
      child: const _StatisticsTabView(),
    );
  }
}

class _StatisticsTabView extends StatefulWidget {
  const _StatisticsTabView();

  @override
  State<_StatisticsTabView> createState() => _StatisticsTabViewState();
}

class _StatisticsTabViewState extends State<_StatisticsTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String _selectedPeriod = 'Month';
  late DateTime _selectedMonth;
  bool _showAmounts = false; // Initially hide amounts
  String _cashflowRange =
      'Daily'; // 'Daily' = Last 7 Days, 'Monthly' = Last 12 Months
  int? _touchedBarGroupIndex; // for bar chart tooltip

  @override
  void initState() {
    super.initState();
    // Set selected month to current month
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month, 1);
  }

  String _getGreeting(BuildContext context) {
    return context.l10n.statisticsGreetingForHour(DateTime.now().hour);
  }

  String _formatIndianMoney(num value) => context.l10n.formatCurrency(
        '$currencySymbol ${Utility.formatIndianNumber(value.ceil())}',
      );

  String _formatIndianAmountDigits(num value) =>
      context.l10n.formatCurrency(Utility.formatIndianNumber(value.ceil()));

  Widget _buildIndianMoneyAmount(num value) {
    final scheme = context.theme.colorScheme;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$currencySymbol ',
            style: AppFonts.interStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: scheme.onSurfaceVariant,
            ),
          ),
          TextSpan(
            text: _formatIndianAmountDigits(value),
            style: AppFonts.interStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  String _compactAmountLabel(double amount) {
    final safeAmount = amount;
    if (safeAmount >= 100000) {
      return '$currencySymbol ${(safeAmount / 100000).toStringAsFixed(1)}L';
    }
    if (safeAmount >= 1000) {
      return '$currencySymbol ${(safeAmount / 1000).toStringAsFixed(1)}K';
    }
    return '$currencySymbol ${safeAmount.toStringAsFixed(0)}';
  }

  String _formatCompactMoney(double amount) =>
      context.l10n.formatCurrency(_compactAmountLabel(amount));

  String _localizedL10n(String message) =>
      context.l10n.localizeMessage(message);

  String _employeeFirstName(String? fullName, {required String fallback}) {
    final parts = fullName?.trim().split(RegExp(r'\s+')) ?? const <String>[];
    if (parts.isEmpty || parts.first.isEmpty) return fallback;
    return parts.first;
  }

  String formatDateTime(String isoString) {
    // Parse the ISO string
    DateTime dateTime = DateTime.parse(isoString);

    // Create the formatter for "Jan 17 - 10:19 PM"
    DateFormat formatter = DateFormat('MMM dd - h:mm a');

    return formatter.format(dateTime);
  }

  double getCurrentDaySales(Map<String, dynamic> monthDailySales) {
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    double todaySales = (monthDailySales[currentDate] ?? 0.0).toDouble();
    return todaySales;
  }

  // Filter daily sales for selected month
  Map<String, double> getFilteredDailySales(Map<String, double> allDailySales) {
    final Map<String, double> filteredSales = {};
    final selectedYear = _selectedMonth.year;
    final selectedMonthNum = _selectedMonth.month;

    allDailySales.forEach((dateString, sales) {
      final date = DateTime.parse(dateString);
      if (date.year == selectedYear && date.month == selectedMonthNum) {
        filteredSales[dateString] = sales;
      }
    });

    return filteredSales;
  }

  // Calculate month sales from daily sales for selected month
  double getSelectedMonthSales(Map<String, double> allDailySales) {
    final filteredSales = getFilteredDailySales(allDailySales);
    return filteredSales.values.fold(0.0, (sum, sales) => sum + sales);
  }

  Future<void> _onRefresh() async {
    // Refresh dashboard summary data
    context.read<DashboardSummaryPageCubit>().getDashboardSummaryPage(
          params: DashboardSummaryPageRequestParams(
            dailyMonth: DateFormat('yyyy-MM').format(_selectedMonth),
          ),
        );

    // Wait a bit to ensure the refresh indicator shows
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _retryEmployeeProfile() async {
    final userId = await SessionHelper.getUserId();
    if (!mounted || userId == null || userId.trim().isEmpty) return;
    context.read<EmployeeCubit>().getEmployeeById(userId);
  }

  Widget _buildGreetingHeader({bool isTablet = false}) {
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (context, state) {
        return state.maybeWhen(
          employeeDetail: (employee) => Align(
            alignment: Alignment.centerLeft,
            child: Text(
              context.l10n.statisticsGreeting(
                _getGreeting(context),
                _employeeFirstName(
                  employee.fullName,
                  fallback: context.l10n.statisticsDefaultUser,
                ),
              ),
              style: context.theme.textTheme.titleLarge?.copyWith(
                fontSize: isTablet ? 26 : null,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildTabletQuickOperationsCard() {
    final scheme = context.theme.colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: _buildQuickOperationsGrid(),
    );
  }

  Widget _buildTabletLandscapeMonthContent(
    DashboardSummaryPageResponseModel data,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildGreetingHeader(isTablet: true),
        const SizedBox(height: 20),
        _buildOverviewCards(data),
        const SizedBox(height: 20),
        _buildTabletQuickOperationsCard(),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: _buildCashflowSection(data),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: BusinessDashboard(
                embedded: true,
                tabletItemsPerRow: 3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const DashboardFavoritesStrip(),
      ],
    );
  }

  Widget _buildTabletPortraitMonthContent(
    DashboardSummaryPageResponseModel data,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildGreetingHeader(isTablet: true),
        const SizedBox(height: 20),
        _buildOverviewCards(data),
        const SizedBox(height: 20),
        _buildTabletQuickOperationsCard(),
        const SizedBox(height: 20),
        _buildCashflowSection(data),
        const SizedBox(height: 20),
        const DashboardFavoritesStrip(),
        const SizedBox(height: 4),
        const BusinessDashboard(),
      ],
    );
  }

  IconData _getGreetingIcon() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return Icons.wb_sunny;
    } else if (hour < 17) {
      return Icons.wb_sunny_outlined;
    } else {
      return Icons.nights_stay;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final currencyService = getIt<AppCurrencyService>();
    return ListenableBuilder(
      listenable: currencyService,
      builder: (context, _) {
        return MultiBlocListener(
          listeners: [
            BlocListener<DailyCashSummaryCubit, DailyCashSummaryState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () => null,
                  error: (message) {
                    AppLoadingOverlay.of(context).hide();
                    context.showKiiSnackBarSuccess(message);
                  },
                  summariesLoaded: (response) {
                    AppLoadingOverlay.of(context).hide();
                    context.router.push(OpeningAmountRoute(response: response));
                  },
                  loading: () {
                    AppLoadingOverlay.of(context).show();
                  },
                );
              },
            ),
          ],
          child: BlocBuilder<EmployeeCubit, EmployeeState>(
            builder: (context, employeeState) {
              // Check if employee data is available
              return employeeState.maybeWhen(
                loading: () => _buildLoadingState(),
                noInternet: () => _buildErrorState(
                  context.l10n.statisticsCheckConnection,
                  title: context.l10n.noInternetConnection.replaceAll('.', ''),
                  isNoInternet: true,
                  onRetry: _retryEmployeeProfile,
                ),
                error: (message) => _buildErrorState(
                  message,
                  title: context.l10n.statisticsCouldNotLoadProfile,
                  onRetry: _retryEmployeeProfile,
                ),
                employeeDetail: (employee) {
                  // Employee data is available, now load dashboard
                  return BlocBuilder<DashboardSummaryPageCubit,
                      DashboardSummaryPageState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () => ScaffoldWrapper(body: Container()),
                        loading: () => _buildLoadingState(),
                        success: (responseData) {
                          final isTablet = DeviceLayout.isTablet(context);
                          final edgePadding = isTablet
                              ? 32.0
                              : context.theme.appTheme.spacing16;

                          return RefreshIndicator(
                            onRefresh: _onRefresh,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.only(
                                bottom: NotchedBottomNavBar
                                    .homeTabScrollBottomPadding(
                                  context,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  edgePadding,
                                  isTablet ? 20 : edgePadding,
                                  edgePadding,
                                  0,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    _buildContentForSelectedPeriod(
                                      responseData.data,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        error: (message) => _buildErrorState(message),
                      );
                    },
                  );
                },
                loaded: (_) => const _RefetchProfileForDashboard(),
                submitSuccess: (_) => const _RefetchProfileForDashboard(),
                orElse: () => _buildLoadingState(),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Container(
      color: context.theme.colorScheme.surfaceContainerLow,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(
    String message, {
    String? title,
    VoidCallback? onRetry,
    bool isNoInternet = false,
  }) {
    return TabErrorView(
      title: title ?? context.l10n.statisticsCouldNotLoadData,
      message: message,
      onRetry: onRetry ?? _onRefresh,
      isNoInternet: isNoInternet,
    );
  }

  Widget _buildPeriodButton(String period) {
    final scheme = context.theme.colorScheme;
    bool isSelected = _selectedPeriod == period;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPeriod = period),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? scheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              context.l10n.statisticsPeriodLabel(period),
              style: AppFonts.interStyle(
                color: isSelected ? scheme.onPrimary : scheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget lastUpdated() {
  //   return GestureDetector(
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //           colors: [
  //             Colors.blue.shade50,
  //             Colors.indigo.shade50,
  //           ],
  //         ),
  //         borderRadius: BorderRadius.circular(12),
  //         border: Border.all(
  //           color: Colors.blue.shade100,
  //           width: 1.5,
  //         ),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.blue.withOpacity(0.1),
  //             blurRadius: 12,
  //             offset: const Offset(0, 4),
  //             spreadRadius: 0,
  //           ),
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.03),
  //             blurRadius: 6,
  //             offset: const Offset(0, 2),
  //             spreadRadius: 0,
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.all(6),
  //             decoration: BoxDecoration(
  //               color: Colors.blue.shade100,
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: Icon(
  //               FontAwesomeIcons.calendar,
  //               color: Colors.blue.shade700,
  //               size: 16,
  //             ),
  //           ),
  //           const SizedBox(width: 12),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   'Last Updated',
  //                   style: AppFonts.interStyle(
  //                     fontSize: 11,
  //                     fontWeight: FontWeight.w500,
  //                     color: Colors.grey.shade600,
  //                     letterSpacing: 0.5,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 1),
  //                 Text(
  //                   DateFormat('MMMM yyyy').format(_selectedMonth),
  //                   style: AppFonts.interStyle(
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.w600,
  //                     color: Colors.blue.shade800,
  //                     letterSpacing: 0.2,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 2),
  //                 Text(
  //                   DateFormat('MMM dd, yyyy • hh:mm a').format(DateTime.now()),
  //                   style: AppFonts.interStyle(
  //                     fontSize: 10,
  //                     fontWeight: FontWeight.w400,
  //                     color: Colors.grey.shade500,
  //                     letterSpacing: 0.3,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             padding: const EdgeInsets.all(4),
  //             decoration: BoxDecoration(
  //               color: Colors.white.withOpacity(0.8),
  //               borderRadius: BorderRadius.circular(6),
  //             ),
  //             child: Icon(
  //               Icons.refresh,
  //               color: context.theme.colorScheme.primary,
  //               size: 16,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildMonthSelector() {
    return GestureDetector(
      onTap: _showMonthPicker,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade50,
              Colors.pink.shade50,
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.purple.shade100,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.date_range_outlined,
                color: Colors.purple.shade700,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.statisticsSelectedPeriod,
                    style: AppFonts.interStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    DateFormat('MMMM yyyy').format(_selectedMonth),
                    style: AppFonts.interStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.purple.shade800,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.purple.shade200,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.expand_more_rounded,
                color: Colors.purple.shade600,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMonthPicker() {
    final scheme = context.theme.colorScheme;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: double.maxFinite,
            height: 420,
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: scheme.shadow.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header with gradient
                Container(
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.statisticsSelectMonth,
                              style: AppFonts.interStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              context.l10n.statisticsSelectMonthSubtitle,
                              style: AppFonts.interStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(dialogContext).pop(),
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: YearView(
                      selectedMonth: _selectedMonth,
                      monthLabels: context.l10n.shortMonthLabels,
                      onMonthChanged: (DateTime month) {
                        setState(() {
                          _selectedMonth = month;
                        });
                        context
                            .read<DashboardSummaryPageCubit>()
                            .getDashboardSummaryPage(
                                params: DashboardSummaryPageRequestParams(
                                    dailyMonth: DateFormat('yyyy-MM')
                                        .format(_selectedMonth)));
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

  Widget _buildContentForSelectedPeriod(
      DashboardSummaryPageResponseModel data) {
    switch (_selectedPeriod) {
      case 'Day':
        return PartyInvoicePage(date: DateTime.now(), showScaffold: false);
      case 'Month':
        return _buildMonthContent(data);
      case 'Year':
        return _buildYearContent(data);
      default:
        return _buildMonthContent(data);
    }
  }

  Widget _buildQuickOperationsGrid() {
    return BusinessMenuGrid(
      title: context.l10n.statisticsQuickOperations,
      seeAllLabel: context.l10n.statisticsQuickOperationsSeeAll,
      onSeeAll: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const OperationManagementPage(),
          ),
        );
      },
      items: [
        BusinessMenuItems.quickSales(
          label: context.l10n.sales,
          onTap: () {
            context.router.push(
              QuickAddItemsRoute(
                invoiceType: InvoiceType.sales,
                fromQuickSales: true,
              ),
            );
          },
        ),
        BusinessMenuItems.quickExpense(
          label: context.l10n.expense,
          onTap: () {
            context.router.push(
              QuickAddItemsRoute(
                invoiceType: InvoiceType.purchase,
                fromQuickSales: true,
              ),
            );
          },
        ),
        BusinessMenuItems.quickInvoice(
          label: context.l10n.statisticsQuickOperationInvoice,
          onTap: () => currentIndex.value = 1,
        ),
        BusinessMenuItems.quickReports(
          label: context.l10n.statisticsQuickOperationReports,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const ReportsHubPage(),
              ),
            );
          },
        ),
      ],
      itemsPerRow: 4,
      distributeEvenly: true,
    );
  }

  Widget _buildMonthContent(DashboardSummaryPageResponseModel data) {
    final isTablet = DeviceLayout.isTablet(context);

    if (isTablet && DeviceLayout.isLandscape(context)) {
      return _buildTabletLandscapeMonthContent(data);
    }

    if (isTablet) {
      return _buildTabletPortraitMonthContent(data);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildGreetingHeader(),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildOverviewCards(data),
            verticalMarginLarge,
            _buildQuickOperationsGrid(),
            verticalMarginLarge,
            _buildCashflowSection(data),
          ],
        ),
        verticalMarginMedium,
        const DashboardFavoritesStrip(),
        const BusinessDashboard(),
      ],
    );
  }

  Widget _buildYearContent(DashboardSummaryPageResponseModel data) {
    return Column(
      children: [
        _buildRevenueCard(
          title: context.l10n.statisticsAnnualRevenue,
          amount: data.yearSalesSales.ceil(),
          color: Colors.green.shade600,
        ),
        const SizedBox(height: 20),
        _buildCashflowSection(data),
        const SizedBox(height: 20),
        _buildSummaryCards(data),
      ],
    );
  }

  Widget _buildRevenueCard({
    required String title,
    required int amount,
    double? todayAmount,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppFonts.interStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  if (todayAmount != null)
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Text(
                        _showAmounts
                            ? '- $currencySymbol ${Utility.formatIndianNumber(todayAmount.ceil())}'
                            : '- $currencySymbol ****',
                        style: AppFonts.interStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  // Show/Hide Amounts Toggle Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showAmounts = !_showAmounts;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _showAmounts ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            _showAmounts
                ? '$currencySymbol ${Utility.formatIndianNumber(amount)}'
                : '$currencySymbol ****',
            style: AppFonts.interStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ).padAll(20),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required double value,
    required IconData icon,
    required Color color,
    required String subtitle,
  }) {
    final scheme = context.theme.colorScheme;
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalMarginSmall,
              Text(
                title,
                style: AppFonts.interStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              _buildIndianMoneyAmount(value),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCards(DashboardSummaryPageResponseModel data) {
    final revenue = data.monthRevenueOverviewAmount;
    final expenses = data.monthExpenseOverviewAmount;
    final unpaidRevenue = data.monthUnpaidSales;
    final unpaidExpenses = data.monthUnpaidPurchase;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildMetricCard(
              title: context.l10n
                  .statisticsMonthRevenueTitle(data.monthRevenueOverviewTitle),
              value: revenue,
              icon: Icons.trending_up,
              color: const Color(0xFF10B981),
              subtitle: _localizedL10n(
                context.l10n.statisticsMetricCollected(
                  _formatCompactMoney(revenue - unpaidRevenue),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildMetricCard(
              title: context.l10n
                  .statisticsMonthExpenseTitle(data.monthExpenseOverviewTitle),
              value: expenses,
              icon: Icons.trending_down,
              color: const Color(0xFFEF4444),
              subtitle: _localizedL10n(
                context.l10n.statisticsMetricPaid(
                  _formatCompactMoney(expenses - unpaidExpenses),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required List<double> amounts,
    required List<String> labels,
    bool isScrollable = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.theme.textTheme.titleLarge,
        ),
        verticalMarginMedium,
        _buildChart(amounts, labels, isScrollable: isScrollable),
      ],
    );
  }

  /// Cashflow section: Daily (bar, last 7 days) or Monthly (line, last 12 months).
  /// Money In = green, Money Out = red; tooltip and summary below.
  Widget _buildCashflowSection(DashboardSummaryPageResponseModel data) {
    final scheme = context.theme.colorScheme;
    final isDaily = _cashflowRange == 'Daily';
    final periodLabel = isDaily
        ? context.l10n.statisticsLast7Days
        : context.l10n.statisticsLast12Months;

    // Daily: last 7 days ending today (so user sees e.g. Feb 3–9, not end-of-month)
    List<String> dayLabels = [];
    List<double> moneyInDaily = [];
    List<double> moneyOutDaily = [];
    if (isDaily) {
      final now = DateTime.now();
      final last7Dates =
          List.generate(7, (i) => now.subtract(Duration(days: 6 - i)));
      for (final dt in last7Dates) {
        final dateStr = DateFormat('yyyy-MM-dd').format(dt);
        dayLabels.add(DateFormat('MMM d').format(dt));
        moneyInDaily.add((data.monthDailySales[dateStr] ?? 0).toDouble());
        moneyOutDaily.add((data.monthDailyPurchase[dateStr] ?? 0).toDouble());
      }
    }

    // Monthly: 12 months from year
    final monthLabels = context.l10n.shortMonthLabels;
    final moneyInMonthly =
        MonthApiKeys.all.map((m) => data.yearAllSales[m] ?? 0.0).toList();
    // Distribute year purchase across months: proportional to sales when possible, else equal split
    final totalYearSales = moneyInMonthly.fold<double>(0, (a, b) => a + b);
    final moneyOutMonthly = totalYearSales > 0
        ? moneyInMonthly
            .map((sales) => (data.yearsPurchase * sales / totalYearSales))
            .toList()
        : List.filled(12, data.yearsPurchase / 12);

    // Totals: Daily = throughout the month; Monthly = throughout the year
    final totalMoneyIn = isDaily ? data.monthSales : data.yearSalesSales;
    final totalMoneyOut = isDaily ? data.monthPurchase : data.yearsPurchase;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => setState(() => _touchedBarGroupIndex = null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: context.theme.textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: context.l10n.statisticsCashflow,
                        style: AppFonts.interStyle(
                          fontWeight: FontWeight.w500,
                          color: scheme.onSurface,
                        ),
                      ),
                      TextSpan(
                        text: ' · $periodLabel',
                        style: AppFonts.interStyle(
                          fontWeight: FontWeight.w400,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  final theme = Theme.of(context);
                  final primary = theme.colorScheme.primary;
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (sheetContext) => SafeArea(
                      child: Container(
                        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 24.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.l10n.statisticsCashflow,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              verticalMarginSmall,
                              const Divider(),
                              verticalMarginMedium,
                              if (context.isSupervisorOrManager) ...[
                                _CashflowRangeTile(
                                  icon: Icons.calendar_view_week_rounded,
                                  title: context.l10n.statisticsDaily,
                                  subtitle: context.l10n.statisticsLast7Days,
                                  selected: _cashflowRange == 'Daily',
                                  color: primary,
                                  onTap: () {
                                    Navigator.pop(sheetContext);
                                    setState(() => _cashflowRange = 'Daily');
                                  },
                                ),
                                verticalMarginLarge,
                                _CashflowRangeTile(
                                  icon: Icons.calendar_month_rounded,
                                  title: context.l10n.statisticsMonthly,
                                  subtitle: context.l10n.statisticsLast12Months,
                                  selected: _cashflowRange == 'Monthly',
                                  color: primary,
                                  onTap: () {
                                    Navigator.pop(sheetContext);
                                    setState(() => _cashflowRange = 'Monthly');
                                  },
                                ),
                                verticalMarginLarge,
                              ],
                              _CashflowRangeTile(
                                icon: Icons.insights_rounded,
                                title: context.l10n.statisticsOverall,
                                subtitle: context.l10n.statisticsAllYears,
                                selected: false,
                                color: primary,
                                onTap: () {
                                  Navigator.pop(sheetContext);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const RevenueDetailsPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.l10n
                            .statisticsCashflowRangeLabel(_cashflowRange),
                        style: AppFonts.interStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: scheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          verticalMarginMedium,
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: scheme.outlineVariant.withValues(alpha: 0.45)),
              boxShadow: [
                BoxShadow(
                  color: scheme.shadow.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _buildCashflowBarChart(
              labels: isDaily ? dayLabels : monthLabels,
              moneyIn: isDaily ? moneyInDaily : moneyInMonthly,
              moneyOut: isDaily ? moneyOutDaily : moneyOutMonthly,
            ),
          ),
          // const SizedBox(height: 16),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Row(
          //         children: [
          //           Container(
          //             width: 10,
          //             height: 10,
          //             decoration: const BoxDecoration(
          //               color: Colors.green,
          //               shape: BoxShape.circle,
          //             ),
          //           ),
          //           const SizedBox(width: 8),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'Total Money In',
          //                 style: AppFonts.interStyle(
          //                   fontSize: 12,
          //                   color: Colors.grey.shade600,
          //                 ),
          //               ),
          //               Text(
          //                 _showAmounts ? 'Rs. ${Utility.formatIndianNumber(totalMoneyIn.ceil())}' : 'Rs. ****',
          //                 style: AppFonts.interStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w700,
          //                   color: Colors.green,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Expanded(
          //       child: Row(
          //         children: [
          //           Container(
          //             width: 10,
          //             height: 10,
          //             decoration: const BoxDecoration(
          //               color: Colors.red,
          //               shape: BoxShape.circle,
          //             ),
          //           ),
          //           const SizedBox(width: 8),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'Total Money Out',
          //                 style: AppFonts.interStyle(
          //                   fontSize: 12,
          //                   color: Colors.grey.shade600,
          //                 ),
          //               ),
          //               Text(
          //                 _showAmounts ? 'Rs. ${Utility.formatIndianNumber(totalMoneyOut.ceil())}' : 'Rs. ****',
          //                 style: AppFonts.interStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w700,
          //                   color: Colors.red,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildCashflowBarChart({
    required List<String> labels,
    required List<double> moneyIn,
    required List<double> moneyOut,
  }) {
    final scheme = context.theme.colorScheme;
    final axisLabelColor = scheme.onSurfaceVariant;
    final gridColor = scheme.outlineVariant.withValues(alpha: 0.45);
    final tooltipBg = scheme.brightness == Brightness.dark
        ? scheme.surfaceContainerHigh
        : scheme.surfaceContainerHighest;
    final tooltipTitleStyle = AppFonts.interStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: scheme.onSurface,
    );
    final tooltipBodyStyle = AppFonts.interStyle(
      fontSize: 12,
      color: scheme.onSurfaceVariant,
    );
    if (labels.isEmpty) {
      return SizedBox(
        height: 180,
        child: Center(child: Text(context.l10n.statisticsNoDataAvailable)),
      );
    }
    final maxVal = [
      moneyIn.isEmpty ? 0.0 : moneyIn.reduce((a, b) => a > b ? a : b),
      moneyOut.isEmpty ? 0.0 : moneyOut.reduce((a, b) => a > b ? a : b),
    ].reduce((a, b) => a > b ? a : b);
    final maxY = maxVal == 0 ? 100.0 : (maxVal * 1.2);

    return SizedBox(
      height: DeviceLayout.isTablet(context)
          ? (DeviceLayout.isLandscape(context) ? 300 : 260)
          : 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          minY: 0,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => tooltipBg,
              tooltipRoundedRadius: 8,
              tooltipMargin: 8,
              maxContentWidth: 260,
              tooltipBorder: BorderSide(
                  color: scheme.outlineVariant.withValues(alpha: 0.6)),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                // Show only one tooltip per group (not one per bar)
                if (rodIndex != 0) return null;
                final i = group.x.toInt();
                if (i < 0 || i >= labels.length) return null;
                final inVal = i < moneyIn.length ? moneyIn[i] : 0.0;
                final outVal = i < moneyOut.length ? moneyOut[i] : 0.0;
                return BarTooltipItem(
                  '${labels[i]}\n',
                  tooltipTitleStyle,
                  children: [
                    TextSpan(
                      text:
                          '${context.l10n.statisticsMoneyInAmount('$currencySymbol ${Utility.formatIndianNumber(inVal.ceil())}')}\n',
                      style: tooltipBodyStyle.copyWith(
                          color: Colors.green.shade600),
                    ),
                    TextSpan(
                      text: context.l10n.statisticsMoneyOutAmount(
                        '$currencySymbol ${Utility.formatIndianNumber(outVal.ceil())}',
                      ),
                      style:
                          tooltipBodyStyle.copyWith(color: Colors.red.shade600),
                    ),
                  ],
                  textAlign: TextAlign.start,
                );
              },
            ),
            touchCallback: (event, response) {
              setState(() {
                if (response?.spot != null) {
                  _touchedBarGroupIndex = response!.spot!.touchedBarGroupIndex;
                } else {
                  _touchedBarGroupIndex = null;
                }
              });
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: maxY / 5,
                getTitlesWidget: (v, meta) {
                  final n = v.toDouble();
                  final str = n >= 1000
                      ? '${(n / 1000).toStringAsFixed(1)}k'
                      : n.toInt().toString();
                  return Text(
                    str,
                    style: AppFonts.interStyle(
                        fontSize: 10, color: axisLabelColor),
                  );
                },
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
                getTitlesWidget: (v, meta) {
                  final i = v.toInt();
                  return i >= 0 && i < labels.length
                      ? Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            labels[i],
                            style: AppFonts.interStyle(
                                fontSize: 10, color: axisLabelColor),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY / 5,
            getDrawingHorizontalLine: (v) =>
                FlLine(color: gridColor, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(
            labels.length,
            (i) => BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: (i < moneyIn.length ? moneyIn[i] : 0.0),
                  color: Colors.green,
                  width: 8,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(4)),
                ),
                BarChartRodData(
                  toY: (i < moneyOut.length ? moneyOut[i] : 0.0),
                  color: Colors.red,
                  width: 8,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
              showingTooltipIndicators: _touchedBarGroupIndex == i ? [0] : [],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCashflowLineChart({
    required List<String> labels,
    required List<double> moneyIn,
    required List<double> moneyOut,
  }) {
    if (labels.isEmpty) return const SizedBox(height: 180);

    final scheme = context.theme.colorScheme;
    final axisLabelColor = scheme.onSurfaceVariant;
    final gridColor = scheme.outlineVariant.withValues(alpha: 0.45);
    final tooltipBg = scheme.brightness == Brightness.dark
        ? scheme.surfaceContainerHigh
        : scheme.surfaceContainerHighest;
    final tooltipTitleStyle = AppFonts.interStyle(
      color: scheme.onSurface,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );

    final maxVal = [
      moneyIn.isEmpty ? 0.0 : moneyIn.reduce((a, b) => a > b ? a : b),
      moneyOut.isEmpty ? 0.0 : moneyOut.reduce((a, b) => a > b ? a : b),
    ].reduce((a, b) => a > b ? a : b);
    final maxY = maxVal == 0 ? 100.0 : (maxVal * 1.2);
    final interval = maxY / 5;

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: maxY,
          lineTouchData: LineTouchData(
            enabled: true,
            touchCallback: (event, response) {
              setState(() {});
            },
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => tooltipBg,
              tooltipRoundedRadius: 8,
              tooltipPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              tooltipBorder: BorderSide(
                  color: scheme.outlineVariant.withValues(alpha: 0.6)),
              getTooltipItems: (List<LineBarSpot> spots) {
                if (spots.isEmpty) return [];
                final i = spots.first.x.toInt();
                if (i < 0 || i >= labels.length) return [];
                final inVal = i < moneyIn.length ? moneyIn[i] : 0.0;
                final outVal = i < moneyOut.length ? moneyOut[i] : 0.0;
                return [
                  LineTooltipItem(
                    '${labels[i]}\n',
                    tooltipTitleStyle,
                  ),
                  LineTooltipItem(
                    '${context.l10n.statisticsMoneyInAmount('$currencySymbol ${Utility.formatIndianNumber(inVal.ceil())}')}\n',
                    AppFonts.interStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  LineTooltipItem(
                    context.l10n.statisticsMoneyOutAmount(
                      '$currencySymbol ${Utility.formatIndianNumber(outVal.ceil())}',
                    ),
                    AppFonts.interStyle(
                      color: Colors.red.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ];
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: interval,
                getTitlesWidget: (v, meta) => Text(
                  v.toInt().toString(),
                  style:
                      AppFonts.interStyle(fontSize: 10, color: axisLabelColor),
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
                getTitlesWidget: (v, meta) {
                  final i = v.toInt();
                  return i >= 0 && i < labels.length
                      ? Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            labels[i],
                            style: AppFonts.interStyle(
                                fontSize: 10, color: axisLabelColor),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: interval,
            getDrawingHorizontalLine: (v) =>
                FlLine(color: gridColor, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                  moneyIn.length, (i) => FlSpot(i.toDouble(), moneyIn[i])),
              isCurved: true,
              curveSmoothness: 0.3,
              color: Colors.green,
              barWidth: 3,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index) =>
                    FlDotCirclePainter(
                  radius: 4,
                  color: scheme.surface,
                  strokeWidth: 2,
                  strokeColor: Colors.green,
                ),
              ),
              belowBarData:
                  BarAreaData(show: true, color: Colors.green.withOpacity(0.2)),
            ),
            LineChartBarData(
              spots: List.generate(
                  moneyOut.length, (i) => FlSpot(i.toDouble(), moneyOut[i])),
              isCurved: true,
              curveSmoothness: 0.3,
              color: Colors.red,
              barWidth: 3,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index) =>
                    FlDotCirclePainter(
                  radius: 4,
                  color: scheme.surface,
                  strokeWidth: 2,
                  strokeColor: Colors.red,
                ),
              ),
              belowBarData:
                  BarAreaData(show: true, color: Colors.red.withOpacity(0.2)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards(DashboardSummaryPageResponseModel data) {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            title: context.l10n.statisticsIncome,
            value: data.yearSalesSales.ceil() - data.yearUnpaidSales.ceil(),
            color: Colors.green.shade600,
            onTap: () => _showSalesDetail(data),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            title: context.l10n.statisticsExpenses,
            value: data.yearsPurchase.ceil(),
            color: Colors.red.shade600,
            onTap: () => _showPurchaseDetail(data),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required int value,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppFonts.interStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _showAmounts
                  ? '$currencySymbol ${Utility.formatIndianNumber(value)}'
                  : '$currencySymbol ****',
              style: AppFonts.interStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(List<double> amounts, List<String> labels,
      {bool isScrollable = false}) {
    if (amounts.isEmpty) return Container();

    final double maxValue =
        amounts.isNotEmpty ? amounts.reduce((a, b) => a > b ? a : b) : 0.0;
    final double maxY = maxValue == 0 ? 100.0 : (maxValue * 1.6);
    final double horizontalInterval = maxY > 0 ? (maxY / 1) : 25.0;

    Widget chart = SizedBox(
      height: 180,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: maxY,
          titlesData: FlTitlesData(
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  return index >= 0 && index < labels.length
                      ? Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            labels[index],
                            style: AppFonts.interStyle(
                              fontSize: 10,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                },
                reservedSize: 28,
                interval: isScrollable ? 1 : (labels.length > 12 ? 2 : 1),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: horizontalInterval,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.shade200,
                strokeWidth: 1,
              );
            },
          ),
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) =>
                  context.theme.colorScheme.primary,
              tooltipRoundedRadius: 8,
              tooltipPadding: EdgeInsets.all(8.r),
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    _showAmounts
                        ? "$currencySymbol ${Utility.formatIndianNumber(spot.y.ceil())}"
                        : "$currencySymbol ****",
                    AppFonts.interStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                amounts.length,
                (i) => FlSpot(i.toDouble(), amounts[i]),
              ),
              isCurved: true,
              curveSmoothness: 0.3,
              barWidth: 3,
              color: context.theme.colorScheme.primary,
              belowBarData: BarAreaData(
                show: true,
                color: context.theme.colorScheme.primary.withOpacity(0.3),
              ),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: context.theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return isScrollable
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: amounts.length * 40.0,
              child: chart,
            ),
          )
        : chart;
  }

  void _showSalesDetail(DashboardSummaryPageResponseModel data) {
    final scheme = context.theme.colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: scheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.statisticsSalesSummary,
                    style: AppFonts.interStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildDetailRow(context.l10n.statisticsTotalSales,
                  data.yearSalesSales.ceil()),
              _buildDetailRow(context.l10n.statisticsTotalIncome,
                  data.yearSalesSales.ceil() - data.yearUnpaidSales.ceil()),
              _buildDetailRow(context.l10n.statisticsTotalUnpaid,
                  data.yearUnpaidSales.ceil()),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showPurchaseDetail(DashboardSummaryPageResponseModel data) {
    final scheme = context.theme.colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: scheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.statisticsPurchaseSummary,
                    style: AppFonts.interStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildDetailRow(context.l10n.statisticsTotalPurchase,
                  data.yearsPurchase.ceil()),
              _buildDetailRow(context.l10n.statisticsPaidPurchase,
                  data.yearsPurchase.ceil() - data.yearUnpaidPurchase.ceil()),
              _buildDetailRow(context.l10n.statisticsUnpaidPurchase,
                  data.yearUnpaidPurchase.ceil()),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, int value) {
    final scheme = context.theme.colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppFonts.interStyle(
              fontSize: 16,
              color: scheme.onSurfaceVariant,
            ),
          ),
          Text(
            _showAmounts
                ? '$currencySymbol ${Utility.formatIndianNumber(value)}'
                : '$currencySymbol ****',
            style: AppFonts.interStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeDashboard(DashboardSummaryPageResponseModel data) {
    final employee = context.employeeData;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.green, Colors.teal],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  context.l10n.statisticsEmployeeDashboard,
                  style: AppTextStyles.textTheme.headlineSmall,
                ),
              ],
            ),
            GestureDetector(
              onTap: _showMonthPicker,
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Icon(
                  FontAwesomeIcons.calendar,
                  size: context.theme.appTheme.spacing16,
                  color: Colors.green.shade700,
                ),
              ),
            ),
          ],
        ),
        verticalMarginLarge,

        // Employee Info Card
        Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.green.shade50,
                Colors.teal.shade50,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.green.shade700,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee?.fullName ??
                          context.l10n.statisticsDefaultEmployee,
                      style: AppFonts.interStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.l10n.statisticsDepartmentPosition(
                        employee?.department ??
                            context.l10n.statisticsDefaultDepartment,
                        employee?.position ??
                            context.l10n.statisticsDefaultPosition,
                      ),
                      style: AppFonts.interStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Summary Cards for Employee
        Row(
          children: [
            Expanded(
              child: _buildEmployeeSummaryCard(
                title: context.l10n.statisticsCurrentMonth,
                subtitle: DateFormat('MMMM yyyy').format(_selectedMonth),
                icon: Icons.calendar_today,
                color: context.theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildEmployeeSummaryCard(
                title: context.l10n.statisticsStatus,
                subtitle:
                    employee?.employmentStatus ?? context.l10n.statisticsActive,
                icon: Icons.check_circle,
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Welcome Message
        Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: context.theme.colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    context.l10n.statisticsWelcome,
                    style: AppFonts.interStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                context.l10n.statisticsEmployeeGreeting(
                  _getGreeting(context),
                  _employeeFirstName(
                    employee?.fullName,
                    fallback: context.l10n.statisticsDefaultEmployee,
                  ),
                ),
                style: context.theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.statisticsEmployeeWelcomeMessage,
                style: AppFonts.interStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeSummaryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    MaterialColor materialColor;
    if (color == Colors.blue) {
      materialColor = Colors.blue;
    } else if (color == Colors.green) {
      materialColor = Colors.green;
    } else {
      materialColor = Colors.blue;
    }

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.theme.colorScheme.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: materialColor.shade700,
                  size: 20,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppFonts.interStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppFonts.interStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: materialColor.shade800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// Custom Year View widget for month selection
class YearView extends StatelessWidget {
  final DateTime selectedMonth;
  final Function(DateTime) onMonthChanged;
  final List<String> monthLabels;

  const YearView({
    super.key,
    required this.selectedMonth,
    required this.onMonthChanged,
    required this.monthLabels,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final primary = scheme.primary;
    final currentYear = DateTime.now().year;
    final years = List.generate(5, (index) => currentYear - 2 + index);

    return DefaultTabController(
      length: years.length,
      initialIndex: years.indexOf(selectedMonth.year),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              isScrollable: true,
              labelColor: scheme.onPrimary,
              unselectedLabelColor: scheme.onSurfaceVariant,
              indicator: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: AppFonts.interStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              unselectedLabelStyle: AppFonts.interStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              tabs: years
                  .map((year) => Tab(
                        child: Text(year.toString()),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              children:
                  years.map((year) => _buildMonthGrid(context, year)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthGrid(BuildContext context, int year) {
    final scheme = Theme.of(context).colorScheme;
    final primary = scheme.primary;
    final months = monthLabels;

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 2.5,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final month = index + 1;
        final monthDate = DateTime(year, month, 1);
        final isSelected =
            selectedMonth.year == year && selectedMonth.month == month;
        final isCurrentMonth =
            DateTime.now().year == year && DateTime.now().month == month;
        final isFutureMonth = monthDate.isAfter(DateTime.now());

        return GestureDetector(
          onTap: () => onMonthChanged(monthDate),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected
                  ? primary
                  : isCurrentMonth
                      ? primary.withValues(alpha: 0.12)
                      : scheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : isCurrentMonth
                        ? primary.withValues(alpha: 0.35)
                        : scheme.outlineVariant.withValues(alpha: 0.45),
                width: isSelected ? 0 : 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                months[index],
                style: AppFonts.interStyle(
                  color: isSelected
                      ? scheme.onPrimary
                      : isCurrentMonth
                          ? primary
                          : isFutureMonth
                              ? scheme.onSurfaceVariant.withValues(alpha: 0.45)
                              : scheme.onSurface,
                  fontWeight: isSelected || isCurrentMonth
                      ? FontWeight.w700
                      : FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CashflowRangeTile extends StatelessWidget {
  const _CashflowRangeTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
    this.selected = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.interStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppFonts.interStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (selected)
            Icon(Icons.check_circle_rounded, color: color, size: 22),
        ],
      ),
    );
  }
}
