import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotel_sales_request_params.freezed.dart';
part 'hotel_sales_request_params.g.dart';

@freezed
class HotelSalesRequestParams with _$HotelSalesRequestParams {
  const factory HotelSalesRequestParams({
    DateTime? startDate,
    DateTime? endDate,
    int? page,
    int? pageSize,
  }) = _HotelSalesRequestParams;

  factory HotelSalesRequestParams.fromJson(Map<String, dynamic> json) =>
      _$HotelSalesRequestParamsFromJson(json);
}
