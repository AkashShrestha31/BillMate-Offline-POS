part of 'previous_stock_delete_cubit.dart';

@freezed
class PreviousStockDeleteState with _$PreviousStockDeleteState {
  const factory PreviousStockDeleteState.initial() = _Initial;
  const factory PreviousStockDeleteState.loading() = _Loading;
  const factory PreviousStockDeleteState.noInternet() = _NoInternet;
  const factory PreviousStockDeleteState.error({required String message}) =
      _Error;
  const factory PreviousStockDeleteState.success({
    required PreviousStockDeleteResponseModel response,
  }) = _Success;
}

