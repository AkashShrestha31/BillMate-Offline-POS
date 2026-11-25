class ApiEndPoints {
  const ApiEndPoints._();
  static String updateInvoiceSales = "api/hotel/api/sales-invoices/";
  static String updateInvoicePurchase = "api/hotel/api/purchase-invoices/";
  static String previousStockBulkEdit = "api/hotel/previous-stock/bulk-edit/";
  static String invoiceSales = "api/hotel/fetch-sales-items-invoice/";
  static String invoicePurchase = "api/hotel/fetch-purchase-items-invoice/";
  static String party = "api/hotel/api/parties/";
  static String reconcileParty = "api/hotel/api/parties/reconcile-outstanding/";
  static String itemCounter = "api/hotel/api/item-counts/";
  static String dashboardSummaryPage = "api/hotel/dashboard-summary/";
  static String login = "api/user/api/token/";
  static const String setupComplete = 'api/setup/complete/';

  /// `GET` — resolve tenant by organization code (pre-login).
  static String orgByCode(String code) => 'api/user/org/$code/';
  /// `GET` — query `user_id` (email or id from JWT).
  static const String userPermissions = 'api/permission/user-permissions';
  static String hotelSales = "api/hotel/sales-expenses/";
  static const String reconciliationUpload =
      'api/hotel/stock-reconciliation/upload/';
  static const String reconciliationGenerateReport =
      'api/hotel/stock-reconciliation/reconcile/';
  static const String reconciliationDirectReport =
      'api/hotel/stock-direct/reconcile/';
  static const String employeeOutstanding = 'api/hotel/parties/search';
  // static const String employeeAdvance = 'api/hotel/api/purchase-analysis/items';
  static const String employeeAdvance = 'api/hotel/api/employees/advance-analysis';
  static const String settlement = 'api/hotel/api/party/bulk-settle-payments/';
  static const String partialSettlement = 'api/hotel/api/party/partial-settle-payment/';
  static const String previousStock = 'api/hotel/api/reporting-dates/';
  static const String previousStockDetails = 'api/hotel/previous-stock/';
  static const String previousStockDeleteByDate =
      'api/hotel/previous-stock/delete-by-date/';


  static const String categories = 'api/hotel/api/items/category/';
  static const String item = 'api/hotel/api/items/';
  static const String itemBulkCreate = 'api/hotel/api/items/bulk-create/';
  static const String createItem = 'api/hotel/api/items/create/';
  static const String updateItem = 'api/hotel/api/items/update-name/';
  static const String itemBulkOperations = 'api/hotel/api/item/bulk-operations/';
  static const String updateParty = 'api/hotel/api/party/update-name/';
  static const String stockAdjustment =
      'api/hotel/api/stock-adjustment/manual/';
  static const String fetchItem = 'api/hotel/api/stock-adjustment/manual/';
  static const String clientToServer = 'api/v1/client-to-server/';
  static const String serverToClient = 'api/v1/files/server-to-client/';
  static const String paymentAnalytics = 'api/hotel/api/purchase-invoices/analytics/reports/';
  static const String payments = 'api/hotel/api/payment/edit/';
  static const String hotelSummary = 'api/hotel/api/payment/summary/';
  static const String liquorItems = 'api/hotel/api/liquor/items/';
  static const String liquorPricing = '/api/hotel/api/liquor/pricing/';
  static const String fileCreationDetails = 'api/hotel/api/file-creation-time/';
  static const String invoiceDates = 'api/hotel/invoice-dates/';
  static const String createInvoiceSales = 'api/hotel/api/sales-invoices/';
  static const String createInvoicePurchase = 'api/hotel/api/purchase-invoices/';
  static const String createExpense = 'api/hotel/api/expenses/';

  // Database Setup
  static const String createEmployeeTables = 'create-employee-tables/';
  static const String createLeaveTables = 'create-leave-tables/';

  // Employee Management
  static const String employees = 'api/employee-management/employees/';
  static String employeeById(int id) => 'api/employee-management/employees/$id/';

  // Attendance Management
  static const String attendance = 'api/employee-management/attendance/';
  static String attendanceById(int id) => 'api/employee-management/attendance/?attendance_id=$id';

  // Payroll Management
  static const String payroll = 'api/employee-management/payroll/';
  static String payrollById(int id) => 'api/employee-management/payroll/$id/';

  // Leave Management
  static const String leaveApplications = 'api/employee-management/leave/applications/';
  static String leaveApplicationById(int id) => 'api/employee-management/leave/applications/$id/';
  static String approveLeaveApplication(int id) => 'api/employee-management/leave/applications/$id/approve/';
  static const String leaveBalances = 'api/employee-management/leave-balances/';
  static const String leaveBalance = 'api/employee-management/leave/balance/';
  static const String leaveTypes = 'api/employee-management/leave-types/';

  // Contact Book
  static const String contactBook = 'api/contacts/contact-book/';

  /// Order API (`hotel-royal-backend` order app). List/create: `GET|POST /api/order/orders/`.
  static const String orderOrders = 'api/order/orders/';
  /// Dashboard aggregates: `GET /api/order/orders/dashboard/`
  static const String orderDashboard = 'api/order/orders/dashboard/';

  /// `GET|PUT|DELETE /api/order/orders/<name>/`
  static String orderDetail(String orderName) =>
      'api/order/orders/${Uri.encodeComponent(orderName)}/';

  /// `GET /api/order/orders/<name>/activity/`
  static String orderActivity(String orderName) =>
      'api/order/orders/${Uri.encodeComponent(orderName)}/activity/';

  /// `PATCH /api/order/orders/<name>/status/`
  static String orderStatusUpdate(String orderName) =>
      'api/order/orders/${Uri.encodeComponent(orderName)}/status/';

  /// `POST /api/order/orders/<name>/checkout/` — complete order, invoice, payments.
  static String orderCheckout(String orderName) =>
      'api/order/orders/${Uri.encodeComponent(orderName)}/checkout/';

  /// `PATCH /api/order/orders/<name>/qots/<qot>/` — [notes], [assigned_to] (per QOT).
  static String orderQotUpdate(String orderName, String qotName) =>
      'api/order/orders/${Uri.encodeComponent(orderName)}/qots/${Uri.encodeComponent(qotName)}/';

  /// `PATCH /api/order/orders/<name>/qots/<qot>/status/`
  static String orderQotStatusUpdate(String orderName, String qotName) =>
      'api/order/orders/${Uri.encodeComponent(orderName)}/qots/${Uri.encodeComponent(qotName)}/status/';

  /// `PATCH /api/order/orders/<order>/items/<line_name>/status/`
  /// [itemLineName] is the **order line row id** (`name` in JSON, e.g. `ab12cd-ef345678`), not the menu [item] label.
  static String orderItemStatusUpdate(String orderName, String itemLineName) =>
      'api/order/orders/${Uri.encodeComponent(orderName)}/items/${Uri.encodeComponent(itemLineName)}/status/';

  /// `PATCH /api/order/orders/<order>/items/<line_name>/` — line [itemLineName] is JSON `name`.
  static String orderItemUpdate(String orderName, String itemLineName) =>
      'api/order/orders/${Uri.encodeComponent(orderName)}/items/${Uri.encodeComponent(itemLineName)}/';

  /// `GET /api/order/orders/party/<party_name>/`
  static String orderPartyOrders(String partyName) =>
      'api/order/orders/party/${Uri.encodeComponent(partyName)}/';

  /// `GET /api/order/orders/table/<table_number>/`
  static String orderTableOrders(String tableNumber) =>
      'api/order/orders/table/${Uri.encodeComponent(tableNumber)}/';

  // Cash Register / Opening (multi-shift)
  static const String cashRegister = 'api/hotel/cash-register/';
  static const String cashRegisterMigrate = 'api/hotel/cash-register/migrate/';
  static const String cashMovement = 'api/hotel/cash-movement/';

  // Reporting & Analytics
  static const String reports = 'api/employee-management/reports/';
  static const String dashboard = '$reports?report_type=dashboard';
  static const String attendanceReport = '$reports?report_type=attendance';
  static const String payrollReport = '$reports?report_type=payroll';
  static const String leaveReport = '$reports?report_type=leave';
  static const String pnlUnified = 'api/analytics/pnl/unified';
  static const String cashBankUnified = 'api/analytics/cash-bank/unified/';
  static const String analyticsUnified = 'api/analytics/unified/';

  /// `GET /api/analytics/payment-methods/` — list payment modes (optional `q`, `type`).
  static const String paymentMethodsList = 'api/analytics/payment-methods/';

  static String paymentMethodByName(String name) =>
      'api/analytics/payment-methods/${Uri.encodeComponent(name)}/';

  /// Accounting settings (`enable_invoice_returns`, etc.).
  static const String accountingSettings = 'api/analytics/settings/';

  static const String salesReturn = 'api/hotel/api/sales-return/';
  static const String purchaseReturn = 'api/hotel/api/purchase-return/';
  static String salesReturnCheck(String invoiceName) =>
      'api/hotel/api/sales-return/${Uri.encodeComponent(invoiceName)}/';
  static String purchaseReturnCheck(String invoiceName) =>
      'api/hotel/api/purchase-return/${Uri.encodeComponent(invoiceName)}/';
  static const String salesReturnCancel = 'api/hotel/api/sales-return/cancel/';
  static const String purchaseReturnCancel = 'api/hotel/api/purchase-return/cancel/';
}

// Employee Status Enums
enum EmploymentType {
  fullTime('FULL_TIME'),
  partTime('PART_TIME'),
  contract('CONTRACT'),
  intern('INTERN');

  const EmploymentType(this.value);
  final String value;
}

enum EmploymentStatus {
  active('ACTIVE'),
  inactive('INACTIVE'),
  terminated('TERMINATED'),
  resigned('RESIGNED');

  const EmploymentStatus(this.value);
  final String value;
}

enum AttendanceStatus {
  present('PRESENT'),
  absent('ABSENT'),
  late('LATE'),
  halfDay('HALF_DAY'),
  sickLeave('SICK_LEAVE'),
  vacation('VACATION'),
  holiday('HOLIDAY');

  const AttendanceStatus(this.value);
  final String value;
}

enum PaymentStatus {
  pending('PENDING'),
  paid('PAID'),
  cancelled('CANCELLED');

  const PaymentStatus(this.value);
  final String value;
}

enum LeaveStatus {
  pending('PENDING'),
  approved('APPROVED'),
  rejected('REJECTED'),
  cancelled('CANCELLED');

  const LeaveStatus(this.value);
  final String value;
}

