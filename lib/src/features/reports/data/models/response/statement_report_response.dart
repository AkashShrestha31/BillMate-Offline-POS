import 'package:freezed_annotation/freezed_annotation.dart';

part 'statement_report_response.freezed.dart';

@freezed
class StatementReportResponse with _$StatementReportResponse {
  const factory StatementReportResponse({
    required Map<String, dynamic> overview,
    required Map<String, dynamic> cashSummary,
    required Map<String, dynamic> cashTrend,
    required Map<String, dynamic> bankSummary,
    required Map<String, dynamic> bankTrend,
    required Map<String, dynamic> dailySummary,
    required Map<String, dynamic> dailyTrend,
  }) = _StatementReportResponse;
}
