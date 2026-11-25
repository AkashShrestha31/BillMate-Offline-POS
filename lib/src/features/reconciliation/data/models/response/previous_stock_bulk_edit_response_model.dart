import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/failed_stock_item_model.dart';
import 'updated_stock_item_model.dart';
import 'edit_summary_model.dart';

part 'previous_stock_bulk_edit_response_model.freezed.dart';
part 'previous_stock_bulk_edit_response_model.g.dart';

@freezed
class PreviousStockBulkEditResponseModel with _$PreviousStockBulkEditResponseModel {
  const factory PreviousStockBulkEditResponseModel({
    required bool success,
    required String message,
    required EditSummaryModel summary,
    @JsonKey(name: 'updated_items') required List<UpdatedStockItemModel> updatedItems,
    @JsonKey(name: 'failed_items') required List<FailedStockItemModel> failedItems,
  }) = _PreviousStockBulkEditResponseModel;

  factory PreviousStockBulkEditResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PreviousStockBulkEditResponseModelFromJson(json);
}
