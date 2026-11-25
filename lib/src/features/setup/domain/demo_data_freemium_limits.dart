import 'package:hotel/src/core/config/app_freemium_config.dart';

/// Caps offline demo/test-data volume to match the free plan on billed platforms.
abstract final class DemoDataFreemiumLimits {
  static bool get applyFreeTierCap => AppFreemiumConfig.enabled;

  static int _capped(int freeValue, int defaultValue) =>
      applyFreeTierCap ? freeValue : defaultValue;

  static int get maxSalesInvoices =>
      _capped(AppFreemiumConfig.salesInvoiceLimit, 20);

  static int get maxPurchaseInvoices =>
      _capped(AppFreemiumConfig.purchaseInvoiceLimit, 20);

  static int get maxEmployees =>
      _capped(AppFreemiumConfig.employeeLimit, 12);

  static int get maxPartiesPerRole =>
      _capped(AppFreemiumConfig.partyPerRoleLimit, 20);

  static int get maxOtherPartiesPerRole =>
      _capped(AppFreemiumConfig.partyOtherRoleLimit, 20);

  static int get maxItems => _capped(AppFreemiumConfig.itemLimit, 100);

  static int get maxSalesItems =>
      applyFreeTierCap ? (maxItems / 2).ceil().clamp(1, maxItems) : 50;

  static int get maxPurchaseItems =>
      applyFreeTierCap ? (maxItems - maxSalesItems).clamp(0, maxItems) : 50;

  static int get maxCategories =>
      _capped(AppFreemiumConfig.categoryLimit, 15);

  static int get maxContacts => applyFreeTierCap ? 10 : 50;

  static int get maxAttendance => applyFreeTierCap ? 20 : 50;

  static int get maxStockRows => applyFreeTierCap ? 10 : 30;

  static int get maxLedgerRows => applyFreeTierCap ? 12 : 35;

  /// Extra demo orgs in the switcher. Demo data always stays on the one
  /// active organization — never provisions additional isolated books.
  static int get extraOrganizations => 0;

  static int get minPartiesForCompleteDemo =>
      applyFreeTierCap ? maxPartiesPerRole.clamp(1, 5) : 5;
}
