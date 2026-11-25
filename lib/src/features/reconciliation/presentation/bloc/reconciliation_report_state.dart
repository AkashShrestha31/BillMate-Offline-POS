part of 'reconciliation_report_cubit.dart';

@freezed
class ReconciliationReportState with _$ReconciliationReportState {
  const factory ReconciliationReportState.initial() = _Initial;

  const factory ReconciliationReportState.loading() = _Loading;

  const factory ReconciliationReportState.noInternet() = _NoInternet;

  const factory ReconciliationReportState.error({required String message}) =
      _Error;

  const factory ReconciliationReportState.success({
    required ApiResponse<ReconciliationReportResponse>
        reconciliationReportResponse,
  }) = _Success;
}
