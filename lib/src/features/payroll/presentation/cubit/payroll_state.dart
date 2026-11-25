part of 'payroll_cubit.dart';

@freezed
class PayrollState with _$PayrollState {
  const factory PayrollState.initial() = _Initial;
  const factory PayrollState.loading() = _Loading;
  const factory PayrollState.noInternet() = _NoInternet;
  const factory PayrollState.error({required String message}) = _Error;
  const factory PayrollState.generated({
    required GeneratePayrollResponse response,
  }) = _Generated;
  const factory PayrollState.loaded({
    required PayrollListResponse response,
  }) = _Loaded;
  const factory PayrollState.paymentUpdated({
    required UpdatePaymentResponse response,
  }) = _PaymentUpdated;
  const factory PayrollState.deleted({
    required DeletePayrollResponse response,
  }) = _Deleted;
}
