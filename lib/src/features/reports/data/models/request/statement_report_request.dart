import 'package:freezed_annotation/freezed_annotation.dart';

part 'statement_report_request.freezed.dart';

@freezed
class StatementReportRequest with _$StatementReportRequest {
  const factory StatementReportRequest({
    required String mode,
    required int year,
    required int month,
    required int monthFrom,
    required int monthTo,
    required DateTime day,
  }) = _StatementReportRequest;

  factory StatementReportRequest.initial() {
    final n = DateTime.now();
    return StatementReportRequest(
      mode: 'year',
      year: n.year,
      month: n.month,
      monthFrom: 1,
      monthTo: n.month,
      day: n,
    );
  }
}
