part of 'payment_methods_cubit.dart';

@freezed
class PaymentMethodsState with _$PaymentMethodsState {
  const factory PaymentMethodsState.initial() = _Initial;
  const factory PaymentMethodsState.loading() = _Loading;
  const factory PaymentMethodsState.noInternet() = _NoInternet;
  const factory PaymentMethodsState.error({required String message}) = _Error;
  const factory PaymentMethodsState.success({required List<PaymentMethodItem> methods}) = _Success;
}
