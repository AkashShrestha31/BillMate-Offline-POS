import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/presentation/bloc/login/invoice_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/delete_invoice/delete_invoice_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/pages/login/party_invoice_page.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';

/// Party invoice list with Sales and Purchase tabs; each tab uses its own [InvoiceCubit].
/// Search and export sit above the tabs and apply to the **current** tab only (same query
/// filters sales or purchase lists when you switch).
@RoutePage()
class PartyInvoiceTabbedPage extends StatefulWidget {
  const PartyInvoiceTabbedPage({
    super.key,
    required this.partyName,
  });

  final String partyName;

  @override
  State<PartyInvoiceTabbedPage> createState() => _PartyInvoiceTabbedPageState();
}

class _PartyInvoiceTabbedPageState extends State<PartyInvoiceTabbedPage>
    with SingleTickerProviderStateMixin {
  static const double _tabletMaxWidth = 900;

  late final TabController _tabController;
  final _salesPageKey = GlobalKey<PartyInvoicePageState>();
  final _purchasePageKey = GlobalKey<PartyInvoicePageState>();
  final _searchController = TextEditingController();
  final _searchQueryNotifier = ValueNotifier<String>('');

  double _tabletContentWidth(BuildContext context) {
    final available = MediaQuery.sizeOf(context).width;
    return available < _tabletMaxWidth ? available : _tabletMaxWidth;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    _searchController.addListener(_onSearchFieldChanged);
  }

  void _onTabChanged() {
    if (mounted) setState(() {});
  }

  void _onSearchFieldChanged() {
    _searchQueryNotifier.value = _searchController.text;
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _searchController.removeListener(_onSearchFieldChanged);
    _searchController.dispose();
    _searchQueryNotifier.dispose();
    super.dispose();
  }

  Future<void> _onExportPressed() async {
    final page = _tabController.index == 0
        ? _salesPageKey.currentState
        : _purchasePageKey.currentState;
    await page?.openBulkExportFromToolbar();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isSalesTab = _tabController.index == 0;

    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        backgroundColor: scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        title: Text(widget.partyName),
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.ios_share_outlined, color: scheme.primary),
            tooltip: isSalesTab
                ? 'Export sales by date range'
                : 'Export purchase by date range',
            onPressed: _onExportPressed,
          ),
        ],
      ),
      body: _buildBody(context, scheme, theme, isSalesTab),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ColorScheme scheme,
    ThemeData theme,
    bool isSalesTab,
  ) {
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSearchRow(context, theme, isSalesTab),
        Material(
          color: scheme.surface,
          elevation: 0,
          child: TabBar(
            controller: _tabController,
            labelColor: scheme.primary,
            unselectedLabelColor: scheme.onSurfaceVariant,
            indicatorColor: scheme.primary,
            tabs: const [
              Tab(text: 'Sales'),
              Tab(text: 'Purchase'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _PartyInvoiceTabPane(
                partyName: widget.partyName,
                invoiceType: InvoiceType.sales,
                pageKey: _salesPageKey,
                parentSearchQuery: _searchQueryNotifier,
              ),
              _PartyInvoiceTabPane(
                partyName: widget.partyName,
                invoiceType: InvoiceType.purchase,
                pageKey: _purchasePageKey,
                parentSearchQuery: _searchQueryNotifier,
              ),
            ],
          ),
        ),
      ],
    );

    if (!DeviceLayout.isTablet(context)) return column;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: _tabletContentWidth(context),
          child: column,
        ),
      ],
    );
  }

  Widget _buildSearchRow(BuildContext context, ThemeData theme, bool isSalesTab) {
    final tablet = DeviceLayout.isTablet(context);
    final scheme = theme.colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: tablet ? 24 : 16.w,
        vertical: tablet ? 12 : 12.h,
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CustomTextFormField(
        controller: _searchController,
        hint: isSalesTab
            ? 'Search sales by item name...'
            : 'Search purchase by item name...',
        prefixIcon: AppSearchIcon.inputDecoration(color: scheme.primary),
        suffixIcon: _searchController.text.trim().isNotEmpty
            ? IconButton(
                icon: Icon(Icons.close, color: scheme.onSurfaceVariant),
                onPressed: () {
                  _searchController.clear();
                  _searchQueryNotifier.value = '';
                  FocusScope.of(context).unfocus();
                  setState(() {});
                },
              )
            : null,
        keyboardType: TextInputType.text,
      ),
    );
  }
}

class _PartyInvoiceTabPane extends StatefulWidget {
  const _PartyInvoiceTabPane({
    required this.partyName,
    required this.invoiceType,
    required this.pageKey,
    required this.parentSearchQuery,
  });

  final String partyName;
  final InvoiceType invoiceType;
  final GlobalKey<PartyInvoicePageState> pageKey;
  final ValueNotifier<String> parentSearchQuery;

  @override
  State<_PartyInvoiceTabPane> createState() => _PartyInvoiceTabPaneState();
}

class _PartyInvoiceTabPaneState extends State<_PartyInvoiceTabPane>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<InvoiceCubit>(
      create: (_) => getIt<InvoiceCubit>(),
      child: BlocProvider<DeleteInvoiceCubit>(
        create: (_) => getIt<DeleteInvoiceCubit>(),
        child: PartyInvoicePage(
          key: widget.pageKey,
          partyName: widget.partyName,
          invoiceType: widget.invoiceType,
          showScaffold: false,
          canPop: false,
          tabbedParentSearchQuery: widget.parentSearchQuery,
        ),
      ),
    );
  }
}
