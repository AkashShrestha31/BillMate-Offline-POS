import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_report_request.freezed.dart';

/// [tabIndex]: 0 purchase, 1 sales, 2 dashboard
@freezed
class AnalyticsReportRequest with _$AnalyticsReportRequest {
  const factory AnalyticsReportRequest({
    required int tabIndex,
    required String mode,
    required int year,
    required int month,
    required DateTime day,
  }) = _AnalyticsReportRequest;

  factory AnalyticsReportRequest.initial() {
    final n = DateTime.now();
    return AnalyticsReportRequest(
      tabIndex: 0,
      mode: 'year',
      year: n.year,
      month: n.month,
      day: n,
    );
  }
}
