import 'package:json_annotation/json_annotation.dart';

part 'hotel_summary_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HotelSummaryResponseModel {
  final bool success;
  final String queryDate;
  final SalesSummary summary;
  final List<SalesInvoice> salesList;
  final List<CreditPayment> creditList;
  final List<PurchaseInvoice> purchaseList;

  HotelSummaryResponseModel({
    required this.success,
    required this.queryDate,
    required this.summary,
    required this.salesList,
    required this.creditList,
    required this.purchaseList,
  });

  factory HotelSummaryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HotelSummaryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelSummaryResponseModelToJson(this);

  // Helper methods for analytics
  double get totalRevenue => summary.totalSales.toDouble();
  double get netProfit => totalRevenue - summary.totalExpenses;
  double get profitMargin => totalRevenue > 0 ? (netProfit / totalRevenue) * 100 : 0;
  bool get isProfitable => netProfit > 0;
  int get totalTransactions => salesList.length;
  double get averageTransactionValue => totalTransactions > 0 ? totalRevenue / totalTransactions : 0;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SalesSummary {
  final int openingBalance;
  final int totalSales;
  final int salesQrAmount;
  final int salesTransferAmount;
  final int salesCashAmount;
  final int totalDiscount;
  final int totalExpenses;
  final int totalExpensesQr;
  final int totalExpensesTransfer;
  final int totalExpensesCash;
  final int unpaidAmount;
  final int creditCash;
  final int creditQr;
  final int lostAmount;
  final int extraAmount;
  final int creditDiscount;
  final int closingBalance;
  final double? payCashGetQrExchange;
  final double? payQrGetCashExchange;

  SalesSummary({
    required this.openingBalance,
    required this.totalSales,
    required this.salesQrAmount,
    required this.salesTransferAmount,
    required this.salesCashAmount,
    required this.totalDiscount,
    required this.totalExpenses,
    required this.totalExpensesQr,
    required this.totalExpensesTransfer,
    required this.totalExpensesCash,
    required this.unpaidAmount,
    required this.creditCash,
    required this.creditQr,
    required this.lostAmount,
    required this.extraAmount,
    required this.creditDiscount,
    required this.closingBalance,
    required this.payCashGetQrExchange,
    required this.payQrGetCashExchange,
  });

  factory SalesSummary.fromJson(Map<String, dynamic> json) =>
      _$SalesSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$SalesSummaryToJson(this);

  // Helper methods for calculations
  double get cashPercentage => totalSales > 0 ? (salesCashAmount / totalSales) * 100 : 0;
  double get qrPercentage => totalSales > 0 ? (salesQrAmount / totalSales) * 100 : 0;
  double get discountPercentage => totalSales > 0 ? (totalDiscount / totalSales) * 100 : 0;
  int get totalPayments => salesCashAmount + salesQrAmount;
  int get totalCredit => creditCash + creditQr;
  double get expenseRatio => totalSales > 0 ? (totalExpenses / totalSales) * 100 : 0;
  bool get hasUnpaidAmount => unpaidAmount > 0;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SalesInvoice {
  final String id;
  final String party;
  final String date;
  final int totalAmount;
  final int totalAmountWithDiscount;
  final int discountAmount;
  final List<PaymentDetail> paymentDetails;

  SalesInvoice({
    required this.id,
    required this.party,
    required this.date,
    required this.totalAmount,
    required this.totalAmountWithDiscount,
    required this.discountAmount,
    required this.paymentDetails,
  });

  factory SalesInvoice.fromJson(Map<String, dynamic> json) =>
      _$SalesInvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$SalesInvoiceToJson(this);

  // Helper methods
  bool get isPaid => paymentDetails.isNotEmpty;
  bool get hasDiscount => discountAmount > 0;
  double get discountPercentage => totalAmount > 0 ? (discountAmount / totalAmount) * 100 : 0;
  int get totalPaidAmount => paymentDetails.fold<int>(0, (sum, payment) => sum + payment.paymentAmount);
  bool get isEmployee => party.toLowerCase().contains('employee');
  bool get isRoom => party.toLowerCase().contains('room') || party.toLowerCase().contains('cabin');
  String get customerType {
    if (isEmployee) return 'Employee';
    if (isRoom) return 'Room';
    return 'Other';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentDetail {
  final String paymentId;
  final String paymentMethod;
  final String paymentDate;
  final int paymentAmount;

  PaymentDetail({
    required this.paymentId,
    required this.paymentMethod,
    required this.paymentDate,
    required this.paymentAmount,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) =>
      _$PaymentDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDetailToJson(this);

  // Helper methods
  bool get isCashPayment => paymentMethod.toLowerCase() == 'cash';
  bool get isTransferPayment => paymentMethod.toLowerCase() == 'transfer';
  DateTime get paymentDateTime => DateTime.parse(paymentDate);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CreditPayment {
  final String invoiceId;
  final String party;
  final String salesDate;
  final int invoiceAmount;
  final int originalDiscount;
  final int outstandingAmount;
  final int totalPayments;
  final int creditDiscountGiven;
  final List<PaymentDetail> payments;

  CreditPayment({
    required this.invoiceId,
    required this.party,
    required this.salesDate,
    required this.invoiceAmount,
    required this.originalDiscount,
    required this.outstandingAmount,
    required this.totalPayments,
    required this.creditDiscountGiven,
    required this.payments,
  });

  factory CreditPayment.fromJson(Map<String, dynamic> json) =>
      _$CreditPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$CreditPaymentToJson(this);

  // Helper methods
  bool get isFullyPaid => outstandingAmount == 0;
  bool get hasOutstanding => outstandingAmount > 0;
  double get paymentPercentage => invoiceAmount > 0 ? (totalPayments / invoiceAmount) * 100 : 0;
  DateTime get salesDateTime => DateTime.parse(salesDate);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PurchaseInvoice {
  final String id;
  final String party;
  final String date;
  final int totalAmount;
  final int totalAmountWithDiscount;
  final int discountAmount;
  final List<PaymentDetail> paymentDetails;

  PurchaseInvoice({
    required this.id,
    required this.party,
    required this.date,
    required this.totalAmount,
    required this.totalAmountWithDiscount,
    required this.discountAmount,
    required this.paymentDetails,
  });

  factory PurchaseInvoice.fromJson(Map<String, dynamic> json) =>
      _$PurchaseInvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseInvoiceToJson(this);

  // Helper methods
  bool get isPaid => paymentDetails.isNotEmpty;
  bool get hasDiscount => discountAmount > 0;
  double get discountPercentage => totalAmount > 0 ? (discountAmount / totalAmount) * 100 : 0;
  int get totalPaidAmount => paymentDetails.fold<int>(0, (sum, payment) => sum + payment.paymentAmount);
  DateTime get purchaseDateTime => DateTime.parse(date);
}