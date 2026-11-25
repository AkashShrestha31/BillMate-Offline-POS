import 'dart:io';
import 'dart:ui' show Rect;

import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/constants/app_empty_state_assets.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/helpers/gallery_save_helper.dart';
import 'package:hotel/src/core/helpers/invoice_receipt_pdf_service.dart';
import 'package:hotel/src/core/helpers/utility.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/action_bottom_sheet.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/date_range_picker_bottom_sheet.dart';
import 'package:hotel/src/core/widget/empty_state_card.dart';
import 'package:hotel/src/core/widget/scaffold_wrapper.dart';
import 'package:hotel/src/features/invoice/data/models/request/delete_invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/invoice/presentation/bloc/login/invoice_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/cubit/accounting_settings_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/delete_invoice/delete_invoice_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_card.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_tab_tablet_layout.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';

ValueNotifier<InvoiceRequestParams> invoiceRequestParams = ValueNotifier<InvoiceRequestParams>(InvoiceRequestParams());

@RoutePage()
class PartyInvoicePage extends StatefulWidget implements AutoRouteWrapper {
  const PartyInvoicePage({
    super.key,
    this.canPop = true,
    this.partyName,
    this.date,
    this.showScaffold = true,
    this.invoiceType,
    this.itemName,
    /// When set (tabbed party invoices), filtering uses this string and inline search/export are hidden.
    this.tabbedParentSearchQuery,
  });
  final bool canPop;
  final String? partyName;
  final String? itemName;

  final DateTime? date;
  final bool showScaffold;
  final InvoiceType? invoiceType;

  /// Shared search text from [PartyInvoiceTabbedPage]; each tab filters its own loaded invoices.
  final ValueNotifier<String>? tabbedParentSearchQuery;

  @override
  State<PartyInvoicePage> createState() => PartyInvoicePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountingSettingsCubit>(
          create: (_) => getIt<AccountingSettingsCubit>(),
        ),
        BlocProvider<InvoiceCubit>(create: (context) => getIt<InvoiceCubit>()),
        BlocProvider<DeleteInvoiceCubit>(create: (context) => getIt<DeleteInvoiceCubit>()),
      ],
      child: this,
    );
  }
}

class PartyInvoicePageState extends State<PartyInvoicePage> with SingleTickerProviderStateMixin {
  static const int _pageSize = 10;

  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');
  NumberFormat get _currencyFormat => AppMoneyFormat.currency(currencySymbol);
  final _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  InvoiceSalesResponseModel? response;
  late AnimationController _footerController;

  /// First-page query template ([page] updated for load-more).
  InvoiceRequestParams? _pagingBase;

  bool _loadingMore = false;

  bool get _useParentSearch => widget.tabbedParentSearchQuery != null;

  bool get _isTablet => DeviceLayout.isTablet(context);

  Color _shellColor(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerLowest;

  BoxDecoration _pageBackgroundDecoration(ColorScheme scheme) => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            scheme.surfaceContainerLow,
            scheme.surfaceContainerLowest,
          ],
        ),
      );

  static const double _tabletMaxWidth = 900;

  double _tabletContentWidth(BuildContext context) {
    final available = MediaQuery.sizeOf(context).width;
    return available < _tabletMaxWidth ? available : _tabletMaxWidth;
  }

  Widget _buildScrollContent(ThemeData theme) {
    final children = <Widget>[
      if (_activeSearchQuery.trim().isEmpty) _buildSummaryFooter(theme),
      _buildInvoiceList(context),
    ];

    if (!_isTablet || _useParentSearch) {
      return Column(children: children);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: _tabletContentWidth(context),
          child: Column(children: children),
        ),
      ],
    );
  }

  String get _activeSearchQuery =>
      _useParentSearch ? widget.tabbedParentSearchQuery!.value : _searchQuery;

  /// Called from [PartyInvoiceTabbedPage] AppBar export action (active tab only).
  Future<void> openBulkExportFromToolbar() => _openBulkExportFlow();

  @override
  void initState() {
    super.initState();
    context.read<AccountingSettingsCubit>().loadIfNeeded();
    if (widget.partyName != null) {
      _pagingBase = InvoiceRequestParams(
        page: 1,
        perPage: _pageSize,
        party: widget.partyName,
        invoiceType: widget.invoiceType,
        sortOrder: 'desc',
      );
      loadApi(_pagingBase!);
    } else if (widget.itemName != null) {
      _pagingBase = InvoiceRequestParams(
        page: 1,
        perPage: _pageSize,
        itemName: widget.itemName,
        invoiceType: widget.invoiceType,
        sortOrder: 'desc',
      );
      loadApi(_pagingBase!);
    } else {
      final day =
          "${widget.date!.year.toString().padLeft(4, '0')}-${widget.date!.month.toString().padLeft(2, '0')}-${widget.date!.day.toString().padLeft(2, '0')}";

      _pagingBase = InvoiceRequestParams(
        page: 1,
        perPage: _pageSize,
        startDate: day,
        endDate: day,
        invoiceType: widget.invoiceType,
        sortOrder: 'desc',
      );
      loadApi(_pagingBase!);
    }

    // Initialize animation controller for footer
    _footerController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scrollController.addListener(_onScroll);

    if (_useParentSearch) {
      widget.tabbedParentSearchQuery!.addListener(_onExternalSearchChanged);
    } else {
      _searchController.addListener(_onSearchChanged);
    }
  }

  void _onExternalSearchChanged() {
    if (mounted) setState(() {});
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  void dispose() {
    if (_useParentSearch) {
      widget.tabbedParentSearchQuery!.removeListener(_onExternalSearchChanged);
    } else {
      _searchController.removeListener(_onSearchChanged);
    }
    _scrollController.removeListener(_onScroll);
    _searchController.dispose();
    _scrollController.dispose();
    _footerController.dispose();
    super.dispose();
  }

  /// Inferred from the last API response (pagination or size of the last merged batch).
  int _itemsInLastRequest = 0;

  bool _hasMorePages() {
    final r = response;
    if (r == null || _pagingBase == null) return false;
    final p = r.pagination;
    final total = p.total_pages;
    final cur = p.current_page;
    if (total != null && total > 0 && cur != null) {
      return cur < total;
    }
    if ((r.data?.length ?? 0) == 0) return false;
    return _itemsInLastRequest >= _pageSize;
  }

  void _onScroll() {
    if (_loadingMore || !mounted || _pagingBase == null) return;
    if (!_hasMorePages()) return;
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (!pos.hasViewportDimension) return;
    if (pos.pixels < pos.maxScrollExtent - 420) return;
    _fetchNextPage();
  }

  Future<void> _fetchNextPage() async {
    if (_loadingMore || !mounted || _pagingBase == null || response == null) return;
    if (!_hasMorePages()) return;
    final cur = response!.pagination.current_page ?? 1;
    final params = _pagingBase!.copyWith(page: cur + 1);
    setState(() => _loadingMore = true);
    await context.read<InvoiceCubit>().invoice(invoiceRequestParam: params, append: true);
    if (mounted) {
      setState(() => _loadingMore = false);
    }
  }

  Future<void> loadApi(InvoiceRequestParams invoiceRequestParams, {bool append = false}) async {
    await context.read<InvoiceCubit>().invoice(
          invoiceRequestParam: invoiceRequestParams,
          append: append,
        );
  }

  // Filter invoices by item name
  List<InvoiceItem> _getFilteredInvoices() {
    if (response == null || response!.data == null) {
      print('DEBUG: Response or data is null');
      return [];
    }

    var allInvoices = response!.data!;
    print('DEBUG: Total invoices in response: ${allInvoices.length}');

    // If no search query, return all invoices
    if (_activeSearchQuery.trim().isEmpty) {
      print('DEBUG: No search query, returning all ${allInvoices.length} invoices');
      return allInvoices;
    }

    final searchTerm = _activeSearchQuery.toLowerCase().trim();
    print('DEBUG: Searching for: "$searchTerm"');

    // Filter invoices that have matching items
    final filtered = allInvoices.where((invoice) {
      // Check if invoice has items
      if (invoice.items == null || invoice.items!.isEmpty) {
        return false;
      }

      // Check if any item matches the search query
      bool hasMatch = invoice.items!.any((item) {
        final itemName = (item.item ?? '').toLowerCase();
        return itemName.contains(searchTerm);
      });

      if (hasMatch) {
        print('DEBUG: Match found in invoice: ${invoice.invoiceName}');
      }

      return hasMatch;
    }).toList();

    print('DEBUG: Filtered to ${filtered.length} invoices');
    return filtered;
  }

  InvoiceType get _effectiveInvoiceType => widget.invoiceType ?? InvoiceType.sales;

  DateTime? _invoiceDateOnly(InvoiceItem invoice) {
    final raw = invoice.date;
    if (raw == null || raw.isEmpty) return null;
    try {
      final d = DateTime.parse(raw);
      return DateTime(d.year, d.month, d.day);
    } catch (_) {
      return null;
    }
  }

  bool _dateOnlyInInclusiveRange(DateTime day, DateTimeRange range) {
    final start = DateTime(range.start.year, range.start.month, range.start.day);
    final end = DateTime(range.end.year, range.end.month, range.end.day);
    return !day.isBefore(start) && !day.isAfter(end);
  }

  List<InvoiceItem> _invoicesForExportRange(DateTimeRange range) {
    final list = _getFilteredInvoices().where((inv) {
      final d = _invoiceDateOnly(inv);
      if (d == null) return false;
      return _dateOnlyInInclusiveRange(d, range);
    }).toList()
      ..sort((a, b) {
        final da = _invoiceDateOnly(a);
        final db = _invoiceDateOnly(b);
        if (da == null && db == null) return 0;
        if (da == null) return 1;
        if (db == null) return -1;
        return da.compareTo(db);
      });
    return list;
  }

  Rect _sharePositionOrigin(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    if (box != null && box.attached && box.hasSize) {
      final rect = box.localToGlobal(Offset.zero) & box.size;
      if (rect.width >= 1 && rect.height >= 1) {
        return rect;
      }
    }
    final size = MediaQuery.sizeOf(context);
    return Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: 2,
      height: 2,
    );
  }

  Future<void> _openBulkExportFlow() async {
    if (!mounted) return;
    DateTimeRange? selected;
    final range = await showModalBottomSheet<DateTimeRange?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (sheetContext) {
        final scheme = Theme.of(sheetContext).colorScheme;
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: StatefulBuilder(
                builder: (context, setModalState) {
                  final hasRange = selected != null;
                  final rangeLabel = hasRange
                      ? '${DateFormat.yMMMd().format(selected!.start)} – ${DateFormat.yMMMd().format(selected!.end)}'
                      : 'Select dates';
                  return Container(
                    decoration: AppBottomSheetTheme.sheetDecoration(sheetContext),
                    child: AppBottomSheetShell(
                      title: 'Export',
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            hasRange
                                ? 'Invoices dated in this range will be included. Search still applies.'
                                : 'Choose dates. Invoice dates must fall in the range. Search still applies.',
                            style: Theme.of(sheetContext)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                  height: 1.35,
                                ),
                          ),
                          SizedBox(height: 16.h),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.r),
                              onTap: () async {
                                final now = DateTime.now();
                                final picked =
                                    await showDateRangePickerBottomSheet(
                                  context: sheetContext,
                                  minDate: DateTime(2020),
                                  maxDate: now.add(
                                    const Duration(days: 365 * 2),
                                  ),
                                  initialStart: selected?.start ??
                                      now.subtract(const Duration(days: 30)),
                                  initialEnd: selected?.end ?? now,
                                  title: 'Select dates',
                                );
                                if (picked != null) {
                                  selected = picked;
                                  setModalState(() {});
                                }
                              },
                              child: Ink(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 14.h,
                                ),
                                decoration: BoxDecoration(
                                  color: scheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: scheme.outlineVariant
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.date_range_outlined,
                                      size: 20.sp,
                                      color: scheme.onSurfaceVariant,
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        rangeLabel,
                                        style: Theme.of(sheetContext)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: hasRange
                                                  ? scheme.onSurface
                                                  : scheme.onSurfaceVariant,
                                              fontWeight: hasRange
                                                  ? FontWeight.w600
                                                  : FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CustomButtonWidget.primary(
                            title: 'Continue',
                            height: 48,
                            borderRadius: 24,
                            onPressed: selected == null
                                ? null
                                : () => Navigator.pop(sheetContext, selected),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
    if (!mounted || range == null) return;
    final list = _invoicesForExportRange(range);
    if (list.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No invoices in this date range (with current search filter).'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    ActionBottomSheet.show(
      context,
      title: 'Export receipts (${list.length})',
      items: [
        ActionSheetItem(
          icon: Icons.picture_as_pdf_outlined,
          title: 'Export as PDF',
          color: const Color(0xFFB91C1C),
          onTap: () => _exportBulkPdf(range, list),
        ),
        ActionSheetItem(
          icon: Icons.image_outlined,
          title: 'Export as image',
          color: const Color(0xFF1D4ED8),
          onTap: () => _exportBulkImages(list),
        ),
      ],
    );
  }

  Future<void> _exportBulkPdf(DateTimeRange range, List<InvoiceItem> list) async {
    if (!await gateInvoiceExport(context)) return;
    try {
      AppLoadingOverlay.of(context).show();
      final bytes = await InvoiceReceiptPdfService.buildBulkPdfBytes(
        invoices: list,
        invoiceType: _effectiveInvoiceType,
        accentColor: Theme.of(context).colorScheme.primary,
      );
      if (!mounted) return;
      AppLoadingOverlay.of(context).hide();
      final name =
          'invoices_${DateFormat('yyyyMMdd').format(range.start)}_${DateFormat('yyyyMMdd').format(range.end)}.pdf';
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => bytes,
        name: name,
      );
    } catch (e) {
      if (mounted) {
        AppLoadingOverlay.of(context).hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not export PDF: $e')),
        );
      }
    }
  }

  Future<void> _showBulkReceiptImagePreview(File file, String subject) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (ctx) => Scaffold(
          appBar: AppBar(
            title: Text('Preview'),
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(ctx),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.download_rounded),
                tooltip: 'Save to gallery',
                onPressed: () => saveImageFileToGallery(ctx, file.path),
              ),
              IconButton(
                icon: Icon(Icons.share),
                tooltip: 'Share',
                onPressed: () async {
                  await Share.shareXFiles(
                    [XFile(file.path)],
                    subject: subject,
                    sharePositionOrigin: _sharePositionOrigin(ctx),
                  );
                },
              ),
            ],
          ),
          body: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4,
            child: Center(
              child: Image.file(file),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _exportBulkImages(List<InvoiceItem> list) async {
    if (!await gateInvoiceExport(context)) return;
    try {
      AppLoadingOverlay.of(context).show();
      final type = _effectiveInvoiceType;
      final accent = Theme.of(context).colorScheme.primary;
      if (list.length == 1) {
        final file = await InvoiceReceiptPdfService.exportToPngFile(
          invoice: list.first,
          invoiceType: type,
          accentColor: accent,
        );
        if (!mounted) return;
        AppLoadingOverlay.of(context).hide();
        await _showBulkReceiptImagePreview(
          file,
          'Receipt ${list.first.invoiceName ?? ''}',
        );
        return;
      }
      final files = <XFile>[];
      for (final invoice in list) {
        final file = await InvoiceReceiptPdfService.exportToPngFile(
          invoice: invoice,
          invoiceType: type,
          accentColor: accent,
        );
        files.add(XFile(file.path));
      }
      if (!mounted) return;
      AppLoadingOverlay.of(context).hide();
      await Share.shareXFiles(
        files,
        subject: 'Receipts (${files.length})',
        sharePositionOrigin: _sharePositionOrigin(context),
      );
    } catch (e) {
      if (mounted) {
        AppLoadingOverlay.of(context).hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not export image: $e')),
        );
      }
    }
  }

  List<Widget> _bulkExportActions(ThemeData theme) => [
        IconButton(
          icon: Icon(Icons.ios_share_outlined, color: theme.colorScheme.primary),
          tooltip: 'Export by date range',
          onPressed: _openBulkExportFlow,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteInvoiceCubit, DeleteInvoiceState>(
          listener: (context, state) {
            state.maybeWhen(
              loading: () {
                AppLoadingOverlay.of(context).show();
              },
              success: (_) {
                AppLoadingOverlay.of(context).hide();
                context.router.maybePop();
              },
              error: (message) {
                AppLoadingOverlay.of(context).hide();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              noInternet: () {
                AppLoadingOverlay.of(context).hide();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No internet connection'),
                    backgroundColor: Colors.orange,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              orElse: () {},
            );
          },
        ),
      ],
      child: widget.showScaffold
          ? Scaffold(
              backgroundColor: _shellColor(context),
              appBar: AppBar(
                leading: widget.canPop ? const AppBarIosBackButton() : null,
                automaticallyImplyLeading: false,
                backgroundColor: theme.colorScheme.surfaceContainerHigh,
                surfaceTintColor: Colors.transparent,
                foregroundColor: theme.colorScheme.onSurface,
                title: Text(
                  widget.partyName != null || widget.itemName != null
                      ? (widget.partyName ?? widget.itemName.toString())
                      : DateFormat('yMMMd').format(widget.date!),
                ),
                elevation: 0,
                scrolledUnderElevation: 0,
                actions: _useParentSearch ? const [] : _bulkExportActions(theme),
              ),
              body: Container(
                decoration: _pageBackgroundDecoration(theme.colorScheme),
                child: BlocBuilder<InvoiceCubit, InvoiceState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => ScaffoldWrapper(body: Container()),
                      loading: () => SizedBox(
                          height: context.height,
                          width: context.width,
                          child: Center(child: CircularProgressIndicator())),
                      success: (responseData) {
                        final oldLen = response?.data?.length ?? 0;
                        final newModel = responseData.data;
                        response = newModel;
                        final newLen = newModel.data?.length ?? 0;
                        _itemsInLastRequest = (newLen - oldLen).clamp(0, newLen);
                        return Column(
                          children: [
                            if (!_useParentSearch) _buildSearchBar(theme),
                            Expanded(
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: _buildScrollContent(theme),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            )
          : Container(
              decoration: _pageBackgroundDecoration(theme.colorScheme),
              child: BlocBuilder<InvoiceCubit, InvoiceState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => ScaffoldWrapper(body: Container()),
                    loading: () => Center(child: CircularProgressIndicator()),
                    success: (responseData) {
                      final oldLen = response?.data?.length ?? 0;
                      final newModel = responseData.data;
                      response = newModel;
                      final newLen = newModel.data?.length ?? 0;
                      _itemsInLastRequest = (newLen - oldLen).clamp(0, newLen);
                      return Column(
                        children: [
                          if (!_useParentSearch) _buildSearchBar(theme),
                          Expanded(
                            child: SingleChildScrollView(
                              child: _buildScrollContent(theme),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    final tablet = _isTablet;
    final scheme = theme.colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: tablet ? 24 : 16.w,
        vertical: tablet ? 12 : 12.h,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        border: Border(
          bottom: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.45),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: _searchController,
              hint: 'Search by item name...',
              prefixIcon: AppSearchIcon.inputDecoration(
                color: scheme.onSurfaceVariant,
              ),
              suffixIcon: _activeSearchQuery.trim().isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.close, color: scheme.onSurfaceVariant),
                      onPressed: () {
                        _searchController.clear();
                        FocusScope.of(context).unfocus();
                      },
                    )
                  : null,
              keyboardType: TextInputType.text,
            ),
          ),
          if (!widget.showScaffold) ..._bulkExportActions(theme),
        ],
      ),
    );
  }

  Widget _buildInvoiceList(BuildContext context) {
    final filteredInvoices = _getFilteredInvoices();

    if (filteredInvoices.isEmpty) {
      return _buildEmptyState();
    }
    return Column(
      key: ValueKey('invoice_list_${filteredInvoices.length}'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            vertical: InvoiceTabTabletLayout.sz(context, 16, 16.h),
          ),
          itemCount: filteredInvoices.length,
          separatorBuilder: (_, __) => SizedBox(
            height: InvoiceTabTabletLayout.sz(context, 12, 12.h),
          ),
          itemBuilder: (context, index) {
            final invoice = filteredInvoices[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InvoiceCard(
                  invoice: invoice,
                  invoiceType: _effectiveInvoiceType,
                  dateFormat: _dateFormat,
                  currencyFormat: _currencyFormat,
                  highlightQuery: _activeSearchQuery,
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
                ).px(InvoiceTabTabletLayout.sz(context, 24, 16.w)),
                if (_activeSearchQuery.trim().isNotEmpty && invoice.items != null && invoice.items!.isNotEmpty)
                  _buildMatchingItems(invoice),
              ],
            );
          },
        ),
        if (_loadingMore)
          Padding(
            padding: EdgeInsets.only(bottom: 24.h),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }

  Widget _buildMatchingItems(InvoiceItem invoice) {
    final scheme = Theme.of(context).colorScheme;
    final searchTerm = _activeSearchQuery.toLowerCase().trim();
    final matchingItems = invoice.items!.where((item) {
      final itemName = (item.item ?? '').toLowerCase();
      return itemName.contains(searchTerm);
    }).toList();

    if (matchingItems.isEmpty) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.inventory_2_outlined, size: 16.r, color: context.theme.colorScheme.primary),
              4.horizontalSpace,
              Text(
                'Matching Items:',
                style: AppFonts.interStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: context.theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          8.verticalSpace,
          ...matchingItems.map((item) {
            // Calculate per piece price: total amount / quantity
            final quantity = item.quantity ?? 0;
            final totalAmount = item.amount ?? 0;
            final pricePerPiece = quantity > 0 ? totalAmount / quantity : 0;

            return Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item name
                  Row(
                    children: [
                      Container(
                        width: 4.w,
                        height: 4.w,
                        decoration: BoxDecoration(
                          color: context.theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: _highlightSearchTerm(
                              item.item ?? '',
                              searchTerm,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  6.verticalSpace,
                  // Details row
                  Wrap(
                    spacing: 12.w,
                    runSpacing: 4.h,
                    children: [
                      // Quantity
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shopping_cart_outlined, size: 12.r, color: scheme.onSurfaceVariant),
                          4.horizontalSpace,
                          Text(
                            'Qty: ${quantity.toStringAsFixed(0)}',
                            style: AppFonts.interStyle(
                              fontSize: 11.sp,
                              color: scheme.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      // Price per piece (calculated)
                      if (pricePerPiece > 0)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.currency_rupee, size: 12.r, color: const Color(0xFF15803D)),
                            2.horizontalSpace,
                            Text(
                              '${pricePerPiece.toStringAsFixed(2)}/pc',
                              style: AppFonts.interStyle(
                                fontSize: 11.sp,
                                color: const Color(0xFF15803D),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      // Total amount
                      if (totalAmount > 0)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Total: ',
                              style: AppFonts.interStyle(
                                fontSize: 10.sp,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              '$currencySymbol ${totalAmount.toStringAsFixed(2)}',
                              style: AppFonts.interStyle(
                                fontSize: 11.sp,
                                color: context.theme.colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  List<TextSpan> _highlightSearchTerm(String text, String query) {
    final scheme = Theme.of(context).colorScheme;
    final baseStyle = AppFonts.interStyle(
      fontSize: 12.sp,
      color: scheme.onSurfaceVariant,
    );
    if (query.isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];
    int start = 0;

    while (true) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index == -1) {
        spans.add(TextSpan(text: text.substring(start), style: baseStyle));
        break;
      }

      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index), style: baseStyle));
      }

      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: AppFonts.interStyle(
            fontSize: 12.sp,
            color: scheme.primary,
            fontWeight: FontWeight.w700,
            backgroundColor: scheme.secondaryContainer,
          ),
        ),
      );

      start = index + query.length;
    }

    return spans;
  }

  Widget _buildEmptyState() {
    final tablet = _isTablet;
    final query = _activeSearchQuery.trim();
    final subtitle = query.isEmpty
        ? 'Try a different search term'
        : 'No items matching "$query"\nTry a different item name';

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: tablet ? 24 : 16.w,
        vertical: tablet ? 32 : 28.h,
      ),
      child: EmptyStateCard(
        title: 'No invoices found',
        subtitle: subtitle,
        iconPath: AppEmptyStateAssets.search,
      ),
    );
  }

  Widget _buildSummaryFooter(ThemeData theme) {
    final filteredInvoices = _getFilteredInvoices();

    // Party-wide totals from API when available (correct under pagination).
    final apiGrand = response?.total_grand_total;
    double grandTotal = 0;
    double unpaidAmount = response?.total_outstanding_amount ?? 0;
    double discountTotal = 0;
    double cashTotal = 0;
    double transferTotal = 0;
    double notSubmitted = response?.total_not_submitted ?? 0;
    for (var invoice in filteredInvoices) {
      grandTotal += invoice.grandTotal ?? 0;

      discountTotal += invoice.totalDiscount ?? 0;

      if (invoice.payment != null) {
        for (var payment in invoice.payment!) {
          final method = (payment.paymentMethod ?? '').toLowerCase();
          if (method.contains('cash')) {
            cashTotal += payment.amount ?? 0;
          } else if (method.contains('transfer') || method.contains('bank')) {
            transferTotal += payment.amount ?? 0;
          }
        }
      }
    }

    if (apiGrand != null) {
      grandTotal = apiGrand;
    }

    final paidAmount = grandTotal - unpaidAmount - discountTotal;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: InvoiceTabTabletLayout.sz(context, 12, 10.h),
        horizontal: InvoiceTabTabletLayout.sz(context, 24, 20.w),
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: const [],
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(InvoiceTabTabletLayout.sz(context, 20, 24.r)),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  context,
                  title: 'Grand Total',
                  amount: grandTotal,
                  icon: Icons.summarize_outlined,
                  color: context.theme.colorScheme.primary,
                ),
              ),
              SizedBox(
                width: InvoiceTabTabletLayout.sz(context, 12, 12),
              ),
              Expanded(
                child: _buildSummaryCard(
                  context,
                  title: 'Paid',
                  amount: paidAmount,
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: InvoiceTabTabletLayout.sz(context, 12, 12)),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  context,
                  title: 'Unpaid',
                  amount: unpaidAmount,
                  icon: Icons.pending_outlined,
                  color: context.theme.colorScheme.error,
                  isWarning: unpaidAmount > 0,
                ),
              ),
            ],
          ),
          SizedBox(height: InvoiceTabTabletLayout.sz(context, 12, 12)),
          Row(
            children: [
              if (notSubmitted != 0)
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: 'Not Submitted',
                    amount: notSubmitted,
                    icon: Icons.pending_outlined,
                    color: Colors.blueAccent.shade200,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    String? subTitle,
    required num amount,
    required IconData icon,
    required Color color,
    bool isWarning = false,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(InvoiceTabTabletLayout.sz(context, 14, 16.r)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(
          InvoiceTabTabletLayout.sz(context, 12, 12.r),
        ),
        border: Border.all(
          color: isWarning
              ? scheme.tertiary.withValues(alpha: 0.35)
              : color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(InvoiceTabTabletLayout.sz(context, 6, 6.r)),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: InvoiceTabTabletLayout.sz(context, 18, 18.r),
                  color: color,
                ),
              ),
              SizedBox(width: InvoiceTabTabletLayout.sz(context, 8, 8)),
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: InvoiceTabTabletLayout.sp(context, 14, 14),
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: InvoiceTabTabletLayout.sz(context, 8, 8)),
          Text(
            '$currencySymbol ${Utility.formatIndianNumber(amount.ceil())}',
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: InvoiceTabTabletLayout.sp(context, 20, 22),
              fontWeight: FontWeight.w800,
              color: isWarning ? scheme.tertiary : scheme.onSurface,
            ),
          ),
          if (subTitle != null && (isWarning ? amount > 0 : true)) ...[
            SizedBox(height: InvoiceTabTabletLayout.sz(context, 4, 4)),
            Text(
              subTitle,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: InvoiceTabTabletLayout.sp(context, 12, 12),
                color: isWarning ? scheme.tertiary : scheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
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
