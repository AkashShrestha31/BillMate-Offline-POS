import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/widget/freemium_access_scope.dart';
import 'package:hotel/src/core/widget/freemium_access_scope.dart';
import 'package:hotel/src/core/widget/freemium_record_gate.dart';
import 'package:hotel/src/core/helpers/utility.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/core/helpers/error_message_helper.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/widget/action_bottom_sheet.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/per_page_expandable_fab.dart';
import 'package:hotel/src/core/widget/tab_error_view.dart';
import 'package:hotel/src/features/dashboard/presentation/main_shell_tab_index.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/party/data/models/request/delete_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/party/domain/party_list_pagination.dart';
import 'package:hotel/src/features/party/data/models/response/party_list_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_pagination_model.dart';
import 'package:hotel/src/features/party/presentation/bloc/party_cubit.dart';
import 'package:hotel/src/features/party/domain/usecases/party_use_cases.dart';
import 'package:hotel/src/features/party/presentation/widgets/pay_advance_bottom_sheet.dart';
import 'package:hotel/src/features/role/data/models/role_item.dart';
import 'package:hotel/src/features/role/domain/party_picker_role_helper.dart';
import 'package:hotel/src/features/role/domain/repositories/roles_repository.dart';
import 'package:hotel/src/features/settlement/presentation/pages/partial_payment_settlement_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hotel/src/core/constants/app_empty_state_assets.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/core/widget/list_empty_state.dart';
import 'package:hotel/src/core/widget/notched_bottom_nav_bar.dart';
import 'package:hotel/src/features/action/presentation/widgets/party_picker_freemium.dart';
import 'package:hotel/src/features/action/presentation/widgets/party_picker_widgets.dart';

/// Hides main shell bottom nav while Parties search is expanded.
ValueNotifier<bool> partySearchMode = ValueNotifier<bool>(false);

@RoutePage()
class PartyDetailsPage extends StatefulWidget {
  const PartyDetailsPage({
    super.key,
    this.deferInitialFetch = false,
  });

  /// When true (main tab shell), parent runs API loads sequentially — skip initState fetch.
  final bool deferInitialFetch;

  @override
  State<PartyDetailsPage> createState() => _PartyDetailsPageState();
}

class _PartyDetailsPageState extends State<PartyDetailsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final _fabScrollHide = ScrollHideFabController();
  bool _searchExpanded = false;

  final ValueNotifier<List<PartyModel>> _allPartiesNotifier = ValueNotifier([]);
  final ValueNotifier<String> _currentFilterNotifier = ValueNotifier('customer');
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier(false);
  final ValueNotifier<PartyPaginationModel?> _paginationNotifier = ValueNotifier(null);
  final ValueNotifier<bool> _hasMoreNotifier = ValueNotifier(false);

  static const String _sortLatest = 'latest';
  static const String _sortAmountHighLow = 'amount_high_low';
  static const String _sortAmountLowHigh = 'amount_low_high';
  static const String _sortNameAZ = 'name_az';
  static const String _sortNameZA = 'name_za';
  final ValueNotifier<String> _selectedSortNotifier = ValueNotifier(_sortLatest);

  int _activeTabIndex = 0;
  final Map<String, int> _roleCounts = {};
  List<String> _tabRoles = const [];
  bool _rolesReady = false;
  bool _hasInitialData = false;
  int _currentPage = 1;
  List<PartyModel> _allLoadedParties = [];
  Timer? _searchDebounce;
  final Set<String> _failedImageUrls = <String>{};

  bool get _isTablet => DeviceLayout.isTablet(context);

  double _sz(double tablet, double phone) => _isTablet ? tablet : phone;

  double _sp(double tablet, double phone) => _isTablet ? tablet : phone.sp;

  @override
  void initState() {
    super.initState();
    _currentFilterNotifier.value = 'customer';
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchTextChanged);
    _loadRoleTabs();

    if (widget.deferInitialFetch) {
      currentIndex.addListener(_onMainShellTabSelected);
      shellTabReselectTick.addListener(_onMainShellTabReselected);
    }
  }

  Future<void> _loadRoleTabs() async {
    var dbRoles = <RoleItem>[];
    if (getIt.isRegistered<RolesRepository>()) {
      final result = await getIt<RolesRepository>().getRoles();
      result.fold((_) {}, (list) => dbRoles = list);
    }
    final tabs = PartyPickerRoleHelper.tabLabelsForPartyList(dbRoles: dbRoles);
    final initialIndex = PartyPickerRoleHelper.initialTabIndex(
      tabs: tabs,
      role: 'customer',
    );
    if (!mounted) return;

    final idx = initialIndex.clamp(0, tabs.length - 1);
    setState(() {
      _tabRoles = tabs;
      _activeTabIndex = idx;
      _rolesReady = true;
    });

    _currentFilterNotifier.value = tabs[idx].toLowerCase();
    unawaited(_loadAllRoleCounts());
    if (!widget.deferInitialFetch) {
      _fetchPartiesForRole(_currentFilterNotifier.value);
    } else {
      _hydrateFromCubitIfLoaded();
    }
  }

  Future<void> _loadAllRoleCounts() async {
    if (_tabRoles.isEmpty) return;

    final useCase = getIt<GetPartyListUseCase>();
    final results = await Future.wait(
      _tabRoles.map((roleLabel) async {
        final role = roleLabel.toLowerCase();
        final params = PartyRequestParams(
          page: 1,
          pageSize: 1,
          role: role,
          status: role == 'employee' || role == 'supplier' ? 1 : null,
        );
        final result = await useCase.execute(params: params);
        final count = result.fold(
          (_) => _roleCounts[role] ?? 0,
          (response) => response.pagination.totalRows,
        );
        return MapEntry(role, count);
      }),
    );

    if (!mounted) return;
    setState(() {
      for (final entry in results) {
        _roleCounts[entry.key] = entry.value;
      }
    });
  }

  int _customerTabIndex() {
    if (_tabRoles.isEmpty) return 0;
    return PartyPickerRoleHelper.initialTabIndex(tabs: _tabRoles, role: 'customer');
  }

  String _activeTabRoleLabel() {
    if (_tabRoles.isEmpty) return 'Customer';
    return _tabRoles[_activeTabIndex.clamp(0, _tabRoles.length - 1)];
  }

  void _onMainShellTabSelected() {
    if (!mounted) return;
    if (currentIndex.value != kMainShellPartiesTabIndex) {
      if (_searchExpanded) {
        _closeSearchMode();
      }
      return;
    }
    _resetToCustomersTab();
  }

  void _onMainShellTabReselected() {
    if (!mounted) return;
    if (currentIndex.value != kMainShellPartiesTabIndex) return;
    _resetToCustomersTab();
  }

  /// Called when the main shell Parties tab is selected (including re-taps).
  void _resetToCustomersTab() {
    _searchDebounce?.cancel();
    _searchController.clear();
    _currentPage = 1;

    final customerIdx = _customerTabIndex();
    if (_activeTabIndex != customerIdx) {
      setState(() => _activeTabIndex = customerIdx);
      _currentFilterNotifier.value = 'customer';
      _performSearch();
      return;
    }

    _currentFilterNotifier.value = 'customer';
    _fetchPartiesForRole('customer');
  }

  void _syncCustomerTabUi() {
    _currentFilterNotifier.value = 'customer';
    final customerIdx = _customerTabIndex();
    if (_activeTabIndex != customerIdx) {
      setState(() => _activeTabIndex = customerIdx);
    }
  }

  PartyRequestParams _partyListParamsForCurrentFilter({int page = 1, String? search}) {
    final role = _currentFilterNotifier.value;
    final sort = _sortByFromKey(_selectedSortNotifier.value);
    return PartyRequestParams(
      page: page,
      pageSize: kPartyListPageSize,
      role: role,
      status: role == 'employee' || role == 'supplier' ? 1 : null,
      sortBy: sort.$1,
      sortOrder: sort.$2,
      search: search,
    );
  }

  void _fetchPartiesForRole(String role) {
    _currentFilterNotifier.value = role;
    context.read<PartyCubit>().getPartyList(
          params: _partyListParamsForCurrentFilter(page: 1),
          forceRefresh: true,
        );
  }

  Future<void> _openPartyInvoices(PartyModel party) async {
    final isEmployee = _currentFilterNotifier.value == 'employee';
    if (isEmployee) {
      await context.router.push(
        PartyInvoiceTabbedRoute(partyName: party.name.toString()),
      );
    } else {
      await context.router.push(
        PartyInvoiceRoute(
          partyName: party.name.toString(),
          invoiceType: _currentFilterNotifier.value == 'supplier'
              ? InvoiceType.purchase
              : InvoiceType.sales,
        ),
      );
    }
    if (mounted) {
      _performSearch();
    }
  }

  void _applyPartyListResponse(PartyListResponseModel response) {
    if (response.pagination.currentPage == 1) {
      _allLoadedParties = List.from(response.data);
    } else {
      _allLoadedParties = [..._allLoadedParties, ...response.data];
    }

    if (_currentFilterNotifier.value == 'employee') {
      _allLoadedParties = _allLoadedParties.where(_isEmployeePartyActive).toList();
    }

    _allLoadedParties = _sortPartiesList(_allLoadedParties);
    _allPartiesNotifier.value = List.from(_allLoadedParties);
    _paginationNotifier.value = response.pagination;
    _hasMoreNotifier.value = response.pagination.currentPage < response.pagination.totalPages;
    _currentPage = response.pagination.currentPage;
    _roleCounts[_currentFilterNotifier.value] = response.pagination.totalRows;
    _hasInitialData = true;
    _isLoadingNotifier.value = false;
  }

  /// When parties were prefetched (main shell), apply cubit state without refetching.
  void _hydrateFromCubitIfLoaded() {
    context.read<PartyCubit>().state.maybeWhen(
          listSuccess: (response) {
            if (response.pagination.currentPage != 1) return;
            _syncCustomerTabUi();
            _applyPartyListResponse(response);
          },
          orElse: () {},
        );
  }

  (String?, String?) _sortByFromKey(String key) {
    switch (key) {
      case _sortLatest:
        return ('modified', 'desc');
      case _sortAmountHighLow:
        // API expects snake_case for this field (camelCase is ignored → sort appeared broken).
        return ('outstanding_amount', 'desc');
      case _sortAmountLowHigh:
        return ('outstanding_amount', 'asc');
      case _sortNameAZ:
        return ('name', 'asc');
      case _sortNameZA:
        return ('name', 'desc');
      default:
        return ('modified', 'desc');
    }
  }

  DateTime _partyModifiedOrCreated(PartyModel p) {
    final m = _tryParsePartyDate(p.modified) ?? _tryParsePartyDate(p.created);
    return m ?? DateTime.fromMillisecondsSinceEpoch(0);
  }

  DateTime? _tryParsePartyDate(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      return DateTime.parse(raw);
    } catch (_) {
      return null;
    }
  }

  /// Server sort is not always applied; re-order the merged list so UI matches the selected option.
  List<PartyModel> _sortPartiesList(List<PartyModel> parties) {
    final sorted = List<PartyModel>.from(parties);
    switch (_selectedSortNotifier.value) {
      case _sortLatest:
        sorted.sort((a, b) => _partyModifiedOrCreated(b).compareTo(_partyModifiedOrCreated(a)));
        break;
      case _sortAmountHighLow:
        sorted.sort((a, b) => (b.outstandingAmount ?? 0).compareTo(a.outstandingAmount ?? 0));
        break;
      case _sortAmountLowHigh:
        sorted.sort((a, b) => (a.outstandingAmount ?? 0).compareTo(b.outstandingAmount ?? 0));
        break;
      case _sortNameAZ:
        sorted.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case _sortNameZA:
        sorted.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
        break;
      default:
        sorted.sort((a, b) => _partyModifiedOrCreated(b).compareTo(_partyModifiedOrCreated(a)));
    }
    return sorted;
  }

  String _unpaidAmountLabel(num amount, {String? partyCurrency}) {
    final formatted = context.l10n.formatCurrency(
      AppCurrencyFormatter.format(amount, currencyCode: partyCurrency),
    );
    return context.l10n.localizeMessage(
      context.l10n.unpaidColonAmount(formatted),
    );
  }

  void _showSortByBottomSheet() {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    const sheetMargin = EdgeInsets.only(left: 16, right: 16, bottom: 16);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SafeArea(
        child: Container(
          margin: sheetMargin,
          decoration: AppBottomSheetTheme.floatingCardDecoration(context),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.partySortBy,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalMarginSmall,
                Divider(),
                _sortOptionTile(context, _sortLatest, context.l10n.partySortLatest, FontAwesomeIcons.arrowsUpDown),
                _sortOptionTile(context, _sortAmountHighLow, context.l10n.partySortAmountHighLow, FontAwesomeIcons.arrowTrendUp),
                _sortOptionTile(context, _sortAmountLowHigh, context.l10n.partySortAmountLowHigh, FontAwesomeIcons.arrowsUpDown),
                _sortOptionTile(context, _sortNameAZ, context.l10n.partySortNameAZ, FontAwesomeIcons.arrowUpAZ),
                _sortOptionTile(context, _sortNameZA, context.l10n.partySortNameZA, FontAwesomeIcons.arrowUpZA),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sortOptionTile(BuildContext context, String value, String label, IconData icon) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        _selectedSortNotifier.value = value;
        Navigator.pop(context);
        _performSearch();
      },
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Icon(icon, size: 22, color: theme.colorScheme.onSurfaceVariant),
          horizontalMarginMedium,
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Radio<String>(
            value: value,
            groupValue: _selectedSortNotifier.value,
            onChanged: (v) {
              if (v != null) {
                _selectedSortNotifier.value = v;
                Navigator.pop(context);
                _performSearch();
              }
            },
            activeColor: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }

  void _showPdfBottomSheet() {
    final theme = Theme.of(context);
    ActionBottomSheet.show(
      context,
      title: context.l10n.export,
      items: [
        ActionSheetItem(
          icon: Icons.picture_as_pdf,
          title: context.l10n.exportAsPdf,
          color: theme.colorScheme.primary,
          onTap: _exportPartyPdf,
        ),
        ActionSheetItem(
          icon: Icons.share,
          title: context.l10n.sharePdf,
          color: theme.colorScheme.primary,
          onTap: _sharePartyPdf,
        ),
      ],
    );
  }

  Future<pw.Document> _generatePartyDetailsPdf(List<PartyModel> parties) {
    final pdf = pw.Document();
    final unpaidColumnLabel = context.l10n.unpaid;
    final roleLabel = _activeTabRoleLabel();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Party Details - $roleLabel',
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Generated: ${DateTime.now().toString().substring(0, 19)}',
                style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Total parties: ${parties.length}',
                style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(1.2),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(1.5),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                children: [
                  _pdfCell('Name', isHeader: true),
                  _pdfCell('Role', isHeader: true),
                  _pdfCell('Email / Phone', isHeader: true),
                  _pdfCell(unpaidColumnLabel, isHeader: true),
                ],
              ),
              ...parties.map(
                (p) => pw.TableRow(
                  children: [
                    _pdfCell(p.name),
                    _pdfCell(p.role),
                    _pdfCell(p.email ?? p.phone ?? '-'),
                    _pdfCell(
                      p.outstandingAmount != null
                          ? 'Rs. ${Utility.formatIndianNumber(p.outstandingAmount!.ceil())}'
                          : '-',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return Future.value(pdf);
  }

  Future<List<PartyModel>> _fetchPartiesForExport() async {
    final loaded = _allPartiesNotifier.value;
    if (loaded.isEmpty) return const [];

    final pagination = _paginationNotifier.value;
    final totalRows = pagination?.totalRows ?? loaded.length;
    if (totalRows <= loaded.length) {
      return loaded;
    }

    final query = _searchController.text.trim();
    final params = _partyListParamsForCurrentFilter(
      page: 1,
      search: query.isEmpty ? null : query,
    ).copyWith(pageSize: totalRows);

    final result = await getIt<GetPartyListUseCase>().execute(params: params);
    return result.fold(
      (_) => loaded,
      (response) {
        var parties = List<PartyModel>.from(response.data);
        if (_currentFilterNotifier.value == 'employee') {
          parties = parties.where(_isEmployeePartyActive).toList();
        }
        return _sortPartiesList(parties);
      },
    );
  }

  String _partyPdfFileName() {
    final role = _currentFilterNotifier.value.trim().toLowerCase();
    final stamp = DateTime.now().millisecondsSinceEpoch;
    return 'party_details_${role}_$stamp.pdf';
  }

  Future<void> _exportPartyPdf() async {
    if (!await gateInvoiceExport(context)) return;
    AppLoadingOverlay.of(context).show();
    try {
      final parties = await _fetchPartiesForExport();
      if (!mounted) return;
      if (parties.isEmpty) {
        AppLoadingOverlay.of(context).hide();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No party data to export'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final pdf = await _generatePartyDetailsPdf(parties);
      final bytes = await pdf.save();
      if (!mounted) return;
      AppLoadingOverlay.of(context).hide();

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => bytes,
        name: _partyPdfFileName(),
      );
    } catch (e) {
      if (!mounted) return;
      AppLoadingOverlay.of(context).hide();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error generating PDF: $e'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _sharePartyPdf() async {
    if (!await gateInvoiceExport(context)) return;
    AppLoadingOverlay.of(context).show();
    try {
      final parties = await _fetchPartiesForExport();
      if (!mounted) return;
      if (parties.isEmpty) {
        AppLoadingOverlay.of(context).hide();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No party data to share'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final pdf = await _generatePartyDetailsPdf(parties);
      final bytes = await pdf.save();
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${_partyPdfFileName()}');
      await file.writeAsBytes(bytes);
      if (!mounted) return;
      AppLoadingOverlay.of(context).hide();

      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Party Details - ${_activeTabRoleLabel()}',
        text: 'Party details list (${parties.length} parties)',
      );
    } catch (e) {
      if (!mounted) return;
      AppLoadingOverlay.of(context).hide();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sharing PDF: $e'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  pw.Widget _pdfCell(String text, {bool isHeader = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: isHeader ? 10 : 9,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  void _onSearchTextChanged() {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      _performSearch();
    });
  }

  void _openSearchMode() {
    if (_searchExpanded) return;
    partySearchMode.value = true;
    setState(() => _searchExpanded = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _searchFocusNode.requestFocus();
    });
  }

  void _closeSearchMode() {
    if (!_searchExpanded) return;
    _searchDebounce?.cancel();
    final hadQuery = _searchController.text.isNotEmpty;
    _searchController.clear();
    _searchFocusNode.unfocus();
    partySearchMode.value = false;
    setState(() => _searchExpanded = false);
    if (hadQuery) {
      _performSearch();
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    _fabScrollHide.updateFromPixels(position.pixels);

    if (position.pixels >= position.maxScrollExtent - 200) {
      final cubit = context.read<PartyCubit>();
      if (_searchController.text.isEmpty &&
          _hasMoreNotifier.value &&
          cubit.hasMoreParties &&
          !cubit.isLoadingMoreParties) {
        _loadMoreParties();
      }
    }
  }

  void _loadMoreParties() {
    final cubit = context.read<PartyCubit>();
    if (!cubit.hasMoreParties || cubit.isLoadingMoreParties) return;
    _isLoadingNotifier.value = true;
    cubit.loadMorePartyList();
  }

  void _selectRoleTab(int index) {
    if (index == _activeTabIndex || index < 0 || index >= _tabRoles.length) return;
    setState(() => _activeTabIndex = index);
    _currentFilterNotifier.value = _tabRoles[index].toLowerCase();
    _performSearch();
  }

  int _roleChipCount(String role) => _roleCounts[role.toLowerCase()] ?? 0;

  String _partyAvatarInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      final word = parts.first;
      return word.length >= 2 ? word.substring(0, 2).toUpperCase() : word.toUpperCase();
    }
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  void dispose() {
    if (widget.deferInitialFetch) {
      currentIndex.removeListener(_onMainShellTabSelected);
      shellTabReselectTick.removeListener(_onMainShellTabReselected);
    }
    _searchDebounce?.cancel();
    partySearchMode.value = false;
    _searchFocusNode.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    _fabScrollHide.dispose();
    _allPartiesNotifier.dispose();
    _currentFilterNotifier.dispose();
    _isLoadingNotifier.dispose();
    _paginationNotifier.dispose();
    _hasMoreNotifier.dispose();
    _selectedSortNotifier.dispose();
    super.dispose();
  }

  void _performSearch() {
    _searchDebounce?.cancel();
    _currentPage = 1;

    final query = _searchController.text.trim();
    context.read<PartyCubit>().getPartyList(
          params: _partyListParamsForCurrentFilter(
            page: 1,
            search: query.isEmpty ? null : query,
          ),
          forceRefresh: true,
        );
  }

  void _navigateToCreatePage() async {
    final filter = _currentFilterNotifier.value;
    final isEmployeeTab = filter == 'employee';
    if (isEmployeeTab) {
      if (!await gateFreemiumFeature(context, FreemiumFeature.employee)) {
        return;
      }
    } else {
      if (!await gateFreemiumFeature(
        context,
        PartyPickerFreemium.featureForTab(filter),
        partyRole: PartyPickerFreemium.partyRoleForTab(filter),
      )) {
        return;
      }
    }
    if (!mounted) return;

    final result = isEmployeeTab
        ? await context.router.push<bool>(EmployeeFormRoute())
        : await context.router.push<bool>(
            PartyEditRoute(
              isEditing: false,
              presetRole: filter,
            ),
          );

    if (result == true) {
      _performSearch();
    }
  }

  void _navigateToEditPage(PartyModel party) async {
    final isEmployeeTab = _currentFilterNotifier.value == 'employee';
    final employeeId = party.employeeDetails?.employeeId;

    if (isEmployeeTab) {
      if (employeeId == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to edit employee. Employee profile not found.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final result = await context.router.push<bool>(
        EmployeeFormRoute(employeeId: employeeId),
      );
      if (result == true) {
        _performSearch();
      }
      return;
    }

    final result = await context.router.push<bool>(
      PartyEditRoute(party: party, isEditing: true),
    );

    if (result == true) {
      _performSearch();
    }
  }

  void _showDeleteDialog(PartyModel party) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Party'),
        content: Text('Are you sure you want to delete "${party.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<PartyCubit>().deleteParty(
                    request: DeletePartyRequest(
                      name: party.name,
                      confirmDelete: true,
                      forceDelete: false,
                      deleteTransactions: false,
                      deletedBy: context.employeeData?.email ?? 'system',
                    ),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _openPaymentSettlementForParty(PartyModel party) {
    final filter = _currentFilterNotifier.value;
    final invoiceType = switch (filter) {
      'supplier' => InvoiceType.purchase,
      _ => InvoiceType.sales,
    };
    final outstanding = party.outstandingAmount ?? 0;

    PartialPaymentSettlementPage.showPartySettlementSheet(
      context,
      partyName: party.name,
      invoiceType: invoiceType,
      outstandingAmount: outstanding > 0 ? outstanding : null,
      currencyCode: party.currency,
    ).then((value) {
      if (value != null && mounted) {
        _performSearch();
      }
    });
  }

  void _openPayAdvanceSheet(PartyModel party) {
    PayAdvanceBottomSheet.show(
      context,
      partyName: party.name,
      employeeDisplayName: _employeePartyListDisplayName(party),
    ).then((value) {
      if (value != null && mounted) {
        _performSearch();
      }
    });
  }

  void _showCardMenu(BuildContext context, PartyModel party) {
    if (_isPartyLocked(party)) {
      unawaited(_gateLockedParty(_currentFilterNotifier.value));
      return;
    }
    final isEmployee = _currentFilterNotifier.value == 'employee';
    final isSupplier = _currentFilterNotifier.value == 'supplier';
    final outstanding = party.outstandingAmount ?? 0;
    final canSettle = outstanding > 0 && !isEmployee;
    final menuTitle =
        isEmployee ? _employeePartyListDisplayName(party) : party.name;

    ActionBottomSheet.show(
      context,
      title: menuTitle,
      items: [
        if (isSupplier)
          ActionSheetItem(
            icon: Icons.receipt_long_outlined,
            title: 'View Statement',
            onTap: () => context.router.push(
              PartyStatementRoute(partyName: party.name),
            ),
          ),
        if (isEmployee)
          ActionSheetItem(
            icon: Icons.payments_outlined,
            title: 'Pay Advance',
            onTap: () => _openPayAdvanceSheet(party),
          ),
        if (canSettle)
          ActionSheetItem(
            icon: Icons.insert_chart,
            title: 'Make Settlement',
            onTap: () => _openPaymentSettlementForParty(party),
          ),
        ActionSheetItem(
          icon: Icons.edit,
          title: isEmployee ? 'Edit Employee' : 'Edit Party',

          onTap: () => _navigateToEditPage(party),
        ),
        ActionSheetItem(
          icon: Icons.delete,
          title: 'Delete Party',

          onTap: () => _showDeleteDialog(party),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final scheme = Theme.of(context).colorScheme;
    return PopScope(
      canPop: !_searchExpanded,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _searchExpanded) {
          _closeSearchMode();
        }
      },
      child: Scaffold(
      backgroundColor: PartyPickerLayout.pageBackground(scheme),
      appBar: _buildAppBar(context, scheme),
      floatingActionButton: _searchExpanded
          ? null
          : ScrollHideFab(
        controller: _fabScrollHide,
        child: FloatingActionButton(
          heroTag: 'party_tab_add_fab',
          onPressed: _navigateToCreatePage,
          elevation: 2,
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.add_rounded, size: 22),
        ),
      ),
      body: BlocConsumer<PartyCubit, PartyState>(
        listener: (context, state) {
          state.maybeWhen(
            loading: () {
              if (!_hasInitialData) {
                _isLoadingNotifier.value = true;
              }
            },
            listSuccess: (response) {
              _applyPartyListResponse(response);
            },
            error: (message) {
              AppLoadingOverlay.of(context).hide();
              _isLoadingNotifier.value = false;
              if (_hasInitialData) {
                _showPageSnackBar(
                  context,
                  message: ErrorMessageHelper.format(message),
                  backgroundColor: Colors.red.shade400,
                );
              }
            },
            deleted: (response) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(response.message),
                  backgroundColor: Colors.green.shade400,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
              unawaited(_loadAllRoleCounts());
              _performSearch();
            },
            updated: (response) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(response.message),
                  backgroundColor: Colors.green.shade400,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
              _performSearch();
            },
            reconcile: (response) {
              AppLoadingOverlay.of(context).hide();
              _performSearch();
            },
            noInternet: () {
              _isLoadingNotifier.value = false;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('No internet connection'),
                  backgroundColor: Colors.orange.shade400,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
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
                final scheme = Theme.of(context).colorScheme;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: scheme.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Loading parties',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                );
              }
              return _buildContent();
            },
            // Show error only if no data
            error: (message) {
              if (!_hasInitialData) {
                return TabErrorView(
                  title: 'Could not load parties',
                  message: message,
                  onRetry: _performSearch,
                );
              }
              return _buildContent();
            },
            noInternet: () {
              if (!_hasInitialData) {
                return TabErrorView(
                  title: 'No internet connection',
                  message: 'Please check your connection and try again.',
                  isNoInternet: true,
                  onRetry: _performSearch,
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

  PreferredSizeWidget _buildAppBar(BuildContext context, ColorScheme scheme) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        child: _searchExpanded
            ? _buildSearchAppBar(context, scheme)
            : _buildDefaultAppBar(context, scheme),
      ),
    );
  }

  Widget _buildAppBarWidthLimiter({required Widget child}) {
    if (!_isTablet) return child;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: child,
        ),
      ),
    );
  }

  AppBar _buildDefaultAppBar(BuildContext context, ColorScheme scheme) {
    final title = Text(
      context.l10n.partiesTitle,
      style: context.theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: _sp(22, 24),
      ),
    );

    final actions = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ..._buildToolbarButtons(scheme),
        IconButton(
          tooltip: context.l10n.search,
          onPressed: _openSearchMode,
          icon: AppSearchIcon(
            size: _sz(22, 22),
            color: scheme.onSurface,
          ),
        ),
      ],
    );

    return AppBar(
      key: const ValueKey<String>('parties_app_bar_default'),
      title: _buildAppBarWidthLimiter(
        child: _isTablet
            ? Row(
                children: [
                  Expanded(child: title),
                  actions,
                ],
              )
            : title,
      ),
      centerTitle: false,
      titleSpacing: _isTablet ? 0 : null,
      backgroundColor: scheme.surfaceContainerHigh,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: _isTablet
          ? const []
          : [
              Padding(
                padding: EdgeInsets.only(right: _sz(8, 4.w)),
                child: actions,
              ),
            ],
    );
  }

  AppBar _buildSearchAppBar(BuildContext context, ColorScheme scheme) {
    return AppBar(
      key: const ValueKey<String>('parties_app_bar_search'),
      automaticallyImplyLeading: false,
      backgroundColor: scheme.surfaceContainerHigh,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      title: _buildAppBarWidthLimiter(
        child: Padding(
          padding: EdgeInsets.only(right: _sz(8, 8.w)),
          child: Row(
            children: [
              IconButton(
                tooltip: context.l10n.back,
                onPressed: _closeSearchMode,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: scheme.onSurface,
                  size: _sz(24, 24),
                ),
              ),
              Expanded(
                child: ListenableBuilder(
                  listenable: Listenable.merge([
                    _searchController,
                    _searchFocusNode,
                  ]),
                  builder: (context, _) {
                    final radius = BorderRadius.circular(_sz(12, 12.r));
                    final focused = _searchFocusNode.hasFocus;
                    final hasText = _searchController.text.isNotEmpty;
                    return Material(
                      color: scheme.surface,
                      borderRadius: radius,
                      clipBehavior: Clip.antiAlias,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: radius,
                          border: Border.all(
                            color: focused ? scheme.primary : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: SizedBox(
                          height: _sz(44, 44.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: _sz(12, 12.w)),
                              AppSearchIcon(
                                size: _sz(18, 16),
                                color: scheme.onSurfaceVariant,
                              ),
                              SizedBox(width: _sz(8, 8.w)),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  focusNode: _searchFocusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: context.theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: _sp(15, 14),
                                  ),
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    isCollapsed: true,
                                    filled: false,
                                    fillColor: Colors.transparent,
                                    hintText: null,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ).copyWith(
                                    hintText: context.l10n.partySearchByName,
                                    hintStyle: context.theme.textTheme.bodyMedium?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w500,
                                      fontSize: _sp(15, 15),
                                    ),
                                  ),
                                ),
                              ),
                              if (hasText)
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(
                                    minWidth: _sz(36, 36.w),
                                    minHeight: _sz(36, 36.h),
                                  ),
                                  icon: Icon(
                                    Icons.close_rounded,
                                    size: _sz(20, 18),
                                    color: scheme.onSurfaceVariant,
                                  ),
                                  onPressed: () => _searchController.clear(),
                                )
                              else
                                SizedBox(width: _sz(8, 8.w)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        ColoredBox(
          color: scheme.surface,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: _isTablet ? 1100 : double.infinity,
              ),
              child: Column(
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: _isLoadingNotifier,
                    builder: (context, isLoading, child) {
                      if (isLoading && _hasInitialData) {
                        return LinearProgressIndicator(
                          minHeight: 2,
                          color: scheme.primary,
                          backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  if (!_rolesReady)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: _sz(12, 12.h)),
                      child: SizedBox(
                        width: _sz(22, 22.w),
                        height: _sz(22, 22.w),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: scheme.primary,
                        ),
                      ),
                    )
                  else if (_isTablet)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.start,
                        children: [
                          for (var index = 0; index < _tabRoles.length; index++)
                            PartyPickerFilterChip(
                              label: context.l10n.localizedPartyRoleName(_tabRoles[index]),
                              count: _roleChipCount(_tabRoles[index]),
                              selected: index == _activeTabIndex,
                              onTap: () => _selectRoleTab(index),
                            ),
                        ],
                      ),
                    )
                  else
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                      child: Row(
                        children: [
                          for (var index = 0; index < _tabRoles.length; index++)
                            PartyPickerFilterChip(
                              label: context.l10n.localizedPartyRoleName(_tabRoles[index]),
                              count: _roleChipCount(_tabRoles[index]),
                              selected: index == _activeTabIndex,
                              onTap: () => _selectRoleTab(index),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: !_rolesReady
              ? const Center(child: CircularProgressIndicator())
              : ValueListenableBuilder<bool>(
                  valueListenable: _hasMoreNotifier,
                  builder: (context, hasMore, child) => _buildTabContent(hasMore),
                ),
        ),
      ],
    );
  }

  void _showPageSnackBar(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: _searchExpanded ? SnackBarBehavior.fixed : SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_searchExpanded ? 0 : 10),
        ),
      ),
    );
  }

  List<Widget> _buildToolbarButtons(ColorScheme scheme) {
    return [
      ValueListenableBuilder<String>(
        valueListenable: _selectedSortNotifier,
        builder: (context, selectedSort, child) {
          return IconButton(
            tooltip: context.l10n.sort,
            onPressed: _showSortByBottomSheet,
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.sort_rounded,
                  size: _sz(22, 22),
                  color: scheme.onSurface,
                ),
                if (selectedSort != _sortLatest)
                  Positioned(
                    right: -1,
                    top: -1,
                    child: Container(
                      width: _sz(7, 7.w),
                      height: _sz(7, 7.w),
                      decoration: BoxDecoration(
                        color: PartyPickerLayout.brandGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: scheme.surface, width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      IconButton(
        tooltip: context.l10n.partyExportPdfTooltip,
        onPressed: _showPdfBottomSheet,
        icon: Icon(
          Icons.picture_as_pdf_rounded,
          size: _sz(22, 22),
          color: PartyPickerLayout.brandGreen,
        ),
      ),
    ];
  }

  Widget _buildTabContent(bool hasMore) {
    final scheme = Theme.of(context).colorScheme;
    final bottomPad = widget.deferInitialFetch
        ? NotchedBottomNavBar.shellTabListBottomGap(context) + (_isTablet ? 24 : 16.h)
        : _sz(24, 24.h);

    return ColoredBox(
      color: PartyPickerLayout.pageBackground(scheme),
      child: RefreshIndicator(
        color: scheme.primary,
        onRefresh: () async {
          _performSearch();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: _isTablet ? 1100 : double.infinity,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: _sz(12, 12.h)),
                  _buildPartiesList(),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isLoadingNotifier,
                    builder: (context, isLoading, child) {
                      if (isLoading && hasMore) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  SizedBox(height: bottomPad),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _gridMainAxisExtent() {
    if (!_isTablet) return 88.h;
    final isEmployee = _currentFilterNotifier.value == 'employee';
    // Employee cards show unpaid + advance pills; fixed 84px was too short.
    return isEmployee ? 116 : 100;
  }

  int _tabletGridCrossAxisCount(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= 1000) return 3;
    return 2;
  }

  Widget _buildPartiesList() {
    return ValueListenableBuilder<String>(
      valueListenable: _currentFilterNotifier,
      builder: (context, role, _) {
        return FreemiumAccessHost(
          feature: PartyPickerFreemium.featureForTab(role),
          partyRole: PartyPickerFreemium.partyRoleForTab(role),
          child: ValueListenableBuilder<List<PartyModel>>(
      valueListenable: _allPartiesNotifier,
      builder: (context, partiesToShow, child) {
        final horizontalPad = _sz(24, 16.w);
        final useGrid = _isTablet && MediaQuery.sizeOf(context).width >= 760;

        Widget emptyOrList() {
          if (partiesToShow.isEmpty && _searchController.text.isNotEmpty) {
            return ListEmptyState(
              illustrationPath: AppEmptyStateAssets.party,
              title: 'No matches',
              subtitle: 'Try a different search.',
            );
          }
          if (partiesToShow.isEmpty) {
            return ListEmptyState(
              illustrationPath: AppEmptyStateAssets.party,
              title: 'No parties yet',
              subtitle: 'Tap + to add your first party.',
            );
          }
          if (useGrid) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _tabletGridCrossAxisCount(context),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: _gridMainAxisExtent(),
              ),
              itemCount: partiesToShow.length,
              itemBuilder: (context, index) => _buildPartyCard(partiesToShow[index]),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: partiesToShow.length,
            separatorBuilder: (_, __) => SizedBox(height: _sz(10, 10.h)),
            itemBuilder: (context, index) => _buildPartyCard(partiesToShow[index]),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPad),
          child: emptyOrList(),
        );
      },
    ),
        );
      },
    );
  }

  bool _isPartyLocked(PartyModel party) {
    final scope = FreemiumAccessScope.maybeOf(context);
    if (scope == null) return false;
    final key = PartyPickerFreemium.recordKeyForPartyModel(
      party,
      _currentFilterNotifier.value,
    );
    if (key.isEmpty) return false;
    return scope.isLocked(key);
  }

  Future<void> _gateLockedParty(String tabRole) {
    return gateFreemiumFeature(
      context,
      PartyPickerFreemium.featureForTab(tabRole),
      partyRole: PartyPickerFreemium.partyRoleForTab(tabRole),
    );
  }

  void _onPartyCardTap(PartyModel party, VoidCallback navigate) {
    if (_isPartyLocked(party)) {
      unawaited(_gateLockedParty(_currentFilterNotifier.value));
      return;
    }
    navigate();
  }

  Widget _buildPartyCard(PartyModel party) {
    final card = _currentFilterNotifier.value == 'employee'
        ? _buildEmployeePartyCard(party)
        : _buildStandardPartyCard(party);
    return FreemiumRecordGate(
      recordKey: PartyPickerFreemium.recordKeyForPartyModel(
        party,
        _currentFilterNotifier.value,
      ),
      child: card,
    );
  }

  Widget _buildStandardPartyCard(PartyModel party) {
    final textTheme = context.theme.textTheme;
    final outstanding = party.outstandingAmount ?? 0;
    final hasOutstanding = outstanding > 0;
    final displayName = party.name;
    final initials = _partyAvatarInitials(displayName);
    final (avatarBg, avatarFg) = PartyPickerAvatarColors.forName(displayName);

    return _buildPartyListTile(
      party: party,
      displayName: displayName,
      initials: initials,
      avatarBg: avatarBg,
      avatarFg: avatarFg,
      textTheme: textTheme,
      imageUrl: party.displayImageUrl,
      onTap: () => _onPartyCardTap(
        party,
        () => _openPartyInvoices(party),
      ),
      badges: [
        _partyBalancePill(
          textTheme: textTheme,
          label: _unpaidAmountLabel(outstanding, partyCurrency: party.currency),
          background: hasOutstanding ? PartyPickerLayout.balanceBg : PartyPickerLayout.settledBg,
          foreground: hasOutstanding ? PartyPickerLayout.balanceFg : PartyPickerLayout.settledFg,
        ),
      ],
    );
  }

  /// List label: prefer API `full_name`, else strip trailing ` - Employee` from party name.
  String _employeePartyListDisplayName(PartyModel party) {
    final full = party.employeeDetails?.fullName?.trim();
    if (full != null && full.isNotEmpty) return full;
    final raw = party.name.trim();
    final stripped = raw.replaceAll(RegExp(r'\s*-\s*Employee\s*$', caseSensitive: false), '').trim();
    return stripped.isEmpty ? raw : stripped;
  }

  Widget _buildEmployeePartyCard(PartyModel party) {
    final textTheme = context.theme.textTheme;
    final scheme = Theme.of(context).colorScheme;
    final outstanding = party.outstandingAmount ?? 0;
    final advance = party.totalAdvance ?? 0;
    final hasOutstanding = outstanding > 0;
    final hasAdvance = advance > 0;
    final displayName = _employeePartyListDisplayName(party);
    final nameForInitial = (party.employeeDetails?.fullName?.trim().isNotEmpty == true)
        ? party.employeeDetails!.fullName!.trim()
        : displayName;
    final initials = _partyAvatarInitials(nameForInitial);
    final (avatarBg, avatarFg) = PartyPickerAvatarColors.forName(displayName);

    return _buildPartyListTile(
      party: party,
      displayName: displayName,
      initials: initials,
      avatarBg: avatarBg,
      avatarFg: avatarFg,
      textTheme: textTheme,
      imageUrl: party.displayImageUrl,
      onTap: () => _onPartyCardTap(
        party,
        () => _openPartyInvoices(party),
      ),
      badges: [
        _partyBalancePill(
          textTheme: textTheme,
          label: _unpaidAmountLabel(outstanding, partyCurrency: party.currency),
          background: hasOutstanding ? PartyPickerLayout.balanceBg : PartyPickerLayout.settledBg,
          foreground: hasOutstanding ? PartyPickerLayout.balanceFg : PartyPickerLayout.settledFg,
        ),
        _partyBalancePill(
          textTheme: textTheme,
          label:
              'Advance (this month): ${AppCurrencyFormatter.format(advance, currencyCode: party.currency)}',
          background: hasAdvance ? scheme.primaryContainer : PartyPickerLayout.settledBg,
          foreground: hasAdvance ? scheme.primary : PartyPickerLayout.settledFg,
        ),
      ],
    );
  }

  Widget _buildPartyListTile({
    required PartyModel party,
    required String displayName,
    required String initials,
    required Color avatarBg,
    required Color avatarFg,
    required TextTheme textTheme,
    required String? imageUrl,
    required VoidCallback onTap,
    required List<Widget> badges,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final cardRadius = PartyPickerLayout.cardRadiusFor(context);
    return Material(
      color: scheme.surface,
      elevation: 0,
      borderRadius: BorderRadius.circular(cardRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onLongPress: () => _showCardMenu(context, party),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _sz(16, 14.w),
            vertical: _sz(12, 14.h),
          ),
          child: Row(
            children: [
              _buildPartyAvatar(
                imageUrl: imageUrl,
                initial: initials,
                radius: _sz(22, 24.r),
                fallbackBackground: avatarBg,
                fallbackForeground: avatarFg,
                textStyle: textTheme.titleSmall,
              ),
              SizedBox(width: _sz(14, 12.w)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.l10n.localizeDigits(displayName),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: _sp(16, 16),
                        color: scheme.onSurface,
                        height: 1.25,
                      ),
                    ),
                    if (badges.isNotEmpty) ...[
                      SizedBox(height: _sz(6, 8.h)),
                      Wrap(
                        spacing: _sz(6, 8.w),
                        runSpacing: _sz(4, 6.h),
                        children: badges,
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: _sz(8, 4.w)),
              Icon(
                Icons.chevron_right_rounded,
                color: scheme.onSurfaceVariant,
                size: _sz(22, 24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _partyBalancePill({
    required TextTheme textTheme,
    required String label,
    required Color background,
    required Color foreground,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _sz(8, 10.w),
        vertical: _sz(4, 5.h),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(_sz(999, 999.r)),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: _sp(10, 11),
          color: foreground,
        ),
      ),
    );
  }

  bool _isEmployeePartyActive(PartyModel party) {
    final byFlag = party.employeeDetails?.isActive;
    if (byFlag != null) return byFlag;

    final status = party.employeeDetails?.employmentStatus?.trim().toLowerCase();
    if (status != null) return status == 'active';

    // Offline/local rows may omit nested employeeDetails; list query already filters status=1.
    return true;
  }

  Widget _buildPartyAvatar({
    required String? imageUrl,
    required String initial,
    required double radius,
    required Color fallbackBackground,
    required Color fallbackForeground,
    required TextStyle? textStyle,
  }) {
    final trimmed = imageUrl?.trim();
    final hasValidUrl = trimmed != null && trimmed.isNotEmpty && !_failedImageUrls.contains(trimmed);
    if (!hasValidUrl) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: fallbackBackground,
        child: Text(
          initial,
          style: textStyle?.copyWith(
            fontWeight: FontWeight.w700,
            color: fallbackForeground,
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: Image.network(
          trimmed,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            if (_failedImageUrls.add(trimmed)) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) setState(() {});
              });
            }
            return CircleAvatar(
              radius: radius,
              backgroundColor: fallbackBackground,
              child: Text(
                initial,
                style: textStyle?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: fallbackForeground,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
