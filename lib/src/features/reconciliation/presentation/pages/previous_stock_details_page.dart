import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_bulk_edit_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_details_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_edit_item_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/edit_summary_model.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_item_model.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_cubit.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_delete_cubit.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_details_cubit.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_edit_cubit.dart';
import 'package:hotel/src/features/reconciliation/presentation/widgets/delete_confirmation_dialog.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

@RoutePage()
class PreviousStockDetailsPage extends StatefulWidget {
  final String reportingDate;
  const PreviousStockDetailsPage({super.key, required this.reportingDate});

  @override
  State<PreviousStockDetailsPage> createState() => _PreviousStockDetailsPageState();
}

class _PreviousStockDetailsPageState extends State<PreviousStockDetailsPage> {
  late TextEditingController _dateController;
  final _batchController = TextEditingController();
  final _itemController = TextEditingController();
  final _locationController = TextEditingController();
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _dateController.dispose();
    _batchController.dispose();
    _itemController.dispose();
    _locationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _fetchStockDetails() {
    context.read<PreviousStockDetailsCubit>().getPreviousStockDetails(
          params: PreviousStockDetailsRequestParams(
            reportingDate: _dateController.text,
            batchNumber: _batchController.text.isEmpty ? null : _batchController.text,
            item: _itemController.text.isEmpty ? null : _itemController.text,
            location: _locationController.text.isEmpty ? null : _locationController.text,
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: widget.reportingDate);
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text);
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _fetchStockDetails();
      },
    );
  }

  List<PreviousStockItemModel> _filteredStockItems(List<PreviousStockItemModel> items) {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return items;
    return items.where((e) {
      return e.item.toLowerCase().contains(q) ||
          e.batchNumber.toLowerCase().contains(q) ||
          e.location.toLowerCase().contains(q) ||
          e.name.toLowerCase().contains(q);
    }).toList();
  }

  Future<void> _onRefresh() async {
    _fetchStockDetails();
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  void _showFilterSheet() {
    final scheme = Theme.of(context).colorScheme;
    HapticFeedback.lightImpact();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) {
        final sheetL10n = ctx.l10n;
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 8,
            bottom: MediaQuery.viewInsetsOf(ctx).bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  sheetL10n.stockFilterTitle,
                  style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _batchController,
                  decoration: InputDecoration(
                    labelText: sheetL10n.stockBatchNumber,
                    hintText: sheetL10n.stockOptionalHint,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _itemController,
                  decoration: InputDecoration(
                    labelText: sheetL10n.item,
                    hintText: sheetL10n.stockOptionalHint,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: sheetL10n.stockLocation,
                    hintText: sheetL10n.stockOptionalHint,
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    Navigator.pop(ctx);
                    _fetchStockDetails();
                  },
                  child: Text(sheetL10n.stockApplyFilters),
                ),
                TextButton(
                  onPressed: () {
                    _batchController.clear();
                    _itemController.clear();
                    _locationController.clear();
                    HapticFeedback.selectionClick();
                  },
                  child: Text(sheetL10n.stockClearFields, style: AppFonts.interStyle(color: scheme.primary)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formattedReportingTitle(BuildContext context) {
    try {
      final d = DateTime.parse(widget.reportingDate);
      return context.l10n.stockShortDateLabel(d);
    } catch (_) {
      return context.l10n.localizeDigits(widget.reportingDate);
    }
  }

  Widget _buildStockLineCard(BuildContext context, PreviousStockItemModel item) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final subtitle = [
      if (item.batchNumber.isNotEmpty) item.batchNumber,
      if (item.location.isNotEmpty) item.location,
    ].join(' · ');

    return Material(
      color: scheme.surface,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
        side: BorderSide(color: scheme.outlineVariant.withOpacity(0.5)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => HapticFeedback.selectionClick(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  context.l10n.formatCount(item.previousQuantity),
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.item,
                      style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openExcelEditor(List<PreviousStockItemModel> stockItems) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<PreviousStockEditCubit>(),
          child: PreviousStockExcelEditorPage(
            stockItems: stockItems,
            reportingDate: _dateController.text,
          ),
        ),
      ),
    );

    if (result == true) {
      // Refresh the data after editing
      _fetchStockDetails();
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        reportingDate: _dateController.text,
        onConfirm: () {
          context.read<PreviousStockDeleteCubit>().deletePreviousStockByDate(
                reportingDate: _dateController.text,
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PreviousStockDeleteCubit, PreviousStockDeleteState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () {
                AppLoadingOverlay.of(context).show();
              },
              success: (response) {
                // Don't hide loading yet - wait for PreviousStockCubit to finish
                context.read<PreviousStockCubit>().getPreviousStock(
                      params: PreviousStockRequestParams(
                        sortOrder: 'desc',
                        limit: 100,
                        onlyActive: true,
                      ),
                    );
                context.showKiiSnackBarSuccess(response.message);
              },
              error: (message) {
                AppLoadingOverlay.of(context).hide();

                // Show error snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );

                // Reset cubit state
                context.read<PreviousStockDeleteCubit>().reset();
              },
              noInternet: () {
                AppLoadingOverlay.of(context).hide();

                // Show no internet snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context.l10n.stockNoInternetRetry),
                    backgroundColor: Colors.orange,
                    behavior: SnackBarBehavior.floating,
                  ),
                );

                // Reset cubit state
                context.read<PreviousStockDeleteCubit>().reset();
              },
            );
          },
        ),
        BlocListener<PreviousStockCubit, PreviousStockState>(
          listener: (context, state) {
            // Only handle if PreviousStockDeleteCubit is in success state (delete completed)
            final deleteState = context.read<PreviousStockDeleteCubit>().state;
            deleteState.maybeWhen(
              success: (_) {
                // Delete was successful, now handle PreviousStockCubit response
                state.maybeWhen(
                  success: (responseModel) {
                    // Hide loading overlay
                    AppLoadingOverlay.of(context).hide();
                    // Pop the page
                    context.router.maybePop();
                    // Reset cubit state
                    context.read<PreviousStockDeleteCubit>().reset();
                  },
                  error: (message) {
                    // Even if refresh fails, hide loading and pop after delete
                    AppLoadingOverlay.of(context).hide();
                    context.router.maybePop();
                    context.read<PreviousStockDeleteCubit>().reset();
                  },
                  orElse: () {},
                );
              },
              orElse: () {
                // Not in a delete operation, ignore
              },
            );
          },
        ),
      ],
      child: BlocBuilder<PreviousStockDetailsCubit, PreviousStockDetailsState>(
        builder: (context, detailsState) {
          final scheme = Theme.of(context).colorScheme;
          final textTheme = Theme.of(context).textTheme;

          return Scaffold(
            backgroundColor: scheme.surfaceContainerLowest,
            appBar: AppBar(
              leading: const AppBarIosBackButton(),
              title: Text(
                _formattedReportingTitle(context),
                style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              actions: [
                ...detailsState.maybeWhen(
                  success: (response) {
                    if (response.stockItems.isEmpty) return <Widget>[];
                    return [
                      IconButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          _showDeleteConfirmation();
                        },
                        icon: const AppDeleteIcon(),
                        tooltip: context.l10n.stockDeleteAllTooltip,
                      ),
                    ];
                  },
                  orElse: () => <Widget>[],
                ),
              ],
            ),
            body: detailsState.when(
              initial: () => Center(
                child: CircularProgressIndicator(color: scheme.primary),
              ),
              loading: () => Center(
                child: CircularProgressIndicator(color: scheme.primary),
              ),
              success: (response) {
                if (response.stockItems.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory_2_outlined, size: 64.r, color: scheme.onSurfaceVariant.withOpacity(0.4)),
                          SizedBox(height: 16.h),
                          Text(
                            context.l10n.stockNoItemsFound,
                            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            context.l10n.stockNoItemsSubtitle,
                            style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24.h),
                          FilledButton.tonalIcon(
                            onPressed: _showFilterSheet,
                            icon: Icon(Icons.tune_rounded),
                            label: Text(context.l10n.stockAdjustFilters),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final filtered = _filteredStockItems(response.stockItems);
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            controller: _searchController,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              hintText: context.l10n.stockSearchItemHint,
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
                    Expanded(
                      child: filtered.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.search_off_rounded, size: 48.r, color: scheme.onSurfaceVariant),
                                  SizedBox(height: 12.h),
                                  Text(
                                    context.l10n.stockNoMatches,
                                    style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    context.l10n.stockTryAnotherSearch,
                                    style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                                  ),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              color: scheme.primary,
                              onRefresh: _onRefresh,
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                                itemCount: filtered.length,
                                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                                itemBuilder: (context, index) {
                                  final item = filtered[index];
                                  return TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0, end: 1),
                                    duration: Duration(milliseconds: 240 + (index * 28).clamp(0, 160)),
                                    curve: Curves.easeOutCubic,
                                    builder: (context, t, child) {
                                      return Opacity(
                                        opacity: t,
                                        child: Transform.translate(
                                          offset: Offset(0, 10 * (1 - t)),
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: _buildStockLineCard(context, item),
                                  );
                                },
                              ),
                            ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: scheme.shadow.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        child: SizedBox(
                          width: double.infinity,
                          height: 52.h,
                          child: FilledButton.icon(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              _openExcelEditor(response.stockItems);
                            },
                            icon: Icon(Icons.edit_note_rounded),
                            label: Text(context.l10n.stockEditQuantities),
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (message) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline_rounded, size: 56.r, color: scheme.error.withOpacity(0.8)),
                      SizedBox(height: 16.h),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 24.h),
                      FilledButton.tonalIcon(
                        onPressed: _fetchStockDetails,
                        icon: Icon(Icons.refresh_rounded),
                        label: Text(context.l10n.retry),
                      ),
                    ],
                  ),
                ),
              ),
              noInternet: () => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_off_rounded, size: 56.r, color: scheme.onSurfaceVariant),
                      SizedBox(height: 16.h),
                      Text(
                        context.l10n.noInternetConnection,
                        style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 24.h),
                      FilledButton.tonalIcon(
                        onPressed: _fetchStockDetails,
                        icon: Icon(Icons.refresh_rounded),
                        label: Text(context.l10n.retry),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Excel Editor Page for Previous Stock
class PreviousStockExcelEditorPage extends StatefulWidget {
  final List<PreviousStockItemModel> stockItems;
  final String reportingDate;

  const PreviousStockExcelEditorPage({
    super.key,
    required this.stockItems,
    required this.reportingDate,
  });

  @override
  State<PreviousStockExcelEditorPage> createState() => _PreviousStockExcelEditorPageState();
}

class _PreviousStockExcelEditorPageState extends State<PreviousStockExcelEditorPage> {
  late List<StockItemEdit> _editableItems;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _initializeEditableItems();
  }

  void _initializeEditableItems() {
    _editableItems = widget.stockItems.map((item) {
      return StockItemEdit(
        originalItem: item,
        quantityController: TextEditingController(
          text: item.previousQuantity.toString(),
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (var item in _editableItems) {
      item.dispose();
    }
    super.dispose();
  }

  void _onQuantityChanged() {
    setState(() {
      _hasChanges = true;
    });
  }

  Future<void> _saveChanges() async {
    try {
      // Create request params using Freezed models (ONLY CHANGED ITEMS)
      final requestParams = _createRequestParams();

      if (requestParams.stockItems.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.stockNoChangesDetected),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      // Send to API via Cubit
      context.read<PreviousStockEditCubit>().bulkEditPreviousStock(params: requestParams);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.stockErrorPreparingChanges(e.toString())),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  PreviousStockBulkEditRequestParams _createRequestParams() {
    final List<PreviousStockEditItemParams> changedItems = [];

    for (var item in _editableItems) {
      // Get updated quantity
      final quantityText = item.quantityController.text.trim();
      final newQuantity = quantityText.isNotEmpty ? (double.tryParse(quantityText) ?? 0.0) : 0.0;
      final originalQuantity = item.originalItem.previousQuantity.toDouble();

      // ONLY ADD ITEMS THAT CHANGED
      if (newQuantity != originalQuantity) {
        changedItems.add(
          PreviousStockEditItemParams(
            name: item.originalItem.name,
            previousQuantity: newQuantity,
          ),
        );
      }
    }

    return PreviousStockBulkEditRequestParams(stockItems: changedItems);
  }

  void _showSuccessDialog(String message, EditSummaryModel summary) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            const SizedBox(width: 12),
            Text(dialogContext.l10n.stockUpdateSuccessful),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: AppFonts.interStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),

              // Summary
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.green.shade600, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          dialogContext.l10n.stockSummary,
                          style: AppFonts.interStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildSummaryRow(dialogContext.l10n.stockTotalRequested, dialogContext.l10n.formatCount(summary.totalRequested)),
                    _buildSummaryRow(dialogContext.l10n.stockSuccessfullyUpdated, dialogContext.l10n.formatCount(summary.successfullyUpdated), Colors.green),
                    if (summary.failed > 0) _buildSummaryRow(dialogContext.l10n.stockFailed, dialogContext.l10n.formatCount(summary.failed), Colors.red),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context, true); // Close editor and refresh
            },
            child: Text(dialogContext.l10n.done),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, [Color? valueColor]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppFonts.interStyle(fontSize: 13),
          ),
          Text(
            value,
            style: AppFonts.interStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 28),
            const SizedBox(width: 12),
            Text(context.l10n.stockUpdateFailed),
          ],
        ),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.okay),
          ),
        ],
      ),
    );
  }

  void _clearAllQuantities() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.stockClearAllQuantitiesTitle),
        content: Text(context.l10n.stockClearAllQuantitiesMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                for (var item in _editableItems) {
                  item.quantityController.text = '0';
                }
                _hasChanges = true;
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(context.l10n.stockClearAll),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PreviousStockEditCubit, PreviousStockEditState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {
            // Show loading dialog
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (loadingContext) => Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(loadingContext.l10n.stockUpdatingQuantities),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          success: (response) {
            // Close loading dialog
            Navigator.pop(context);

            // Show success dialog
            _showSuccessDialog(response.message, response.summary);

            // Reset cubit state
            context.read<PreviousStockEditCubit>().reset();
          },
          error: (message) {
            // Close loading dialog
            Navigator.pop(context);

            // Show error dialog
            _showErrorDialog(message);

            // Reset cubit state
            context.read<PreviousStockEditCubit>().reset();
          },
          noInternet: () {
            // Close loading dialog
            Navigator.pop(context);

            // Show no internet dialog
            _showErrorDialog(context.l10n.stockNoInternetRetry);

            // Reset cubit state
            context.read<PreviousStockEditCubit>().reset();
          },
        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          leading: const AppBarIosBackButton(color: Colors.black87),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.stockEditQuantitiesTitle,
                style: AppFonts.interStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                context.l10n.stockReportingDate(context.l10n.localizeDigits(widget.reportingDate)),
                style: AppFonts.interStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          actions: [
            TextButton.icon(
              onPressed: _clearAllQuantities,
              icon: Icon(Icons.clear_all, size: 18),
              label: Text(context.l10n.clear),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red.shade600,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Info Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade600, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      context.l10n.stockTotalItemsHint(context.l10n.formatCount(_editableItems.length)),
                      style: AppFonts.interStyle(
                        fontSize: 12,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Column Headers
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      '#',
                      style: AppFonts.interStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: Text(
                      context.l10n.stockItemName,
                      style: AppFonts.interStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Text(
                      context.l10n.quantity,
                      style: AppFonts.interStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Data Rows
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ListView.builder(
                    itemCount: _editableItems.length,
                    itemBuilder: (context, index) {
                      final item = _editableItems[index];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: index < _editableItems.length - 1
                                ? BorderSide(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  )
                                : BorderSide.none,
                          ),
                          color: index % 2 == 0 ? Colors.grey.shade50 : Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: Text(
                                context.l10n.formatCount(index + 1),
                                style: AppFonts.interStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.originalItem.item,
                                    style: AppFonts.interStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    context.l10n.stockBatchPrefix(item.originalItem.batchNumber),
                                    style: AppFonts.interStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: TextField(
                                controller: item.quantityController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (_) => _onQuantityChanged(),
                                decoration: InputDecoration(
                                  hintText: '0',
                                  hintStyle: AppFonts.interStyle(fontSize: 13, color: Colors.grey.shade400),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: Colors.blue.shade400, width: 1.5),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 10,
                                  ),
                                  isDense: true,
                                ),
                                style: AppFonts.interStyle(fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Bottom Buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(context.l10n.cancel),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: _hasChanges ? _saveChanges : null,
                        icon: Icon(Icons.check_circle),
                        label: Text(context.l10n.saveChanges),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey.shade300,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper class to manage editable stock items
class StockItemEdit {
  final PreviousStockItemModel originalItem;
  final TextEditingController quantityController;

  StockItemEdit({
    required this.originalItem,
    required this.quantityController,
  });

  void dispose() {
    quantityController.dispose();
  }
}
