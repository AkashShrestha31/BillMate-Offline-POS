import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/widget/notched_bottom_nav_bar.dart';
import 'package:hotel/src/core/widget/per_page_expandable_fab.dart';
import 'package:hotel/src/features/dashboard/presentation/main_shell_tab_index.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/debouncer.dart';
import 'package:hotel/src/core/helpers/error_message_helper.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';
import 'package:hotel/src/core/widget/date_range_picker_bottom_sheet.dart';
import 'package:hotel/src/core/constants/app_empty_state_assets.dart';
import 'package:hotel/src/core/widget/empty_state_card.dart';
import 'package:hotel/src/core/widget/tab_error_view.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:hotel/src/features/action/presentation/cubit/party_cubit.dart';
import 'package:hotel/src/features/invoice/data/models/request/delete_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_dates_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/invoice/presentation/bloc/filter/filter_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/bloc/login/invoice_cubit.dart';
import 'package:hotel/src/features/settings/presentation/live_stock_issue_guard.dart';
import 'package:hotel/src/features/invoice/presentation/cubit/accounting_settings_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/delete_invoice/delete_invoice_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/delete_invoice_confirm_sheet.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/invoice_dates/invoice_dates_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/update_invoice/update_invoice_cubit.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/features/invoice/presentation/pages/login/create_invoice_page.dart'
    show QuickAddInvoiceDraft, QuickAddInvoiceDraftBridge;
import 'package:hotel/src/features/invoice/presentation/pages/login/quick_add_items_page.dart'
    show QuickAddItemsPage, SelectedItemSummary;
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_card.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_list_chrome.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_month_year_picker_dialog.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_tab_tablet_layout.dart';
import 'package:intl/intl.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/widget/freemium_access_scope.dart';
import 'package:hotel/src/core/widget/freemium_record_gate.dart';

ValueNotifier<InvoiceRequestParams> invoiceRequestParams = ValueNotifier<InvoiceRequestParams>(InvoiceRequestParams());
ValueNotifier<bool> salesInvoiceSearchMode = ValueNotifier<bool>(false);

class SalesInvoicePage extends StatefulWidget implements AutoRouteWrapper {
  const SalesInvoicePage({
    super.key,
    this.canPop = true,
    required this.invoiceType,
    this.deferInitialFetch = false,
  });

  final InvoiceType invoiceType;
  final bool? canPop;

  /// When true (main tab shell), parent runs API loads sequentially — skip initState fetches.
  final bool deferInitialFetch;

  @override
  State<SalesInvoicePage> createState() => _SalesInvoicePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AccountingSettingsCubit>(),
      child: this,
    );
  }
}

class _SalesInvoicePageState extends State<SalesInvoicePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');
  NumberFormat get _currencyFormat => AppMoneyFormat.currency(currencySymbol);
  final _scrollController = ScrollController();
  final _searchDeBouncer = DeBouncer(milliseconds: 300);
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _itemSearchController = TextEditingController();
  InvoiceSalesResponseModel? response;
  final FocusNode _searchFocusNode = FocusNode();
  final FocusNode _itemSearchFocusNode = FocusNode();
  double _previousBottomInset = 0;
  // Multi-select state
  bool _isSelectionMode = false;
  final Set<String> _selectedInvoices = {};

  // ValueNotifiers
  final ValueNotifier<DateTime> _selectedMonthNotifier = ValueNotifier<DateTime>(DateTime.now());
  final ValueNotifier<DateTime?> _selectedDateNotifier = ValueNotifier<DateTime?>(DateTime.now());
  final ValueNotifier<bool> _isDateLoadingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isInitialLoadingNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<InvoiceSalesResponseModel?> _responseNotifier = ValueNotifier<InvoiceSalesResponseModel?>(null);
  final ValueNotifier<List<String>> _availableDatesNotifier = ValueNotifier<List<String>>([]);
  final ValueNotifier<DateTimeRange?> _selectedDateRangeNotifier = ValueNotifier<DateTimeRange?>(null);
  final ValueNotifier<String> _searchQueryNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> _itemSearchQueryNotifier = ValueNotifier<String>('');
  final ValueNotifier<bool> _showItemSearchNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isItemSearchLoadingNotifier = ValueNotifier<bool>(false);
  final _key = GlobalKey<ExpandableFabState>();
  late final PerPageExpandableFabLocation _expandableFabLocation = PerPageExpandableFabLocation();
  final ValueNotifier<bool> _blockingOverlayVisible = ValueNotifier<bool>(false);
  int _blockingOverlayDepth = 0;
  int _selectedMonthIndex = 0;
  DateTime? _monthBeforeItemSearch;

  String _itemSearchScopeLabel(BuildContext context) {
    final l10n = context.l10n;
    final range = _selectedDateRangeNotifier.value;
    if (range != null) {
      return l10n.invoiceDateRangeScopeLabel(range.start, range.end);
    }
    return l10n.invoiceMonthYearLabel(_selectedMonthNotifier.value);
  }

  String _formatMoney(BuildContext context, num value) => context.l10n.formatCurrency(_currencyFormat.format(value));

  String _formatQty(BuildContext context, num value) => context.l10n.formatDecimal(value);

  String _localizedL10n(BuildContext context, String message) => context.l10n.localizeMessage(message);

  BoxDecoration _surfaceCardDecoration({double radius = 16}) {
    return InvoiceListChrome.cardDecoration(
      context,
      borderRadius: BorderRadius.circular(radius.r),
    );
  }

  void _enterItemSearchMode() {
    _monthBeforeItemSearch = _selectedMonthNotifier.value;
    salesInvoiceSearchMode.value = true;
    _showItemSearchNotifier.value = true;
  }

  void _shiftCalendarMonth(int delta) {
    final current = _selectedMonthNotifier.value;
    final next = DateTime(current.year, current.month + delta, 1);
    _selectedMonthNotifier.value = next;
    _selectedMonthIndex = next.month - 1;
    context.read<InvoiceDatesCubit>().getInvoiceDates(
          params: _invoiceDatesParams(next),
        );
  }

  void _acquireBlockingOverlay() {
    _blockingOverlayDepth++;
    if (_blockingOverlayDepth == 1) {
      _blockingOverlayVisible.value = true;
    }
  }

  void _releaseBlockingOverlay() {
    if (_blockingOverlayDepth <= 0) return;
    _blockingOverlayDepth--;
    if (_blockingOverlayDepth == 0) {
      _blockingOverlayVisible.value = false;
    }
  }

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  void _deferIfMounted(VoidCallback fn) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      fn();
    });
  }

  String _ymd(DateTime d) => '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  InvoiceDatesRequestParams _invoiceDatesParams([DateTime? month]) {
    return InvoiceDatesRequestParams.forMonth(
      invoiceType: InvoiceType.sales.name,
      month: month ?? _selectedMonthNotifier.value,
    );
  }

  @override
  void dispose() {
    if (widget.deferInitialFetch) {
      currentIndex.removeListener(_onMainShellTabChanged);
    }
    salesInvoiceSearchMode.value = false;
    _scrollController.dispose();
    _searchController.dispose();
    _itemSearchController.dispose();
    _fadeController.dispose();
    _selectedMonthNotifier.dispose();
    _selectedDateNotifier.dispose();
    _isDateLoadingNotifier.dispose();
    _isInitialLoadingNotifier.dispose();
    _responseNotifier.dispose();
    _availableDatesNotifier.dispose();
    _selectedDateRangeNotifier.dispose();
    _searchQueryNotifier.dispose();
    _itemSearchQueryNotifier.dispose();
    _showItemSearchNotifier.dispose();
    _isItemSearchLoadingNotifier.dispose();
    _searchFocusNode.dispose();
    _itemSearchFocusNode.dispose();
    _selectedInvoices.clear();
    _expandableFabLocation.dispose();
    _blockingOverlayVisible.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<AccountingSettingsCubit>().loadIfNeeded();
    _selectedMonthIndex = DateTime.now().month - 1;
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    if (!widget.deferInitialFetch) {
      context.read<InvoiceDatesCubit>().getInvoiceDates(
            params: _invoiceDatesParams(),
          );

      final today = DateTime.now();
      final day = _ymd(today);
      loadApi(
          InvoiceRequestParams(
            perPage: 5000,
            startDate: day,
            endDate: day,
          ),
          isInitialLoad: true);
    }

    if (widget.deferInitialFetch) {
      currentIndex.addListener(_onMainShellTabChanged);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _hydrateInvoiceListFromCubit();
      });
    }

    WidgetsBinding.instance.platformDispatcher.onMetricsChanged = () {
      _handleKeyboardVisibility();
    };
  }

  /// When the parent loads invoices before this page's listener is attached,
  /// copy the already-emitted success into [_responseNotifier].
  void _hydrateInvoiceListFromCubit() {
    if (!mounted) return;
    context.read<InvoiceCubit>().state.maybeWhen(
      success: (responseData) {
        final data = responseData.data;
        response = data;
        _responseNotifier.value = data;
        _isDateLoadingNotifier.value = false;
        _isInitialLoadingNotifier.value = false;
      },
      orElse: () {},
    );
  }

  void _onMainShellTabChanged() {
    if (!mounted) return;
    if (currentIndex.value == 1) return;
    if (_showItemSearchNotifier.value) {
      _exitItemSearchMode();
    }
  }

  void _handleKeyboardVisibility() {
    final mediaQuery = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first);
    final currentBottomInset = mediaQuery.viewInsets.bottom;

    if (_previousBottomInset > 0 && currentBottomInset == 0) {
      _searchFocusNode.unfocus();
      _itemSearchFocusNode.unfocus();
    }

    _previousBottomInset = currentBottomInset;
  }

  loadApi(InvoiceRequestParams invoiceRequestParams,
      {bool isDateChange = false, bool isInitialLoad = false, bool hideLoading = false, bool isItemSearch = false}) {
    if (isItemSearch) {
      _isItemSearchLoadingNotifier.value = true;
    } else if (isDateChange) {
      _isDateLoadingNotifier.value = true;
    }
    if (!isInitialLoad) {
      _isInitialLoadingNotifier.value = false;
    }

    // Always sales on this page — shared [FilterCubit] can carry purchase filters otherwise.
    final param = invoiceRequestParams.copyWith(invoiceType: InvoiceType.sales);
    context.read<InvoiceCubit>().invoice(invoiceRequestParam: param);
    _fadeController.reset();
    _fadeController.forward();
  }

  bool _invoiceDatesReachedIdle(InvoiceDatesState s) => s.maybeWhen(
        success: (_, type) => type == InvoiceType.sales.name,
        error: (_) => true,
        noInternet: () => true,
        orElse: () => false,
      );

  bool _salesInvoiceListReachedIdle(InvoiceState s) => s.maybeWhen(
        success: (_) => true,
        error: (_) => true,
        noInternet: () => true,
        orElse: () => false,
      );

  Future<void> _onRefreshSalesData() async {
    if (!mounted) return;
    final datesCubit = context.read<InvoiceDatesCubit>();
    final invoiceCubit = context.read<InvoiceCubit>();

    datesCubit.getInvoiceDates(params: _invoiceDatesParams());
    await datesCubit.stream.firstWhere(_invoiceDatesReachedIdle);
    if (!mounted) return;

    if (_showItemSearchNotifier.value) {
      final query = _itemSearchQueryNotifier.value.trim();
      if (query.isNotEmpty) {
        _searchItemsByApi(query);
      }
    } else {
      final d = _selectedDateNotifier.value ?? DateTime.now();
      final selectedDateStr = _ymd(d);
      invoiceCubit.invoice(
        invoiceRequestParam: InvoiceRequestParams(
          perPage: 5000,
          invoiceType: InvoiceType.sales,
          startDate: selectedDateStr,
          endDate: selectedDateStr,
        ),
      );
    }
    await invoiceCubit.stream.firstWhere(_salesInvoiceListReachedIdle);
  }

  // Multi-select methods
  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      if (!_isSelectionMode) {
        _selectedInvoices.clear();
      }
    });
  }

  void _toggleInvoiceSelection(String invoiceName) {
    setState(() {
      if (_selectedInvoices.contains(invoiceName)) {
        _selectedInvoices.remove(invoiceName);
      } else {
        _selectedInvoices.add(invoiceName);
      }

      if (_selectedInvoices.isEmpty) {
        _isSelectionMode = false;
      }
    });
  }

  void _selectAllInvoices(List<InvoiceItem> invoices) {
    setState(() {
      if (_selectedInvoices.length == invoices.length) {
        _selectedInvoices.clear();
        _isSelectionMode = false;
      } else {
        _selectedInvoices.clear();
        _selectedInvoices.addAll(invoices.map((invoice) => invoice.invoiceName ?? '').where((name) => name.isNotEmpty));
      }
    });
  }

  void _exitItemSearchMode() {
    salesInvoiceSearchMode.value = false;
    _showItemSearchNotifier.value = false;
    _itemSearchQueryNotifier.value = '';
    _itemSearchController.clear();
    _selectedDateRangeNotifier.value = null;
    _isItemSearchLoadingNotifier.value = false;
    _responseNotifier.value = null;

    if (_monthBeforeItemSearch != null) {
      _selectedMonthNotifier.value = _monthBeforeItemSearch!;
      _selectedMonthIndex = _monthBeforeItemSearch!.month - 1;
      _monthBeforeItemSearch = null;
      context.read<InvoiceDatesCubit>().getInvoiceDates(
            params: _invoiceDatesParams(_selectedMonthNotifier.value),
          );
    }

    final sel = _selectedDateNotifier.value;
    if (sel == null) return;
    final selectedDateStr = _ymd(sel);
    loadApi(
      InvoiceRequestParams(
        perPage: 5000,
        startDate: selectedDateStr,
        endDate: selectedDateStr,
      ),
      hideLoading: true,
    );
  }

  Future<void> _deleteSelectedInvoices() async {
    if (_selectedInvoices.isEmpty) return;

    final count = _selectedInvoices.length;
    final confirmed = await showDeleteInvoiceConfirmSheet(
      context: context,
      title: _localizedL10n(
        context,
        context.l10n.invoiceDeleteTitle(count),
      ),
      message: _localizedL10n(
        context,
        context.l10n.invoiceDeleteMessage(count),
      ),
    );
    if (!confirmed || !mounted) return;

    context.read<DeleteInvoiceCubit>().deleteInvoice(
          params: DeleteInvoiceRequestParams(
            invoiceNames: _selectedInvoices.toList(),
            confirmDelete: true,
            forceDelete: false,
            deletedBy: context.employeeData?.email,
          ),
        );

    setState(() {
      _selectedInvoices.clear();
      _isSelectionMode = false;
    });
  }

  ({String start, String end}) _itemSearchDateRangeStrings() {
    final range = _selectedDateRangeNotifier.value;
    if (range != null) {
      return (start: _ymd(range.start), end: _ymd(range.end));
    }

    final selectedMonth = _selectedMonthNotifier.value;
    final startDate = DateTime(selectedMonth.year, selectedMonth.month, 1);
    final endDate = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);
    return (start: _ymd(startDate), end: _ymd(endDate));
  }

  void _searchItemsByApi(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      _responseNotifier.value = null;
      _isItemSearchLoadingNotifier.value = false;
      return;
    }

    final range = _itemSearchDateRangeStrings();
    loadApi(
      InvoiceRequestParams(
        page: 1,
        perPage: 50,
        startDate: range.start,
        endDate: range.end,
        itemName: trimmed,
      ),
      hideLoading: true,
      isItemSearch: true,
    );
  }

  // Get invoices for selected date
  List<InvoiceItem> _getInvoicesForSelectedDate() {
    final currentResponse = _responseNotifier.value;
    if (currentResponse?.data == null) {
      return [];
    }

    final invoices = currentResponse!.data!;
    return invoices;
  }

  // Get dates that have invoices in the selected month
  Set<int> _getDatesWithInvoices() {
    final availableDates = _availableDatesNotifier.value;
    if (availableDates.isEmpty) return {};

    Set<int> datesWithInvoices = {};

    for (final dateString in availableDates) {
      try {
        final invoiceDate = DateTime.parse(dateString);

        if (invoiceDate.year == _selectedMonthNotifier.value.year &&
            invoiceDate.month == _selectedMonthNotifier.value.month) {
          datesWithInvoices.add(invoiceDate.day);
        }
      } catch (e) {}
    }

    return datesWithInvoices;
  }

  bool _invoiceInSearchDateWindow(DateTime invoiceDate) {
    final range = _selectedDateRangeNotifier.value;
    if (range != null) {
      final dateOnly = DateTime(invoiceDate.year, invoiceDate.month, invoiceDate.day);
      final start = DateTime(range.start.year, range.start.month, range.start.day);
      final end = DateTime(range.end.year, range.end.month, range.end.day);
      return !dateOnly.isBefore(start) && !dateOnly.isAfter(end);
    }

    final month = _selectedMonthNotifier.value;
    return invoiceDate.year == month.year && invoiceDate.month == month.month;
  }

  // Search for items across all invoices in the month
  List<Map<String, dynamic>> _searchItemsInMonth() {
    if (_itemSearchQueryNotifier.value.isEmpty) return [];

    List<Map<String, dynamic>> itemResults = [];
    final currentResponse = _responseNotifier.value;
    if (currentResponse?.data == null) return [];

    for (final invoice in currentResponse!.data!) {
      if (invoice.date != null && invoice.items != null) {
        try {
          final invoiceDate = DateTime.parse(invoice.date!);

          if (!_invoiceInSearchDateWindow(invoiceDate)) continue;

          for (final item in invoice.items!) {
            final itemName = item.item?.toLowerCase() ?? '';
            final searchLower = _itemSearchQueryNotifier.value.toLowerCase();

            if (itemName.contains(searchLower)) {
              itemResults.add({
                'itemName': item.item ?? context.l10n.invoiceCommonUnknownItem,
                'quantity': item.quantity ?? 0,
                'rate': item.rate ?? 0,
                'total': item.amount ?? 0,
                'date': invoiceDate,
                'invoiceNumber': invoice.invoiceName ?? context.l10n.invoiceCommonNotAvailable,
                'partyName': invoice.party ?? context.l10n.invoiceCommonNotAvailable,
              });
            }
          }
        } catch (e) {}
      }
    }

    itemResults.sort((a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime));
    return itemResults;
  }

  // Calculate total quantity for search results
  double _calculateTotalQuantity(List<Map<String, dynamic>> itemResults) {
    return itemResults.fold<double>(0, (sum, item) => sum + (item['quantity'] as num).toDouble());
  }

  // Calculate total amount for search results
  double _calculateTotalAmount(List<Map<String, dynamic>> itemResults) {
    return itemResults.fold<double>(0, (sum, item) => sum + (item['total'] as num).toDouble());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FreemiumAccessHost(
      feature: widget.invoiceType == InvoiceType.purchase
          ? FreemiumFeature.purchaseInvoice
          : FreemiumFeature.salesInvoice,
      child: ValueListenableBuilder<bool>(
      valueListenable: _blockingOverlayVisible,
      builder: (context, showBlockingOverlay, _) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            MultiBlocListener(
              listeners: [
                BlocListener<InvoiceCubit, InvoiceState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      success: (responseData) {
                        final data = responseData.data;
                        _releaseBlockingOverlay();
                        response = data;
                        _responseNotifier.value = data;
                        _isDateLoadingNotifier.value = false;
                        _isInitialLoadingNotifier.value = false;
                        if (_showItemSearchNotifier.value) {
                          _isItemSearchLoadingNotifier.value = false;
                        }
                      },
                      error: (message) {
                        _releaseBlockingOverlay();
                        _isDateLoadingNotifier.value = false;
                        _isInitialLoadingNotifier.value = false;
                        if (_showItemSearchNotifier.value) {
                          _isItemSearchLoadingNotifier.value = false;
                        }
                      },
                      orElse: () {},
                      loading: () {
                        if (_isInitialLoadingNotifier.value && !widget.deferInitialFetch) {
                          _acquireBlockingOverlay();
                        }
                      },
                    );
                  },
                ),
                BlocListener<InvoiceDatesCubit, InvoiceDatesState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      success: (_, type) {
                        if (type == InvoiceType.sales.name) {
                          _hydrateInvoiceListFromCubit();
                        }
                      },
                      orElse: () {},
                    );
                  },
                ),
                BlocListener<UpdateInvoiceCubit, UpdateInvoiceState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      success: (responseData) {
                        _releaseBlockingOverlay();
                        final sel = _selectedDateNotifier.value;
                        if (sel == null) return;
                        final selectedDateStr = _ymd(sel);
                        _deferIfMounted(() {
                          loadApi(
                            InvoiceRequestParams(
                              perPage: 5000,
                              startDate: selectedDateStr,
                              endDate: selectedDateStr,
                            ),
                            hideLoading: true,
                          );
                          context.router.maybePop();
                        });
                      },
                      error: (message) {
                        _releaseBlockingOverlay();
                      },
                      orElse: () {},
                      loading: () {
                        _deferIfMounted(() {
                          _acquireBlockingOverlay();
                        });
                      },
                    );
                  },
                ),
                BlocListener<DeleteInvoiceCubit, DeleteInvoiceState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      success: (responseData) {
                        _releaseBlockingOverlay();
                        final sel = _selectedDateNotifier.value;
                        if (sel == null) return;
                        final selectedDateStr = _ymd(sel);
                        _deferIfMounted(() {
                          loadApi(
                            InvoiceRequestParams(
                              perPage: 5000,
                              startDate: selectedDateStr,
                              endDate: selectedDateStr,
                            ),
                            hideLoading: true,
                          );
                          context.showKiiSnackBarSuccess(responseData.message);
                          context.router.maybePop();
                        });
                      },
                      error: (message) {
                        _releaseBlockingOverlay();
                        _deferIfMounted(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(ErrorMessageHelper.format(message)),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        });
                      },
                      orElse: () {},
                      loading: () {
                        _deferIfMounted(() {
                          _acquireBlockingOverlay();
                        });
                      },
                    );
                  },
                )
              ],
              child: BlocBuilder<InvoiceDatesCubit, InvoiceDatesState>(
                buildWhen: (previous, current) => current.maybeWhen(
                  success: (_, type) => type == InvoiceType.sales.name,
                  orElse: () => true,
                ),
                builder: (context, state) {
                  return state.maybeWhen(
                    error: (message) => TabErrorView(
                      title: context.l10n.invoiceSalesCouldNotLoad,
                      message: message,
                      onRetry: _onRefreshSalesData,
                    ),
                    noInternet: () => TabErrorView(
                      title: context.l10n.noInternetConnection,
                      message: context.l10n.statisticsCheckConnection,
                      isNoInternet: true,
                      onRetry: _onRefreshSalesData,
                    ),
                    orElse: () => Container(),
                    loading: () {
                      return Center(child: CircularProgressIndicator());
                    },
                    success: (responseData, invoiceType) {
                      if (invoiceType != InvoiceType.sales.name) {
                        return Center(child: CircularProgressIndicator());
                      }
                      _availableDatesNotifier.value = responseData.dates;
                      return ValueListenableBuilder<bool>(
                        valueListenable: _showItemSearchNotifier,
                        builder: (context, showItemSearch, _) => Scaffold(
                          floatingActionButtonLocation: _expandableFabLocation,
                          floatingActionButton: showItemSearch
                              ? null
                              : ExpandableFab(
                                  key: _key,
                                  fabLocation: _expandableFabLocation,
                                  shellBottomLift: widget.deferInitialFetch
                                      ? NotchedBottomNavBar.shellTabFabBottomLift(
                                          context,
                                        )
                                      : null,
                                  overlayStyle: ExpandableFabOverlayStyle(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    blur: 5,
                                  ),
                                  onOpen: () {
                                    debugPrint('onOpen');
                                  },
                                  afterOpen: () {
                                    debugPrint('afterOpen');
                                  },
                                  onClose: () {
                                    debugPrint('onClose');
                                  },
                                  afterClose: () {
                                    debugPrint('afterClose');
                                  },
                                  openButtonBuilder: RotateFloatingActionButtonBuilder(
                                    heroTag: 'sales_invoice_fab_open',
                                    child: Icon(Icons.add),
                                    fabSize: ExpandableFabSize.regular,
                                    foregroundColor: Colors.white,
                                    backgroundColor: context.theme.colorScheme.primary,
                                    shape: const CircleBorder(),
                                    angle: 3.14 * 2,
                                    elevation: 5,
                                  ),
                                  closeButtonBuilder: RotateFloatingActionButtonBuilder(
                                    heroTag: 'sales_invoice_fab_close',
                                    child: Icon(Icons.close),
                                    fabSize: ExpandableFabSize.small,
                                    foregroundColor: Colors.white,
                                    backgroundColor: context.theme.colorScheme.primary,
                                    shape: const CircleBorder(),
                                    angle: 3.14 * 2,
                                    elevation: 5,
                                  ),
                                  children: [
                                    FloatingActionButton.small(
                                      shape: const CircleBorder(),
                                      heroTag: 'sales_invoice_fab_search',
                                      backgroundColor: context.theme.colorScheme.primary,
                                      child: AppSearchIcon(
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        final state = _key.currentState;
                                        if (state != null) {
                                          state.toggle();
                                          _enterItemSearchMode();
                                        }
                                      },
                                    ),
                                    FloatingActionButton.small(
                                      shape: const CircleBorder(),
                                      heroTag: 'sales_invoice_fab_add',
                                      backgroundColor: context.theme.colorScheme.primary,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        final state = _key.currentState;
                                        if (state != null) {
                                          state.toggle();
                                          final selectedItemsNotifier = ValueNotifier<List<SelectedItemSummary>>([]);
                                          final cartTotalNotifier = ValueNotifier<double>(0);
                                          String? selectedPartyName;
                                          String? selectedPartyCurrency;

                                          void recalculateCartTotal() {
                                            final total = selectedItemsNotifier.value.fold<double>(
                                              0,
                                              (sum, e) => sum + (e.rate * e.quantity),
                                            );
                                            cartTotalNotifier.value = total;
                                          }

                                          int? addOrIncreaseItem(ItemModel item) {
                                            final list = List<SelectedItemSummary>.from(selectedItemsNotifier.value);
                                            final idx = list.indexWhere((e) => e.name == item.name);
                                            final nextQty = idx >= 0 ? list[idx].quantity + 1 : 1;
                                            if (!liveStockAllowsSale(
                                              itemName: item.name,
                                              requestedQty: nextQty.toDouble(),
                                              itemType: item.itemType,
                                            )) {
                                              showLiveStockShortage(context, item.name);
                                              return idx >= 0 ? list[idx].quantity : 0;
                                            }
                                            if (idx >= 0) {
                                              final existing = list[idx];
                                              final updated = SelectedItemSummary(
                                                name: existing.name,
                                                quantity: existing.quantity + 1,
                                                rate: existing.rate,
                                                imageUrl: existing.imageUrl,
                                              );
                                              list[idx] = updated;
                                              selectedItemsNotifier.value = list;
                                              recalculateCartTotal();
                                              return updated.quantity;
                                            }
                                            list.add(SelectedItemSummary(
                                              name: item.name,
                                              quantity: 1,
                                              rate: item.rate,
                                              imageUrl: item.image,
                                            ));
                                            selectedItemsNotifier.value = list;
                                            recalculateCartTotal();
                                            return 1;
                                          }

                                          void increaseItem(String itemName) {
                                            final list = List<SelectedItemSummary>.from(selectedItemsNotifier.value);
                                            final idx = list.indexWhere((e) => e.name == itemName);
                                            if (idx < 0) return;
                                            final existing = list[idx];
                                            if (!liveStockAllowsSale(
                                              itemName: itemName,
                                              requestedQty: (existing.quantity + 1).toDouble(),
                                            )) {
                                              showLiveStockShortage(context, itemName);
                                              return;
                                            }
                                            list[idx] = SelectedItemSummary(
                                              name: existing.name,
                                              quantity: existing.quantity + 1,
                                              rate: existing.rate,
                                              imageUrl: existing.imageUrl,
                                            );
                                            selectedItemsNotifier.value = list;
                                            recalculateCartTotal();
                                          }

                                          void decreaseItem(String itemName) {
                                            final list = List<SelectedItemSummary>.from(selectedItemsNotifier.value);
                                            final idx = list.indexWhere((e) => e.name == itemName);
                                            if (idx < 0) return;
                                            final existing = list[idx];
                                            if (existing.quantity <= 1) {
                                              list.removeAt(idx);
                                            } else {
                                              list[idx] = SelectedItemSummary(
                                                name: existing.name,
                                                quantity: existing.quantity - 1,
                                                rate: existing.rate,
                                                imageUrl: existing.imageUrl,
                                              );
                                            }
                                            selectedItemsNotifier.value = list;
                                            recalculateCartTotal();
                                          }

                                          QuickAddItemsPage.open(
                                            context,
                                            invoiceType: InvoiceType.sales,
                                            onItemSelected: addOrIncreaseItem,
                                            cartTotalNotifier: cartTotalNotifier,
                                            selectedItemsNotifier: selectedItemsNotifier,
                                            onIncreaseItem: increaseItem,
                                            onDecreaseItem: decreaseItem,
                                            showDoneButton: true,
                                            showPartySelector: true,
                                            onPartySelected: (partyName, {String? currency}) {
                                              selectedPartyName = partyName;
                                              selectedPartyCurrency = currency;
                                            },
                                            onDone: () {
                                              QuickAddInvoiceDraftBridge.set(
                                                QuickAddInvoiceDraft(
                                                  invoiceType: InvoiceType.sales,
                                                  items: List<SelectedItemSummary>.from(selectedItemsNotifier.value),
                                                  partyName: selectedPartyName,
                                                  partyCurrency: selectedPartyCurrency,
                                                ),
                                              );
                                              context.router.push(CreateInvoiceRoute(
                                                selectedDate: _selectedDateNotifier.value!,
                                                invoiceType: InvoiceType.sales,
                                                onComplete: () {
                                                  final sel = _selectedDateNotifier.value;
                                                  if (sel == null) return;
                                                  final selectedDateStr = _ymd(sel);
                                                  loadApi(
                                                      InvoiceRequestParams(
                                                        perPage: 5000,
                                                        startDate: selectedDateStr,
                                                        endDate: selectedDateStr,
                                                      ),
                                                      hideLoading: true);
                                                },
                                              ));
                                            },
                                          );
                                        }
                                      },
                                    ),
                                    FloatingActionButton.small(
                                      shape: const CircleBorder(),
                                      heroTag: 'sales_invoice_fab_filter',
                                      backgroundColor: context.theme.colorScheme.primary,
                                      child: Icon(
                                        Icons.filter_list_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        final state = _key.currentState;
                                        if (state != null) {
                                          state.toggle();
                                          _showMonthYearPicker();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                          appBar: AppBar(
                            title: _isSelectionMode
                                ? Text(_localizedL10n(
                                    context,
                                    context.l10n.invoiceCommonSelectedCount(
                                      _selectedInvoices.length,
                                    ),
                                  ))
                                : Text(context.l10n.sales),
                            // leading: _isSelectionMode
                            //     ? IconButton(
                            //         icon: Icon(Icons.close_rounded),
                            //         onPressed: _toggleSelectionMode,
                            //       )
                            //     : const AppBarIosBackButton(),
                            actions: [
                              if (_isSelectionMode) ...[
                                // Select All button
                                GestureDetector(
                                  onTap: () {
                                    final invoices = _getInvoicesForSelectedDate();
                                    _selectAllInvoices(invoices);
                                  },
                                  child: Center(
                                    child: Text(
                                      context.l10n.invoiceCommonSelectAll,
                                      style: AppFonts.interStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ).pOnly(right: context.theme.appTheme.spacing12),

                                // Delete button
                                GestureDetector(
                                  onTap: _selectedInvoices.isEmpty ? null : _deleteSelectedInvoices,
                                  child: AppDeleteIcon(
                                    size: 20.r,
                                    color: _selectedInvoices.isEmpty ? Colors.grey : Colors.red,
                                  ),
                                ).pOnly(right: context.theme.appTheme.spacing12),
                              ] else if (showItemSearch) ...[
                                IconButton(
                                  tooltip: context.l10n.invoiceCommonFilterByDateRange,
                                  onPressed: _showDateRangePicker,
                                  icon: Icon(
                                    Icons.filter_alt_outlined,
                                  ),
                                ),
                                IconButton(
                                  tooltip: context.l10n.invoiceCommonCloseSearch,
                                  onPressed: _exitItemSearchMode,
                                  icon: Icon(
                                    Icons.close_rounded,
                                  ),
                                ),
                              ],
                            ],
                            centerTitle: false,
                          ),
                          body: Align(
                            alignment: Alignment.topCenter,
                            child: RefreshIndicator(
                              onRefresh: _onRefreshSalesData,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: ValueListenableBuilder<bool>(
                                  valueListenable: _showItemSearchNotifier,
                                  builder: (context, showItemSearch, child) {
                                    return Padding(
                                      padding: InvoiceTabTabletLayout.contentPadding(
                                        context,
                                        shellTab: widget.deferInitialFetch,
                                      ),
                                      child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Item Search Bar
                                        if (showItemSearch) _buildItemSearchBar(),

                                        // Filter chips (only show when not in item search mode)
                                        if (!showItemSearch)
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: BlocConsumer<FilterCubit, FilterState>(
                                              listener: (context, state) {},
                                              builder: (context, state) {
                                                final Map<String, String?> filters =
                                                    Map<String, String?>.from(state.selectedFilters);
                                                final List<Widget> chips = [];

                                                filters.forEach((key, value) {
                                                  if (value != null &&
                                                      value.isNotEmpty &&
                                                      key != "page" &&
                                                      key != "per_page" &&
                                                      key != "startDate" &&
                                                      key != "endDate") {
                                                    chips.add(
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 8.0),
                                                        child: Chip(
                                                          label: Text(value, style: AppFonts.interStyle(fontSize: 12.sp)),
                                                          deleteIcon: Icon(Icons.close, size: 16.r),
                                                          onDeleted: () {
                                                            context.read<FilterCubit>().toggleFilter(key, value);
                                                            if (key == "dateRange") {
                                                              context.read<FilterCubit>().toggleFilter("startDate",
                                                                  state.selectedFilters["startDate"].toString());
                                                              context.read<FilterCubit>().toggleFilter("endDate",
                                                                  state.selectedFilters["endDate"].toString());
                                                            }
                                                            final selectedFilters =
                                                                context.read<FilterCubit>().state.selectedFilters;
                                                            InvoiceRequestParams invoiceRequestParams =
                                                                InvoiceRequestParams.fromJson(selectedFilters);
                                                            loadApi(invoiceRequestParams, hideLoading: true);
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                });

                                                return Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: chips);
                                              },
                                            ),
                                          ),
                                        // verticalMarginMedium,

                                        // Show either calendar view or item search results
                                        if (!showItemSearch) ...[
                                          InvoiceTabTabletLayout.calendarWithInvoices(
                                            context: context,
                                            calendar: _buildCalendarSection(),
                                            invoices: _buildSelectedDateInvoices(),
                                          ),
                                        ] else ...[
                                          _buildItemSearchResults(),
                                        ],
                                      ],
                                    ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            if (showBlockingOverlay)
              Positioned.fill(
                child: AbsorbPointer(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const ModalBarrier(
                        color: Colors.black54,
                        dismissible: false,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: context.theme.colorScheme.surface,
                          borderRadius: allRadiusLarge,
                        ),
                        padding: symmetricPaddingMedium,
                        child: const CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    ),
    );
  }

  Widget _buildItemSearchBar() {
    return ValueListenableBuilder<DateTimeRange?>(
      valueListenable: _selectedDateRangeNotifier,
      builder: (context, selectedDateRange, _) {
        return ValueListenableBuilder<DateTime>(
          valueListenable: _selectedMonthNotifier,
          builder: (context, _, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 12.h, top: 4.h),
                  child: ValueListenableBuilder<String>(
                    valueListenable: _itemSearchQueryNotifier,
                    builder: (context, itemSearchQuery, child) {
                      return CustomTextFormField(
                        controller: _itemSearchController,
                        focusNode: _itemSearchFocusNode,
                        hint: _localizedL10n(
                          context,
                          context.l10n.invoiceCommonSearchItemsHint(
                            _itemSearchScopeLabel(context),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.none,
                        borderRadius: 12,
                        suffixIcon: itemSearchQuery.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  _itemSearchController.clear();
                                  _itemSearchQueryNotifier.value = '';
                                  _responseNotifier.value = null;
                                  _isItemSearchLoadingNotifier.value = false;
                                },
                                child: Icon(
                                  Icons.clear_rounded,
                                  color: InvoiceListChrome.mutedText(context),
                                  size: 20.r,
                                ),
                              )
                            : null,
                        onChanged: (value) {
                          _searchDeBouncer.run(() {
                            _itemSearchQueryNotifier.value = value;
                            _searchItemsByApi(value);
                          });
                        },
                      );
                    },
                  ),
                ),
                if (selectedDateRange != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.date_range_rounded, size: 16.r, color: context.colorScheme.primary),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    _itemSearchScopeLabel(context),
                                    style: AppFonts.interStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: context.colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () {
                            _selectedDateRangeNotifier.value = null;
                            final query = _itemSearchQueryNotifier.value.trim();
                            if (query.isNotEmpty) {
                              _searchItemsByApi(query);
                            }
                          },
                          child: Icon(Icons.close_rounded, color: InvoiceListChrome.mutedText(context), size: 20.r),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildItemSearchResults() {
    return ValueListenableBuilder<String>(
      valueListenable: _itemSearchQueryNotifier,
      builder: (context, itemSearchQuery, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: _isItemSearchLoadingNotifier,
          builder: (context, isItemSearchLoading, child) {
            final itemResults = _searchItemsInMonth();
            final totalQuantity = _calculateTotalQuantity(itemResults);
            final totalAmount = _calculateTotalAmount(itemResults);

            if (itemSearchQuery.isEmpty) {
              return _buildItemSearchEmptyPrompt();
            }

            if (isItemSearchLoading) {
              return Container(
                width: context.width,
                padding: EdgeInsets.all(40.r),
                decoration: _surfaceCardDecoration(),
                child: Column(
                  children: [
                    SizedBox(
                      width: 32.r,
                      height: 32.r,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      _localizedL10n(
                        context,
                        context.l10n.invoiceCommonSearchingFor(itemSearchQuery),
                      ),
                      style: AppFonts.interStyle(
                        fontSize: 14.sp,
                        color: InvoiceListChrome.mutedText(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (itemResults.isEmpty) {
              return _buildItemSearchNoResults(itemSearchQuery);
            }

            return _buildItemSearchResultsBody(
              itemSearchQuery: itemSearchQuery,
              itemResults: itemResults,
              totalQuantity: totalQuantity,
              totalAmount: totalAmount,
            );
          },
        );
      },
    );
  }

  Widget _buildItemSearchEmptyPrompt() {
    return EmptyStateCard(
      title: context.l10n.invoiceCommonSearchForItems,
      subtitle: _localizedL10n(
        context,
        context.l10n.invoiceCommonSalesSearchPrompt(
          _itemSearchScopeLabel(context),
        ),
      ),
      iconPath: AppEmptyStateAssets.search,
      framed: false,
    );
  }

  Widget _buildItemSearchNoResults(String itemSearchQuery) {
    return EmptyStateCard(
      title: context.l10n.invoiceCommonNoItemsFound,
      subtitle: _localizedL10n(
        context,
        context.l10n.invoiceCommonSalesNoMatch(
          itemSearchQuery,
          _itemSearchScopeLabel(context),
        ),
      ),
      iconPath: AppEmptyStateAssets.search,
      framed: false,
    );
  }

  Widget _buildItemSearchResultsBody({
    required String itemSearchQuery,
    required List<Map<String, dynamic>> itemResults,
    required double totalQuantity,
    required double totalAmount,
  }) {
    Map<String, List<Map<String, dynamic>>> groupedByDate = {};
    for (var item in itemResults) {
      final dateKey = DateFormat('yyyy-MM-dd').format(item['date'] as DateTime);
      if (!groupedByDate.containsKey(dateKey)) {
        groupedByDate[dateKey] = [];
      }
      groupedByDate[dateKey]!.add(item);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary header
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.receipt_long_rounded, color: Colors.white, size: 20.r),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _localizedL10n(
                            context,
                            context.l10n.invoiceFoundSalesCount(
                              itemResults.length,
                            ),
                          ),
                          style: AppFonts.interStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'of "$itemSearchQuery"',
                          style: AppFonts.interStyle(
                            fontSize: 12.sp,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.invoiceCommonTotalQuantity,
                          style: AppFonts.interStyle(
                            fontSize: 12.sp,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _formatQty(context, totalQuantity),
                          style: AppFonts.interStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.invoiceCommonTotalAmount,
                          style: AppFonts.interStyle(
                            fontSize: 12.sp,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _formatMoney(context, totalAmount),
                          style: AppFonts.interStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Grouped results by date
        ...groupedByDate.entries.map((entry) {
          final date = DateTime.parse(entry.key);
          final items = entry.value;
          final dateQuantity = items.fold<double>(0, (sum, item) => sum + (item['quantity'] as num).toDouble());

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date header
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: InvoiceListChrome.subtleFill(context),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_rounded, size: 14.r, color: InvoiceListChrome.mutedText(context)),
                    SizedBox(width: 8.w),
                    Text(
                      context.l10n.invoiceDayMonthYearLabel(date),
                      style: AppFonts.interStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: InvoiceListChrome.primaryText(context),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        _localizedL10n(
                          context,
                          context.l10n.invoiceCommonQtyLabel(
                            _formatQty(context, dateQuantity),
                          ),
                        ),
                        style: AppFonts.interStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      _localizedL10n(
                        context,
                        context.l10n.invoiceDateSalesCount(items.length),
                      ),
                      style: AppFonts.interStyle(
                        fontSize: 11.sp,
                        color: InvoiceListChrome.mutedText(context),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),

              // Items for this date
              ...items.map((item) {
                return Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: _surfaceCardDecoration(radius: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['itemName'],
                                  style: AppFonts.interStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: InvoiceListChrome.primaryText(context),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  _localizedL10n(
                                    context,
                                    context.l10n.invoiceCommonInvoiceLabel(
                                      context.l10n.localizeDigits(
                                        item['invoiceNumber'] as String,
                                      ),
                                    ),
                                  ),
                                  style: AppFonts.interStyle(
                                    fontSize: 11.sp,
                                    color: InvoiceListChrome.mutedText(context),
                                  ),
                                ),
                                Text(
                                  context.l10n.invoiceCommonCustomerLabel(
                                    item['partyName'] as String,
                                  ),
                                  style: AppFonts.interStyle(
                                    fontSize: 11.sp,
                                    color: InvoiceListChrome.mutedText(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _localizedL10n(
                                    context,
                                    context.l10n.invoiceCommonQtyLabel(
                                      _formatQty(
                                        context,
                                        (item['quantity'] as num).toDouble(),
                                      ),
                                    ),
                                  ),
                                  style: AppFonts.interStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                                Text(
                                  '@${_formatMoney(context, item['rate'] as num)}',
                                  style: AppFonts.interStyle(
                                    fontSize: 10.sp,
                                    color: InvoiceListChrome.mutedText(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Divider(height: 1, color: InvoiceListChrome.border(context)),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.l10n.invoiceCommonTotal,
                            style: AppFonts.interStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: InvoiceListChrome.mutedText(context),
                            ),
                          ),
                          Text(
                            _formatMoney(context, item['total'] as num),
                            style: AppFonts.interStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: InvoiceListChrome.primaryText(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: 12.h),
            ],
          );
        }).toList(),
      ],
    );
  }

  void _showDateRangePicker() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedMonth = _selectedMonthNotifier.value;
    final firstDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month, 1);
    final lastDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);
    final monthEnd = lastDayOfMonth.isAfter(today) ? today : lastDayOfMonth;
    final initialRange = _selectedDateRangeNotifier.value ?? DateTimeRange(start: firstDayOfMonth, end: monthEnd);

    final picked = await showDateRangePickerBottomSheet(
      context: context,
      minDate: DateTime(2020, 1, 1),
      maxDate: today,
      initialStart: initialRange.start,
      initialEnd: initialRange.end,
      title: context.l10n.invoiceCommonFilterByDate,
    );

    if (picked != null) {
      _selectedDateRangeNotifier.value = picked;
      final query = _itemSearchQueryNotifier.value.trim();
      if (query.isNotEmpty) {
        _searchItemsByApi(query);
      }
    }
  }

  Widget _buildCalendarSection() {
    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => _buildCalendarWithData(),
          loading: () => ValueListenableBuilder<bool>(
            valueListenable: _isInitialLoadingNotifier,
            builder: (context, isInitialLoading, child) {
              return isInitialLoading ? _buildLoadingCalendar() : _buildCalendarWithData();
            },
          ),
          success: (responseData) {
            return _buildCalendarWithData();
          },
        );
      },
    );
  }

  Widget _buildCalendarWithData() {
    return Container(
      decoration: _surfaceCardDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCalendarHeader(),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildLoadingCalendar() {
    final tablet = InvoiceTabTabletLayout.isTablet(context);
    return Container(
      height: tablet ? 320 : 280.h,
      decoration: _surfaceCardDecoration(),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: tablet ? 2 : 2.w,
          valueColor: AlwaysStoppedAnimation<Color>(context.colorScheme.primary),
        ),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    final tablet = InvoiceTabTabletLayout.isTablet(context);
    return ValueListenableBuilder<DateTime>(
      valueListenable: _selectedMonthNotifier,
      builder: (context, selectedMonth, child) {
        return Container(
          padding: EdgeInsets.all(InvoiceTabTabletLayout.sz(context, 16, 12.w)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(InvoiceTabTabletLayout.sz(context, 12, 5.r)),
              topRight: Radius.circular(InvoiceTabTabletLayout.sz(context, 12, 5.r)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment:
                    context.isSupervisorOrManager ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                children: [
                  if (context.isSupervisorOrManager)
                    GestureDetector(
                      onTap: () => _shiftCalendarMonth(-1),
                      child: Container(
                        padding: EdgeInsets.all(InvoiceTabTabletLayout.sz(context, 8, 5.r)),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          borderRadius: BorderRadius.circular(InvoiceTabTabletLayout.sz(context, 18, 18.r)),
                        ),
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.white,
                          size: InvoiceTabTabletLayout.sz(context, 22, 20.r),
                        ),
                      ),
                    ),
                  Text(
                    context.l10n.invoiceMonthYearLabel(selectedMonth),
                    style: AppFonts.interStyle(
                      fontSize: InvoiceTabTabletLayout.sp(context, 18, 18),
                      fontWeight: FontWeight.w600,
                      color: InvoiceListChrome.primaryText(context),
                    ),
                  ),
                  if (context.isSupervisorOrManager)
                    GestureDetector(
                      onTap: () => _shiftCalendarMonth(1),
                      child: Container(
                        padding: EdgeInsets.all(InvoiceTabTabletLayout.sz(context, 8, 5.r)),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          borderRadius: BorderRadius.circular(InvoiceTabTabletLayout.sz(context, 18, 18.r)),
                        ),
                        child: Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white,
                          size: InvoiceTabTabletLayout.sz(context, 22, 20.r),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: InvoiceTabTabletLayout.sz(context, 12, 12.h)),
              Row(
                children: context.l10n.invoiceWeekdayLabels.map((day) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        day.toUpperCase(),
                        style: AppFonts.interStyle(
                          fontSize: InvoiceTabTabletLayout.sp(context, 11, 10),
                          fontWeight: FontWeight.w600,
                          color: InvoiceListChrome.mutedText(context),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCalendarGrid() {
    return ValueListenableBuilder<DateTime>(
      valueListenable: _selectedMonthNotifier,
      builder: (context, selectedMonth, child) {
        return ValueListenableBuilder<List<String>>(
          valueListenable: _availableDatesNotifier,
          builder: (context, availableDates, child) {
            final daysInMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;
            final firstWeekday = DateTime(selectedMonth.year, selectedMonth.month, 1).weekday;
            // Sunday-first columns (header is Sun..Sat). Dart: Mon=1 .. Sun=7.
            final leadingDays = firstWeekday % 7;
            final rowCount = (leadingDays + daysInMonth + 6) ~/ 7;
            final gridCellCount = rowCount * 7;
            final datesWithInvoices = _getDatesWithInvoices();
            final today = DateTime.now();
            final todayDateOnly = DateTime(today.year, today.month, today.day);
            return LayoutBuilder(
              builder: (context, constraints) {
                final crossSpacing = InvoiceTabTabletLayout.calendarGridSpacing(context);
                final mainSpacing = InvoiceTabTabletLayout.calendarMainSpacing(context);
                final cellSize = (constraints.maxWidth - 6 * crossSpacing) / 7;
                final gridHeight = rowCount * cellSize + (rowCount - 1) * mainSpacing;

                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    InvoiceTabTabletLayout.sz(context, 16, 12.w),
                    0,
                    InvoiceTabTabletLayout.sz(context, 16, 12.w),
                    InvoiceTabTabletLayout.sz(context, 16, 12.h),
                  ),
                  child: SizedBox(
                    height: gridHeight,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: mainSpacing,
                        crossAxisSpacing: crossSpacing,
                        childAspectRatio: 1,
                      ),
                      itemCount: gridCellCount,
                      itemBuilder: (context, index) {
                        final dayNumber = index - leadingDays + 1;

                        if (dayNumber <= 0 || dayNumber > daysInMonth) {
                          return Container();
                        }

                        final date = DateTime(selectedMonth.year, selectedMonth.month, dayNumber);
                        final isFutureDate = date.isAfter(todayDateOnly);

                        return ValueListenableBuilder<DateTime?>(
                          valueListenable: _selectedDateNotifier,
                          builder: (context, selectedDate, child) {
                            final isSelected = selectedDate != null &&
                                date.day == selectedDate.day &&
                                date.month == selectedDate.month &&
                                date.year == selectedDate.year;
                            final hasInvoices = datesWithInvoices.contains(dayNumber);
                            final isToday = date.day == DateTime.now().day &&
                                date.month == DateTime.now().month &&
                                date.year == DateTime.now().year;

                            return GestureDetector(
                              onTap: isFutureDate
                                  ? null
                                  : () {
                                      _selectedDateNotifier.value = date;

                                      final selectedDateStr = _ymd(date);

                                      loadApi(
                                          InvoiceRequestParams(
                                            perPage: 5000,
                                            startDate: selectedDateStr,
                                            endDate: selectedDateStr,
                                          ),
                                          isDateChange: true,
                                          hideLoading: true);
                                    },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? context.colorScheme.primary
                                      : isToday
                                          ? context.colorScheme.primary.withValues(alpha: 0.1)
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    InvoiceTabTabletLayout.calendarDayRadius(context),
                                  ),
                                  border: hasInvoices && !isSelected && !isFutureDate
                                      ? Border.all(
                                          color: context.colorScheme.primary.withValues(alpha: 0.3),
                                          width: 1,
                                        )
                                      : null,
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Text(
                                        context.l10n.formatCount(dayNumber),
                                        style: AppFonts.interStyle(
                                          fontSize: InvoiceTabTabletLayout.calendarDayFontSize(context),
                                          fontWeight: isSelected || isToday ? FontWeight.w700 : FontWeight.w600,
                                          color: InvoiceTabTabletLayout.calendarDayTextColor(
                                            context,
                                            isFutureDate: isFutureDate,
                                            isSelected: isSelected,
                                            isToday: isToday,
                                            hasInvoices: hasInvoices,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (hasInvoices && !isSelected && !isFutureDate)
                                      Positioned(
                                        top: InvoiceTabTabletLayout.sz(context, 4, 3.h),
                                        right: InvoiceTabTabletLayout.sz(context, 4, 3.w),
                                        child: Container(
                                          width: InvoiceTabTabletLayout.sz(context, 5, 4.w),
                                          height: InvoiceTabTabletLayout.sz(context, 5, 4.h),
                                          decoration: BoxDecoration(
                                            color: context.colorScheme.primary,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildSelectedDateInvoices() {
    return ValueListenableBuilder<InvoiceSalesResponseModel?>(
      valueListenable: _responseNotifier,
      builder: (context, currentResponse, child) {
        final invoicesForDate = _getInvoicesForSelectedDate();
        final scrollable = InvoiceTabTabletLayout.isTabletLandscape(context);

        return ValueListenableBuilder<DateTime?>(
          valueListenable: _selectedDateNotifier,
          builder: (context, selectedDate, child) {
            return Container(
              margin: EdgeInsets.only(
                top: InvoiceTabTabletLayout.sz(context, 0, 12.h),
              ),
              child: Column(
                mainAxisSize: scrollable ? MainAxisSize.max : MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (selectedDate != null && invoicesForDate.isNotEmpty) ...[
                    _buildDateHeader(invoicesForDate),
                    SizedBox(height: InvoiceTabTabletLayout.sz(context, 12, 12.h)),
                  ],
                  if (invoicesForDate.isEmpty)
                    EmptyStateCard(
                      title: context.l10n.invoiceSalesNoFound,
                      subtitle: selectedDate != null
                          ? _localizedL10n(
                              context,
                              context.l10n.invoiceCommonEmptyForDate(
                                context.l10n.invoiceDayMonthYearLabel(selectedDate),
                              ),
                            )
                          : context.l10n.invoiceSalesSelectDate,
                      iconPath: AppEmptyStateAssets.sales,
                    )
                  else if (scrollable)
                    Expanded(
                      child: _buildInvoiceListView(
                        invoicesForDate,
                        scrollable: true,
                      ),
                    )
                  else
                    _buildInvoiceListView(
                      invoicesForDate,
                      scrollable: false,
                    ),
                  if (!widget.deferInitialFetch && !scrollable)
                    SizedBox(height: 20.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInvoiceListView(
    List<InvoiceItem> invoicesForDate, {
    required bool scrollable,
  }) {
    return ListView.separated(
      padding: EdgeInsets.only(
        bottom: InvoiceTabTabletLayout.sz(context, 8, 0),
      ),
      shrinkWrap: !scrollable,
      physics: scrollable
          ? const ClampingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemCount: invoicesForDate.length,
      separatorBuilder: (_, __) => SizedBox(
        height: InvoiceTabTabletLayout.invoiceListSeparatorHeight(context),
      ),
      itemBuilder: (context, index) {
        final invoice = invoicesForDate[index];
        final isSelected = _selectedInvoices.contains(invoice.invoiceName);

        return FreemiumRecordGate(
          recordKey: invoice.invoiceName ?? '',
          child: GestureDetector(
          onTap: _isSelectionMode
              ? () => _toggleInvoiceSelection(invoice.invoiceName ?? '')
              : null,
          child: Stack(
            children: [
              Opacity(
                opacity: _isSelectionMode && !isSelected ? 0.5 : 1.0,
                child: InvoiceCard(
                  invoice: invoice,
                  dateFormat: _dateFormat,
                  invoiceType: InvoiceType.sales,
                  currencyFormat: _currencyFormat,
                  highlightQuery: _searchQueryNotifier.value,
                  isSelectionMode: _isSelectionMode,
                  isSelected: isSelected,
                  onCompleted: () {
                    final sel = _selectedDateNotifier.value;
                    if (sel == null) return;
                    final selectedDateStr = _ymd(sel);
                    loadApi(
                      InvoiceRequestParams(
                        perPage: 5000,
                        startDate: selectedDateStr,
                        endDate: selectedDateStr,
                      ),
                      hideLoading: true,
                    );
                  },
                  onDelete: () {
                    context.read<DeleteInvoiceCubit>().deleteInvoice(
                          params: DeleteInvoiceRequestParams(
                            invoiceNames: [invoice.invoiceName.toString()],
                            confirmDelete: true,
                            forceDelete: false,
                            deletedBy: context.employeeData?.email,
                          ),
                        );
                  },
                  onSubmit: () {
                    context.read<UpdateInvoiceCubit>().updateInvoice(
                          params: InvoiceItem(
                            invoiceType: widget.invoiceType,
                            invoiceName: invoice.invoiceName.toString(),
                            action: 'submit',
                            modifiedBy: 'hotelroyalrestro@gmail.com',
                          ),
                        );
                  },
                ),
              ),
              if (_isSelectionMode)
                Positioned(
                  top: InvoiceTabTabletLayout.sz(context, 12, 12.h),
                  right: InvoiceTabTabletLayout.sz(context, 12, 12.w),
                  child: Container(
                    width: InvoiceTabTabletLayout.sz(context, 28, 28.w),
                    height: InvoiceTabTabletLayout.sz(context, 28, 28.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? context.colorScheme.primary
                          : context.colorScheme.surface,
                      border: Border.all(
                        color: isSelected
                            ? context.colorScheme.primary
                            : context.colorScheme.outlineVariant,
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.colorScheme.shadow.withValues(alpha: 0.12),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check_rounded,
                            size: InvoiceTabTabletLayout.sz(context, 18, 18.r),
                            color: context.colorScheme.onPrimary,
                          )
                        : null,
                  ),
                ),
            ],
          ),
        ),
        );
      },
    );
  }

  Widget _buildDateHeader(List<InvoiceItem> invoices) {
    final totalAmount = invoices.fold(0.0, (sum, invoice) => sum + (invoice.grandTotal ?? 0));

    return ValueListenableBuilder<DateTime?>(
      valueListenable: _selectedDateNotifier,
      builder: (context, selectedDate, child) {
        if (selectedDate == null) return const SizedBox.shrink();

        return InvoiceTabTabletLayout.daySummaryCard(
          context: context,
          icon: Icons.event_note_rounded,
          dateLabel: context.l10n.invoiceDayMonthYearLabel(selectedDate),
          countLabel: _localizedL10n(
            context,
            context.l10n.invoiceDateInvoiceCount(invoices.length),
          ),
          totalLabel: _formatMoney(context, totalAmount),
          decoration: _surfaceCardDecoration(radius: 12),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return ValueListenableBuilder<DateTime?>(
      valueListenable: _selectedDateNotifier,
      builder: (context, selectedDate, child) {
        return Container(
          width: context.width,
          padding: EdgeInsets.all(20.r),
          decoration: _surfaceCardDecoration(),
          child: Column(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 40.r,
                color: InvoiceListChrome.mutedText(context),
              ),
              SizedBox(height: 12.h),
              Text(
                context.l10n.invoiceSalesNoInvoicesFound,
                style: AppFonts.interStyle(
                  fontSize: 14.sp,
                  color: InvoiceListChrome.mutedText(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                selectedDate != null
                    ? _localizedL10n(
                        context,
                        context.l10n.invoiceCommonEmptyForDate(
                          context.l10n.invoiceDayMonthYearLabel(selectedDate),
                        ),
                      )
                    : context.l10n.invoiceSalesSelectDateLegacy,
                style: AppFonts.interStyle(
                  fontSize: 12.sp,
                  color: InvoiceListChrome.mutedText(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMonthYearPicker() {
    InvoiceMonthYearPickerDialog.show(
      context,
      initialMonth: _selectedMonthNotifier.value,
      onToday: () {
        final now = DateTime.now();
        _selectedMonthNotifier.value = now;
        _selectedDateNotifier.value = now;
        _selectedMonthIndex = now.month - 1;
        context.read<InvoiceDatesCubit>().getInvoiceDates(
              params: _invoiceDatesParams(now),
            );
        final selectedDateStr = _ymd(now);
        loadApi(
          InvoiceRequestParams(
            perPage: 5000,
            startDate: selectedDateStr,
            endDate: selectedDateStr,
          ),
          hideLoading: true,
        );
      },
      onSelect: (tempSelectedMonth) {
        _selectedMonthNotifier.value = tempSelectedMonth;
        _selectedMonthIndex = tempSelectedMonth.month - 1;
        _selectedDateNotifier.value = DateTime(
          tempSelectedMonth.year,
          tempSelectedMonth.month,
          1,
        );
        context.read<InvoiceDatesCubit>().getInvoiceDates(
              params: _invoiceDatesParams(tempSelectedMonth),
            );
        final firstDay = DateTime(
          tempSelectedMonth.year,
          tempSelectedMonth.month,
          1,
        );
        final selectedDateStr = _ymd(firstDay);
        loadApi(
          InvoiceRequestParams(
            perPage: 5000,
            startDate: selectedDateStr,
            endDate: selectedDateStr,
          ),
          hideLoading: true,
        );
      },
    );
  }

  String getTitle(String key) {
    switch (key) {
      case "dateRange":
        return "Date Range";
      case "paymentStatus":
        return "Payment Status";
      case "amount":
        return "Amount";
    }
    return "";
  }
}
