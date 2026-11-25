import 'dart:async';

import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/l10n/app_locale_service.dart';
import 'package:hotel/src/core/services/display_precision/app_display_precision_service.dart';
import 'package:hotel/src/core/themes/app_theme_mode_service.dart';
import 'package:hotel/src/core/services/notifications/shift_notification_service.dart';
import 'package:hotel/src/features/backup/domain/auto_backup_coordinator.dart';
import 'package:hotel/src/core/services/notifications/shift_reminder_monitor.dart';
import 'package:hotel/src/core/helpers/logged_in_profile_store.dart';
import 'package:hotel/src/core/helpers/app_route_observer.dart';
import 'package:hotel/src/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/themes/app_theme.dart';
import 'package:hotel/src/core/widget/keyboard_insets_clamp.dart';
import 'package:hotel/src/core/widget/keyboard_resume_observer.dart';
import 'package:hotel/src/features/app_lock/presentation/widgets/app_lock_gate.dart';
import 'package:hotel/src/features/action/presentation/cubit/item_cubit.dart';
import 'package:hotel/src/features/action/presentation/cubit/party_cubit.dart';
import 'package:hotel/src/features/category/presentation/cubit/category_cubit.dart';
import 'package:hotel/src/features/action/presentation/cubit/payment_analytics_cubit.dart';
import 'package:hotel/src/features/action/presentation/cubit/payment_cubit.dart';
import 'package:hotel/src/features/closing/presentation/bloc/hotel_summary_cubit.dart';
import 'package:hotel/src/features/contact_book/presentation/cubit/contact_cubit.dart';
import 'package:hotel/src/features/dashboard/presentation/bloc/client_to_server_cubit.dart';
import 'package:hotel/src/features/dashboard/presentation/bloc/dashboard_summary_page_cubit.dart';
import 'package:hotel/src/features/dashboard/presentation/bloc/hotel_sales_cubit.dart';
import 'package:hotel/src/features/dashboard/presentation/bloc/server_to_client_cubit.dart';
import 'package:hotel/src/features/employee/presentation/bloc/employee_advance_cubit.dart';
import 'package:hotel/src/features/employee/presentation/bloc/employee_outstanding_cubit.dart';
import 'package:hotel/src/features/employee_management/presentation/bloc/attendance_cubit.dart';
import 'package:hotel/src/features/employee_management/presentation/bloc/employee_cubit.dart';
import 'package:hotel/src/features/employee_management/presentation/bloc/payroll_cubit.dart';
import 'package:hotel/src/features/file_creation/file_creation.dart';
import 'package:hotel/src/features/hotel_summary/presentation/cubit/daily_cash_summary_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/bloc/filter/filter_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/bloc/login/invoice_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/bloc/login/invoice_purchase_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/cubit/accounting_settings_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/delete_invoice/delete_invoice_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/invoice_dates/invoice_dates_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/cubits/update_invoice/update_invoice_cubit.dart';
import 'package:hotel/src/features/liquor/liquor.dart';
import 'package:hotel/src/features/login/presentation/bloc/login_cubit.dart';
import 'package:hotel/src/features/org/presentation/cubit/org_lookup_cubit.dart';
import 'package:hotel/src/features/other/presentation/bloc/item_counter_cubit.dart';
import 'package:hotel/src/features/payment_methods/presentation/cubit/payment_method_manage_cubit.dart';
import 'package:hotel/src/features/payment_methods/presentation/cubit/payment_methods_cubit.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_cubit.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_delete_cubit.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_details_cubit.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_edit_cubit.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/reconciliation_direct_report_cubit.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/reconciliation_report_cubit.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/reconciliation_upload_cubit.dart';
import 'package:hotel/src/features/settlement/presentation/bloc/partial_settlement_cubit.dart';
import 'package:hotel/src/features/settlement/presentation/cubit/settlement_cubit.dart';
import 'package:hotel/src/features/stock_adjustment/presentation/bloc/stock_adjustment_cubit.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:hotel/src/features/party/presentation/bloc/party_cubit.dart' as pt;
import 'package:hotel/src/features/permission/presentation/cubit/user_permissions_cubit.dart';

final talker = TalkerFlutter.init();

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final router = getIt<AppRouter>();
  final _localeService = getIt<AppLocaleService>();
  final _themeModeService = getIt<AppThemeModeService>();
  final _displayPrecisionService = getIt<AppDisplayPrecisionService>();
  final _shiftReminderMonitor = getIt<ShiftReminderMonitor>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _localeService.load();
    _shiftReminderMonitor.start();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notificationService = getIt<ShiftNotificationService>();
      await notificationService.initialize();
      await notificationService.requestNotificationPermissionIfNeeded();
      await notificationService.handlePendingLaunchAction();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _shiftReminderMonitor.stop();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _shiftReminderMonitor.onAppResumed();
      unawaited(getIt<AutoBackupCoordinator>().maybeRunOnAppResume());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<InvoiceCubit>()),
        BlocProvider(
          create: (context) => getIt<FilterCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<PartyCubit>(),
        ),
        // BlocProvider(
        //   create: (context) => getIt<DashboardSummaryPageCubit>(),
        // ),
        BlocProvider(
          create: (context) => getIt<ItemCounterCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<LoginCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<HotelSalesCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ReconciliationUploadCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<InvoicePurchaseCubit>(),
        ),
        BlocProvider<FilterCubit>(create: (context) => getIt<FilterCubit>()),
        BlocProvider<PartyCubit>(create: (context) => getIt<PartyCubit>()),
        BlocProvider<EmployeeOutstandingCubit>(create: (context) => getIt<EmployeeOutstandingCubit>()),
        BlocProvider<EmployeeAdvanceCubit>(create: (context) => getIt<EmployeeAdvanceCubit>()),
        BlocProvider<PreviousStockCubit>(create: (context) => getIt<PreviousStockCubit>()),
        BlocProvider<ReconciliationReportCubit>(create: (context) => getIt<ReconciliationReportCubit>()),
        BlocProvider<ItemCubit>(create: (context) => getIt<ItemCubit>()),
        BlocProvider<CategoryCubit>(create: (context) => getIt<CategoryCubit>()),
        BlocProvider<StockAdjustmentCubit>(create: (context) => getIt<StockAdjustmentCubit>()),
        BlocProvider<SettlementCubit>(create: (context) => getIt<SettlementCubit>()),
        BlocProvider<ReconciliationDirectReportCubit>(create: (context) => getIt<ReconciliationDirectReportCubit>()),
        BlocProvider<PartyCubit>(create: (context) => getIt<PartyCubit>()),
        BlocProvider<ClientToServerCubit>(create: (context) => getIt<ClientToServerCubit>()),
        BlocProvider<PartialSettlementCubit>(create: (context) => getIt<PartialSettlementCubit>()),
        BlocProvider<ServerToClientCubit>(create: (context) => getIt<ServerToClientCubit>()),
        BlocProvider<PaymentAnalyticsCubit>(create: (context) => getIt<PaymentAnalyticsCubit>()),
        BlocProvider<PaymentCubit>(create: (context) => getIt<PaymentCubit>()),
        BlocProvider<LiquorCubit>(create: (context) => getIt<LiquorCubit>()),
        BlocProvider<FileCreationCubit>(create: (context) => getIt<FileCreationCubit>()),
        BlocProvider<HotelSummaryCubit>(create: (context) => getIt<HotelSummaryCubit>()),
        // BlocProvider<UpdateInvoiceCubit>(create: (context) => getIt<UpdateInvoiceCubit>()),
        BlocProvider<InvoiceDatesCubit>(create: (context) => getIt<InvoiceDatesCubit>()),
        BlocProvider<DailyCashSummaryCubit>(create: (context) => getIt<DailyCashSummaryCubit>()),
        BlocProvider<PreviousStockDetailsCubit>(create: (context) => getIt<PreviousStockDetailsCubit>()),
        BlocProvider<PreviousStockEditCubit>(create: (context) => getIt<PreviousStockEditCubit>()),
        BlocProvider<PreviousStockDeleteCubit>(create: (context) => getIt<PreviousStockDeleteCubit>()),
        BlocProvider<UpdateInvoiceCubit>(create: (context) => getIt<UpdateInvoiceCubit>()),
        BlocProvider<DeleteInvoiceCubit>(create: (context) => getIt<DeleteInvoiceCubit>()),
        BlocProvider<EmployeeCubit>(
          create: (context) {
            final cubit = getIt<EmployeeCubit>();
            loggedInProfileStore.bindAppEmployeeCubit(cubit);
            return cubit;
          },
        ),
        // BlocProvider<PayrollCubit>(create: (context) => getIt<PayrollCubit>()),
        BlocProvider<pt.PartyCubit>(create: (context) => getIt<pt.PartyCubit>()),
        BlocProvider<AttendanceCubit>(create: (context) => getIt<AttendanceCubit>()),
        BlocProvider<UserPermissionsCubit>(create: (context) => getIt<UserPermissionsCubit>()),
        BlocProvider<PaymentMethodsCubit>(create: (context) => getIt<PaymentMethodsCubit>()),
        BlocProvider<ContactCubit>(create: (context) => getIt<ContactCubit>()),
        BlocProvider<AccountingSettingsCubit>(create: (context) => getIt<AccountingSettingsCubit>()),
        BlocProvider<OrgLookupCubit>(create: (context) => getIt<OrgLookupCubit>()),
        BlocProvider<PaymentMethodManageCubit>(create: (context) => getIt<PaymentMethodManageCubit>()),

      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return ListenableBuilder(
            listenable: Listenable.merge([
              _localeService,
              _themeModeService,
              _displayPrecisionService,
            ]),
            builder: (context, _) {
              return KeyboardInsetsClamp(
                child: MaterialApp.router(
              locale: _localeService.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routerDelegate: router.delegate(
                navigatorObservers: () => [AppRouteObserver()],
              ),
              routeInformationParser: router.defaultRouteParser(),
              scaffoldMessengerKey: scaffoldKey,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightThemeData,
              darkTheme: AppTheme.darkThemeData,
              themeMode: _themeModeService.themeMode,
              // locale: localeState.selectedLanguage,
              builder: (context, child) => DefaultTextStyle(
                style: AppFonts.interStyle(),
                child: TalkerWrapper(
                  talker: talker,
                  child: AppLockGate(
                    child: KeyboardResumeObserver(child: child!),
                  ),
                ),
              ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
