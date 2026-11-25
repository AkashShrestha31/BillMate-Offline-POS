import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/utility.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_response_model.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_cubit.dart';
import 'package:intl/intl.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/constants.dart';

@RoutePage()
class PreviousStockPage extends StatefulWidget {
  const PreviousStockPage({super.key});

  @override
  State<PreviousStockPage> createState() => _PreviousStockPageState();
}

class _PreviousStockPageState extends State<PreviousStockPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text);
    });
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadData() {
    context.read<PreviousStockCubit>().getPreviousStock(
          params: PreviousStockRequestParams(
            sortOrder: 'desc',
            limit: 100,
            onlyActive: true,
          ),
        );
  }

  Future<void> _onRefresh() async {
    context.read<PreviousStockCubit>().getPreviousStock(
          params: PreviousStockRequestParams(
            sortOrder: 'desc',
            limit: 100,
            onlyActive: true,
          ),
        );
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  List<ReportingDateModel> _filteredDates(List<ReportingDateModel> dates) {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return dates;
    return dates.where((d) {
      final dt = DateTime.tryParse(d.reportingDate);
      if (dt == null) return d.reportingDate.toLowerCase().contains(q);
      final long = DateFormat('EEEE, MMM dd, yyyy').format(dt).toLowerCase();
      final short = DateFormat('yyyy-MM-dd').format(dt);
      return long.contains(q) ||
          short.contains(q) ||
          '${dt.day}'.contains(q) ||
          DateFormat('MMMM').format(dt).toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;

    return BlocConsumer<PreviousStockCubit, PreviousStockState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          loading: () => AppLoadingOverlay.of(context).show(),
          success: (response) => AppLoadingOverlay.of(context).hide(),
          error: (message) {
            AppLoadingOverlay.of(context).hide();
            context.showKiiSnackBarError(message);
          },
          noInternet: () {
            AppLoadingOverlay.of(context).hide();
            context.showKiiSnackBarError(context.l10n.noInternetConnection);
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: scheme.surfaceContainerLowest,
          appBar: AppBar(
            leading: const AppBarIosBackButton(),
            title: Text(
              context.l10n.stocksTitle,
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            actions: [
              IconButton(
                tooltip: context.l10n.stockUploadTooltip,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.router.push(StockUploadRoute());
                },
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
          body: state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            initial: () => Center(child: CircularProgressIndicator(color: scheme.primary)),
            loading: () => Center(child: CircularProgressIndicator(color: scheme.primary)),
            success: (response) {
              if (response.data.uniqueReportingDates.isEmpty) {
                return _buildEmptyState(
                  context,
                  icon: Icons.inbox_outlined,
                  message: context.l10n.stockNoDataYet,
                  subtitle: context.l10n.stockNoDataSubtitle,
                  actionLabel: context.l10n.stockUploadAction,
                  onAction: () => context.router.push(StockUploadRoute()),
                );
              }
              final filtered = _filteredDates(response.data.uniqueReportingDates);
              return RefreshIndicator(
                color: scheme.primary,
                onRefresh: _onRefresh,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              context.l10n.stockCountsPageHint,
                              style: textTheme.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            TextField(
                              controller: _searchController,
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                hintText: context.l10n.stockSearchByDateHint,
                                prefixIcon: AppSearchIcon.inputDecoration( color: scheme.onSurfaceVariant),
                                suffixIcon: _searchQuery.isEmpty
                                    ? null
                                    : IconButton(
                                        tooltip: context.l10n.clear,
                                        icon: Icon(Icons.clear_rounded, color: scheme.onSurfaceVariant),
                                        onPressed: () {
                                          _searchController.clear();
                                          HapticFeedback.selectionClick();
                                        },
                                      ),
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (filtered.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: _buildEmptyState(
                          context,
                          icon: Icons.search_off_rounded,
                          message: context.l10n.stockNoMatches,
                          subtitle: context.l10n.stockTryDifferentSearch,
                        ),
                      )
                    else
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        sliver: SliverList.separated(
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            return TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: 1),
                              duration: Duration(milliseconds: 280 + (index * 40).clamp(0, 200)),
                              curve: Curves.easeOutCubic,
                              builder: (context, t, child) {
                                return Opacity(
                                  opacity: t,
                                  child: Transform.translate(
                                    offset: Offset(0, 12 * (1 - t)),
                                    child: child,
                                  ),
                                );
                              },
                              child: _buildStockCard(context, filtered[index], index),
                            );
                          },
                        ),
                      ),
                    SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  ],
                ),
              );
            },
            error: (message) => _buildErrorState(context, message),
            noInternet: () => _buildErrorState(context, context.l10n.noInternetConnection, isNoInternet: true),
          ),
        );
      },
    );
  }

  Widget _buildStockCard(BuildContext context, ReportingDateModel dateData, int index) {
    final l10n = context.l10n;
    final scheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;
    final date = DateTime.parse(dateData.reportingDate);

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(16.r),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          context.router.push(PreviousStockDetailsRoute(reportingDate: dateData.reportingDate));
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: scheme.outlineVariant.withOpacity(0.65)),
          ),
          child: Padding(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.calendar_month_rounded, color: scheme.primary, size: 22.r),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.stockLongDateLabel(date),
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: scheme.onSurface,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            l10n.stockCardSummary(
                              l10n.formatCount(dateData.recordCount),
                              l10n.formatCount(dateData.uniqueItems),
                              l10n.formatCount(dateData.uniqueLocations),
                            ),
                            style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, color: scheme.onSurfaceVariant, size: 22.r),
                  ],
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    _infoChip(
                      context,
                      Icons.scale_rounded,
                      l10n.stockQtyChipLabel(dateData.totalQuantity),
                      scheme.secondaryContainer,
                      scheme.onSecondaryContainer,
                    ),
                    _infoChip(
                      context,
                      Icons.payments_outlined,
                      l10n.stockMoneyChipLabel(currencySymbol, dateData.totalValue.round()),
                      scheme.primaryContainer,
                      scheme.onPrimaryContainer,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoChip(
    BuildContext context,
    IconData icon,
    String text,
    Color bg,
    Color fg,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bg.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.r, color: fg),
          SizedBox(width: 6.w),
          Text(
            text,
            style: context.theme.textTheme.labelMedium?.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context, {
    required IconData icon,
    required String message,
    String? subtitle,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final scheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 72.r, color: scheme.onSurfaceVariant.withOpacity(0.35)),
            SizedBox(height: 20.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            if (subtitle != null) ...[
              SizedBox(height: 8.h),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant, height: 1.35),
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: 24.h),
              FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.upload_file_rounded),
                label: Text(actionLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message, {bool isNoInternet = false}) {
    final scheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isNoInternet ? Icons.wifi_off_rounded : Icons.error_outline_rounded,
              size: 72.r,
              color: scheme.error.withOpacity(0.65),
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            FilledButton.tonalIcon(
              onPressed: _loadData,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
