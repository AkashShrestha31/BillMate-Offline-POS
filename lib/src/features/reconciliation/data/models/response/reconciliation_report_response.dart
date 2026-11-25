// reconciliation_report_response.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reconciliation_report_response.freezed.dart';
part 'reconciliation_report_response.g.dart';

@freezed
class ReconciliationReportResponse with _$ReconciliationReportResponse {
  const factory ReconciliationReportResponse({
    required bool success,
    @JsonKey(name: 'report_date') required String reportDate,
    required String period,
    @JsonKey(name: 'starting_stock_date') required String startingStockDate,
    @JsonKey(name: 'current_stock_date') required String currentStockDate,
    @JsonKey(name: 'reconciliation_method')
    required String reconciliationMethod,
    @JsonKey(name: 'calculation_explanation')
    required String calculationExplanation,
    required ReconciliationReportSummary summary,
    @JsonKey(name: 'reconciliation_details')
    required List<ReconciliationReportDetail> reconciliationDetails,
    @JsonKey(name: 'saved_to_database') required bool savedToDatabase,
  }) = _ReconciliationReportResponse;

  factory ReconciliationReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ReconciliationReportResponseFromJson(json);
}

@freezed
class ReconciliationReportSummary with _$ReconciliationReportSummary {
  const factory ReconciliationReportSummary({
    @JsonKey(name: 'total_items') required int totalItems,
    @JsonKey(name: 'over_stock_items') required int overStockItems,
    @JsonKey(name: 'short_stock_items') required int shortStockItems,
    @JsonKey(name: 'matching_items') required int matchingItems,
    @JsonKey(name: 'total_variance_value', fromJson: _stringToDouble)
    required double totalVarianceValue,
    @JsonKey(name: 'total_over_value', fromJson: _stringToDouble)
    required double totalOverValue,
    @JsonKey(name: 'total_short_value', fromJson: _stringToDouble)
    required double totalShortValue,
  }) = _ReconciliationReportSummary;

  factory ReconciliationReportSummary.fromJson(Map<String, dynamic> json) =>
      _$ReconciliationReportSummaryFromJson(json);
}

@freezed
class ReconciliationReportDetail with _$ReconciliationReportDetail {
  const factory ReconciliationReportDetail({
    required String item,
    required String location,
    @JsonKey(name: 'starting_stock') required int startingStock,
    @JsonKey(name: 'total_purchases') required int totalPurchases,
    @JsonKey(name: 'total_sales') required int totalSales,
    @JsonKey(name: 'total_stock_in') required int totalStockIn,
    @JsonKey(name: 'total_stock_out') required int totalStockOut,
    @JsonKey(name: 'expected_stock') required int expectedStock,
    @JsonKey(name: 'actual_stock') required int actualStock,
    required int variance,
    @JsonKey(name: 'variance_value', fromJson: _stringToDouble)
    required double varianceValue,
    @JsonKey(name: 'item_rate', fromJson: _stringToDouble)
    required double itemRate,
    @JsonKey(name: 'precious_stock') List<StockRecord>? preciousStock,
    @JsonKey(name: 'current_stock') List<StockRecord>? currentStock,
    required String status,
    @JsonKey(name: 'calculation_formula') required String calculationFormula,
  }) = _ReconciliationReportDetail;

  factory ReconciliationReportDetail.fromJson(Map<String, dynamic> json) =>
      _$ReconciliationReportDetailFromJson(json);
}

// Helper functions to handle type conversion
double _stringToDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0.0;
}

@freezed
class StockRecord with _$StockRecord {
  const factory StockRecord({
    required String name,
    required String item,
    required String location,
    @JsonKey(name: 'previousQuantity') required int previousQuantity,
    @JsonKey(name: 'reportingDate') required String reportingDate,
    @JsonKey(name: 'uploadDate') required String uploadDate,
    @JsonKey(name: 'uploadedBy') required String uploadedBy,
    @JsonKey(name: 'batchNumber') required String batchNumber,
    @JsonKey(name: 'expiryDate') required String expiryDate,
    required int rate,
    required int value,
    required String notes,
    @JsonKey(name: 'isActive') required int isActive,
    @JsonKey(name: 'createdBy') required String createdBy,
    @JsonKey(name: 'modifiedBy') required String modifiedBy,
    required String created,
    required String modified,
  }) = _StockRecord;

  factory StockRecord.fromJson(Map<String, dynamic> json) =>
      _$StockRecordFromJson(json);
}
