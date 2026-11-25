import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/helpers/keyboard_dismiss_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/constants/app_constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/services/token_storage.dart';
import 'package:hotel/src/features/permission/presentation/cubit/user_permissions_cubit.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/widget/app_brand_name.dart';
import 'package:hotel/src/core/widget/employee_profile_avatar.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/notched_bottom_nav_bar.dart';
import 'package:hotel/src/core/widget/progress_step_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:hotel/src/features/dashboard/presentation/bloc/client_to_server_cubit.dart';
import 'package:hotel/src/features/dashboard/presentation/bloc/server_to_client_cubit.dart';
import 'package:hotel/src/features/dashboard/presentation/main_shell_tab_index.dart';
import 'package:hotel/src/features/org/domain/organization_session_guard.dart';
import 'package:hotel/src/features/org/domain/org_switch_coordinator.dart';
import 'package:hotel/src/features/dashboard/presentation/pages/statstics_tab.dart';
import 'package:hotel/src/features/employee_management/presentation/bloc/employee_cubit.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_dates_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/presentation/bloc/login/invoice_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/bloc/login/invoice_purchase_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/invoice_dates/invoice_dates_cubit.dart';
import 'package:hotel/src/features/party/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/party/domain/party_list_pagination.dart';
import 'package:hotel/src/features/party/presentation/bloc/party_cubit.dart';

import 'package:hotel/src/features/invoice/presentation/pages/login/invoice.dart';
import 'package:hotel/src/features/invoice/presentation/pages/login/purchase_invoice_page.dart';
import 'package:hotel/src/features/invoice/presentation/cubit/accounting_settings_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/pages/login/sales_invoice_page.dart';
import 'package:hotel/src/features/party/presentation/pages/party_details_page.dart';

import 'more_page.dart';

export 'package:hotel/src/features/dashboard/presentation/main_shell_tab_index.dart'
    show currentIndex, kMainShellPartiesTabIndex, shellTabReselectTick;

final ValueNotifier<String?> lastUpdatedNotifier = ValueNotifier<String?>('');

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /// Tab order must match bottom nav: 0 Home, 1 Sales, 2 Expenses, 3 Parties, 4 More.
  List<Widget> _buildTabs(int orgVersion) => [
        StatisticsTab(key: ValueKey('stats-$orgVersion')),
        SalesInvoicePage(
          key: ValueKey('sales-$orgVersion'),
          invoiceType: InvoiceType.sales,
          deferInitialFetch: true,
        ),
        PurchaseInvoicePage(
          key: ValueKey('purchase-$orgVersion'),
          deferInitialFetch: true,
        ),
        PartyDetailsPage(
          key: ValueKey('parties-$orgVersion'),
          deferInitialFetch: true,
        ),
        const MorePage(),
      ];

  bool _customerPartiesLoaded = false;

  static String _ymd(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  void _onCurrentTabChanged() {
    // Defer until after the shell rebuild so Sales/Purchase listeners are
    // attached before the fetch completes (local DB can finish in the same frame).
    final index = currentIndex.value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || currentIndex.value != index) return;
      _loadDataForTab(index);
    });
  }

  void _selectShellTab(int index) {
    if (currentIndex.value == index) {
      shellTabReselectTick.value++;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || currentIndex.value != index) return;
        _loadDataForTab(index);
      });
      return;
    }
    currentIndex.value = index;
  }

  /// Preloads customer parties so the Parties tab is ready on first open.
  void _loadCustomerParties(BuildContext ctx, {bool force = false}) {
    if (!force && _customerPartiesLoaded) return;

    final cubit = ctx.read<PartyCubit>();
    final alreadyLoaded = cubit.state.maybeWhen(
      listSuccess: (response) =>
          response.pagination.currentPage == 1 && response.data.isNotEmpty,
      orElse: () => false,
    );
    final listLoading = cubit.state.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (!force && (alreadyLoaded || listLoading)) {
      _customerPartiesLoaded = true;
      return;
    }

    _customerPartiesLoaded = true;
    cubit.getPartyList(
      params: const PartyRequestParams(
        page: 1,
        pageSize: kPartyListPageSize,
        role: 'customer',
        sortBy: 'modified',
        sortOrder: 'desc',
      ),
    );
  }

  /// Load invoice/party data for the selected tab (1=Sales, 2=Expenses, 3=Parties).
  /// Sales and expenses refetch whenever you switch to that tab so lists stay in sync.
  void _loadDataForTab(int index) {
    if (!mounted) return;
    final ctx = context;
    final today = DateTime.now();

    switch (index) {
      case 0:
        // Home tab depends on employee/session payloads.
        unawaited(_loadEmployeeOnce());
        unawaited(_refreshUserPermissions());
        break;
      case 1:
        ctx.read<InvoiceDatesCubit>().getInvoiceDates(
              params: InvoiceDatesRequestParams.forMonth(
                invoiceType: InvoiceType.sales.name,
                month: today,
              ),
            );
        ctx.read<InvoiceCubit>().invoice(
              invoiceRequestParam: InvoiceRequestParams(
                perPage: 5000,
                invoiceType: InvoiceType.sales,
                startDate: _ymd(today),
                endDate: _ymd(today),
              ),
            );
        break;
      case 2:
        ctx.read<InvoiceDatesCubit>().getInvoiceDates(
              params: InvoiceDatesRequestParams.forMonth(
                invoiceType: InvoiceType.purchase.name,
                month: today,
              ),
            );
        ctx.read<InvoicePurchaseCubit>().invoice(
              invoiceRequestParam: InvoiceRequestParams(
                perPage: 5000,
                invoiceType: InvoiceType.purchase,
                startDate: _ymd(today),
                endDate: _ymd(today),
              ),
            );
        break;
      case kMainShellPartiesTabIndex:
        _loadCustomerParties(ctx);
        break;
      default:
        break;
    }
  }

  Future<void> _loadEmployeeOnce({bool force = false}) async {
    if (!mounted) return;
    if (force) {
      final userId = await SessionHelper.getUserId();
      if (!mounted || userId == null || userId.trim().isEmpty) return;
      context.read<EmployeeCubit>().getEmployeeById(userId);
      return;
    }
    final hasEmployeeDetail = context.read<EmployeeCubit>().state.maybeWhen(
          employeeDetail: (_) => true,
          orElse: () => false,
        );
    if (hasEmployeeDetail) {
      return;
    }
    final userId = await SessionHelper.getUserId();
    if (!mounted || userId == null || userId.trim().isEmpty) {
      return;
    }
    context.read<EmployeeCubit>().getEmployeeById(userId);
  }

  /// Keeps dashboard permission gates in sync (login skips splash; admin may change grants while app runs).
  Future<void> _refreshUserPermissions() async {
    // TEMP: user permission API sync disabled.
    // if (!mounted) return;
    // final email = await TokenStorage.getUserLoginEmail();
    // if (email == null || email.trim().isEmpty) return;
    // if (!mounted) return;
    // final normalized = email.trim().toLowerCase();
    // final permState = context.read<UserPermissionsCubit>().state;
    // if (permState is UserPermissionsSuccess &&
    //     permState.data.userId.trim().toLowerCase() == normalized) {
    //   return;
    // }
    // await context
    //     .read<UserPermissionsCubit>()
    //     .fetchUserPermissions(userId: normalized);
  }

  void _onOrgSwitched() {
    if (!mounted) return;
    _customerPartiesLoaded = false;
    _loadDataForTab(currentIndex.value);
    _loadEmployeeOnce(force: true);
    _loadCustomerParties(context, force: true);
  }

  Future<void> _clearStaleKeyboardOnLanding() async {
    await dismissKeyboard();
    if (!mounted) return;
    await dismissKeyboard(settleDelay: const Duration(milliseconds: 80));
    if (!mounted) return;
    await dismissKeyboard(settleDelay: const Duration(milliseconds: 200));
  }

  @override
  void initState() {
    super.initState();
    currentIndex.addListener(_onCurrentTabChanged);
    OrgSwitchCoordinator.notifier.addListener(_onOrgSwitched);
    unawaited(_clearStaleKeyboardOnLanding());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // AccountingSettingsCubit lives under [BlocProvider] in [build]; do not use this State's context.read here.
      // On first build we always reload data using the current org, in case
      // MainPage was pushed after an org switch event.
      _loadDataForTab(currentIndex.value);
      _loadEmployeeOnce(force: true);
      _loadCustomerParties(context, force: true);
    });
  }

  @override
  void dispose() {
    currentIndex.removeListener(_onCurrentTabChanged);
    OrgSwitchCoordinator.notifier.removeListener(_onOrgSwitched);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AccountingSettingsCubit>(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<EmployeeCubit, EmployeeState>(
            listener: (context, state) {
              state.maybeWhen(
                error: (message) {
                  if (OrganizationSessionGuard.isInvalidSessionError(message)) {
                    unawaited(
                      OrganizationSessionGuard.invalidateSessionAndNavigate(
                        context,
                      ),
                    );
                  }
                },
                orElse: () {},
              );
            },
          ),
          BlocListener<ClientToServerCubit, ClientToServerState>(
            listener: (context, state) {
              state.maybeWhen(
                loading: () {},
                success: (response) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UnifiedProgressPage(
                        requestId: response.requestId,
                        operationType: OperationType.upload,
                      ),
                    ),
                  );
                },
                error: (message) {
                  AppLoadingOverlay.of(context).hide();
                },
                orElse: () {},
              );
            },
          ),
          BlocListener<ServerToClientCubit, ServerToClientState>(
            listener: (context, state) {
              state.maybeWhen(
                loading: () {},
                success: (response) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UnifiedProgressPage(
                        operationType: OperationType.download,
                      ),
                    ),
                  );
                },
                error: (message) {},
                orElse: () {},
              );
            },
          ),
        ],
        // Keep one stable parent tree for every tab. Switching Home ↔ Sales used
        // to swap bare Scaffold vs ValueListenableBuilder→Scaffold and remount
        // IndexedStack, so invoice pages missed the already-emitted cubit success.
        child: ListenableBuilder(
          listenable: Listenable.merge([
            currentIndex,
            salesInvoiceSearchMode,
            purchaseInvoiceSearchMode,
            partySearchMode,
          ]),
          builder: (context, _) {
            final index = currentIndex.value;
            final hideShellChrome = switch (index) {
              1 => salesInvoiceSearchMode.value,
              2 => purchaseInvoiceSearchMode.value,
              kMainShellPartiesTabIndex => partySearchMode.value,
              _ => false,
            };
            return _buildShellScaffold(
              context,
              index,
              hideShellChrome: hideShellChrome,
            );
          },
        ),
      ),
    );
  }

  Widget _buildShellScaffold(
    BuildContext context,
    int index, {
    bool hideShellChrome = false,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final shellBackground = scheme.surfaceContainerLow;

    return Scaffold(
      backgroundColor: shellBackground,
      extendBody: false,
      resizeToAvoidBottomInset: false,
      appBar: index == 0 ? _buildStatisticsAppBar() : null,
      body: Builder(
        builder: (context) {
          // Home tab: never reserve login keyboard inset (IndexedStack keeps all tabs alive).
          var mq = MediaQuery.of(context);
          if (index == 0) {
            mq = mq.copyWith(
              viewInsets: mq.viewInsets.copyWith(bottom: 0),
            );
          }
          return MediaQuery(
            data: mq,
            child: ValueListenableBuilder<int>(
              valueListenable: OrgSwitchCoordinator.notifier,
              builder: (context, orgVersion, _) {
                return IndexedStack(
                  index: index,
                  children: _buildTabs(orgVersion),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: hideShellChrome
          ? const SizedBox.shrink()
          : _MainNotchedNav.bar(
              context,
              index,
              onTabSelected: _selectShellTab,
            ),
    );
  }

  PreferredSizeWidget _buildStatisticsAppBar() {
    final scheme = Theme.of(context).colorScheme;
    final shellBackground = scheme.surfaceContainerLow;

    return AppBar(
      title: AppBrandName(
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
      ),
      centerTitle: true,
      backgroundColor: shellBackground,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: BlocBuilder<EmployeeCubit, EmployeeState>(
          builder: (context, state) {
            return state.maybeWhen(
              employeeDetail: (employee) {
                final firstLetter = employee.firstName.isNotEmpty
                    ? employee.firstName[0].toUpperCase()
                    : 'U';

                return GestureDetector(
                  onTap: () {
                    currentIndex.value = 4;
                  },
                  child: Transform.scale(
                    scale: 0.9,
                    child: EmployeeProfileAvatar(
                      profileImage: employee.profileImage,
                      initial: firstLetter,
                      radius: 18,
                      backgroundColor: context.theme.colorScheme.primary,
                      initialStyle: AppFonts.interStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
              orElse: () => CircleAvatar(
                radius: 18,
                backgroundColor: scheme.surfaceContainerHighest,
                child: Icon(
                  Icons.person,
                  color: scheme.onSurfaceVariant,
                  size: 20,
                ),
              ),
            );
          },
        ),
      ),
      actions: const [],
    );
  }
}

/// Main shell bottom nav: Home · Sales · Expenses · Parties · More.
class _MainNotchedNav {
  _MainNotchedNav._();

  static const _items = [
    NotchedNavTab(
      index: 0,
      icon: Iconsax.home_1,
      activeIcon: Iconsax.home_1_copy,
      label: 'Home',
    ),
    NotchedNavTab(
      index: 1,
      icon: Iconsax.chart_1,
      activeIcon: Iconsax.chart_1_copy,
      label: 'Sales',
    ),
    NotchedNavTab(
      index: 2,
      icon: Iconsax.shopping_cart,
      activeIcon: Iconsax.shopping_cart_copy,
      label: 'Expenses',
    ),
    NotchedNavTab(
      index: 3,
      icon: Iconsax.people,
      activeIcon: Iconsax.people_copy,
      label: 'Parties',
    ),
    NotchedNavTab(
      index: 4,
      icon: Iconsax.element_4,
      activeIcon: Iconsax.element_4_copy,
      label: 'More',
    ),
  ];

  static Widget bar(
    BuildContext context,
    int index, {
    required ValueChanged<int> onTabSelected,
  }) {
    return NotchedBottomNavBar(
      currentIndex: index,
      onTabSelected: onTabSelected,
      items: _items,
    );
  }
}
