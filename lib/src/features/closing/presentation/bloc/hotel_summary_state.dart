part of 'hotel_summary_cubit.dart';

@freezed
class HotelSummaryState with _$HotelSummaryState {
  const factory HotelSummaryState.initial() = _Initial;
  const factory HotelSummaryState.loading() = _Loading;
  const factory HotelSummaryState.loadingDetail() = _LoadingDetail;
  const factory HotelSummaryState.creating() = _Creating;
  const factory HotelSummaryState.updating() = _Updating;
  const factory HotelSummaryState.deleting() = _Deleting;
  const factory HotelSummaryState.noInternet() = _NoInternet;
  const factory HotelSummaryState.error({required String message}) = _Error;
  const factory HotelSummaryState.loaded({required ApiResponse<HotelSummaryResponseModel> hotelSummaryResponseModel}) = _Loaded;
  const factory HotelSummaryState.detailLoaded({required HotelSummaryResponseModel summary}) = _DetailLoaded;
  const factory HotelSummaryState.created({required HotelSummaryResponseModel summary}) = _Created;
  const factory HotelSummaryState.updated({required HotelSummaryResponseModel summary}) = _Updated;
  const factory HotelSummaryState.deleted() = _Deleted;
}
