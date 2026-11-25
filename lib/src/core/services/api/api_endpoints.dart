/// Offline builds do not call a server. Names stay so existing data sources compile.
class ApiEndPoints {
  const ApiEndPoints._();

  static const String _none = '';

  static String updateInvoiceSales = _none;
  static String updateInvoicePurchase = _none;
  static String previousStockBulkEdit = _none;
  static String invoiceSales = _none;
  static String invoicePurchase = _none;
  static String party = _none;
  static String reconcileParty = _none;
  static String itemCounter = _none;
  static String dashboardSummaryPage = _none;
  static String login = _none;
  static const String setupComplete = _none;

  static String orgByCode(String code) => _none;
  static const String userPermissions = _none;
  static String hotelSales = _none;
  static const String reconciliationUpload = _none;
  static const String reconciliationGenerateReport = _none;
  static const String reconciliationDirectReport = _none;
  static const String employeeOutstanding = _none;
  static const String employeeAdvance = _none;
  static const String settlement = _none;
  static const String partialSettlement = _none;
  static const String previousStock = _none;
  static const String previousStockDetails = _none;
  static const String previousStockDeleteByDate = _none;

  static const String categories = _none;
  static const String item = _none;
  static const String itemBulkCreate = _none;
  static const String createItem = _none;
  static const String updateItem = _none;
  static const String itemBulkOperations = _none;
  static const String updateParty = _none;
  static const String stockAdjustment = _none;
  static const String fetchItem = _none;
  static const String clientToServer = _none;
  static const String serverToClient = _none;
  static const String paymentAnalytics = _none;
  static const String payments = _none;
  static const String hotelSummary = _none;
  static const String liquorItems = _none;
  static const String liquorPricing = _none;
  static const String fileCreationDetails = _none;
  static const String invoiceDates = _none;
  static const String createInvoiceSales = _none;
  static const String createInvoicePurchase = _none;
  static const String createExpense = _none;

  static const String createEmployeeTables = _none;
  static const String createLeaveTables = _none;

  static const String employees = _none;
  static String employeeById(int id) => _none;

  static const String attendance = _none;
  static String attendanceById(int id) => _none;

  static const String payroll = _none;
  static String payrollById(int id) => _none;

  static const String leaveApplications = _none;
  static String leaveApplicationById(int id) => _none;
  static String approveLeaveApplication(int id) => _none;
  static const String leaveBalances = _none;
  static const String leaveBalance = _none;
  static const String leaveTypes = _none;

  static const String contactBook = _none;

  static const String orderOrders = _none;
  static const String orderDashboard = _none;

  static String orderDetail(String orderName) => _none;
  static String orderActivity(String orderName) => _none;
  static String orderStatusUpdate(String orderName) => _none;
  static String orderCheckout(String orderName) => _none;
  static String orderQotUpdate(String orderName, String qotName) => _none;
  static String orderQotStatusUpdate(String orderName, String qotName) => _none;
  static String orderItemStatusUpdate(String orderName, String itemLineName) => _none;
  static String orderItemUpdate(String orderName, String itemLineName) => _none;
  static String orderPartyOrders(String partyName) => _none;
  static String orderTableOrders(String tableNumber) => _none;

  static const String cashRegister = _none;
  static const String cashRegisterMigrate = _none;
  static const String cashMovement = _none;

  static const String reports = _none;
  static const String dashboard = _none;
  static const String attendanceReport = _none;
  static const String payrollReport = _none;
  static const String leaveReport = _none;
  static const String pnlUnified = _none;
  static const String cashBankUnified = _none;
  static const String analyticsUnified = _none;

  static const String paymentMethodsList = _none;
  static String paymentMethodByName(String name) => _none;

  static const String accountingSettings = _none;

  static const String salesReturn = _none;
  static const String purchaseReturn = _none;
  static String salesReturnCheck(String invoiceName) => _none;
  static String purchaseReturnCheck(String invoiceName) => _none;
  static const String salesReturnCancel = _none;
  static const String purchaseReturnCancel = _none;
}

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
