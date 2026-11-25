part of 'previous_stock_cubit.dart';

@freezed
class PreviousStockState with _$PreviousStockState {
  // Fixed: underscore instead of asterisk
  const factory PreviousStockState.initial() =
      _Initial; // Fixed: underscore instead of asterisk

  const factory PreviousStockState.loading() =
      _Loading; // Fixed: underscore instead of asterisk

  const factory PreviousStockState.noInternet() =
      _NoInternet; // Fixed: underscore instead of asterisk

  const factory PreviousStockState.error({required String message}) =
      _Error; // Fixed: underscore instead of asterisk

  const factory PreviousStockState.success(
          {required ApiResponse<PreviousStockResponseModel> responseModel}) =
      _Success; // Fixed: underscore instead of asterisk
}
