part of 'payment_cubit.dart';

@freezed
class PaymentState with _$PaymentState {
  const factory PaymentState.initial() = _Initial;
  const factory PaymentState.loading() = _Loading;
  const factory PaymentState.noInternet() = _NoInternet;
  const factory PaymentState.error({required String message}) = _Error;
  const factory PaymentState.loaded({required PaymentResponseModel payment}) = _Updated;
}