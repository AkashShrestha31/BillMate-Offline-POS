import 'dart:async';
import 'package:hotel/constants.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart' show Listenable;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/app_empty_state_assets.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/list_empty_state.dart';
import 'package:hotel/src/core/widget/keyboard_done_bar.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/features/action/data/models/request/item_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:hotel/src/features/action/presentation/cubit/item_cubit.dart';
import 'package:hotel/src/features/action/presentation/cubit/party_cubit.dart';
import 'package:hotel/src/features/action/presentation/pages/item_edit_page.dart';
import 'package:hotel/src/features/action/presentation/widgets/party_picker_sheet.dart';
import 'package:hotel/src/features/category/data/models/category_model.dart';
import 'package:hotel/src/features/category/presentation/cubit/category_cubit.dart';
import 'package:hotel/src/features/invoice/data/models/request/create_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/create_invoice/create_invoice_cubit.dart';
import 'package:hotel/src/features/order/presentation/models/restaurant_cart_line.dart';
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart';

import '../../../../../core/constants/constants.dart';
import 'package:hotel/src/core/helpers/item_image_helper.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/helpers/permission_helper.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/features/action/presentation/pages/barcode_scanner_page.dart';
import 'package:hotel/src/features/order/presentation/utils/order_ui_helpers.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';
import 'package:hotel/src/features/settings/presentation/live_stock_issue_guard.dart';

/// One line in the cart summary (name, quantity, rate, subtotal).
class SelectedItemSummary {
  const SelectedItemSummary({
    required this.name,
    required this.quantity,
    required this.rate,
    this.imageUrl,
  });

  final String name;
  final int quantity;
  final double rate;

  /// From [ItemModel.image] when added from the menu.
  final String? imageUrl;

  double get subtotal => rate * quantity;
}

/// Full-screen page for adding items to the invoice by category.
/// When [fromQuickSales] is true (e.g. from home Quick Sales), shows Done button and creates invoice on Done with party picker.
/// When [fromRestaurantOrder] is true (Order → Quick Add), Done navigates to Check In → KOT review → `POST api/order/orders/`.
enum _QuickMenuRail { all, favorites, repeated, category }

@RoutePage()
class QuickAddItemsPage extends StatefulWidget implements AutoRouteWrapper {
  const QuickAddItemsPage({
    super.key,
    required this.invoiceType,
    this.fromQuickSales = false,
    this.fromRestaurantOrder = false,
    this.initialTableNumber,
    this.menuTitleSuffix,

    /// Pre-fills cart when [fromQuickSales] (e.g. Add Dishes from [OrderDetailPage]).
    /// JSON list per [RestaurantCartLine.encodeList].
    this.initialRestaurantCartJson,
    this.onItemSelected,
    this.cartTotalNotifier,
    this.initialQuantities,
    this.selectedItemsNotifier,
    this.onIncreaseItem,
    this.onDecreaseItem,
    this.showDoneButton = false,
    this.showPartySelector = false,
    this.initialPartyName,
    this.onPartySelected,
    this.onDone,
    this.startOnFavorites = false,
  });

  final InvoiceType invoiceType;
  final bool fromQuickSales;

  /// Order flow: submit via [CreateOrderUseCase] instead of [CreateInvoiceCubit].
  final bool fromRestaurantOrder;

  /// Pre-select party / table (Party.name for `tableNumber`).
  final String? initialTableNumber;

  /// Shown in the app bar after "Dishes", e.g. `Table 1`.
  final String? menuTitleSuffix;

  /// Optional seed cart (same shape as KOT review / POST order lines).
  final String? initialRestaurantCartJson;

  /// Returns [null] if a new line was added, or the new quantity if same item incremented. Null when [fromQuickSales] is true.
  final int? Function(ItemModel item)? onItemSelected;
  final ValueNotifier<double>? cartTotalNotifier;

  /// Current quantity per item name on the invoice (so we can show count on cards).
  final Map<String, int>? initialQuantities;
  final ValueNotifier<List<SelectedItemSummary>>? selectedItemsNotifier;
  final void Function(String itemName)? onIncreaseItem;
  final void Function(String itemName)? onDecreaseItem;
  final bool showDoneButton;
  final bool showPartySelector;
  final String? initialPartyName;
  final void Function(String partyName, {String? currency})? onPartySelected;
  final VoidCallback? onDone;

  /// Opens the favorites filter so the dashboard Manage action lands there.
  final bool startOnFavorites;

  @override
  Widget wrappedRoute(BuildContext context) {
    if (!fromQuickSales) return this;
    if (fromRestaurantOrder) return this;
    return BlocProvider(
      create: (_) => getIt<CreateInvoiceCubit>(),
      child: this,
    );
  }

  static Future<void> open(
    BuildContext context, {
    required InvoiceType invoiceType,
    String? menuTitleSuffix,
    required int? Function(ItemModel item) onItemSelected,
    required ValueNotifier<double> cartTotalNotifier,
    Map<String, int>? initialQuantities,
    ValueNotifier<List<SelectedItemSummary>>? selectedItemsNotifier,
    void Function(String itemName)? onIncreaseItem,
    void Function(String itemName)? onDecreaseItem,
    bool showDoneButton = false,
    bool showPartySelector = false,
    String? initialPartyName,
    void Function(String partyName, {String? currency})? onPartySelected,
    VoidCallback? onDone,
  }) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => QuickAddItemsPage(
          invoiceType: invoiceType,
          fromQuickSales: false,
          menuTitleSuffix: menuTitleSuffix,
          onItemSelected: onItemSelected,
          cartTotalNotifier: cartTotalNotifier,
          initialQuantities: initialQuantities,
          selectedItemsNotifier: selectedItemsNotifier,
          onIncreaseItem: onIncreaseItem,
          onDecreaseItem: onDecreaseItem,
          showDoneButton: showDoneButton,
          showPartySelector: showPartySelector,
          initialPartyName: initialPartyName,
          onPartySelected: onPartySelected,
          onDone: onDone,
        ),
      ),
    );
  }

  @override
  State<QuickAddItemsPage> createState() => _QuickAddItemsPageState();
}

class _QuickAddItemsPageState extends State<QuickAddItemsPage> {
  static const int _quickAddItemsPerPage = 10;

  String? _selectedCategoryName;
  bool _initialCategoryApplied = false;
  _QuickMenuRail _menuRail = _QuickMenuRail.all;

  /// Params of the last [ItemCubit.getItems] search from this page.
  String? _lastItemRequestSearch;

  /// True after we handled the first [CategoryCubit] load for this page (avoids duplicate bootstraps).
  bool _menuBootstrappedFromCategoryApi = false;

  /// Item name -> quantity on invoice (shown as badge on card). When fromQuickSales, derived from _localSelectedNotifier.
  late Map<String, int> _itemQuantities;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  void Function()? _summaryListener;
  bool _searchExpanded = false;
  Timer? _searchApiDebounce;
  static const Duration _searchApiDebounceDuration =
      Duration(milliseconds: 400);
  ItemResponseModel? _lastItemsResponse;

  /// When [fromQuickSales]: selected customer (sales) or supplier (purchase) for the draft invoice.
  String? _selectedPartyName;
  String? _selectedPartyCurrency;

  /// When fromQuickSales: local cart and total. Null when not fromQuickSales.
  ValueNotifier<List<SelectedItemSummary>>? _localSelectedNotifier;
  ValueNotifier<double>? _localTotalNotifier;

  bool get _isStandalone => widget.fromQuickSales;

  bool _isTablet(BuildContext context) => DeviceLayout.isTablet(context);

  double _sz(BuildContext context, double tablet, double phone) =>
      _isTablet(context) ? tablet : phone;

  double _sp(BuildContext context, double tablet, double phone) =>
      _isTablet(context) ? tablet : phone.sp;

  int _gridCrossAxisCount(BuildContext context) {
    if (!_isTablet(context)) return 2;
    final w = MediaQuery.sizeOf(context).width;
    if (w >= 1100) return 4;
    if (w >= 820) return 3;
    return 2;
  }

  double _gridChildAspectRatio(BuildContext context) {
    if (!_isTablet(context)) return 0.68;
    return switch (_gridCrossAxisCount(context)) {
      4 => 0.92,
      3 => 0.86,
      _ => 0.78,
    };
  }

  double _categoryRailWidth(BuildContext context) =>
      _isTablet(context) ? 148 : 120.w;

  List<SelectedItemSummary> get _effectiveSelectedItems => _isStandalone
      ? (_localSelectedNotifier?.value ?? [])
      : (widget.selectedItemsNotifier?.value ?? []);

  int _cartLineItemCount() {
    if (_isStandalone && _localSelectedNotifier != null) {
      return _localSelectedNotifier!.value
          .fold<int>(0, (sum, s) => sum + s.quantity);
    }
    if (widget.selectedItemsNotifier != null) {
      return widget.selectedItemsNotifier!.value
          .fold<int>(0, (sum, s) => sum + s.quantity);
    }
    return _itemQuantities.values.fold<int>(0, (sum, q) => sum + q);
  }

  String _formatMoneyLabel(num value, {int fractionDigits = 1}) =>
      context.l10n.formatCurrency(
        '$currencySymbol ${value.toStringAsFixed(fractionDigits)}',
      );

  String _formatQtyLabel(num value) => context.l10n.formatCount(value);

  String _formatCartLineSubtitle(SelectedItemSummary s) =>
      '${_formatMoneyLabel(s.rate, fractionDigits: 2)} × ${_formatQtyLabel(s.quantity)} = ${_formatMoneyLabel(s.subtotal, fractionDigits: 2)}';

  /// Rebuilds cart badge when line items or total change.
  Listenable get _appBarCartListenable {
    final parts = <Listenable>[
      if (_localSelectedNotifier != null) _localSelectedNotifier!,
      if (widget.selectedItemsNotifier != null) widget.selectedItemsNotifier!,
      if (widget.cartTotalNotifier != null) widget.cartTotalNotifier!,
    ];
    if (parts.isEmpty) {
      return ValueNotifier<int>(0);
    }
    return parts.length == 1 ? parts.first : Listenable.merge(parts);
  }

  void _syncQuantitiesFromSummary() {
    final notifier = widget.selectedItemsNotifier;
    if (notifier == null || !mounted) return;
    final map = <String, int>{};
    for (final s in notifier.value) {
      map[s.name] = (map[s.name] ?? 0) + s.quantity;
    }
    setState(() => _itemQuantities = map);
  }

  void _updateLocalTotal() {
    if (_localSelectedNotifier == null || _localTotalNotifier == null) return;
    final total = _localSelectedNotifier!.value
        .fold<double>(0, (sum, s) => sum + s.subtotal);
    _localTotalNotifier!.value = total;
  }

  @override
  void initState() {
    super.initState();
    if (widget.startOnFavorites) {
      _menuRail = _QuickMenuRail.favorites;
    }
    _searchFocusNode.addListener(_onSearchFocusChangedForBar);
    if (_isStandalone) {
      _localSelectedNotifier = ValueNotifier<List<SelectedItemSummary>>([]);
      _localTotalNotifier = ValueNotifier<double>(0);
      final seedJson = widget.initialRestaurantCartJson?.trim();
      if (seedJson != null && seedJson.isNotEmpty) {
        final lines = RestaurantCartLine.decodeList(seedJson);
        final summaries = lines
            .where((l) => l.name.trim().isNotEmpty && l.quantity > 0)
            .map(
              (l) => SelectedItemSummary(
                name: l.name.trim(),
                quantity: l.quantity,
                rate: l.rate,
                imageUrl: l.imageUrl,
              ),
            )
            .toList();
        _localSelectedNotifier!.value = summaries;
        final map = <String, int>{};
        for (final s in summaries) {
          map[s.name] = (map[s.name] ?? 0) + s.quantity;
        }
        _itemQuantities = map;
        _updateLocalTotal();
      } else {
        _itemQuantities = {};
      }
    } else {
      _itemQuantities = Map<String, int>.from(widget.initialQuantities ?? {});
      final notifier = widget.selectedItemsNotifier;
      if (notifier != null) {
        _summaryListener = () {
          if (mounted) _syncQuantitiesFromSummary();
        };
        notifier.addListener(_summaryListener!);
      }
    }
    if (widget.fromQuickSales && widget.initialTableNumber != null) {
      final t = widget.initialTableNumber!.trim();
      if (t.isNotEmpty) _selectedPartyName = t;
    }
    final initialParty = widget.initialPartyName?.trim();
    if ((initialParty ?? '').isNotEmpty) {
      _selectedPartyName = initialParty;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<CategoryCubit>().loadCategories();
      // Items load is started from [CategoryCubit] first category (see [_onCategoriesLoadedForMenu])
      // so we do not hit `GET .../api/hotel/api/items/` without `category` first.
      // Parties load only when the Room/Customer dropdown is opened (see [_openAppBarPartyPicker]).
    });
  }

  void _onSearchFocusChangedForBar() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _searchApiDebounce?.cancel();
    _searchFocusNode.removeListener(_onSearchFocusChangedForBar);
    _searchController.dispose();
    _searchFocusNode.dispose();
    _localSelectedNotifier?.dispose();
    _localTotalNotifier?.dispose();
    final notifier = widget.selectedItemsNotifier;
    if (notifier != null && _summaryListener != null) {
      notifier.removeListener(_summaryListener!);
    }
    super.dispose();
  }

  void _scheduleItemsFetchFromSearchField() {
    _searchApiDebounce?.cancel();
    _searchApiDebounce = Timer(_searchApiDebounceDuration, () {
      if (!mounted) return;
      final q = _searchController.text.trim();
      _fetchItems(_selectedCategoryName, search: q.isEmpty ? null : q);
    });
  }

  /// Rebuilds suffix/clear affordances; debounces API search.
  void _onSearchTextChanged(String _) {
    setState(() {});
    _scheduleItemsFetchFromSearchField();
  }

  void _applySearchNow() {
    _searchApiDebounce?.cancel();
    if (!mounted) return;
    final q = _searchController.text.trim();
    _fetchItems(_selectedCategoryName, search: q.isEmpty ? null : q);
  }

  static const Color _searchAccentRed = Color(0xFFE53935);

  void _openSearchMode() {
    setState(() => _searchExpanded = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _searchFocusNode.requestFocus();
    });
  }

  void _exitSearchMode() {
    if (!_searchExpanded) return;
    _searchApiDebounce?.cancel();
    setState(() {
      _searchExpanded = false;
      _searchController.clear();
    });
    _searchFocusNode.unfocus();
    _fetchItems(_selectedCategoryName, search: null);
    setState(() {});
  }

  Future<void> _openAddItemEditorAndRefresh() async {
    final q = _searchController.text.trim();
    final purpose =
        widget.invoiceType == InvoiceType.sales ? 'Sales' : 'Purchases';
    // Bottom sheet so name/purpose reach [ItemEditPage] reliably; same form as full-screen route.
    final created = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        final mq = MediaQuery.of(sheetCtx);
        final topPeek = mq.viewPadding.top + 56;
        final sheetHeight = mq.size.height - topPeek;
        return Padding(
          padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
          child: SizedBox(
            height: sheetHeight,
            width: mq.size.width,
            child: ItemEditPage(
              asBottomSheet: true,
              isEditing: false,
              initialItemName: q.isEmpty ? null : q,
              initialPurpose: purpose,
              initialCategory: _selectedCategoryName,
            ),
          ),
        );
      },
    );
    if (!mounted) return;
    if (created == true) {
      _fetchItems(
        _selectedCategoryName,
        search: q.isEmpty ? null : q,
      );
    }
  }

  /// True when the current search query finished loading and the filtered grid would be empty.
  bool _showAddItemInSearchSuffix(String trimmedQuery, ItemState itemState) {
    if (trimmedQuery.isEmpty) return false;
    final loading =
        itemState.maybeWhen(loading: () => true, orElse: () => false);
    if (loading) return false;
    if (_lastItemsResponse == null) return false;
    if (_lastItemRequestSearch?.trim() != trimmedQuery) return false;
    return _applyRecommendedFilter(_lastItemsResponse!.data).isEmpty;
  }

  List<ItemModel> _applyRecommendedFilter(List<ItemModel> items) => items;

  void _pickCategory(String categoryName) {
    setState(() {
      _menuRail = _QuickMenuRail.category;
      _selectedCategoryName = categoryName;
    });
    _fetchItems(
      categoryName,
      search: _searchController.text.trim().isEmpty
          ? null
          : _searchController.text.trim(),
    );
  }

  void _pickAllCategories() {
    setState(() {
      _menuRail = _QuickMenuRail.all;
      _selectedCategoryName = null;
    });
    _fetchItems(
      null,
      search: _searchController.text.trim().isEmpty
          ? null
          : _searchController.text.trim(),
    );
  }

  void _pickFavorites() {
    setState(() {
      _menuRail = _QuickMenuRail.favorites;
      _selectedCategoryName = null;
    });
    _fetchItems(
      null,
      search: _searchController.text.trim().isEmpty
          ? null
          : _searchController.text.trim(),
    );
  }

  void _pickRepeated() {
    setState(() {
      _menuRail = _QuickMenuRail.repeated;
      _selectedCategoryName = null;
    });
    _fetchItems(
      null,
      search: _searchController.text.trim().isEmpty
          ? null
          : _searchController.text.trim(),
    );
  }

  void _onCategoriesLoadedForMenu(List<CategoryModel> categories) {
    if (_menuBootstrappedFromCategoryApi || !mounted) return;
    _menuBootstrappedFromCategoryApi = true;
    if (_initialCategoryApplied) return;
    _initialCategoryApplied = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (widget.startOnFavorites) {
        _pickFavorites();
        return;
      }
      setState(() {
        _menuRail = _QuickMenuRail.all;
        _selectedCategoryName = null;
      });
      _fetchItems(null, search: null);
    });
  }

  int _quantityFor(String name) {
    if (_isStandalone) {
      return (_localSelectedNotifier?.value ?? [])
          .where((s) => s.name == name)
          .fold<int>(0, (sum, s) => sum + s.quantity);
    }
    return _itemQuantities[name] ?? 0;
  }

  bool _guardSalesQty(
    String itemName,
    int requestedQty, {
    String? itemType,
    bool notify = true,
  }) {
    if (widget.invoiceType != InvoiceType.sales) return true;
    if (liveStockAllowsSale(
      itemName: itemName,
      requestedQty: requestedQty.toDouble(),
      itemType: itemType,
    )) {
      return true;
    }
    if (notify) showLiveStockShortage(context, itemName);
    return false;
  }

  void _handleQuickAdd(
    ItemModel item, {
    bool skipStockGuard = false,
    int count = 1,
  }) {
    final add = count < 1 ? 1 : count;
    if (!skipStockGuard &&
        _isStandalone &&
        !_guardSalesQty(item.name, _quantityFor(item.name) + add,
            itemType: item.itemType)) {
      return;
    }
    if (_isStandalone) {
      final list =
          List<SelectedItemSummary>.from(_localSelectedNotifier!.value);
      final idx = list.indexWhere((s) => s.name == item.name);
      final rate = item.rate;
      if (idx >= 0) {
        final s = list[idx];
        list[idx] = SelectedItemSummary(
          name: s.name,
          quantity: s.quantity + add,
          rate: s.rate,
          imageUrl: s.imageUrl ?? item.image?.trim(),
        );
      } else {
        list.add(SelectedItemSummary(
          name: item.name,
          quantity: add,
          rate: rate,
          imageUrl: item.image?.trim(),
        ));
      }
      _localSelectedNotifier!.value = list;
      _updateLocalTotal();
      setState(() {});
    } else if (widget.onItemSelected != null) {
      var last = _quantityFor(item.name);
      for (var i = 0; i < add; i++) {
        final next = widget.onItemSelected!(item);
        if (next == null || next <= last) break;
        last = next;
      }
      setState(() => _itemQuantities[item.name] = last);
    }
  }

  String get _scanForFilter =>
      widget.invoiceType == InvoiceType.sales ? 'Sales' : 'Purchases';

  Future<void> _openCheckoutScanner() async {
    final allowed = await PermissionHelper.cameraPermission();
    if (!mounted) return;
    if (!allowed) {
      context.showKiiSnackBarError(context.l10n.posScanCameraDenied);
      return;
    }
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => BarcodeScannerPage(
          continuous: true,
          lookupItem: _lookupScannedItemName,
          onConfirmed: _confirmScannedQuantity,
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  ItemModel? _pendingScanItem;

  Future<String?> _lookupScannedItemName(String code) async {
    final item = await context.read<ItemCubit>().findByBarcode(
          code,
          forFilter: _scanForFilter,
        );
    if (!mounted || item == null) return null;
    _pendingScanItem = item;
    return item.name;
  }

  Future<BarcodeScanFeedback> _confirmScannedQuantity(
    String _,
    int addQty,
  ) async {
    final l10n = context.l10n;
    final item = _pendingScanItem;
    if (!mounted || item == null) {
      return BarcodeScanFeedback(
        message: l10n.posScanItemNotFound,
        isError: true,
      );
    }
    if (!_guardSalesQty(
      item.name,
      _quantityFor(item.name) + addQty,
      itemType: item.itemType,
      notify: false,
    )) {
      final available = liveStockOrNull()?.onHand(item.name) ?? 0;
      final message = available <= 0
          ? l10n.liveStockOutOfStock(item.name)
          : l10n.liveStockInsufficient(
              item.name,
              LiveStockTrackingService.formatQty(available),
            );
      return BarcodeScanFeedback(message: message, isError: true);
    }
    _handleQuickAdd(item, skipStockGuard: true, count: addQty);
    final qty = _quantityFor(item.name);
    return BarcodeScanFeedback(
      message: l10n.posScanItemAdded(item.name, l10n.formatCount(qty)),
    );
  }

  void _handleQuickDecrease(ItemModel item) {
    if (_isStandalone) {
      final list =
          List<SelectedItemSummary>.from(_localSelectedNotifier!.value);
      final idx = list.indexWhere((s) => s.name == item.name);
      if (idx < 0) return;
      final s = list[idx];
      if (s.quantity <= 1) {
        list.removeAt(idx);
      } else {
        list[idx] = SelectedItemSummary(
          name: s.name,
          quantity: s.quantity - 1,
          rate: s.rate,
          imageUrl: s.imageUrl,
        );
      }
      _localSelectedNotifier!.value = list;
      _updateLocalTotal();
      setState(() {});
    } else {
      widget.onDecreaseItem?.call(item.name);
    }
  }

  static int _optionsLabelCount(ItemModel item) {
    var n = 1;
    if ((item.hasBatch ?? 0) > 0) n += 2;
    if ((item.hasSerialNumber ?? 0) > 0) n += 1;
    return n.clamp(1, 99);
  }

  static Widget? _itemImage(String? raw, ThemeData theme) {
    if (raw == null || raw.trim().isEmpty) return null;
    final resolved = resolveOrderItemImageUrl(raw) ?? raw.trim();
    if (!ItemImageHelper.hasDisplayableImage(resolved)) return null;
    if (ItemImageHelper.isNetworkUrl(resolved)) {
      return Image.network(
        resolved,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (_, __, ___) => _imagePlaceholder(theme),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Center(
            child: SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: theme.colorScheme.primary),
            ),
          );
        },
      );
    }
    return ItemImageHelper.buildImage(
      resolved,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) => _imagePlaceholder(theme),
    );
  }

  static Widget _imagePlaceholder(ThemeData theme) {
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.6),
      child: Center(
        child: Icon(Icons.restaurant_menu_rounded,
            size: 40,
            color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5)),
      ),
    );
  }

  void _showCartSummarySheet(BuildContext context, ThemeData theme) {
    final notifier =
        _isStandalone ? _localSelectedNotifier! : widget.selectedItemsNotifier!;
    void onIncrease(String name) {
      if (_isStandalone && !_guardSalesQty(name, _quantityFor(name) + 1))
        return;
      if (_isStandalone) {
        final list =
            List<SelectedItemSummary>.from(_localSelectedNotifier!.value);
        final idx = list.indexWhere((s) => s.name == name);
        if (idx >= 0) {
          final s = list[idx];
          list[idx] = SelectedItemSummary(
            name: s.name,
            quantity: s.quantity + 1,
            rate: s.rate,
            imageUrl: s.imageUrl,
          );
          _localSelectedNotifier!.value = list;
          _updateLocalTotal();
        }
      } else {
        widget.onIncreaseItem?.call(name);
      }
    }

    void onDecrease(String name) {
      if (_isStandalone) {
        final list =
            List<SelectedItemSummary>.from(_localSelectedNotifier!.value);
        final idx = list.indexWhere((s) => s.name == name);
        if (idx >= 0) {
          final s = list[idx];
          if (s.quantity <= 1) {
            list.removeAt(idx);
          } else {
            list[idx] = SelectedItemSummary(
              name: s.name,
              quantity: s.quantity - 1,
              rate: s.rate,
              imageUrl: s.imageUrl,
            );
          }
          _localSelectedNotifier!.value = list;
          _updateLocalTotal();
        }
      } else {
        widget.onDecreaseItem?.call(name);
      }
    }

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.6),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.checkoutCartSummary,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Flexible(
                child: ValueListenableBuilder<List<SelectedItemSummary>>(
                  valueListenable: notifier,
                  builder: (context, items, _) {
                    if (items.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          context.l10n.checkoutNoItemsInCart,
                          style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final s = items[index];
                        return ListTile(
                          title: Text(
                            s.name,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            _formatCartLineSubtitle(s),
                            style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline),
                                onPressed: () => onDecrease(s.name),
                                style: IconButton.styleFrom(
                                    padding: const EdgeInsets.all(4),
                                    minimumSize: const Size(36, 36)),
                              ),
                              Text(
                                _formatQtyLabel(s.quantity),
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.add_circle_outline),
                                onPressed: () => onIncrease(s.name),
                                style: IconButton.styleFrom(
                                    padding: const EdgeInsets.all(4),
                                    minimumSize: const Size(36, 36)),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: Text(context.l10n.done),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Show just the name part for display, e.g. "Food - Main Course (Chicken)" → "Main Course (Chicken)".
  static String categoryDisplayName(String fullName) {
    final idx = fullName.indexOf(' - ');
    if (idx >= 0 && idx + 3 < fullName.length) {
      return fullName.substring(idx + 3).trim();
    }
    return fullName;
  }

  Future<void> _toggleFavorite(ItemModel item) async {
    await context.read<ItemCubit>().setFavorite(
          itemName: item.name,
          isFavorite: !item.isFavorite,
        );
  }

  void _showCardMenu(BuildContext context, ItemModel item) {
    final l10n = context.l10n;
    showAppBottomSheet<void>(
      context: context,
      title: item.name,
      shrinkWrap: true,
      compactHeader: true,
      bodyBuilder: (sheetContext) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _QuickItemMenuTile(
              icon: item.isFavorite
                  ? Icons.star_rounded
                  : Icons.star_border_rounded,
              title: item.isFavorite
                  ? l10n.invoiceQuickRemoveFavorite
                  : l10n.invoiceQuickAddFavorite,
              color: const Color(0xFFF59E0B),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _toggleFavorite(item);
              },
            ),
            const SizedBox(height: 4),
            _QuickItemMenuTile(
              icon: Icons.edit_outlined,
              title: l10n.invoiceQuickEditItem,
              color: Theme.of(sheetContext).colorScheme.primary,
              onTap: () {
                Navigator.of(sheetContext).pop();
                context.router.push(ItemEditRoute(item: item, isEditing: true));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _openAppBarPartyPicker(BuildContext context) async {
    final role =
        widget.invoiceType == InvoiceType.sales ? 'customer' : 'supplier';
    // Match first tab of [PartyPickerSheet]: room for Order → Quick Add, else customer/supplier.
    final preloadType = widget.fromRestaurantOrder ? 'room' : role;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: 16.h),
                  Text(
                    context.l10n.loading,
                    style: Theme.of(dialogContext).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    context.read<PartyCubit>().getParties(
          params: PartyRequestParams(
            page: 1,
            perPage: 500,
            partyType: preloadType,
            status: preloadType == 'employee' || preloadType == 'supplier'
                ? 1
                : null,
            sortBy: 'name',
            sortOrder: 'asc',
          ),
        );

    await context.read<PartyCubit>().stream.firstWhere(
          (s) => s.maybeWhen(
            success: (_) => true,
            error: (_) => true,
            noInternet: () => true,
            orElse: () => false,
          ),
        );

    if (!context.mounted) return;
    Navigator.of(context).pop();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => PartyPickerSheet(
        role: widget.fromRestaurantOrder ? 'room' : role,
        roomAndCabinOnly: widget.fromRestaurantOrder,
        includeEmployeeTab: !widget.fromRestaurantOrder &&
            widget.invoiceType == InvoiceType.sales,
        supplierIncludeEmployeeTab: !widget.fromRestaurantOrder &&
            widget.invoiceType == InvoiceType.purchase,
        selectedPartyName: _selectedPartyName,
        onSelect: (PartyItem party) {
          Navigator.pop(sheetContext);
          setState(() {
            _selectedPartyName = party.name ?? '';
            _selectedPartyCurrency = party.currency;
          });
        },
      ),
    );
  }

  Widget _buildAppBarPartySelector(
      BuildContext context, ThemeData theme, ColorScheme cs) {
    final l10n = context.l10n;
    final isSales = widget.invoiceType == InvoiceType.sales;
    final hintLabel = widget.fromRestaurantOrder
        ? l10n.invoiceQuickRoomCabinEmployee
        : (isSales
            ? l10n.partyRoleCustomer
            : l10n.invoiceQuickSupplierEmployee);
    final picked = _selectedPartyName?.trim();
    final hasPick = picked != null && picked.isNotEmpty;
    final displayName =
        (picked != null && picked.isNotEmpty) ? picked : hintLabel;

    return Padding(
      padding: EdgeInsets.only(left: _sz(context, 0, 6)),
      child: Material(
        // App bar sits on surfaceContainerHigh — use surface plus a border so
        // the selector reads as a field instead of blending into the bar.
        color: cs.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_sz(context, 10, 10)),
          side: BorderSide(color: cs.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(_sz(context, 10, 10)),
          onTap: () => _openAppBarPartyPicker(context),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _sz(context, 12, 8),
              vertical: _sz(context, 8, 8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_outline_rounded,
                  size: _sz(context, 20, 18),
                  color: cs.primary,
                ),
                SizedBox(width: _sz(context, 8, 6)),
                Expanded(
                  child: Text(
                    displayName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      fontSize: _sp(context, 15, 14),
                      color: hasPick ? cs.onSurface : cs.onSurfaceVariant,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: cs.onSurface,
                  size: _sz(context, 24, 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _fetchItems(String? categoryName, {String? search}) {
    _lastItemRequestSearch = search;
    context.read<ItemCubit>().getItems(
          params: ItemRequestParams(
            page: 1,
            forFilter:
                widget.invoiceType == InvoiceType.sales ? 'Sales' : 'Purchases',
            perPage: _quickAddItemsPerPage,
            excludeZeroSales: false,
            sortBy: 'name',
            sortOrder: 'asc',
            category:
                _menuRail == _QuickMenuRail.category ? categoryName : null,
            search: search,
            favoritesOnly: _menuRail == _QuickMenuRail.favorites,
            repeatedSales: _menuRail == _QuickMenuRail.repeated,
          ),
        );
  }

  Widget _buildItemsGrid(
    BuildContext context,
    ThemeData theme,
    ColorScheme cs,
    ItemResponseModel response,
    bool hasMore,
  ) {
    final l10n = context.l10n;
    final allItems = response.data;
    final items = _applyRecommendedFilter(allItems);
    if (items.isEmpty) {
      final isSearch = _searchController.text.trim().isNotEmpty;
      final title = isSearch
          ? l10n.invoiceQuickNoResults
          : _menuRail == _QuickMenuRail.favorites
              ? l10n.invoiceQuickNoFavorites
              : _menuRail == _QuickMenuRail.repeated
                  ? l10n.invoiceQuickNoRepeated
                  : l10n.invoiceQuickNoItemsInCategory;
      final subtitle = isSearch
          ? l10n.invoiceQuickNoResultsSubtitle
          : _menuRail == _QuickMenuRail.favorites
              ? l10n.invoiceQuickNoFavoritesSubtitle
              : _menuRail == _QuickMenuRail.repeated
                  ? l10n.invoiceQuickNoRepeatedSubtitle
                  : l10n.invoiceQuickNoItemsInCategorySubtitle;
      return SingleChildScrollView(
        child: ListEmptyState(
          illustrationPath: isSearch
              ? AppEmptyStateAssets.search
              : AppEmptyStateAssets.inventory,
          title: title,
          subtitle: subtitle,
          action: isSearch ||
                  _menuRail == _QuickMenuRail.favorites ||
                  _menuRail == _QuickMenuRail.repeated
              ? null
              : FilledButton.icon(
                  onPressed: _openAddItemEditorAndRefresh,
                  icon: const Icon(Icons.add_rounded, size: 20),
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  label: Text(
                    l10n.invoiceQuickAddItem,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
        ),
      );
    }
    final totalRows = response.pagination.totalRows;
    final summaryLine = totalRows > 0
        ? l10n.invoiceQuickShowingItems(items.length, totalRows)
        : l10n.invoiceQuickLoadedItems(items.length);
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification n) {
        if (!hasMore) return false;
        final m = n.metrics;
        if (m.maxScrollExtent <= 0) return false;
        if (m.pixels >= m.maxScrollExtent - 320) {
          context.read<ItemCubit>().loadMoreItems();
        }
        return false;
      },
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              _sz(context, 16, 10),
              _sz(context, 12, 8),
              _sz(context, 16, 12),
              0,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _gridCrossAxisCount(context),
                childAspectRatio: _gridChildAspectRatio(context),
                crossAxisSpacing: _sz(context, 12, 10),
                mainAxisSpacing: _sz(context, 12, 10),
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = items[index];
                  final qty = _isStandalone
                      ? _localSelectedNotifier!.value
                          .where((s) => s.name == item.name)
                          .fold<int>(0, (sum, s) => sum + s.quantity)
                      : (_itemQuantities[item.name] ?? 0);
                  return _DishItemCard(
                    item: item,
                    quantity: qty,
                    onAdd: () => _handleQuickAdd(item),
                    onDecrease: () => _handleQuickDecrease(item),
                    onLongPress: () => _showCardMenu(context, item),
                    onFavorite: () => _toggleFavorite(item),
                    optionsCount: _optionsLabelCount(item),
                    limitByStock: widget.invoiceType == InvoiceType.sales,
                    image: _itemImage(item.image, theme),
                  );
                },
                childCount: items.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 24),
              child: Column(
                children: [
                  if (hasMore) ...[
                    TextButton.icon(
                      onPressed: () =>
                          context.read<ItemCubit>().loadMoreItems(),
                      icon: Icon(Icons.expand_more_rounded),
                      label: Text(l10n.invoiceQuickLoadMore),
                    ),
                    Text(
                      l10n.invoiceQuickScrollLoadMore(_quickAddItemsPerPage),
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: cs.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      summaryLine,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
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

  static const Duration _appBarSwitchDuration = Duration(milliseconds: 320);

  PreferredSizeWidget _buildQuickAddAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AnimatedSwitcher(
        duration: _appBarSwitchDuration,
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.06, 0),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
        child: _searchExpanded
            ? _buildSearchModeAppBar(context, theme, cs)
            : _buildDefaultQuickAddAppBar(context, theme, cs),
      ),
    );
  }

  Widget _buildSearchModeAppBar(
      BuildContext context, ThemeData theme, ColorScheme cs) {
    return AppBar(
      key: const ValueKey<String>('quick_add_app_bar_search'),
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: kToolbarHeight,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      flexibleSpace: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.lerp(cs.surface, cs.surfaceContainerHighest, 0.4)!,
              cs.surface,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  color: cs.surfaceContainerHighest.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: _exitSearchMode,
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: Icon(Icons.chevron_left_rounded,
                          color: cs.onSurface, size: 28),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ListenableBuilder(
                    listenable: _searchController,
                    builder: (context, _) {
                      return BlocBuilder<ItemCubit, ItemState>(
                        builder: (context, itemState) {
                          final q = _searchController.text.trim();
                          final showAddItem =
                              _showAddItemInSearchSuffix(q, itemState);
                          final pill = BorderRadius.circular(10);
                          final focused = _searchFocusNode.hasFocus;
                          return Material(
                            color: cs.surfaceContainerHighest.withOpacity(0.95),
                            elevation: 0,
                            borderRadius: pill,
                            clipBehavior: Clip.antiAlias,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: pill,
                                border: Border.all(
                                  color: focused
                                      ? cs.outline.withOpacity(0.5)
                                      : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: SizedBox(
                                height: 44,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 12),
                                    AppSearchIcon(
                                        color: cs.onSurfaceVariant, size: 22),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: TextField(
                                        controller: _searchController,
                                        focusNode: _searchFocusNode,
                                        cursorColor: _searchAccentRed,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(height: 1.2),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          isCollapsed: true,
                                          hintText:
                                              context.l10n.checkoutSearchHere,
                                          hintStyle: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                            color: cs.onSurfaceVariant,
                                            height: 1.2,
                                          ),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          filled: false,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        textInputAction: TextInputAction.search,
                                        onChanged: _onSearchTextChanged,
                                        onSubmitted: (_) => _applySearchNow(),
                                      ),
                                    ),
                                    if (showAddItem) ...[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4),
                                        child: GestureDetector(
                                          onTap: _openAddItemEditorAndRefresh,
                                          child: Text(
                                            context.l10n.invoiceQuickAddItem,
                                            style: theme.textTheme.labelLarge
                                                ?.copyWith(
                                              color: cs.primary,
                                              fontWeight: FontWeight.w700,
                                              height: 1.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    if (q.isNotEmpty)
                                      IconButton(
                                        tooltip: context
                                            .l10n.invoiceQuickClearSearch,
                                        visualDensity: VisualDensity.compact,
                                        padding: const EdgeInsets.all(8),
                                        constraints: const BoxConstraints(
                                            minWidth: 40, minHeight: 40),
                                        icon: Icon(
                                          Icons.close_rounded,
                                          color: _searchAccentRed,
                                          size: 22,
                                        ),
                                        onPressed: () {
                                          _searchApiDebounce?.cancel();
                                          _searchController.clear();
                                          _fetchItems(_selectedCategoryName,
                                              search: null);
                                          setState(() {});
                                        },
                                      ),
                                    if (q.isEmpty)
                                      const SizedBox(width: 8)
                                    else
                                      const SizedBox(width: 4),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: cs.surfaceContainerHighest.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(10),
                  child: Tooltip(
                    message: context.l10n.itemScanBarcode,
                    child: InkWell(
                      onTap: _openCheckoutScanner,
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(
                          Icons.qr_code_scanner_rounded,
                          color: cs.onSurface,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultQuickAddAppBar(
      BuildContext context, ThemeData theme, ColorScheme cs) {
    return AppBar(
      key: const ValueKey<String>('quick_add_app_bar_default'),
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: kToolbarHeight,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: (widget.fromQuickSales || widget.showPartySelector)
          ? Row(
              children: [
                if (_isTablet(context))
                  SizedBox(
                    width: 320,
                    child: _buildAppBarPartySelector(context, theme, cs),
                  )
                else
                  Expanded(
                      child: _buildAppBarPartySelector(context, theme, cs)),
              ],
            )
          : Text(
              widget.menuTitleSuffix != null &&
                      widget.menuTitleSuffix!.trim().isNotEmpty
                  ? widget.menuTitleSuffix!.trim()
                  : context.l10n.invoiceQuickAddItemsTitle,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
      actions: [
        IconButton(
          tooltip: context.l10n.itemScanBarcode,
          icon: const Icon(Icons.qr_code_scanner_rounded),
          onPressed: _openCheckoutScanner,
        ),
        IconButton(
          tooltip: context.l10n.search,
          icon: const AppSearchIcon(),
          onPressed: _openSearchMode,
        ),
        ListenableBuilder(
          listenable: _appBarCartListenable,
          builder: (context, _) {
            final count = _cartLineItemCount();
            final badgeLabel = count > 99
                ? context.l10n.localizeDigits('99+')
                : context.l10n.formatCount(count);
            return IconButton(
              tooltip: count > 0
                  ? context.l10n.invoiceQuickCartWithCount(count)
                  : context.l10n.invoiceQuickCart,
              onPressed: () => _showCartSummarySheet(context, theme),
              icon: Badge(
                isLabelVisible: count > 0,
                backgroundColor: cs.primary,
                label: Text(
                  badgeLabel,
                  style: AppFonts.interStyle(
                    color: cs.onPrimary,
                    fontSize: count > 9 ? 9 : 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                child: Icon(Icons.shopping_bag_outlined),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    Widget scaffold = Scaffold(
      backgroundColor: cs.surface,
      appBar: _buildQuickAddAppBar(context),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CategoryCubit, CategoryState>(
            listenWhen: (prev, curr) => curr.maybeWhen(
              loaded: (_) => true,
              error: (_) => true,
              orElse: () => false,
            ),
            listener: (context, state) {
              state.maybeWhen(
                loaded: _onCategoriesLoadedForMenu,
                error: (_) {
                  if (_menuBootstrappedFromCategoryApi) return;
                  _menuBootstrappedFromCategoryApi = true;
                  if (!_initialCategoryApplied) {
                    _initialCategoryApplied = true;
                  }
                  _fetchItems(null, search: null);
                },
                orElse: () {},
              );
            },
          ),
          BlocListener<ItemCubit, ItemState>(
            listenWhen: (prev, curr) => curr.maybeWhen(
                loading: () => true,
                success: (_, __) => true,
                error: (_) => true,
                orElse: () => false),
            listener: (context, state) {
              state.maybeWhen(
                loading: () {},
                success: (response, _) {
                  if (!mounted) return;
                  setState(() {
                    _lastItemsResponse = response;
                  });
                },
                error: (_) {
                  if (!mounted) return;
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SizedBox(
            //   height: 44,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     padding: const EdgeInsets.symmetric(horizontal: 8),
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            //         child: ActionChip(
            //           avatar: Icon(Icons.category_outlined, size: 18),
            //           label: Text('Category'),
            //           onPressed: () {},
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            //         child: ActionChip(
            //           avatar: Icon(Icons.tune_rounded, size: 18),
            //           label: Text('Filters'),
            //           onPressed: () {
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               SnackBar(content: Text('Filters — use category rail & search')),
            //             );
            //           },
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            //         child: FilterChip(
            //           avatar: Icon(Icons.star_rounded, size: 18, color: Colors.amber.shade800),
            //           label: Text('Recommended'),
            //           selected: _recommendedOnly,
            //           onSelected: (v) {
            //             setState(() => _recommendedOnly = v);
            //           },
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            //         child: ActionChip(
            //           label: Text('Default'),
            //           onPressed: () {
            //             setState(() => _recommendedOnly = false);
            //             _searchController.clear();
            //             final list = _categoriesWithItemsFromCubits();
            //             if (list.isEmpty) {
            //               setState(() {
            //                 _selectedCategoryName = null;
            //                 _initialCategoryApplied = false;
            //               });
            //               _fetchItems(null, search: null);
            //             } else {
            //               _pickCategory(list.first.name);
            //             }
            //             _searchApiDebounce?.cancel();
            //             setState(() {});
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, catState) {
                  final categories = catState.maybeWhen(
                    loaded: (list) => list,
                    orElse: () => <CategoryModel>[],
                  );

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Material(
                        color: cs.surfaceContainerLow,
                        child: SizedBox(
                          width: _categoryRailWidth(context),
                          child: ListView(
                            padding: EdgeInsets.symmetric(
                              vertical: _sz(context, 8, 8),
                              horizontal: _sz(context, 6, 4),
                            ),
                            children: [
                              _CategoryRailTile(
                                label: context.l10n.all,
                                tooltip: context.l10n.categories,
                                selected: _menuRail == _QuickMenuRail.all,
                                onTap: _pickAllCategories,
                              ),
                              _CategoryRailTile(
                                icon: Icons.star_rounded,
                                label: context.l10n.invoiceQuickFavorites,
                                tooltip: context.l10n.invoiceQuickFavorites,
                                selected: _menuRail == _QuickMenuRail.favorites,
                                onTap: _pickFavorites,
                              ),
                              _CategoryRailTile(
                                icon: Icons.replay_rounded,
                                label: context.l10n.invoiceQuickRepeated,
                                tooltip: context.l10n.invoiceQuickRepeatedHint,
                                selected: _menuRail == _QuickMenuRail.repeated,
                                onTap: _pickRepeated,
                              ),
                              ...categories.map(
                                (c) => _CategoryRailTile(
                                  label: categoryDisplayName(c.name),
                                  selected:
                                      _menuRail == _QuickMenuRail.category &&
                                          _selectedCategoryName == c.name,
                                  onTap: () => _pickCategory(c.name),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<ItemCubit, ItemState>(
                          builder: (context, state) {
                            if (_lastItemsResponse == null) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return state.maybeWhen(
                              loading: () =>
                                  Center(child: CircularProgressIndicator()),
                              success: (ItemResponseModel response,
                                      bool hasMore) =>
                                  _buildItemsGrid(
                                      context, theme, cs, response, hasMore),
                              error: (message) => Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Text(message,
                                      textAlign: TextAlign.center),
                                ),
                              ),
                              orElse: () => Center(
                                  child: Text(
                                      context.l10n.invoiceQuickLoadingMenu)),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            if (widget.fromQuickSales || widget.showDoneButton)
              ListenableBuilder(
                listenable: _appBarCartListenable,
                builder: (context, _) {
                  if (_cartLineItemCount() == 0) {
                    return const SizedBox.shrink();
                  }
                  return Material(
                    elevation: 6,
                    color: cs.surface,
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                        child: CustomButtonWidget(
                          onPressed: () {
                            if (widget.fromQuickSales) {
                              _onDoneQuickSales(context);
                            } else {
                              _onDoneNonStandalone(context);
                            }
                          },
                          width: double.infinity,
                          title: context.l10n.done,
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
    if (widget.fromQuickSales && !widget.fromRestaurantOrder) {
      scaffold = BlocListener<CreateInvoiceCubit, CreateInvoiceState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (_) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(context.l10n.invoiceQuickInvoiceCreated)),
                );
                Navigator.of(context).pop();
              }
            },
            error: (message) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              }
            },
            orElse: () {},
          );
        },
        child: scaffold,
      );
    }
    return PopScope(
      canPop: !_searchExpanded,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _searchExpanded) {
          _exitSearchMode();
        }
      },
      child: Stack(
        children: [
          scaffold,
          const KeyboardDoneBar(),
        ],
      ),
    );
  }

  Future<void> _replaceRestaurantOrderWithCheckIn(BuildContext context) async {
    final lines = _localSelectedNotifier!.value
        .map(
          (s) => RestaurantCartLine(
            name: s.name,
            quantity: s.quantity,
            rate: s.rate,
            imageUrl: s.imageUrl,
          ),
        )
        .toList();
    final cartJson = RestaurantCartLine.encodeList(lines);
    final picked = _selectedPartyName?.trim();
    final tableLabel = (picked != null && picked.isNotEmpty)
        ? picked
        : widget.initialTableNumber?.trim();
    await context.router.replace(
      OrderCheckInRoute(
        cartJson: cartJson,
        initialTableLabel: tableLabel,
        isExistingOrderAddition: widget.initialTableNumber != null &&
            widget.initialTableNumber!.trim().isNotEmpty,
      ),
    );
  }

  /// Order flow: Room / Cabin before check-in — same sheet as app bar picker ([role] must be `room` first, not `customer`).
  void _openRestaurantPartyPickerThenCheckIn(BuildContext context) {
    const sheetRole = 'room';
    context.read<PartyCubit>().getParties(
          params: PartyRequestParams(
            page: 1,
            perPage: 500,
            partyType: sheetRole,
            sortBy: 'name',
            sortOrder: 'asc',
          ),
        );
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => PartyPickerSheet(
        role: sheetRole,
        roomAndCabinOnly: true,
        includeEmployeeTab: true,
        selectedPartyName: _selectedPartyName,
        onSelect: (PartyItem party) async {
          Navigator.pop(sheetContext);
          final name = party.name?.trim() ?? '';
          if (name.isEmpty) return;
          setState(() {
            _selectedPartyName = party.name;
            _selectedPartyCurrency = party.currency;
          });
          if (!context.mounted) return;
          await _replaceRestaurantOrderWithCheckIn(context);
        },
      ),
    );
  }

  Future<void> _onDoneQuickSales(BuildContext context) async {
    if (_effectiveSelectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.invoiceQuickAddAtLeastOneItem)),
      );
      return;
    }
    if (widget.fromRestaurantOrder) {
      final picked = _selectedPartyName?.trim();
      if (picked == null || picked.isEmpty) {
        _openRestaurantPartyPickerThenCheckIn(context);
        return;
      }
      await _replaceRestaurantOrderWithCheckIn(context);
      return;
    }
    final picked = _selectedPartyName?.trim();
    if (picked != null && picked.isNotEmpty) {
      _createInvoiceFromQuickSales(context, picked);
      return;
    }
    _showPartyPickerThenCreateInvoice(context);
  }

  Future<void> _onDoneNonStandalone(BuildContext context) async {
    if (_effectiveSelectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.invoiceQuickAddAtLeastOneItem)),
      );
      return;
    }
    if (widget.showPartySelector) {
      final picked = _selectedPartyName?.trim();
      if (picked == null || picked.isEmpty) {
        await _openAppBarPartyPicker(context);
      }
      final selected = _selectedPartyName?.trim();
      if (selected == null || selected.isEmpty) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Please select a party')),
        // );
        return;
      }
      widget.onPartySelected?.call(
        selected,
        currency: _selectedPartyCurrency,
      );
    }
    widget.onDone?.call();
    if (context.mounted) Navigator.of(context).pop();
  }

  void _showPartyPickerThenCreateInvoice(BuildContext context) {
    final role =
        widget.invoiceType == InvoiceType.sales ? 'customer' : 'supplier';
    context.read<PartyCubit>().getParties(
          params: PartyRequestParams(
            page: 1,
            perPage: 500,
            partyType: role,
            status: role == 'employee' || role == 'supplier' ? 1 : null,
            sortBy: 'name',
            sortOrder: 'asc',
          ),
        );
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => PartyPickerSheet(
        role: role,
        includeEmployeeTab: role != 'supplier',
        supplierIncludeEmployeeTab: role == 'supplier',
        selectedPartyName: _selectedPartyName,
        onSelect: (PartyItem party) {
          Navigator.pop(sheetContext);
          final partyName = party.name ?? '';
          _selectedPartyCurrency = party.currency;
          _createInvoiceFromQuickSales(
            context,
            partyName,
            currency: party.currency,
          );
        },
      ),
    );
  }

  void _createInvoiceFromQuickSales(
    BuildContext context,
    String partyName, {
    String? currency,
  }) {
    if (widget.invoiceType == InvoiceType.sales) {
      for (final line in _localSelectedNotifier!.value) {
        if (!_guardSalesQty(line.name, line.quantity)) return;
      }
    }
    final items = _localSelectedNotifier!.value
        .map((s) => CreateInvoiceItem(
              item: s.name,
              rate: s.rate,
              quantity: s.quantity.toDouble(),
              account: 'Sales',
              setItemDiscountAmount: false,
              itemDiscountAmount: null,
            ))
        .toList();
    final dateStr = DateTime.now().toIso8601String();
    final currencyCode = (currency ?? _selectedPartyCurrency)?.trim();
    final params = CreateInvoiceRequestParams(
      invoiceType: widget.invoiceType,
      party: partyName,
      account: 'Debtors',
      date: dateStr,
      currency: (currencyCode != null && currencyCode.isNotEmpty)
          ? currencyCode.toUpperCase()
          : AppCurrencyFormatter.code,
      setDiscountAmount: false,
      discountAmount: null,
      discountPercent: null,
      createdBy: 'hotelroyalrestro@gmail.com',
      modifiedBy: 'hotelroyalrestro@gmail.com',
      items: items,
    );
    context.read<CreateInvoiceCubit>().createInvoice(params: params);
  }
}

class _CategoryRailTile extends StatelessWidget {
  const _CategoryRailTile({
    required this.label,
    this.tooltip,
    this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String? tooltip;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = DeviceLayout.isTablet(context);
    final textStyle = theme.textTheme.labelMedium?.copyWith(
      fontSize: isTablet ? 13 : 12.5,
      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
      color: selected ? Colors.white : theme.colorScheme.onSurface,
      height: 1.25,
    );
    final textWidget = Text(
      label,
      textAlign: TextAlign.start,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: textStyle,
    );

    Widget tile = Padding(
      padding: EdgeInsets.only(bottom: isTablet ? 4 : 6.sp),
      child: Material(
        color: selected ? context.theme.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(isTablet ? 8 : 8),
        child: InkWell(
          borderRadius: BorderRadius.circular(isTablet ? 8 : 6.sp),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 10 : 10.sp,
              vertical: isTablet ? 8 : 10.sp,
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: isTablet ? 16 : 15,
                    color:
                        selected ? Colors.white : theme.colorScheme.onSurface,
                  ),
                  SizedBox(width: isTablet ? 6 : 4),
                ],
                Expanded(child: textWidget),
              ],
            ),
          ),
        ),
      ),
    );

    if (tooltip != null && tooltip!.isNotEmpty) {
      tile = Tooltip(
        message: tooltip,
        child: tile,
      );
    }
    return tile;
  }
}

class _QuickItemMenuTile extends StatelessWidget {
  const _QuickItemMenuTile({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DishItemCard extends StatelessWidget {
  const _DishItemCard({
    required this.item,
    required this.quantity,
    required this.onAdd,
    required this.onDecrease,
    required this.onLongPress,
    required this.onFavorite,
    required this.optionsCount,
    required this.limitByStock,
    required this.image,
  });

  final ItemModel item;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onDecrease;
  final VoidCallback onLongPress;
  final VoidCallback onFavorite;
  final int optionsCount;
  final bool limitByStock;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isTablet = DeviceLayout.isTablet(context);
    final isDark = theme.brightness == Brightness.dark;
    // Overlay controls sit on a dark gradient — avoid light text on a light chip in dark mode.
    final controlFill = isDark
        ? cs.surfaceContainerHighest.withValues(alpha: 0.96)
        : Colors.white.withValues(alpha: 0.92);
    final controlBorder = isDark
        ? cs.outlineVariant.withValues(alpha: 0.55)
        : Colors.white.withValues(alpha: 0.85);
    final controlFg = isDark ? cs.onSurface : const Color(0xFF1A1B1E);
    final img = image ??
        ColoredBox(
          color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.65),
          child: Center(
            child: Icon(Icons.restaurant_menu_rounded,
                size: 40,
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.45)),
          ),
        );

    return Material(
      color: theme.colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.dividerColor.withOpacity(0.28)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onLongPress: onLongPress,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(child: img),
            Positioned(
              top: isTablet ? 12 : 10,
              left: isTablet ? 8 : 6,
              child: _stockDot(),
            ),
            Positioned(
              top: isTablet ? 8 : 6,
              right: isTablet ? 8 : 6,
              child: Material(
                color: Colors.black54,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onFavorite,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      item.isFavorite
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      size: isTablet ? 18 : 16,
                      color: item.isFavorite
                          ? const Color(0xFFFBBF24)
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.45),
                      Colors.black.withOpacity(0.82),
                    ],
                    stops: const [0.0, 0.35, 1.0],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    isTablet ? 10 : 8,
                    isTablet ? 16 : 20,
                    isTablet ? 10 : 8,
                    isTablet ? 8 : 6,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: isTablet ? 13 : null,
                              color: Colors.white,
                              shadows: const [
                                Shadow(
                                    color: Colors.black45,
                                    blurRadius: 4,
                                    offset: Offset(0, 1)),
                              ],
                            ),
                          ),
                          SizedBox(height: isTablet ? 2 : 2),
                          Text(
                            context.l10n.formatCurrency(
                              '$currencySymbol ${item.rate.toStringAsFixed(1)}',
                            ),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: isTablet ? 13 : null,
                              shadows: const [
                                Shadow(
                                    color: Colors.black54,
                                    blurRadius: 3,
                                    offset: Offset(0, 1)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isTablet ? 6 : 6),
                      if (quantity <= 0)
                        CustomButtonWidget.outlined(
                          title: context.l10n.add,
                          onPressed: onAdd,
                          width: double.infinity,
                          height: isTablet ? 32 : 34,
                          borderRadius: isTablet ? 8 : 8.sp,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                            vertical: isTablet ? 4 : 4,
                            horizontal: isTablet ? 8 : 8,
                          ),
                          backgroundColor: controlFill,
                          titleColor: controlFg,
                          borderColor: controlBorder,
                          icon: Icon(
                            Icons.add_rounded,
                            size: isTablet ? 16 : 16,
                            color: cs.primary,
                          ),
                          titleStyle: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: isTablet ? 12 : null,
                            color: controlFg,
                          ),
                        )
                      else
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: controlFill,
                            borderRadius:
                                BorderRadius.circular(isTablet ? 8 : 8.sp),
                            border: Border.all(color: controlBorder),
                          ),
                          child: SizedBox(
                            height: isTablet ? 32 : 34,
                            child: Row(
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  constraints: const BoxConstraints(
                                      minWidth: 40, minHeight: 34),
                                  onPressed: onDecrease,
                                  icon: Icon(Icons.remove_rounded,
                                      size: 22, color: cs.primary),
                                ),
                                Expanded(
                                  child: Text(
                                    context.l10n.formatCount(quantity),
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: controlFg,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  constraints: const BoxConstraints(
                                      minWidth: 40, minHeight: 34),
                                  onPressed: onAdd,
                                  icon: Icon(Icons.add_rounded,
                                      size: 22, color: cs.primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (optionsCount > 1)
              Positioned(
                left: 4,
                top: 36,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade600,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      '$optionsCount Options',
                      style: AppFonts.interStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
            if (quantity > 0)
              Positioned(
                left: optionsCount > 1 ? 32 : (isTablet ? 30 : 26),
                top: isTablet ? 8 : 6,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: theme.colorScheme.primary,
                  child: Text(
                    context.l10n.formatCount(quantity),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _stockDot() {
    Widget dot(bool inStock) {
      return Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          color: inStock ? Colors.green.shade600 : Colors.red.shade600,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
        ),
      );
    }

    if (!limitByStock) return dot(true);
    final tracking = liveStockOrNull();
    if (tracking == null) return dot(true);
    return ListenableBuilder(
      listenable: tracking,
      builder: (_, __) {
        return dot(
          liveStockAllowsSale(
            itemName: item.name,
            requestedQty: (quantity + 1).toDouble(),
            itemType: item.itemType,
          ),
        );
      },
    );
  }
}
