import 'package:freezed_annotation/freezed_annotation.dart';

part 'previous_stock_details_request_params.freezed.dart';
part 'previous_stock_details_request_params.g.dart';

@freezed
class PreviousStockDetailsRequestParams with _$PreviousStockDetailsRequestParams {
  const factory PreviousStockDetailsRequestParams({
    @JsonKey(name: 'reporting_date') required String reportingDate,
    @JsonKey(name: 'batch_number') String? batchNumber,
    String? item,
    String? location,
  }) = _PreviousStockDetailsRequestParams;

  factory PreviousStockDetailsRequestParams.fromJson(Map<String, dynamic> json) =>
      _$PreviousStockDetailsRequestParamsFromJson(json);
}
