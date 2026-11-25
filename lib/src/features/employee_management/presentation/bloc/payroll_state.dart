part of 'payroll_cubit.dart';

@freezed
class PayrollState with _$PayrollState {
  const factory PayrollState.initial() = _Initial;
  const factory PayrollState.loading() = _Loading;
  const factory PayrollState.submitting() = _Submitting;
  const factory PayrollState.noInternet() = _NoInternet;
  const factory PayrollState.error({required String message}) = _Error;
  const factory PayrollState.loaded({
    required PayrollListResponseModel response,
  }) = _Loaded;
  const factory PayrollState.payrollDetail({
    required PayrollModel payroll,
  }) = _PayrollDetail;
  const factory PayrollState.submitSuccess({
    required CommonSuccessResponseModel response,
  }) = _SubmitSuccess;
}
