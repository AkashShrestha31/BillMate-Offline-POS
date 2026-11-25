import 'package:freezed_annotation/freezed_annotation.dart';

part 'profit_loss_report_request.freezed.dart';

/// UI / query params for parallel P&amp;L unified API calls (period + trend `group_by`).
@freezed
class ProfitLossReportRequest with _$ProfitLossReportRequest {
  const factory ProfitLossReportRequest({
    required String mode,
    required int year,
    required int month,
    required int monthFrom,
    required int monthTo,
    required DateTime customStart,
    required DateTime customEnd,
  }) = _ProfitLossReportRequest;

  factory ProfitLossReportRequest.initial() {
    final n = DateTime.now();
    return ProfitLossReportRequest(
      mode: 'year',
      year: n.year,
      month: n.month,
      monthFrom: 1,
      monthTo: n.month,
      customStart: DateTime(n.year, 1, 1),
      customEnd: n,
    );
  }
}
