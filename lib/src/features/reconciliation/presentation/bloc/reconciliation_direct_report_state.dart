part of 'reconciliation_direct_report_cubit.dart';

@freezed
class ReconciliationDirectReportState with _$ReconciliationDirectReportState {
  const factory ReconciliationDirectReportState.initial() = _Initial;

  const factory ReconciliationDirectReportState.loading() = _Loading;

  const factory ReconciliationDirectReportState.noInternet() = _NoInternet;

  const factory ReconciliationDirectReportState.error(
      {required String message}) = _Error;

  const factory ReconciliationDirectReportState.success({
    required ApiResponse<ReconciliationReportResponse>
        reconciliationDirectReportResponse,
  }) = _Success;
}
