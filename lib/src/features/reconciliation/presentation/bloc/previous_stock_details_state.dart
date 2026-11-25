part of 'previous_stock_details_cubit.dart';

@freezed
class PreviousStockDetailsState with _$PreviousStockDetailsState {
  const factory PreviousStockDetailsState.initial() = _Initial;
  const factory PreviousStockDetailsState.loading() = _Loading;
  const factory PreviousStockDetailsState.noInternet() = _NoInternet;
  const factory PreviousStockDetailsState.error({required String message}) = _Error;
  const factory PreviousStockDetailsState.success({
    required PreviousStockDetailsResponseModel response,
  }) = _Success;
}
