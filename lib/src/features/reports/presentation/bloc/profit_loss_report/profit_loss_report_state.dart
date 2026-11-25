part of 'profit_loss_report_cubit.dart';

@freezed
class ProfitLossReportState with _$ProfitLossReportState {
  const factory ProfitLossReportState.initial() = _Initial;

  const factory ProfitLossReportState.loading() = _Loading;

  const factory ProfitLossReportState.noInternet() = _NoInternet;

  const factory ProfitLossReportState.error({required String message}) = _Error;

  const factory ProfitLossReportState.success({
    required ProfitLossReportResponse response,
  }) = _Success;
}
