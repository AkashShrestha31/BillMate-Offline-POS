import 'package:freezed_annotation/freezed_annotation.dart';
import 'previous_stock_edit_item_params.dart';

part 'previous_stock_bulk_edit_request_params.freezed.dart';
part 'previous_stock_bulk_edit_request_params.g.dart';

@freezed
class PreviousStockBulkEditRequestParams with _$PreviousStockBulkEditRequestParams {
  const factory PreviousStockBulkEditRequestParams({
    @JsonKey(name: 'stock_items') required List<PreviousStockEditItemParams> stockItems,
  }) = _PreviousStockBulkEditRequestParams;

  factory PreviousStockBulkEditRequestParams.fromJson(Map<String, dynamic> json) =>
      _$PreviousStockBulkEditRequestParamsFromJson(json);
}
