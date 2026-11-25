part of 'item_counter_cubit.dart';

@freezed
class ItemCounterState with _$ItemCounterState {
  const factory ItemCounterState.initial() = _Initial;

  const factory ItemCounterState.loading() = _Loading;

  const factory ItemCounterState.noInternet() = _NoInternet;

  const factory ItemCounterState.error({required String message}) = _Error;

  const factory ItemCounterState.success({
    required ApiResponse<ItemCounterResponseModel> itemCounterResponseModel,
  }) = _Success;
}
