import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/l10n/closing_l10n_x.dart';
import 'package:hotel/src/features/closing/data/models/request/hotel_summary_request_params.dart';
import 'package:hotel/src/features/closing/data/models/response/hotel_summary_response_model.dart';
import 'package:hotel/src/features/closing/presentation/bloc/hotel_summary_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_list_chrome.dart';
import 'package:intl/intl.dart';

/// Payment labels stay in English across locales.
const String _kPayCashGetQrTitle = 'Pay Cash → Get QR';
const String _kPayQrGetCashTitle = 'Pay Qr → Get Cash';

@RoutePage()
class HotelSummaryPage extends StatefulWidget {
  final HotelSummaryRequestParams hotelSummaryRequestParams;
  const HotelSummaryPage({super.key, required this.hotelSummaryRequestParams});

  @override
  State<HotelSummaryPage> createState() => _HotelSummaryPageState();
}

class _HotelSummaryPageState extends State<HotelSummaryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime selectedDate = DateTime.now();

  String _formatAmount(num value) =>
      context.l10n.formatMoneyWithSymbol(currencySymbol, value.toDouble());

  String _formatAmountString(dynamic value) {
    if (value is num) return _formatAmount(value);
    final parsed = double.tryParse(value.toString().replaceAll(',', ''));
    if (parsed != null) return _formatAmount(parsed);
    return context.l10n.formatCurrency('$currencySymbol $value');
  }

  BoxDecoration _panelDecoration(BuildContext context, {double radius = 12}) {
    return InvoiceListChrome.cardDecoration(
      context,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  BoxDecoration _metricCardDecoration(
    BuildContext context, {
    required bool positive,
  }) {
    final scheme = Theme.of(context).colorScheme;
    if (scheme.brightness == Brightness.dark) {
      final tint = positive ? scheme.primaryContainer : scheme.errorContainer;
      final border = positive ? scheme.primary : scheme.error;
      return BoxDecoration(
        color: tint.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border.withValues(alpha: 0.35)),
      );
    }
    return BoxDecoration(
      gradient: LinearGradient(
        colors: positive
            ? [Colors.green.shade50, Colors.green.shade100]
            : [Colors.red.shade50, Colors.red.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: positive ? Colors.green.shade200 : Colors.red.shade200,
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    selectedDate = DateTime.parse(widget.hotelSummaryRequestParams.date.toString());
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<HotelSummaryCubit>().getHotelSummaries(
              params: widget.hotelSummaryRequestParams,
            );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSummaryCubit, HotelSummaryState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
          appBar: _buildAppBar(),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildDashboardWithState(state),
              _buildSalesListTab(state),
              _buildCreditListTab(state),
              _buildPurchaseListTab(state),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      title: Text(
        context.l10n.closeSummaryTitle,
        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      surfaceTintColor: scheme.surfaceTint,
      bottom: TabBar(
        controller: _tabController,
        labelColor: scheme.primary,
        unselectedLabelColor: scheme.onSurfaceVariant,
        indicatorColor: scheme.primary,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: context.theme.textTheme.bodyMedium,
        unselectedLabelStyle:context.theme.textTheme.bodyMedium,
        tabs: [
          Tab(text: context.l10n.closeTabDashboard),
          Tab(text: context.l10n.sales),
          Tab(text: context.l10n.closeTabCredits),
          Tab(text: context.l10n.purchase),
        ],
      ),
    );
  }

  Widget _buildDashboardWithState(HotelSummaryState state) {
    return state.when(
      initial: () => _buildInitialState(),
      loading: () => _buildLoadingState(),
      loadingDetail: () => _buildLoadingState(),
      creating: () => _buildLoadingState(),
      updating: () => _buildLoadingState(),
      deleting: () => _buildLoadingState(),
      noInternet: () => _buildNoInternetState(),
      error: (message) => _buildErrorState(message),
      loaded: (response) => _buildDashboard(response.data),
      detailLoaded: (summary) => _buildDashboard(summary),
      created: (summary) => _buildDashboard(summary),
      updated: (summary) => _buildDashboard(summary),
      deleted: () => _buildDeletedState(),
    );
  }

  Widget _buildInitialState() {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hotel, size: 64, color: scheme.onSurfaceVariant),
          const SizedBox(height: 16),
          Text(
            context.l10n.closeWelcome,
            style: AppFonts.interStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.closeSelectDateHint,
            style: AppFonts.interStyle(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(context.l10n.closeLoadingDashboard),
        ],
      ),
    );
  }

  Widget _buildNoInternetState() {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 64, color: scheme.onSurfaceVariant),
          const SizedBox(height: 16),
          Text(context.l10n.noInternetConnection),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              context.read<HotelSummaryCubit>().getHotelSummaries(
                    params: HotelSummaryRequestParams(
                      date: DateFormat('yyyy-MM-dd').format(selectedDate),
                    ),
                  );
            },
            icon: Icon(Icons.refresh),
            label: Text(context.l10n.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 64, color: Colors.red.shade400),
          const SizedBox(height: 16),
          Text(context.l10n.closeErrorPrefix(message)),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              context.read<HotelSummaryCubit>().getHotelSummaries(
                    params: HotelSummaryRequestParams(
                      date: DateFormat('yyyy-MM-dd').format(selectedDate),
                    ),
                  );
            },
            icon: Icon(Icons.refresh),
            label: Text(context.l10n.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildDeletedState() {
    return Center(
      child: Text(context.l10n.closeDataDeleted),
    );
  }

  Widget _buildDashboard(HotelSummaryResponseModel data) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.primary,
      onRefresh: () async {
        HapticFeedback.lightImpact();
        context.read<HotelSummaryCubit>().getHotelSummaries(
              params: HotelSummaryRequestParams(
                date: DateFormat('yyyy-MM-dd').format(selectedDate),
              ),
            );
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildHeaderCard(data),
            // const SizedBox(height: 20),
            Column(
              children: [
                _buildClosingAmount(data),
                const SizedBox(height: 20),
              ],
            ),
            if (data.summary.extraAmount > 0)
              Column(
                children: [
                  _buildExtraAmount(data),
                  const SizedBox(height: 20),
                ],
              ),
            if (data.summary.lostAmount > 0)
              Column(
                children: [
                  _buildLostAmount(data),
                  const SizedBox(height: 20),
                ],
              ),
            _buildQuickStats(data),
            const SizedBox(height: 20),
            _buildPaymentMethods(data),
          ],
        ),
      ),
    );
  }

  Widget _buildExtraAmount(HotelSummaryResponseModel summary) {
    final v = _formatAmount(summary.summary.extraAmount);
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showMetricBottomSheet(
              title: context.l10n.closeExtraAmount,
              value: v,
              description: context.l10n.closeExtraAmountDesc,
            ),
        child: Ink(
          decoration: _metricCardDecoration(context, positive: true),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.theme.appTheme.spacing18,
              vertical: context.theme.appTheme.spacing8,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.payments_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.closeExtraAmount,
                        style: AppFonts.interStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: scheme.onSurface,
                        ),
                      ),
                      Text(
                        context.l10n.closeTapForDetails,
                        style: AppFonts.interStyle(fontSize: 11, color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                Text(
                  v,
                  style: AppFonts.interStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLostAmount(HotelSummaryResponseModel summary) {
    final v = _formatAmount(summary.summary.lostAmount);
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showMetricBottomSheet(
              title: context.l10n.closeLostAmount,
              value: v,
              description: context.l10n.closeLostAmountDesc,
            ),
        child: Ink(
          decoration: _metricCardDecoration(context, positive: false),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.theme.appTheme.spacing18,
              vertical: context.theme.appTheme.spacing8,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.trending_down_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.closeLostAmount,
                        style: AppFonts.interStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: scheme.onSurface,
                        ),
                      ),
                      Text(
                        context.l10n.closeTapForDetails,
                        style: AppFonts.interStyle(fontSize: 11, color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                Text(
                  v,
                  style: AppFonts.interStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClosingAmount(HotelSummaryResponseModel summary) {
    final closingAmount = summary.summary.lostAmount;
    final positive = closingAmount <= 0;
    final scheme = Theme.of(context).colorScheme;
    final accent = positive ? Colors.green.shade600 : Colors.red.shade600;
    final valueColor = positive ? Colors.green.shade700 : Colors.red.shade700;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          _showClosingAmountFormula(summary);
        },
        child: Ink(
          decoration: _metricCardDecoration(context, positive: positive),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    positive ? Icons.account_balance_wallet_rounded : Icons.warning_amber_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    context.l10n.closeAmountLabel,
                    style: AppFonts.interStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: scheme.onSurface,
                    ),
                  ),
                ),
                Text(
                  _formatAmountString(summary.summary.closingBalance),
                  style: AppFonts.interStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showClosingAmountFormula(HotelSummaryResponseModel summary) {
    HapticFeedback.lightImpact();
    final cashSales = summary.summary.salesCashAmount;
    final cashExpenses = summary.summary.totalExpensesCash;
    final closingAmount = cashSales - cashExpenses;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.calculate,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      context.l10n.closeAmountFormula,
                      style: AppFonts.interStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Formula
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  context.l10n.closeFormulaExpression,
                  style: AppFonts.interStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 20),

              // Calculation breakdown
              _buildFormulaRow(context.l10n.closeCashSales, cashSales, Colors.green, Icons.add),
              const SizedBox(height: 8),
              _buildFormulaRow(context.l10n.closeCashExpenses, cashExpenses, Colors.red, Icons.remove),

              const Divider(height: 24),

              _buildFormulaRow(context.l10n.closeClosingAmount, closingAmount, closingAmount >= 0 ? Colors.green : Colors.red,
                  Icons.account_balance_wallet),

              const SizedBox(height: 20),

              // Explanation
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade600, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          context.l10n.closeWhatThisMeans,
                          style: AppFonts.interStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.l10n.closeClosingMeaning,
                      style: AppFonts.interStyle(
                        fontSize: 12,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMetricBottomSheet({
    required String title,
    required String value,
    String? description,
  }) {
    HapticFeedback.lightImpact();
    final scheme = Theme.of(context).colorScheme;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(ctx).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: scheme.primary,
                    ),
              ),
              if (description != null && description.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  description,
                  style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.45,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showQuickStatDetail(String title, String value) {
    _showMetricBottomSheet(
      title: title,
      value: value,
      description: _hintForStatTitle(title),
    );
  }

  String? _hintForStatTitle(String title) {
    final l10n = context.l10n;
    if (title == l10n.closeOpeningBalance) return l10n.closeHintOpeningBalance;
    if (title == l10n.closeTotalSales) return l10n.closeHintTotalSales;
    if (title == l10n.closeQrAmount) return l10n.closeHintQrAmount;
    if (title == l10n.closeCashAmount) return l10n.closeHintCashAmount;
    if (title == l10n.closeCashExpenses) return l10n.closeHintCashExpenses;
    if (title == l10n.closeSalesDiscount) return l10n.closeHintSalesDiscount;
    if (title == l10n.unpaid) return l10n.unpaidAmountNotYetCollected;
    if (title == l10n.closeCreditQr) return l10n.closeHintCreditQr;
    if (title == l10n.closeCreditCash) return l10n.closeHintCreditCash;
    if (title == l10n.closeCreditDiscount) return l10n.closeHintCreditDiscount;
    if (title == _kPayCashGetQrTitle) return l10n.closeHintPayCashGetQr;
    if (title == _kPayQrGetCashTitle) return l10n.closeHintPayQrGetCash;
    return null;
  }

  void _showPaymentSplitDetail(HotelSummaryResponseModel summary, {required bool cash}) {
    final amt = cash ? summary.summary.salesCashAmount : summary.summary.salesTransferAmount;
    final pct = cash ? summary.summary.cashPercentage : summary.summary.qrPercentage;
    final label = cash ? 'Cash' : 'Digital (QR)';
    _showMetricBottomSheet(
      title: context.l10n.closeSalesLabel(label),
      value: _formatAmount(amt),
      description: context.l10n.closeSalesShareDescription(
        label,
        context.l10n.formatDecimal(pct, fractionDigits: 1),
      ),
    );
  }

  Widget _buildFormulaRow(String label, int amount, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: AppFonts.interStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          Text(
            _formatAmount(amount),
            style: AppFonts.interStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildHeaderCard(HotelSummaryResponseModel summary) {
  //   return Container(
  //     padding: const EdgeInsets.all(24),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: [Colors.blue.shade700, Colors.blue.shade500],
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //       ),
  //       borderRadius: BorderRadius.circular(16),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.blue.withOpacity(0.3),
  //           blurRadius: 10,
  //           offset: const Offset(0, 5),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Daily Summary',
  //               style: AppFonts.interStyle(
  //                 color: Colors.white,
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //               decoration: BoxDecoration(
  //                 color: summary.isProfitable ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
  //                 borderRadius: BorderRadius.circular(20),
  //                 border: Border.all(
  //                   color: summary.isProfitable ? Colors.green : Colors.red,
  //                 ),
  //               ),
  //               child: Text(
  //                 summary.isProfitable ? 'Profitable' : 'Loss',
  //                 style: AppFonts.interStyle(
  //                   color: summary.isProfitable ? Colors.green : Colors.red,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 12),
  //         Text(
  //           DateFormat('EEEE, MMMM dd, yyyy').format(selectedDate),
  //           style: AppFonts.interStyle(
  //             color: Colors.white70,
  //             fontSize: 14,
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Total Revenue',
  //                     style: AppFonts.interStyle(
  //                       color: Colors.white70,
  //                       fontSize: 14,
  //                     ),
  //                   ),
  //                   Text(
  //                     _formatAmount(summary.totalRevenue),
  //                     style: AppFonts.interStyle(
  //                       color: Colors.white,
  //                       fontSize: 28,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Text(
  //                     'Net Profit',
  //                     style: AppFonts.interStyle(
  //                       color: Colors.white70,
  //                       fontSize: 14,
  //                     ),
  //                   ),
  //                   Text(
  //                     _formatAmount(summary.netProfit),
  //                     style: AppFonts.interStyle(
  //                       color: summary.isProfitable ? Colors.green.shade200 : Colors.red.shade200,
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildQuickStats(HotelSummaryResponseModel summary) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.closeQuickStats,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          context.l10n.closeTapCardHint,
          style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 14),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.45,
          children: [
            _buildStatCard(
              context,
              context.l10n.closeOpeningBalance,
              _formatAmount(summary.summary.openingBalance),
              Icons.trending_up,
              Colors.green,
            ),
            _buildStatCard(context,
              context.l10n.closeTotalSales,
              _formatAmount(summary.summary.totalSales),
              Icons.trending_up,
              Colors.green,
            ),
            _buildStatCard(context,
              context.l10n.closeQrAmount,
              _formatAmount(summary.summary.salesTransferAmount),
              Icons.trending_up,
              Colors.green,
            ),
            _buildStatCard(context,
              context.l10n.closeCashAmount,
              _formatAmount(summary.summary.salesCashAmount),
              Icons.trending_down,
              Colors.red,
            ),
            _buildStatCard(context,
              context.l10n.closeCashExpenses,
              _formatAmount(summary.summary.totalExpensesCash),
              Icons.trending_down,
              Colors.red,
            ),
            _buildStatCard(context,
              context.l10n.closeSalesDiscount,
              _formatAmount(summary.summary.totalDiscount),
              Icons.trending_down,
              Colors.red,
            ),
            _buildStatCard(context,
              context.l10n.unpaid,
              _formatAmount(summary.summary.unpaidAmount),
              Icons.pending,
              Colors.orange,
            ),
            _buildStatCard(context,
              context.l10n.closeCreditQr,
              _formatAmount(summary.summary.creditQr),
              Icons.trending_down,
              Colors.red,
            ),
            _buildStatCard(context,
              context.l10n.closeCreditCash,
              _formatAmount(summary.summary.creditCash),
              Icons.trending_down,
              Colors.red,
            ),
            _buildStatCard(context,
              context.l10n.closeCreditDiscount,
              _formatAmount(summary.summary.creditDiscount),
              Icons.trending_down,
              Colors.red,
            ),
            _buildStatCard(context,
              _kPayCashGetQrTitle,
              _formatAmount(summary.summary.payCashGetQrExchange ?? 0),
              Icons.trending_down,
              Colors.red,
            ),
            _buildStatCard(context,
              _kPayQrGetCashTitle,
              _formatAmount(summary.summary.payQrGetCashExchange ?? 0),
              Icons.trending_down,
              Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showQuickStatDetail(title, value),
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.outlineVariant.withOpacity(0.55)),
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icon, color: color, size: 22),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: color, size: 15),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  title,
                  style: AppFonts.interStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    value,
                    style: AppFonts.interStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: scheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethods(HotelSummaryResponseModel summary) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant.withOpacity(0.55)),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.closePaymentMix,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.closePaymentMixHint,
            style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _showPaymentSplitDetail(summary, cash: true),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: _buildPaymentMethodCard(
                        'Cash',
                        summary.summary.salesCashAmount.toDouble(),
                        summary.summary.cashPercentage,
                        Icons.payments_rounded,
                        Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _showPaymentSplitDetail(summary, cash: false),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: _buildPaymentMethodCard(
                        'Digital',
                        summary.summary.salesTransferAmount.toDouble(),
                        summary.summary.qrPercentage,
                        Icons.qr_code_rounded,
                        Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Tooltip(
            message: context.l10n.closeCashVsDigitalTooltip,
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: scheme.surfaceContainerHighest.withOpacity(0.8),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cashWidth = (summary.summary.cashPercentage / 100) * constraints.maxWidth;
                  return Stack(
                    children: [
                      if (cashWidth > 0)
                        Container(
                          width: cashWidth,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      if (constraints.maxWidth - cashWidth > 0)
                        Positioned(
                          left: cashWidth,
                          child: Container(
                            width: constraints.maxWidth - cashWidth,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade600,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(String method, double amount, double percentage, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          method,
          style: AppFonts.interStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _formatAmount(amount),
          style: AppFonts.interStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          '${percentage.toStringAsFixed(1)}%',
          style: AppFonts.interStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTransactions(HotelSummaryResponseModel summary) {
    if (summary.salesList.isEmpty) {
      return _buildEmptyCard(context.l10n.closeNoTransactions, Icons.receipt_long);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _panelDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.closeRecentTransactions,
                style: AppFonts.interStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () => _tabController.animateTo(1),
                child: Text(context.l10n.closeViewAll),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: summary.salesList.take(3).length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final sale = summary.salesList[index];
              return _buildTransactionItem(sale);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecentPurchases(HotelSummaryResponseModel summary) {
    if (summary.purchaseList.isEmpty) {
      return _buildEmptyCard(context.l10n.closeNoPurchases, Icons.shopping_bag_outlined);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _panelDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.closeRecentPurchases,
                style: AppFonts.interStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () => _tabController.animateTo(3),
                child: Text(context.l10n.closeViewAll),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: summary.purchaseList.take(3).length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final purchase = summary.purchaseList[index];
              return _buildPurchaseItem(purchase);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCard(String message, IconData icon) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _panelDecoration(context),
      child: Column(
        children: [
          Icon(icon, size: 48, color: scheme.onSurfaceVariant),
          const SizedBox(height: 12),
          Text(
            message,
            style: AppFonts.interStyle(
              fontSize: 16,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(SalesInvoice sale) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: sale.isRoom
            ? Colors.green.shade100
            : sale.isEmployee
                ? Colors.blue.shade100
                : Colors.orange.shade100,
        child: Icon(
          sale.isRoom
              ? Icons.hotel
              : sale.isEmployee
                  ? Icons.person
                  : Icons.shopping_cart,
          color: sale.isRoom
              ? Colors.green
              : sale.isEmployee
                  ? Colors.blue
                  : Colors.orange,
        ),
      ),
      title: Text(
        sale.party,
        style: AppFonts.interStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(sale.id),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _formatAmount(sale.totalAmount),
            style: AppFonts.interStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          if (sale.hasDiscount)
            Text(
              context.l10n.closeDiscountShort(_formatAmount(sale.discountAmount)),
              style: AppFonts.interStyle(
                color: Colors.orange.shade600,
                fontSize: 12,
              ),
            ),
        ],
      ),
      onTap: () => _showTransactionDetails(sale),
    );
  }

  Widget _buildPurchaseItem(PurchaseInvoice purchase) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.red.shade100,
        child: Icon(
          Icons.shopping_bag,
          color: Colors.red,
        ),
      ),
      title: Text(
        purchase.party,
        style: AppFonts.interStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(purchase.id),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _formatAmount(purchase.totalAmount),
            style: AppFonts.interStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.red,
            ),
          ),
          if (purchase.hasDiscount)
            Text(
              context.l10n.closeDiscountShort(_formatAmount(purchase.discountAmount)),
              style: AppFonts.interStyle(
                color: Colors.orange.shade600,
                fontSize: 12,
              ),
            ),
        ],
      ),
      onTap: () => _showPurchaseDetails(purchase),
    );
  }

  Widget _buildActionButtons(HotelSummaryResponseModel data) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _showSummaryStatistics(data),
            icon: Icon(Icons.analytics),
            label: Text(context.l10n.closeViewStatistics),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _exportData(data),
            icon: Icon(Icons.download),
            label: Text(context.l10n.closeExportData),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  // Sales List Tab
  Widget _buildSalesListTab(HotelSummaryState state) {
    return state.when(
      initial: () => _buildInitialState(),
      loading: () => _buildLoadingState(),
      loadingDetail: () => _buildLoadingState(),
      creating: () => _buildLoadingState(),
      updating: () => _buildLoadingState(),
      deleting: () => _buildLoadingState(),
      noInternet: () => _buildNoInternetState(),
      error: (message) => _buildErrorState(message),
      loaded: (response) => _buildSalesList(response.data.salesList),
      detailLoaded: (summary) => _buildSalesList(summary.salesList),
      created: (summary) => _buildSalesList(summary.salesList),
      updated: (summary) => _buildSalesList(summary.salesList),
      deleted: () => _buildDeletedState(),
    );
  }

  Widget _buildSalesList(List<SalesInvoice> salesList) {
    if (salesList.isEmpty) {
      final scheme = Theme.of(context).colorScheme;
      final textTheme = Theme.of(context).textTheme;
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer.withOpacity(0.35),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.receipt_long_rounded,
                  size: 44,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.closeNoSalesDate,
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.closeNoSalesHint,
                style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Group sales by customer type - only room if party contains "room"
    final roomSales = salesList.where((sale) => sale.party.toLowerCase().contains('room')).toList();
    final employeeSales = salesList.where((sale) => sale.isEmployee).toList();
    final otherSales =
        salesList.where((sale) => !sale.party.toLowerCase().contains('room') && !sale.isEmployee).toList();

    return RefreshIndicator(
      color: Theme.of(context).colorScheme.primary,
      onRefresh: () async {
        context.read<HotelSummaryCubit>().getHotelSummaries(
              params: HotelSummaryRequestParams(
                date: DateFormat('yyyy-MM-dd').format(selectedDate),
              ),
            );
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        children: [
          if (roomSales.isNotEmpty) ...[
            _buildSalesSectionHeader(
              context,
              title: context.l10n.closeRoomSales,
              count: roomSales.length,
              isFirst: true,
            ),
            ...roomSales.map((sale) => _buildSalesCard(context, sale)),
            const SizedBox(height: 8),
          ],
          if (employeeSales.isNotEmpty) ...[
            _buildSalesSectionHeader(
              context,
              title: context.l10n.closeEmployeeSales,
              count: employeeSales.length,
              isFirst: roomSales.isEmpty,
            ),
            ...employeeSales.map((sale) => _buildSalesCard(context, sale)),
            const SizedBox(height: 8),
          ],
          if (otherSales.isNotEmpty) ...[
            _buildSalesSectionHeader(
              context,
              title: context.l10n.closeOtherSales,
              count: otherSales.length,
              isFirst: roomSales.isEmpty && employeeSales.isEmpty,
            ),
            ...otherSales.map((sale) => _buildSalesCard(context, sale)),
          ],
        ],
      ),
    );
  }

  Widget _buildSalesSectionHeader(
    BuildContext context, {
    required String title,
    required int count,
    bool isFirst = false,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(top: isFirst ? 0 : 20, bottom: 12),
      child: Text(
        context.l10n.closeSectionCount(title, context.l10n.formatCount(count)),
        style: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
          letterSpacing: 0.15,
        ),
      ),
    );
  }

  Widget _buildSalesCard(BuildContext context, SalesInvoice sale) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isRoomSale = sale.party.toLowerCase().contains('room');
    final accent = isRoomSale
        ? const Color(0xFF2E7D32)
        : sale.isEmployee
            ? scheme.primary
            : const Color(0xFFE65100);
    final iconBg = accent.withOpacity(0.12);
    final formattedAmount = NumberFormat('#,##0');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: scheme.surface,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: scheme.outlineVariant.withOpacity(0.55)),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _showTransactionDetails(sale),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isRoomSale
                        ? Icons.bed_rounded
                        : sale.isEmployee
                            ? Icons.badge_outlined
                            : Icons.shopping_bag_outlined,
                    color: accent,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sale.party,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${sale.id} · ${DateFormat('MMM d').format(DateTime.parse(sale.date))}',
                        style: textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                      ),
                      if (sale.hasDiscount) ...[
                        const SizedBox(height: 6),
                        Text(
                          context.l10n.closePercentOff(context.l10n.formatDecimal(sale.discountPercentage, fractionDigits: 1)),
                          style: textTheme.labelMedium?.copyWith(
                            color: scheme.tertiary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (sale.hasDiscount) ...[
                      Text(
                        'Rs. ${formattedAmount.format(sale.totalAmount)}',
                        style: textTheme.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Rs. ${formattedAmount.format(sale.totalAmountWithDiscount)}',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: scheme.primary,
                        ),
                      ),
                    ] else
                      Text(
                        'Rs. ${formattedAmount.format(sale.totalAmount)}',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    const SizedBox(height: 10),
                    _buildPaidStatusPill(context, paid: sale.isPaid),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaidStatusPill(BuildContext context, {required bool paid}) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: paid ? scheme.primaryContainer.withOpacity(0.85) : scheme.secondaryContainer.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        paid ? context.l10n.paid : context.l10n.closePending,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
              color: paid ? scheme.onPrimaryContainer : scheme.onSecondaryContainer,
            ),
      ),
    );
  }

  // Credit List Tab
  Widget _buildCreditListTab(HotelSummaryState state) {
    return state.when(
      initial: () => _buildInitialState(),
      loading: () => _buildLoadingState(),
      loadingDetail: () => _buildLoadingState(),
      creating: () => _buildLoadingState(),
      updating: () => _buildLoadingState(),
      deleting: () => _buildLoadingState(),
      noInternet: () => _buildNoInternetState(),
      error: (message) => _buildErrorState(message),
      loaded: (response) => _buildCreditList(response.data.creditList),
      detailLoaded: (summary) => _buildCreditList(summary.creditList),
      created: (summary) => _buildCreditList(summary.creditList),
      updated: (summary) => _buildCreditList(summary.creditList),
      deleted: () => _buildDeletedState(),
    );
  }

  Widget _buildCreditList(List<CreditPayment> creditList) {
    if (creditList.isEmpty) {
      final scheme = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: scheme.tertiaryContainer.withValues(alpha: 0.35),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.credit_card,
                size: 48,
                color: scheme.tertiary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.closeNoCreditPayments,
              style: AppFonts.interStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.closeNoCreditHint,
              style: AppFonts.interStyle(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HotelSummaryCubit>().getHotelSummaries(
              params: HotelSummaryRequestParams(
                date: DateFormat('yyyy-MM-dd').format(selectedDate),
              ),
            );
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: creditList.length,
        itemBuilder: (context, index) {
          final credit = creditList[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: _panelDecoration(context),
            child: InkWell(
              onTap: () => _showCreditDetails(credit),
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  // Status Avatar
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: credit.isFullyPaid ? Colors.green.shade100 : Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      credit.isFullyPaid ? Icons.check_circle : Icons.pending,
                      color: credit.isFullyPaid ? Colors.green.shade600 : Colors.orange.shade600,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          credit.party,
                          style: AppFonts.interStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          credit.invoiceId,
                          style: AppFonts.interStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('MMM dd, yyyy').format(credit.salesDateTime),
                          style: AppFonts.interStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.85),
                            fontSize: 12,
                          ),
                        ),
                        if (credit.hasOutstanding) ...[
                          const SizedBox(height: 4),
                          Text(
                            context.l10n.unpaidColonAmount(
                                _formatAmount(credit.outstandingAmount)),
                            style: AppFonts.interStyle(
                              fontSize: 12,
                              color: Colors.red.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Amount & Status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatAmount(credit.invoiceAmount),
                        style: AppFonts.interStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Paid: Rs. ${NumberFormat('#,##0').format(credit.totalPayments)}',
                        style: AppFonts.interStyle(
                          fontSize: 12,
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: credit.isFullyPaid ? Colors.green.shade100 : Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${credit.paymentPercentage.toInt()}%',
                          style: AppFonts.interStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: credit.isFullyPaid ? Colors.green.shade700 : Colors.orange.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Purchase List Tab
  Widget _buildPurchaseListTab(HotelSummaryState state) {
    return state.when(
      initial: () => _buildInitialState(),
      loading: () => _buildLoadingState(),
      loadingDetail: () => _buildLoadingState(),
      creating: () => _buildLoadingState(),
      updating: () => _buildLoadingState(),
      deleting: () => _buildLoadingState(),
      noInternet: () => _buildNoInternetState(),
      error: (message) => _buildErrorState(message),
      loaded: (response) => _buildPurchaseList(response.data.purchaseList),
      detailLoaded: (summary) => _buildPurchaseList(summary.purchaseList),
      created: (summary) => _buildPurchaseList(summary.purchaseList),
      updated: (summary) => _buildPurchaseList(summary.purchaseList),
      deleted: () => _buildDeletedState(),
    );
  }

  Widget _buildPurchaseList(List<PurchaseInvoice> purchaseList) {
    if (purchaseList.isEmpty) {
      final scheme = Theme.of(context).colorScheme;
      final textTheme = Theme.of(context).textTheme;
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: scheme.errorContainer.withOpacity(0.35),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 44,
                  color: scheme.error,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'No purchases for this date',
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Purchase invoices will show here when available.',
                style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      color: Theme.of(context).colorScheme.primary,
      onRefresh: () async {
        context.read<HotelSummaryCubit>().getHotelSummaries(
              params: HotelSummaryRequestParams(
                date: DateFormat('yyyy-MM-dd').format(selectedDate),
              ),
            );
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        children: [
          _buildPurchasesSectionHeader(context, purchaseList.length),
          ...purchaseList.map((p) => _buildPurchaseCard(context, p)),
        ],
      ),
    );
  }

  Widget _buildPurchasesSectionHeader(BuildContext context, int count) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        'Purchases ($count)',
        style: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
          letterSpacing: 0.15,
        ),
      ),
    );
  }

  Widget _buildPurchaseCard(BuildContext context, PurchaseInvoice purchase) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final accent = scheme.error;
    final formattedAmount = NumberFormat('#,##0');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: scheme.surface,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: scheme.outlineVariant.withOpacity(0.55)),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _showPurchaseDetails(purchase),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: accent,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        purchase.party,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        purchase.id,
                        style: textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        DateFormat('MMM d, yyyy · hh:mm a').format(purchase.purchaseDateTime),
                        style: textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                      ),
                      if (purchase.hasDiscount) ...[
                        const SizedBox(height: 6),
                        Text(
                          '${purchase.discountPercentage.toStringAsFixed(1)}% off',
                          style: textTheme.labelMedium?.copyWith(
                            color: scheme.tertiary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (purchase.hasDiscount) ...[
                      Text(
                        'Rs. ${formattedAmount.format(purchase.totalAmount)}',
                        style: textTheme.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Rs. ${formattedAmount.format(purchase.totalAmountWithDiscount)}',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: accent,
                        ),
                      ),
                    ] else
                      Text(
                        'Rs. ${formattedAmount.format(purchase.totalAmount)}',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: accent,
                        ),
                      ),
                    const SizedBox(height: 10),
                    _buildPaidStatusPill(context, paid: purchase.isPaid),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Detail Dialog Methods
  void _showTransactionDetails(SalesInvoice sale) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: sale.isRoom
                          ? Colors.green.shade100
                          : sale.isEmployee
                              ? Colors.blue.shade100
                              : Colors.orange.shade100,
                      child: Icon(
                        sale.isRoom
                            ? Icons.hotel
                            : sale.isEmployee
                                ? Icons.person
                                : Icons.shopping_cart,
                        color: sale.isRoom
                            ? Colors.green
                            : sale.isEmployee
                                ? Colors.blue
                                : Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transaction Details',
                            style: AppFonts.interStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            sale.customerType,
                            style: AppFonts.interStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Transaction Info
                _buildDetailRow('Invoice ID', sale.id, isHeader: true),
                _buildDetailRow('Customer', sale.party),
                _buildDetailRow('Date', DateFormat('MMM dd, yyyy - hh:mm a').format(DateTime.parse(sale.date))),

                const Divider(height: 24),

                // Financial Details
                _buildDetailRow('Total Amount', _formatAmount(sale.totalAmount)),
                if (sale.hasDiscount) ...[
                  _buildDetailRow('Discount', _formatAmount(sale.discountAmount),
                      valueColor: Colors.orange),
                  _buildDetailRow('Final Amount', _formatAmount(sale.totalAmountWithDiscount),
                      isHeader: true),
                ],

                const Divider(height: 24),

                // Payment Details
                Text(
                  'Payment Details',
                  style: AppFonts.interStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                if (sale.paymentDetails.isEmpty)
                  Text(
                    'No payment recorded',
                    style: AppFonts.interStyle(color: Colors.grey),
                  )
                else
                  ...sale.paymentDetails.map((payment) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  payment.paymentMethod,
                                  style: AppFonts.interStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  DateFormat('MMM dd, yyyy').format(payment.paymentDateTime),
                                  style: AppFonts.interStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _formatAmount(payment.paymentAmount),
                              style: AppFonts.interStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      )),

                const SizedBox(height: 20),

                // Status
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: sale.isPaid ? Colors.green.shade50 : Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: sale.isPaid ? Colors.green.shade200 : Colors.orange.shade200,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        sale.isPaid ? Icons.check_circle : Icons.pending,
                        color: sale.isPaid ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        sale.isPaid ? 'Payment Completed' : 'Payment Pending',
                        style: AppFonts.interStyle(
                          fontWeight: FontWeight.w500,
                          color: sale.isPaid ? Colors.green : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCreditDetails(CreditPayment credit) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: credit.isFullyPaid ? Colors.green.shade100 : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        credit.isFullyPaid ? Icons.check_circle : Icons.pending,
                        color: credit.isFullyPaid ? Colors.green.shade600 : Colors.orange.shade600,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Credit Details',
                            style: AppFonts.interStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            credit.isFullyPaid ? 'Fully Paid' : 'Partial Payment',
                            style: AppFonts.interStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Credit Info
                _buildDetailRow('Invoice ID', credit.invoiceId),
                _buildDetailRow('Customer', credit.party),
                _buildDetailRow('Date', DateFormat('MMM dd, yyyy').format(credit.salesDateTime)),

                const Divider(height: 24),

                // Financial Details
                _buildDetailRow('Total Amount', _formatAmount(credit.invoiceAmount)),
                _buildDetailRow('Amount Paid', _formatAmount(credit.totalPayments),
                    valueColor: Colors.green),
                if (credit.hasOutstanding)
                  _buildDetailRow(context.l10n.unpaid, _formatAmount(credit.outstandingAmount),
                      valueColor: Colors.red),

                const Divider(height: 24),

                // Payment History
                Text(
                  'Payment History',
                  style: AppFonts.interStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                if (credit.payments.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'No payments recorded',
                        style: AppFonts.interStyle(color: Colors.grey),
                      ),
                    ),
                  )
                else
                  ...credit.payments.map((payment) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  payment.paymentMethod,
                                  style: AppFonts.interStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  DateFormat('MMM dd, yyyy').format(payment.paymentDateTime),
                                  style: AppFonts.interStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _formatAmount(payment.paymentAmount),
                              style: AppFonts.interStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green.shade600,
                              ),
                            ),
                          ],
                        ),
                      )),

                const SizedBox(height: 20),

                // Simple Status
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: credit.isFullyPaid ? Colors.green.shade50 : Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        credit.isFullyPaid ? Icons.check_circle : Icons.pending,
                        color: credit.isFullyPaid ? Colors.green.shade600 : Colors.orange.shade600,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          credit.isFullyPaid
                              ? 'Payment Completed'
                              : 'Payment ${credit.paymentPercentage.toInt()}% Complete',
                          style: AppFonts.interStyle(
                            fontWeight: FontWeight.w600,
                            color: credit.isFullyPaid ? Colors.green.shade700 : Colors.orange.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPurchaseDetails(PurchaseInvoice purchase) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red.shade100,
                      child: Icon(
                        Icons.shopping_bag,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Purchase Details',
                            style: AppFonts.interStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Expense Record',
                            style: AppFonts.interStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Purchase Info
                _buildDetailRow('Purchase ID', purchase.id, isHeader: true),
                _buildDetailRow('Vendor/Supplier', purchase.party),
                _buildDetailRow('Date', DateFormat('MMM dd, yyyy - hh:mm a').format(purchase.purchaseDateTime)),

                const Divider(height: 24),

                // Financial Details
                _buildDetailRow('Total Amount', _formatAmount(purchase.totalAmount),
                    valueColor: Colors.red),
                if (purchase.hasDiscount) ...[
                  _buildDetailRow('Discount', _formatAmount(purchase.discountAmount),
                      valueColor: Colors.orange),
                  _buildDetailRow(
                      'Final Amount', _formatAmount(purchase.totalAmountWithDiscount),
                      isHeader: true, valueColor: Colors.red),
                ],

                const Divider(height: 24),

                // Payment Details
                Text(
                  'Payment Details',
                  style: AppFonts.interStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                if (purchase.paymentDetails.isEmpty)
                  Text(
                    'No payment recorded',
                    style: AppFonts.interStyle(color: Colors.grey),
                  )
                else
                  ...purchase.paymentDetails.map((payment) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  payment.paymentMethod,
                                  style: AppFonts.interStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  DateFormat('MMM dd, yyyy').format(payment.paymentDateTime),
                                  style: AppFonts.interStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _formatAmount(payment.paymentAmount),
                              style: AppFonts.interStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      )),

                const SizedBox(height: 20),

                // Status
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: purchase.isPaid ? Colors.green.shade50 : Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: purchase.isPaid ? Colors.green.shade200 : Colors.orange.shade200,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        purchase.isPaid ? Icons.check_circle : Icons.pending,
                        color: purchase.isPaid ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        purchase.isPaid ? 'Payment Completed' : 'Payment Pending',
                        style: AppFonts.interStyle(
                          fontWeight: FontWeight.w500,
                          color: purchase.isPaid ? Colors.green : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSummaryStatistics(HotelSummaryResponseModel summary) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Icon(Icons.analytics, color: Colors.blue, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complete Summary Statistics',
                            style: AppFonts.interStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('EEEE, MMMM dd, yyyy').format(selectedDate),
                            style: AppFonts.interStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Revenue Analysis
                _buildStatSection(
                  'Revenue Analysis',
                  [
                    _buildStatItem(
                        'Total Revenue', _formatAmount(summary.totalRevenue), Colors.green),
                    _buildStatItem('Total Expenses',
                        _formatAmount(summary.summary.totalExpenses), Colors.red),
                    _buildStatItem('Net Profit', _formatAmount(summary.netProfit),
                        summary.isProfitable ? Colors.green : Colors.red),
                    _buildStatItem('Profit Margin', '${summary.profitMargin.toStringAsFixed(2)}%',
                        summary.isProfitable ? Colors.green : Colors.red),
                  ],
                ),

                const SizedBox(height: 16),

                // Transaction Analysis
                _buildStatSection(
                  'Transaction Analysis',
                  [
                    _buildStatItem('Total Transactions', '${summary.totalTransactions}', Colors.blue),
                    _buildStatItem('Average Transaction',
                        _formatAmount(summary.averageTransactionValue), Colors.purple),
                    _buildStatItem('Total Discounts',
                        _formatAmount(summary.summary.totalDiscount), Colors.orange),
                    _buildStatItem('Unpaid Amount', _formatAmount(summary.summary.unpaidAmount),
                        Colors.red),
                  ],
                ),

                const SizedBox(height: 16),

                // Payment Method Analysis
                _buildStatSection(
                  'Payment Method Analysis',
                  [
                    _buildStatItem('Cash Payments',
                        _formatAmount(summary.summary.salesCashAmount), Colors.green),
                    _buildStatItem('Digital Payments',
                        _formatAmount(summary.summary.salesQrAmount), Colors.blue),
                    _buildStatItem(
                        'Cash Percentage', '${summary.summary.cashPercentage.toStringAsFixed(1)}%', Colors.green),
                    _buildStatItem(
                        'Digital Percentage', '${summary.summary.qrPercentage.toStringAsFixed(1)}%', Colors.blue),
                  ],
                ),

                const SizedBox(height: 16),

                // Expense Analysis
                _buildStatSection(
                  'Expense Analysis',
                  [
                    _buildStatItem(context.l10n.closeCashExpenses,
                        _formatAmount(summary.summary.totalExpensesCash), Colors.red),
                    _buildStatItem('Digital Expenses',
                        _formatAmount(summary.summary.totalExpensesTransfer), Colors.red),
                    _buildStatItem('Expense Ratio', '${summary.summary.expenseRatio.toStringAsFixed(1)}%', Colors.red),
                    _buildStatItem('Credit Amount', _formatAmount(summary.summary.totalCredit),
                        Colors.orange),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _exportData(HotelSummaryResponseModel data) {
    // Add export functionality here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.l10n.closeExportComingSoon),
        backgroundColor: Colors.blue,
      ),
    );
  }

  // Helper Methods
  Widget _buildDetailRow(String label, String value, {bool isHeader = false, Color? valueColor}) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppFonts.interStyle(
              fontSize: isHeader ? 14 : 13,
              fontWeight: isHeader ? FontWeight.w600 : FontWeight.w500,
              color: scheme.onSurfaceVariant,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: AppFonts.interStyle(
                fontSize: isHeader ? 14 : 13,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
                color: valueColor ?? scheme.onSurface,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatSection(String title, List<Widget> children) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _panelDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.interStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppFonts.interStyle(
              fontSize: 13,
              color: scheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: AppFonts.interStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
