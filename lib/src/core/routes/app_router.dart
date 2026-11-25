import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/token_storage.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter implements AutoRouteGuard {
  @override
  RouteType get defaultRouteType => RouteType.custom(
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    durationInMilliseconds: 300,
  );

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: StartupSplashRoute.page,
    ),
    AutoRoute(
      path: '/language-selection',
      page: LanguageSelectionRoute.page,
    ),
    AutoRoute(
      path: '/walkthrough',
      page: AppWalkthroughRoute.page,
    ),
    AutoRoute(
      path: '/local-setup',
      page: LocalSetupRoute.page,
    ),
    AutoRoute(
      path: '/organization',
      page: OrganizationCodeRoute.page,
    ),
    AutoRoute(
      path: '/main',
      page: MainRoute.page,
      guards: [AuthGuard()],
    ),
    AutoRoute(page: InvoiceRouteWrapper.page, path: '/invoice', children: [
      RedirectRoute(path: '', redirectTo: 'invoice'),
    ]),
    AutoRoute(path: '/party-invoice', page: PartyInvoiceRoute.page),
    AutoRoute(path: '/party-invoice-tabbed', page: PartyInvoiceTabbedRoute.page),
    AutoRoute(path: '/liquor-price', page: LiquorPriceRoute.page),
    AutoRoute(path: '/inventory-count', page: InventoryDashboardRoute.page),
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/premium', page: PremiumPaywallRoute.page),
    AutoRoute(path: '/Sales-dashboard', page: LoginRoute.page),
    AutoRoute(path: '/Sales-details', page: HotelSalesRoute.page),
    AutoRoute(path: '/hotel-summary', page: HotelSummaryRoute.page),
    AutoRoute(path: '/edit-product', page: EditProductRoute.page),
    AutoRoute(path: '/add-product', page: AddProductRoute.page),
    AutoRoute(path: '/product-settings', page: ProductSettingsRoute.page),
    AutoRoute(path: '/daily-cash', page: DailyCashSummaryRoute.page),
    AutoRoute(path: '/create-daily-cash', page: CreateDailyCashSummaryRoute.page),
    AutoRoute(path: '/invoice-edit-page', page: InvoiceEditRoute.page),
    AutoRoute(path: '/invoice-details-page', page: InvoiceDetailsRoute.page),
    AutoRoute(path: '/create-invoice-page', page: CreateInvoiceRoute.page),
    AutoRoute(path: '/add-expense-page', page: AddExpenseRoute.page),
    AutoRoute(path: '/opening-amount-page', page: OpeningAmountRoute.page),
    AutoRoute(path: '/item-details', page: ItemDetailsRoute.page),
    AutoRoute(path: '/item-edit-details', page: ItemEditRoute.page),
    AutoRoute(path: '/bulk-add-items', page: BulkAddItemsRoute.page),
    AutoRoute(path: '/floor-plan', page: RestaurantFloorPlanRoute.page),
    AutoRoute(path: '/previous-stock', page: PreviousStockRoute.page),
    AutoRoute(path: '/previous-stock-details', page: PreviousStockDetailsRoute.page),
    AutoRoute(path: '/employee-dashboard', page: EmployeeDashboardRoute.page),
    AutoRoute(path: '/employee-form', page: EmployeeFormRoute.page),
    AutoRoute(path: '/party-details', page: PartyDetailsRoute.page),
    AutoRoute(path: '/party-edit', page: PartyEditRoute.page),
    AutoRoute(path: '/party-statement', page: PartyStatementRoute.page),
    AutoRoute(path: '/payroll-list', page: PayrollListRoute.page),
    AutoRoute(path: '/payroll-detail', page: PayrollDetailRoute.page),
    AutoRoute(path: '/generate-payroll', page: GeneratePayrollRoute.page),
    AutoRoute(path: '/stock-upload', page: StockUploadRoute.page),
    AutoRoute(path: '/more-page', page: MoreRoute.page),
    AutoRoute(path: '/contacts', page: ContactListRoute.page),
    AutoRoute(path: '/contact-form', page: ContactFormRoute.page),
    AutoRoute(path: '/categories', page: CategoriesListRoute.page),
    AutoRoute(path: '/payment-methods', page: PaymentMethodsListRoute.page),
    AutoRoute(path: '/quick-add-items', page: QuickAddItemsRoute.page),
    AutoRoute(path: '/order-check-in', page: OrderCheckInRoute.page),
    AutoRoute(path: '/order-kot-review', page: OrderKotReviewRoute.page),
    AutoRoute(path: '/order', page: OrderRoute.page),
    AutoRoute(path: '/order-detail', page: OrderDetailRoute.page),
    AutoRoute(path: '/order-qot-hub', page: OrderQotHubRoute.page),
  ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    log('We are navigating to ${router.current.path}');
    resolver.next(true);
  }
}

void navigateBackCount(BuildContext context, int pages) {
  int popCount = 0;
  context.router.popUntil((route) {
    popCount++;
    return popCount > pages;
  });
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (await TokenStorage.hasActiveSession()) {
      resolver.next(true);
    } else {
      router.replace(const LoginRoute());
    }
  }
}