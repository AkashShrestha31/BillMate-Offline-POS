// reconciliation_direct_report_request.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reconciliation_direct_report_request.freezed.dart';
part 'reconciliation_direct_report_request.g.dart';

@freezed
class ReconciliationDirectReportRequest
    with _$ReconciliationDirectReportRequest {
  const factory ReconciliationDirectReportRequest({
    @JsonKey(name: 'previous_stock') required List<StockItem> previousStock,
    @JsonKey(name: 'current_stock') required List<StockItem> currentStock,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'end_date') required String endDate,
    @JsonKey(name: 'include_transaction_details')
    required bool includeTransactionDetails,
    @JsonKey(name: 'save_report') required bool saveReport,
    @JsonKey(name: 'report_name') required String reportName,
  }) = _ReconciliationDirectReportRequest;

  factory ReconciliationDirectReportRequest.fromJson(
          Map<String, dynamic> json) =>
      _$ReconciliationDirectReportRequestFromJson(json);
}

@freezed
class StockItem with _$StockItem {
  const factory StockItem({
    required String item,
    required String location,
    @JsonKey(fromJson: _numberToDouble) required double quantity,
  }) = _StockItem;

  factory StockItem.fromJson(Map<String, dynamic> json) =>
      _$StockItemFromJson(json);
}

extension ReconciliationDirectReportRequestExtension
    on ReconciliationDirectReportRequest {
  Map<String, dynamic> toQueryParams() {
    return {
      'start_date': startDate,
      'end_date': endDate,
      'include_transaction_details': includeTransactionDetails,
      'save_report': saveReport,
      'report_name': reportName,
    };
  }

  Map<String, dynamic> toRequestBody() {
    return {
      'previous_stock': previousStock.map((item) => item.toJson()).toList(),
      'current_stock': currentStock.map((item) => item.toJson()).toList(),
      'start_date': startDate,
      'end_date': endDate,
      'include_transaction_details': includeTransactionDetails,
      'save_report': saveReport,
      'report_name': reportName,
    };
  }
}

// Helper function to handle type conversion for quantity
double _numberToDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0.0;
}
