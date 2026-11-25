part of 'analytics_report_cubit.dart';

@freezed
class AnalyticsReportState with _$AnalyticsReportState {
  const factory AnalyticsReportState.initial() = _Initial;

  const factory AnalyticsReportState.loading() = _Loading;

  const factory AnalyticsReportState.noInternet() = _NoInternet;

  const factory AnalyticsReportState.error({required String message}) = _Error;

  const factory AnalyticsReportState.success({
    required AnalyticsReportResponse response,
  }) = _Success;
}
