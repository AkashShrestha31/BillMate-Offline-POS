import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/services/reconciliation_pdf_export_service.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_report_response.dart';
import 'package:hotel/src/features/reconciliation/presentation/widgets/reconciliation_charts_sheet.dart';
import 'package:hotel/src/features/stock_adjustment/presentation/bloc/stock_adjustment_cubit.dart';

class ReconciliationDetailsPage extends StatefulWidget {
  final ReconciliationReportResponse data;

  const ReconciliationDetailsPage({
    super.key,
    required this.data,
  });

  @override
  State<ReconciliationDetailsPage> createState() =>
      _ReconciliationDetailsPageState();
}

class _ReconciliationDetailsPageState extends State<ReconciliationDetailsPage>
    with SingleTickerProviderStateMixin {
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Short', 'Over', 'Matching'];
  bool _isExporting = false;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _filterOptions.length, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    final filter = _filterOptions[_tabController.index];
    if (_selectedFilter == filter) return;
    setState(() => _selectedFilter = filter);
  }

  void _selectFilter(String filter) {
    final index = _filterOptions.indexOf(filter);
    if (index < 0) return;
    HapticFeedback.selectionClick();
    if (_tabController.index != index) {
      _tabController.animateTo(index);
    }
    setState(() => _selectedFilter = filter);
  }

  List<ReconciliationReportDetail> get _filteredDetails {
    if (_selectedFilter == 'All') return widget.data.reconciliationDetails;
    return widget.data.reconciliationDetails
        .where((detail) => detail.status == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<StockAdjustmentCubit, StockAdjustmentState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              error: (message) {
                AppLoadingOverlay.of(context).hide();
                context.showKiiSnackBarSuccess(message);
              },
              success: (response) {
                AppLoadingOverlay.of(context).hide();
                context.showKiiSnackBarSuccess(response.data.message);
                Navigator.of(context).pop();
              },
              loading: () {
                AppLoadingOverlay.of(context).show();
                // No action needed
              },
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          leading: const AppBarIosBackButton(color: Colors.black87),
          title: Text('Stock Reconciliation'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              color: Colors.grey.shade200,
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'Export PDF',
              icon: Icon(Icons.picture_as_pdf_outlined),
              onPressed: _isExporting ? null : _exportToPdf,
            ),
            IconButton(
              tooltip: 'More options',
              icon: Icon(Icons.more_vert),
              onPressed: _showMoreOptionsSheet,
            ),
          ],
        ),
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                _buildMainCard(),
              ],
            ),
            if (_isExporting) _buildExportOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildExportOverlay() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  'Generating PDF...',
                  style: AppFonts.interStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _exportToPdf() async {
    setState(() => _isExporting = true);

    try {
      final file = await ReconciliationPdfExportService.exportToPdf(
        data: widget.data,
        filterType: _selectedFilter,
      );

      setState(() => _isExporting = false);

      // Show success dialog with options
      if (!mounted) return;

      _showPdfExportedSheet(file);
    } catch (e) {
      setState(() => _isExporting = false);

      if (!mounted) return;
      _showSnackbar(
        'Failed to export PDF: ${e.toString()}',
        Colors.red,
      );
    }
  }

  Future<void> _sharePdf() async {
    setState(() => _isExporting = true);

    try {
      final file = await ReconciliationPdfExportService.exportToPdf(
        data: widget.data,
        filterType: _selectedFilter,
      );

      setState(() => _isExporting = false);

      // TODO: Implement share functionality using share_plus package
      _showSnackbar(
        'PDF generated. Add share_plus package for sharing functionality.',
        Colors.blue,
      );

      // Open the file for now
      await ReconciliationPdfExportService.openPdf(file);
    } catch (e) {
      setState(() => _isExporting = false);

      if (!mounted) return;

      _showSnackbar(
        'Failed to generate PDF: ${e.toString()}',
        Colors.red,
      );
    }
  }

  Widget _buildMainCard() {
    final filteredDetails = _filteredDetails;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.sp),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSummaryHeader(),
          _buildFilterTabs(),
          Divider(height: 1, color: Colors.grey.shade200),
          if (filteredDetails.isEmpty)
            _buildEmptyState()
          else
            ...filteredDetails.asMap().entries.map((entry) {
              final index = entry.key;
              final detail = entry.value;
              return Column(
                children: [
                  if (index > 0) Divider(height: 1, color: Colors.grey.shade200),
                  _buildItemRow(detail),
                ],
              );
            }),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader() {
    final summary = widget.data.summary;
    final isNegative = summary.totalVarianceValue < 0;
    final varianceColor = isNegative ? Colors.red.shade600 : Colors.green.shade600;
    final formattedVariance =
        '$currencySymbol ${summary.totalVarianceValue.abs().toStringAsFixed(2)}';

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.reportDate,
            style: AppFonts.interStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    _showVarianceBreakdown(context);
                  },
                  child: Text(
                    isNegative ? '- $formattedVariance' : '+ $formattedVariance',
                    style: AppFonts.interStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: varianceColor,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'View charts',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                icon: Icon(
                  Icons.bar_chart_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 26,
                ),
                onPressed: () {
                  HapticFeedback.selectionClick();
                  showReconciliationChartsSheet(
                    context: context,
                    data: widget.data,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${summary.totalItems} items · ${isNegative ? 'Loss' : 'Gain'}',
            style: AppFonts.interStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          ReconciliationChartPreview(summary: summary),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return TabBar(
      controller: _tabController,
      isScrollable: false,
      tabAlignment: TabAlignment.fill,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 3,
      indicatorPadding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
      labelColor: primary,
      unselectedLabelColor: Colors.grey.shade700,
      indicatorColor: primary,
      dividerColor: Colors.transparent,
      labelStyle: AppFonts.interStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: AppFonts.interStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      onTap: (_) => HapticFeedback.selectionClick(),
      tabs: _filterOptions
          .map((filter) => Tab(text: _tabLabel(filter)))
          .toList(),
    );
  }

  String _tabLabel(String filter) {
    switch (filter) {
      case 'Matching':
        return 'Match';
      default:
        return filter;
    }
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(Icons.filter_list_off, size: 36, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            'No $_selectedFilter items',
            style: AppFonts.interStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => _selectFilter('All'),
            child: Text('Show all'),
          ),
        ],
      ),
    );
  }

  Widget _sheetListDivider(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: scheme.outlineVariant.withValues(alpha: 0.5),
    );
  }

  Widget _buildSheetInfoList(List<(String label, String value)> rows) {
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: rows.length,
      separatorBuilder: (context, _) => _sheetListDivider(context),
      itemBuilder: (context, index) {
        final row = rows[index];
        return ListTile(
          title: Text(
            row.$1,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Text(
            row.$2,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: scheme.primary,
            ),
          ),
        );
      },
    );
  }

  void _showMoreOptionsSheet() {
    final options = <(String, VoidCallback)>[
      ('Report details', _showReportInfoSheet),
      ('How it works', () => _showCalculationHelp(context)),
      ('Share PDF', _sharePdf),
    ];

    showAppBottomSheet<void>(
      context: context,
      title: 'Options',
      maxHeightFactor: 0.42,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        separatorBuilder: (context, _) => _sheetListDivider(context),
        itemBuilder: (context, index) {
          final option = options[index];
          return AppBottomSheetListTile(
            title: option.$1,
            onTap: () {
              HapticFeedback.selectionClick();
              Navigator.pop(context);
              option.$2();
            },
          );
        },
      ),
    );
  }

  void _showPdfExportedSheet(File file) {
    final scheme = Theme.of(context).colorScheme;

    showAppBottomSheet<void>(
      context: context,
      title: 'PDF exported',
      maxHeightFactor: 0.42,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 12),
            child: Text(
              'Your reconciliation report has been exported successfully.',
              style: AppFonts.interStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
          ),
          _sheetListDivider(context),
          AppBottomSheetListTile(
            title: 'Open PDF',
            trailing: Icon(Icons.open_in_new_rounded, color: scheme.primary),
            onTap: () async {
              HapticFeedback.selectionClick();
              Navigator.pop(context);
              await ReconciliationPdfExportService.openPdf(file);
            },
          ),
        ],
      ),
    );
  }

  void _showReportInfoSheet() {
    showAppBottomSheet<void>(
      context: context,
      title: 'Report details',
      maxHeightFactor: 0.45,
      child: _buildSheetInfoList([
        ('Date', widget.data.reportDate),
        ('Period', widget.data.period),
        ('Method', widget.data.reconciliationMethod),
        ('Status', widget.data.success ? 'Success' : 'Failed'),
      ]),
    );
  }

  Widget _buildItemRow(ReconciliationReportDetail detail) {
    final statusColor = _getStatusColor(detail.status);

    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        _openItemSheet(detail);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail.item,
                    style: AppFonts.interStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    detail.location,
                    style: AppFonts.interStyle(fontSize: 12, color: Colors.grey.shade600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${detail.variance > 0 ? '+' : ''}${detail.variance}',
                  style: AppFonts.interStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
                Text(
                  '$currencySymbol ${detail.varianceValue.abs().toStringAsFixed(2)}',
                  style: AppFonts.interStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }

  void _openItemSheet(ReconciliationReportDetail detail) {
    final varianceLabel =
        '${detail.variance > 0 ? '+' : ''}${detail.variance}';

    showAppBottomSheet<void>(
      context: context,
      title: detail.item,
      maxHeightFactor: 0.62,
      scrollableBody: true,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
              child: Text(
                detail.location,
                style: AppFonts.interStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            _buildSheetInfoList([
              ('Starting stock', detail.startingStock.toString()),
              ('Purchases', detail.totalPurchases.toString()),
              ('Sales', detail.totalSales.toString()),
              ('Stock in', detail.totalStockIn.toString()),
              ('Stock out', detail.totalStockOut.toString()),
              ('Expected', detail.expectedStock.toString()),
              ('Actual', detail.actualStock.toString()),
              ('Variance', varianceLabel),
            ]),
            // Calculation and adjust stock temporarily hidden.
            // const SizedBox(height: 8),
            // _sheetListDivider(context),
            // AppBottomSheetListTile(
            //   title: 'Calculation',
            //   onTap: () {
            //     Navigator.pop(context);
            //     _showCalculationDetails(detail);
            //   },
            // ),
            // _sheetListDivider(context),
            // AppBottomSheetListTile(
            //   title: 'Adjust stock',
            //   trailingText: varianceLabel,
            //   onTap: () {
            //     Navigator.pop(context);
            //     _adjustStock(detail);
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'short':
        return Colors.red.shade600;
      case 'over':
        return Colors.green.shade600;
      case 'matching':
        return Colors.orange.shade600;
      default:
        return Colors.blue.shade600;
    }
  }

  void _showCalculationHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How Calculation Works',
                style: AppFonts.interStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Expected Stock Formula:',
                style: AppFonts.interStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Starting Stock + Purchases + Stock In - Sales - Stock Out',
                style: AppFonts.interStyle(
                  fontSize: 14,
                  color: Colors.blue.shade600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Variance Calculation:',
                style: AppFonts.interStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Actual Stock - Expected Stock',
                style: AppFonts.interStyle(
                  fontSize: 14,
                  color: Colors.blue.shade600,
                ),
              ),
              const SizedBox(height: 16),
              Text('• Positive variance = Overstocking'),
              Text('• Negative variance = Shortage'),
              Text('• Zero variance = Perfect match'),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Got it'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showVarianceBreakdown(BuildContext context) {
    final summary = widget.data.summary;
    final totalColor = summary.totalVarianceValue < 0
        ? Colors.red.shade600
        : Colors.green.shade600;

    showAppBottomSheet<void>(
      context: context,
      title: 'Variance breakdown',
      maxHeightFactor: 0.38,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildColoredSheetRow(
            'Total variance',
            '$currencySymbol ${summary.totalVarianceValue.toStringAsFixed(2)}',
            totalColor,
          ),
          _sheetListDivider(context),
          _buildColoredSheetRow(
            'Over stock value',
            '$currencySymbol ${summary.totalOverValue.toStringAsFixed(2)}',
            Colors.green.shade600,
          ),
          _sheetListDivider(context),
          _buildColoredSheetRow(
            'Short stock value',
            '$currencySymbol ${summary.totalShortValue.toStringAsFixed(2)}',
            Colors.red.shade600,
          ),
        ],
      ),
    );
  }

  Widget _buildColoredSheetRow(String label, String value, Color color) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(
        label,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        value,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  void _showCalculationDetails(ReconciliationReportDetail detail) {
    final statusColor = _getStatusColor(detail.status);
    final varianceLabel =
        '${detail.variance > 0 ? '+' : ''}${detail.variance}';

    showAppBottomSheet<void>(
      context: context,
      title: detail.item,
      maxHeightFactor: 0.55,
      scrollableBody: true,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              child: Text(
                'Formula: ${detail.calculationFormula}',
                style: AppFonts.interStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            _buildSheetInfoList([
              ('Starting stock', detail.startingStock.toString()),
              ('Purchases', detail.totalPurchases.toString()),
              ('Sales', detail.totalSales.toString()),
              ('Stock in', detail.totalStockIn.toString()),
              ('Stock out', detail.totalStockOut.toString()),
              ('Expected stock', detail.expectedStock.toString()),
              ('Actual stock', detail.actualStock.toString()),
            ]),
            _sheetListDivider(context),
            _buildColoredSheetRow('Variance', varianceLabel, statusColor),
          ],
        ),
      ),
    );
  }

  void _adjustStock(ReconciliationReportDetail detail) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Adjust Stock for ${detail.item}',
                style: AppFonts.interStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Stock adjustment interface would be implemented here.',
                style: AppFonts.interStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showSnackbar(
                            'Stock adjustment initiated', Colors.green);
                      },
                      child: Text('Adjust'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
