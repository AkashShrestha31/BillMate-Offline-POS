// reconciliation_report_request.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reconciliation_report_request.freezed.dart';
part 'reconciliation_report_request.g.dart';

@freezed
class ReconciliationReportRequest with _$ReconciliationReportRequest {
  const factory ReconciliationReportRequest({
    @JsonKey(name: 'from_date') required String fromDate,
    @JsonKey(name: 'to_date') required String toDate,
    @JsonKey(name: 'current_stock_date') required String currentStockDate,
    @JsonKey(name: 'previous_stock_date') required String previousStockDate,
    required List<String> items,
    required List<String> locations,
    @JsonKey(name: 'save_report') required bool saveReport,
  }) = _ReconciliationReportRequest;

  factory ReconciliationReportRequest.fromJson(Map<String, dynamic> json) =>
      _$ReconciliationReportRequestFromJson(json);
}

extension ReconciliationReportRequestExtension on ReconciliationReportRequest {
  Map<String, dynamic> toQueryParams() {
    return {
      'from_date': fromDate,
      'to_date': toDate,
      'current_stock_date': currentStockDate,
      'previous_stock_date': previousStockDate,
      'items': items,
      'locations': locations,
      'save_report': saveReport,
    };
  }
}
