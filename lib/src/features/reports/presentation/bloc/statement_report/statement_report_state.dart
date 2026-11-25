part of 'statement_report_cubit.dart';

@freezed
class StatementReportState with _$StatementReportState {
  const factory StatementReportState.initial() = _Initial;

  const factory StatementReportState.loading() = _Loading;

  const factory StatementReportState.noInternet() = _NoInternet;

  const factory StatementReportState.error({required String message}) = _Error;

  const factory StatementReportState.success({
    required StatementReportResponse response,
  }) = _Success;
}
