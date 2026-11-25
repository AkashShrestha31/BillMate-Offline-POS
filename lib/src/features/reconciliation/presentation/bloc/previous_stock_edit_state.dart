part of 'previous_stock_edit_cubit.dart';

@freezed
class PreviousStockEditState with _$PreviousStockEditState {
  const factory PreviousStockEditState.initial() = _Initial;
  const factory PreviousStockEditState.loading() = _Loading;
  const factory PreviousStockEditState.noInternet() = _NoInternet;
  const factory PreviousStockEditState.error({required String message}) = _Error;
  const factory PreviousStockEditState.success({
    required PreviousStockBulkEditResponseModel response,
  }) = _Success;
}
