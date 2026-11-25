part of 'leave_application_cubit.dart';

@freezed
class LeaveApplicationState with _$LeaveApplicationState {
  const factory LeaveApplicationState.initial() = _Initial;
  const factory LeaveApplicationState.loading() = _Loading;
  const factory LeaveApplicationState.submitting() = _Submitting;
  const factory LeaveApplicationState.noInternet() = _NoInternet;
  const factory LeaveApplicationState.error({required String message}) = _Error;
  const factory LeaveApplicationState.loaded({
    required LeaveApplicationsListResponseModel response,
  }) = _Loaded;
  const factory LeaveApplicationState.applicationDetail({
    required LeaveApplicationModel application,
  }) = _ApplicationDetail;
  const factory LeaveApplicationState.balanceLoaded({
    required LeaveBalanceListResponseModel response,
  }) = _BalanceLoaded;
  const factory LeaveApplicationState.submitSuccess({
    required CommonSuccessResponseModel response,
  }) = _SubmitSuccess;
}
