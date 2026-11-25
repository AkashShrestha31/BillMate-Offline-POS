import 'package:freezed_annotation/freezed_annotation.dart';

part 'party_transaction_summary_model.freezed.dart';
part 'party_transaction_summary_model.g.dart';

@freezed
class PartyTransactionSummaryModel with _$PartyTransactionSummaryModel {
  const factory PartyTransactionSummaryModel({
    @JsonKey(name: 'total_sales_invoices') int? totalSalesInvoices,
    @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
    @JsonKey(name: 'total_purchase_invoices') int? totalPurchaseInvoices,
    @JsonKey(name: 'total_purchase_amount') double? totalPurchaseAmount,
    @JsonKey(name: 'total_payments') int? totalPayments,
    @JsonKey(name: 'total_payment_amount') double? totalPaymentAmount,
  }) = _PartyTransactionSummaryModel;

  factory PartyTransactionSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$PartyTransactionSummaryModelFromJson(json);
}
