part of 'payment_analytics_cubit.dart';

@freezed
class PaymentAnalyticsState with _$PaymentAnalyticsState {
  const factory PaymentAnalyticsState.initial() = _Initial;
  const factory PaymentAnalyticsState.loading() = _Loading;
  const factory PaymentAnalyticsState.noInternet() = _NoInternet;
  const factory PaymentAnalyticsState.error({required String message}) = _Error;
  const factory PaymentAnalyticsState.success({
    required PaymentAnalyticsResponseModel responseModel
  }) = _Success;
}
