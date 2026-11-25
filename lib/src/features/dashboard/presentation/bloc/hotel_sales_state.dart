part of 'hotel_sales_cubit.dart';

@freezed
class HotelSalesState with _$HotelSalesState {
  const factory HotelSalesState.initial() = _Initial;

  const factory HotelSalesState.loading() = _Loading;

  const factory HotelSalesState.noInternet() = _NoInternet;

  const factory HotelSalesState.error({required String message}) = _Error;

  const factory HotelSalesState.success({
    required ApiResponse<HotelSalesResponseModel> hotelSalesResponseModel,
  }) = _Success;
}
