import 'package:freezed_annotation/freezed_annotation.dart';

part 'reconcile_party_response.freezed.dart';
part 'reconcile_party_response.g.dart';

@freezed
class ReconcilePartyResponse with _$ReconcilePartyResponse {
  const factory ReconcilePartyResponse({
    required bool success,
    required String message,
    required ReconciliationSummary summary,
    @JsonKey(name: 'reconciliation_results')
    required List<ReconciliationResult> reconciliationResults,
  }) = _ReconcilePartyResponse;

  factory ReconcilePartyResponse.fromJson(Map<String, dynamic> json) =>
      _$ReconcilePartyResponseFromJson(json);
}

@freezed
class ReconciliationSummary with _$ReconciliationSummary {
  const factory ReconciliationSummary({
    @JsonKey(name: 'total_parties_checked') required int totalPartiesChecked,
    @JsonKey(name: 'total_mismatches') required int totalMismatches,
    @JsonKey(name: 'total_fixed') required int totalFixed,
    @JsonKey(name: 'auto_fix_enabled') required bool autoFixEnabled,
    @JsonKey(name: 'transaction_status') required String transactionStatus,
  }) = _ReconciliationSummary;

  factory ReconciliationSummary.fromJson(Map<String, dynamic> json) =>
      _$ReconciliationSummaryFromJson(json);
}

@freezed
class ReconciliationResult with _$ReconciliationResult {
  const factory ReconciliationResult({
    @JsonKey(name: 'party_name') required String partyName,
    @JsonKey(name: 'party_outstanding') required double partyOutstanding,
    @JsonKey(name: 'actual_outstanding') required double actualOutstanding,
    @JsonKey(name: 'total_grand_total') required double totalGrandTotal,
    required double difference,
    @JsonKey(name: 'total_invoice_count') required int totalInvoiceCount,
    @JsonKey(name: 'unpaid_invoice_count') required int unpaidInvoiceCount,
    required String status,
    required bool updated,
    @JsonKey(name: 'update_error') String? updateError,
    @JsonKey(name: 'unpaid_invoices') required List<UnpaidInvoice> unpaidInvoices,
  }) = _ReconciliationResult;

  factory ReconciliationResult.fromJson(Map<String, dynamic> json) =>
      _$ReconciliationResultFromJson(json);
}

@freezed
class UnpaidInvoice with _$UnpaidInvoice {
  const factory UnpaidInvoice({
    @JsonKey(name: 'invoice_name') required String invoiceName,
    @JsonKey(name: 'discount_amount') required String discountAmount,
    @JsonKey(name: 'grand_total') required double grandTotal,
    required DateTime date,
    required String status,
    @JsonKey(name: 'outstanding_amount') required double outstandingAmount,
  }) = _UnpaidInvoice;

  factory UnpaidInvoice.fromJson(Map<String, dynamic> json) =>
      _$UnpaidInvoiceFromJson(json);
}
