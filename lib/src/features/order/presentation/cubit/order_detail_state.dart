part of 'order_detail_cubit.dart';

@freezed
class OrderDetailState with _$OrderDetailState {
  const factory OrderDetailState.initial() = _Initial;
  const factory OrderDetailState.loading({OrderModel? cachedOrder}) = _Loading;
  const factory OrderDetailState.noInternet({OrderModel? cachedOrder}) = _NoInternet;
  const factory OrderDetailState.error({
    required String message,
    OrderModel? cachedOrder,
  }) = _Error;
  const factory OrderDetailState.loaded({
    required OrderModel order,
    @Default(false) bool isCheckoutLoading,
    String? errorMessage,
    @Default(false) bool isNoInternet,
    @Default(<OrderActivityEntry>[]) List<OrderActivityEntry> activities,
    @Default(false) bool isActivityLoading,
    String? activityErrorMessage,
  }) = _Loaded;
}
