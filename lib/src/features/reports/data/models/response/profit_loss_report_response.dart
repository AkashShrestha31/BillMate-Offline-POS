import 'package:freezed_annotation/freezed_annotation.dart';

part 'profit_loss_report_response.freezed.dart';

/// Bundles raw JSON from the five parallel `view=` P&amp;L calls.
@freezed
class ProfitLossReportResponse with _$ProfitLossReportResponse {
  const factory ProfitLossReportResponse({
    required Map<String, dynamic> summary,
    required Map<String, dynamic> trend,
    required Map<String, dynamic> statement,
    required Map<String, dynamic> expense,
    required Map<String, dynamic> revenue,
  }) = _ProfitLossReportResponse;
}
