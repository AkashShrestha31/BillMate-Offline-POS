import 'dart:io';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/pdf_export_option_tile.dart';
import 'package:hotel/src/features/action/data/models/request/delete_item_request.dart';
import 'package:hotel/src/features/action/data/models/request/item_request_params.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:hotel/src/features/action/presentation/cubit/item_cubit.dart';
import 'package:hotel/src/core/helpers/item_image_helper.dart';
import 'package:hotel/src/core/helpers/item_search_helper.dart';
import 'package:hotel/src/features/action/presentation/widgets/item_code_sheet.dart';
import 'package:hotel/src/features/order/presentation/utils/order_ui_helpers.dart';
import 'package:hotel/src/core/constants/app_empty_state_assets.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/core/widget/list_empty_state.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/widget/freemium_access_scope.dart';
import 'package:hotel/src/core/widget/freemium_record_gate.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';
import 'package:hotel/src/features/settings/presentation/live_stock_issue_guard.dart';
import 'package:hotel/src/features/settings/presentation/live_stock_on_hand_sheet.dart';
import 'package:hotel/constants.dart';
// import 'package:hotel/src/features/action/presentation/pages/merge_items_page.dart';

@RoutePage()
class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({
    super.key,
    this.initialCategory,
  });

  /// When set, lists only items belonging to this category.
  final String? initialCategory;

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final ValueNotifier<List<ItemModel>> _allItemsNotifier = ValueNotifier([]);
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier(false);
  final ValueNotifier<PaginationModel?> _paginationNotifier = ValueNotifier(null);
  final ValueNotifier<bool> _hasMoreNotifier = ValueNotifier(false);

  late TabController _tabController;
  bool _hasInitialData = false;
  bool _listenToTabChanges = false;

  bool get _isCategoryView {
    final category = widget.initialCategory?.trim();
    return category != null && category.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    if (!_isCategoryView) {
      _tabController.addListener(_onTabChanged);
    }
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (getIt.isRegistered<LiveStockTrackingService>()) {
        getIt<LiveStockTrackingService>().refreshCache();
      }
      _loadItems();
      _listenToTabChanges = true;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (_searchController.text.isEmpty) {
        final cubit = context.read<ItemCubit>();
        if (cubit.hasMore && !cubit.isLoadingMore) {
          cubit.loadMoreItems();
        }
      }
    }
  }

  void _onTabChanged() {
    if (!_listenToTabChanges) return;
    if (_tabController.indexIsChanging) return;
    _loadItems();
  }

  /// Matches API query param `for`: Both | Sales | Purchases.
  /// Category drill-down omits this so Sales and Purchase items both appear.
  String? _forFilterForActiveTab() {
    if (_isCategoryView) return null;
    switch (_tabController.index) {
      case 1:
        return 'Sales';
      case 2:
        return 'Purchases';
      default:
        return 'Both';
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    _allItemsNotifier.dispose();
    _isLoadingNotifier.dispose();
    _paginationNotifier.dispose();
    _hasMoreNotifier.dispose();
    super.dispose();
  }

  void _performSearch() {
    _loadItems();
  }

  void _loadItems() {
    final query = _searchController.text.trim();
    context.read<ItemCubit>().getItems(
          params: ItemRequestParams(
            page: 1,
            perPage: _isCategoryView ? 200 : 10,
            forFilter: _forFilterForActiveTab(),
            excludeZeroSales: false,
            sortBy: 'name',
            sortOrder: 'asc',
            search: query.isEmpty ? null : query,
            category: widget.initialCategory,
          ),
        );
  }

  void _navigateToCreatePage() async {
    final result = await context.router.push(
      ItemEditRoute(
        isEditing: false,
        initialCategory: widget.initialCategory,
      ),
    );

    if (result == true) {
      _performSearch();
    }
  }

  void _navigateToBulkAddPage() async {
    // `ItemCubit.bulkCreateItems()` already refreshes the list and waits for
    // completion, so no need to re-fetch here after returning.
    await context.router.push(const BulkAddItemsRoute());
  }

  void _showAddOptionsSheet() {
    final theme = Theme.of(context);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  ctx.l10n.itemAddSheetTitle,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                verticalMarginSmall,
                const Divider(),
                verticalMarginMedium,
                PdfExportOptionTile(
                  icon: Icons.add,
                  title: ctx.l10n.itemSingleAdd,
                  color: theme.colorScheme.primary,
                  onTap: () {
                    Navigator.pop(ctx);
                    _navigateToCreatePage();
                  },
                ),
                verticalMarginLarge,
                PdfExportOptionTile(
                  icon: Icons.playlist_add,
                  title: ctx.l10n.itemBulkAdd,
                  color: theme.colorScheme.primary,
                  onTap: () {
                    Navigator.pop(ctx);
                    _navigateToBulkAddPage();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToEditPage(ItemModel item) async {
    final result = await context.router.push(ItemEditRoute(item: item, isEditing: true));

    if (result == true) {
      _performSearch();
    }
  }

  void _showDeleteDialog(ItemModel item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(context.l10n.itemDeleteTitle),
        content: Text(context.l10n.itemDeleteConfirm(item.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ItemCubit>().deleteItem(
                    request: DeleteItemRequest(
                      itemName: item.name,
                      confirmDelete: true,
                      forceDelete: false,
                      deleteStockEntries: false,
                      deletedBy: context.employeeData!.email.toString(),
                    ),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: context.theme.colorScheme.onPrimary,
            ),
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );
  }

  bool _canSetOnHand(ItemModel item) {
    final tracking = liveStockOrNull();
    if (tracking == null || !tracking.enabled) return false;
    return item.itemType?.trim().toLowerCase() != 'service';
  }

  void _showCardMenu(BuildContext context, ItemModel item) {
    final theme = Theme.of(context);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  item.name,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                verticalMarginSmall,
                const Divider(),
                verticalMarginMedium,
                PdfExportOptionTile(
                  icon: Icons.qr_code_2,
                  title: context.l10n.itemBarcodeLabel,
                  color: context.theme.colorScheme.primary,
                  onTap: () {
                    Navigator.pop(sheetContext);
                    final sku = itemSku(item);
                    showItemCodeSheet(
                      context,
                      itemName: item.name,
                      code: itemScannableCode(item),
                      usesSku: sku != null,
                    );
                  },
                ),
                verticalMarginLarge,
                PdfExportOptionTile(
                  icon: Icons.edit,
                  title: context.l10n.itemEditTitle,
                  color: context.theme.colorScheme.primary,
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _navigateToEditPage(item);
                  },
                ),
                if (_canSetOnHand(item)) ...[
                  verticalMarginLarge,
                  PdfExportOptionTile(
                    icon: Icons.inventory_2_outlined,
                    title: context.l10n.liveStockSetOnHand,
                    color: context.theme.colorScheme.primary,
                    onTap: () async {
                      Navigator.pop(sheetContext);
                      await Future<void>.delayed(
                        const Duration(milliseconds: 150),
                      );
                      if (!context.mounted) return;
                      final saved = await showLiveStockOnHandSheet(
                        context,
                        itemName: item.name,
                        itemType: item.itemType,
                      );
                      if (saved && context.mounted) {
                        context.showKiiSnackBarSuccess(
                          context.l10n.liveStockOnHandSaved,
                        );
                      }
                    },
                  ),
                ],
                verticalMarginLarge,
                PdfExportOptionTile(
                  icon: Icons.delete,
                  title: context.l10n.itemDeleteTitle,
                  color: context.theme.colorScheme.primary,
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showDeleteDialog(item);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLow,
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(
          widget.initialCategory == null
              ? context.l10n.itemsTitle
              : _categoryDisplayName(widget.initialCategory!),
        ),

        elevation: 0,
        centerTitle: false,
        actions: [
          // Merge items entry — restore import for `merge_items_page.dart` when re-enabled.
          // GestureDetector(
          //     onTap: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => const MergeItemsPage()));
          //     },
          //     child: Icon(Icons.merge).pOnly(right: context.theme.appTheme.spacing12)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddOptionsSheet,
        backgroundColor: context.theme.colorScheme.primary,
        foregroundColor: context.theme.colorScheme.onPrimary,
        child: Icon(Icons.add),
      ),
      body: FreemiumAccessHost(
        feature: FreemiumFeature.item,
        child: BlocConsumer<ItemCubit, ItemState>(
        listener: (context, state) {
          state.maybeWhen(
            loading: () {
              _isLoadingNotifier.value = true;
            },
            success: (response, hasMore) {
              _applyItemsResponse(response, hasMore);
            },
            error: (message) {
              _isLoadingNotifier.value = false;
              if (_hasInitialData) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red.shade400,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }
            },
            deleted: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.itemDeletedSuccess),
                  backgroundColor: Colors.green.shade400,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
              _performSearch();
            },
            orElse: () {
              _isLoadingNotifier.value = false;
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            // Show initial loading only if no data
            loading: () {
              if (!_hasInitialData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(strokeWidth: 3),
                      const SizedBox(height: 20),
                      Text(
                        context.l10n.itemLoading,
                        style: AppFonts.interStyle(
                          fontSize: 16,
                          color: context.theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return _buildContent();
            },
            success: (response, hasMore) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                _applyItemsResponse(response, hasMore);
              });
              return _buildContent();
            },
            // Show error only if no data
            error: (message) {
              if (!_hasInitialData) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.errorContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.error_outline,
                            size: 48,
                            color: context.theme.colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          context.l10n.itemErrorTitle,
                          style: AppFonts.interStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message,
                          style: AppFonts.interStyle(
                            fontSize: 14,
                            color: context.theme.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _performSearch,
                          icon: Icon(Icons.refresh, size: 18),
                          label: Text(context.l10n.itemTryAgain),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.theme.colorScheme.primary,
                            foregroundColor: context.theme.colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return _buildContent();
            },
            orElse: () => _buildContent(),
          );
        },
      ),
      ),
    );
  }

  void _applyItemsResponse(ItemResponseModel response, bool hasMore) {
    var items = response.data;
    final category = widget.initialCategory;
    if (category != null && category.trim().isNotEmpty) {
      items = items
          .where((item) => itemBelongsToCategory(item, category))
          .toList(growable: false);
    }
    _hasInitialData = true;
    _isLoadingNotifier.value = false;
    _allItemsNotifier.value = items;
    _paginationNotifier.value = response.pagination;
    _hasMoreNotifier.value = hasMore;
  }

  Widget _buildContent() {
    return Column(
      children: [
        // Search Bar
        _buildSearchBar(),
        if (!_isCategoryView)
          Container(
          color: context.theme.colorScheme.surface,
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.only(right: 28.w),
            labelColor: context.theme.colorScheme.primary,
            unselectedLabelColor: context.theme.colorScheme.inverseSurface,
            indicatorColor: context.theme.colorScheme.primary,
            dividerColor: Colors.transparent,
            labelStyle: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.theme.colorScheme.primary,
            ),
            unselectedLabelStyle: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.theme.colorScheme.inverseSurface,
            ),

            tabs: [
              Tab(text: context.l10n.localizedItemTabLabel('Both')),
              Tab(text: context.l10n.localizedItemTabLabel('Sales')),
              Tab(text: context.l10n.localizedItemTabLabel('Purchases')),
            ],
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<PaginationModel?>(
            valueListenable: _paginationNotifier,
            builder: (context, pagination, child) {
              return ValueListenableBuilder<bool>(
                valueListenable: _hasMoreNotifier,
                builder: (context, hasMore, child) {
                  if (_isCategoryView) {
                    return _buildTabContent(pagination, hasMore);
                  }
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _buildTabContent(pagination, hasMore),
                      _buildTabContent(pagination, hasMore),
                      _buildTabContent(pagination, hasMore),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  static const _searchBarHeight = 52.0;

  Widget _buildSearchBar() {
    final scheme = context.theme.colorScheme;
    return Container(
      color: scheme.surface,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _searchController,
              builder: (context, value, child) {
                return CustomTextFormField(
                  controller: _searchController,
                  height: _searchBarHeight,
                  hint: context.l10n.itemSearchHint,
                  suffixIcon: value.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: scheme.onSurfaceVariant, size: 20),
                          onPressed: () {
                            _searchController.clear();
                            _performSearch();
                          },
                        )
                      : null,
                  style: AppFonts.interStyle(fontSize: 14),
                  onFieldSubmitted: (_) => _performSearch(),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: _searchBarHeight,
            width: _searchBarHeight,
            child: Material(
              color: scheme.primary,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: _performSearch,
                borderRadius: BorderRadius.circular(12),
                child: Center(
                  child: AppSearchIcon(
                    color: scheme.onPrimary,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(PaginationModel? pagination, bool hasMore) {
    final cubit = context.read<ItemCubit>();

    return RefreshIndicator(
      onRefresh: () async {
        _performSearch();
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildItemsList(),
            if (cubit.isLoadingMore)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ValueListenableBuilder<List<ItemModel>>(
              valueListenable: _allItemsNotifier,
              builder: (context, items, child) {
                if (!hasMore && items.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        context.l10n.itemNoMoreItems,
                        style: AppFonts.interStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsList() {
    return ValueListenableBuilder<List<ItemModel>>(
      valueListenable: _allItemsNotifier,
      builder: (context, itemsToShow, child) {
        return Container(

          margin: const EdgeInsets.symmetric(horizontal: 16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (itemsToShow.isEmpty && _searchController.text.isNotEmpty)
                ListEmptyState(
                  illustrationPath: AppEmptyStateAssets.inventory,
                  title: context.l10n.itemNoItemsFound,
                  subtitle: context.l10n.itemTryAdjustSearch,
                )
              else if (itemsToShow.isEmpty)
                ListEmptyState(
                  illustrationPath: AppEmptyStateAssets.inventory,
                  title: context.l10n.itemNoItemsAvailable,
                  subtitle: context.l10n.itemAddToGetStarted,
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemsToShow.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = itemsToShow[index];
                    return FreemiumRecordGate(
                      recordKey: item.name,
                      child: _buildItemCard(item),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItemCard(ItemModel item) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final typeLabel = item.itemType?.trim();
    final categoryLabel = item.category?.trim();
    final skuLabel = itemSku(item);

    return Material(
      color: scheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: scheme.outlineVariant.withOpacity(0.45)),
      ),
      child: InkWell(
        onTap: () => _showCardMenu(context, item),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildItemThumbnail(item.image, scheme),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    if (typeLabel != null && typeLabel.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      _itemMetaChip(
                        label: typeLabel,
                        background: scheme.primaryContainer.withOpacity(0.55),
                        foreground: scheme.onPrimaryContainer,
                      ),
                    ],
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        _itemMetaChip(
                          label: '$currencySymbol ${item.rate.toStringAsFixed(2)}',
                          background: scheme.surfaceContainerHighest.withOpacity(0.7),
                          foreground: scheme.onSurface,
                        ),
                        _itemMetaChip(
                          label: item.unit,
                          background: scheme.surfaceContainerHighest.withOpacity(0.7),
                          foreground: scheme.onSurfaceVariant,
                        ),
                        if (categoryLabel != null && categoryLabel.isNotEmpty)
                          _itemMetaChip(
                            label: categoryLabel,
                            background: scheme.secondaryContainer.withOpacity(0.45),
                            foreground: scheme.onSecondaryContainer,
                          ),
                        if (skuLabel != null)
                          _itemMetaChip(
                            label: 'SKU: $skuLabel',
                            background: scheme.tertiaryContainer.withOpacity(0.45),
                            foreground: scheme.onTertiaryContainer,
                          ),
                        if (getIt.isRegistered<LiveStockTrackingService>())
                          ListenableBuilder(
                            listenable: getIt<LiveStockTrackingService>(),
                            builder: (context, _) {
                              final tracking = getIt<LiveStockTrackingService>();
                              final type = item.itemType?.trim().toLowerCase();
                              if (!tracking.enabled || type == 'service') {
                                return const SizedBox.shrink();
                              }
                              final byLocation =
                                  tracking.onHandByLocation(item.name);
                              return Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                children: [
                                  _itemMetaChip(
                                    label: context.l10n.liveStockOnHand(
                                      LiveStockTrackingService.formatQty(
                                        tracking.onHand(item.name),
                                      ),
                                    ),
                                    background: scheme.primaryContainer
                                        .withOpacity(0.55),
                                    foreground: scheme.onPrimaryContainer,
                                  ),
                                  if (byLocation.length > 1)
                                    for (final entry in byLocation.entries)
                                      _itemMetaChip(
                                        label:
                                            '${entry.key}: ${LiveStockTrackingService.formatQty(entry.value)}',
                                        background: scheme
                                            .surfaceContainerHighest
                                            .withOpacity(0.7),
                                        foreground: scheme.onSurfaceVariant,
                                      ),
                                ],
                              );
                            },
                          ),
                      ],
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

  Widget _buildItemThumbnail(String? imageUrl, ColorScheme scheme) {
    const size = 64.0;
    final borderRadius = BorderRadius.circular(12);

    Widget placeholder() {
      return ColoredBox(
        color: scheme.surfaceContainerHighest.withOpacity(0.65),
        child: Center(
          child: Icon(
            Icons.inventory_2_outlined,
            size: 28,
            color: scheme.onSurfaceVariant.withOpacity(0.55),
          ),
        ),
      );
    }

    final raw = imageUrl?.trim();
    final resolved = raw != null && raw.isNotEmpty
        ? (resolveOrderItemImageUrl(raw) ?? raw)
        : null;
    final Widget child;
    if (resolved != null &&
        resolved.isNotEmpty &&
        ItemImageHelper.hasDisplayableImage(resolved)) {
      if (ItemImageHelper.isNetworkUrl(resolved)) {
        child = Image.network(
          resolved,
          fit: BoxFit.cover,
          width: size,
          height: size,
          errorBuilder: (_, __, ___) => placeholder(),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: scheme.primary,
                ),
              ),
            );
          },
        );
      } else {
        child = ItemImageHelper.buildImage(
          resolved,
          fit: BoxFit.cover,
          width: size,
          height: size,
          errorBuilder: (_, __, ___) => placeholder(),
        );
      }
    } else {
      child = placeholder();
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(width: size, height: size, child: child),
    );
  }

  Widget _itemMetaChip({
    required String label,
    required Color background,
    required Color foreground,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppFonts.interStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
      ),
    );
  }
}

String _categoryDisplayName(String fullName) {
  final idx = fullName.indexOf(' - ');
  if (idx >= 0 && idx + 3 < fullName.length) {
    return fullName.substring(idx + 3).trim();
  }
  return fullName;
}
