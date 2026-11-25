part of 'daily_cash_summary_cubit.dart';

@freezed
class DailyCashSummaryState with _$DailyCashSummaryState {
  const factory DailyCashSummaryState.initial() = _Initial;

  const factory DailyCashSummaryState.loading() = _Loading;

  const factory DailyCashSummaryState.noInternet() = _NoInternet;

  const factory DailyCashSummaryState.error({required String message}) = _Error;

  const factory DailyCashSummaryState.summaryCreated({
    required DailyCashSummaryResponseModel response,
  }) = _SummaryCreated;

  const factory DailyCashSummaryState.summariesLoaded({
    required DailyCashSummaryResponseModel response,
  }) = _SummariesLoaded;

  const factory DailyCashSummaryState.summaryUpdated({
    required DailyCashSummaryResponseModel response,
  }) = _SummaryUpdated;

  const factory DailyCashSummaryState.summaryDeleted({
    required DailyCashSummaryResponseModel response,
  }) = _SummaryDeleted;
}
