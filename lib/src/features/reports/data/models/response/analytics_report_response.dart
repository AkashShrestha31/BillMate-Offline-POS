import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_report_response.freezed.dart';

@freezed
class AnalyticsReportResponse with _$AnalyticsReportResponse {
  const factory AnalyticsReportResponse({
    required Map<String, dynamic> dashboard,
    required Map<String, dynamic> summary,
    required Map<String, dynamic> trend,
    required Map<String, dynamic> items,
    required Map<String, dynamic> categories,
    required Map<String, dynamic> parties,
  }) = _AnalyticsReportResponse;
}
