part of 'reconciliation_upload_cubit.dart';

@freezed
class ReconciliationUploadState with _$ReconciliationUploadState {
  const factory ReconciliationUploadState.initial() = _Initial;

  const factory ReconciliationUploadState.loading() = _Loading;

  const factory ReconciliationUploadState.noInternet() = _NoInternet;

  const factory ReconciliationUploadState.error({required String message}) =
      _Error;

  const factory ReconciliationUploadState.success({
    required ApiResponse<ReconciliationUploadResponse>
        reconciliationUploadResponse,
  }) = _Success;
}
