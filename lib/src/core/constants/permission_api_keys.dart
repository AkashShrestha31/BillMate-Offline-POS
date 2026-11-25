/// API `featureName` / `permissionKey` strings used for UI checks.
abstract final class PermissionApiKeys {
  static const monthRevenue = 'month_revenue';
  static const monthExpenses = 'month_expenses';
  static const salesInvoice = 'sales_invoice';
  static const purchaseInvoice = 'purchase_invoice';

  /// Home “Quick Expenses” / “Quick Sales” tiles (see API `featureName`).
  static const quickExpenses = 'quick_expenses';
  static const quickSales = 'quick_sales';

  static const read = 'read';
  static const create = 'create';

  /// Used by API for `quick_expenses` (and expected for `quick_sales` when added).
  static const show = 'show';

  /// Dashboard cashflow chart (`featureName` / `permissionKey` from API).
  static const graph = 'graph';
  static const cashflowShow = 'cashflow-show';

  /// Explore Features (`permissionKey` is usually `show`).
  static const closing = 'closing';
  static const reconciliation = 'reconciliation';
  static const calculator = 'calculator';
  static const opening = 'opening';

  /// Inventory module (`featureName` from API); Explore tile uses `show` (e.g. “Show Inventory”).
  static const inventoryManagement = 'inventory_management';

  /// Kitchen / table orders (`featureName` from API); Explore tile uses `show`.
  static const order = 'order';
}
