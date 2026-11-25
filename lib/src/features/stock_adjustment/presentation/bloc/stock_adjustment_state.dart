part of 'stock_adjustment_cubit.dart';

@freezed
class StockAdjustmentState with _$StockAdjustmentState {
  const factory StockAdjustmentState.initial() = StockAdjustmentStateInitial;

  const factory StockAdjustmentState.loading() = StockAdjustmentStateLoading;

  const factory StockAdjustmentState.noInternet() =
      StockAdjustmentStateNoInternet;

  const factory StockAdjustmentState.error({required String message}) =
      StockAdjustmentStateError;

  const factory StockAdjustmentState.success({
    required ApiResponse<StockAdjustmentResponseModel> itemResponseModel,
  }) = StockAdjustmentStateSuccess;
}
