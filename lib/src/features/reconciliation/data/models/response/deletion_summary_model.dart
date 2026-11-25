import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/deleted_stock_item_model.dart';

part 'deletion_summary_model.freezed.dart';
part 'deletion_summary_model.g.dart';

@freezed
class DeletionSummaryModel with _$DeletionSummaryModel {
  const factory DeletionSummaryModel({
    @JsonKey(name: 'reporting_date') required String reportingDate,
    @JsonKey(name: 'total_records_deleted') required int totalRecordsDeleted,
    @JsonKey(name: 'unique_items') required int uniqueItems,
    @JsonKey(name: 'unique_locations') required int uniqueLocations,
    @JsonKey(name: 'total_quantity') required int totalQuantity,
    @JsonKey(name: 'total_value') required double totalValue,
    @JsonKey(name: 'uploaded_by') required String uploadedBy,
    @JsonKey(name: 'upload_time') required String uploadTime,
    @JsonKey(name: 'sample_deleted_items')
        required List<DeletedStockItemModel> sampleDeletedItems,
  }) = _DeletionSummaryModel;

  factory DeletionSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$DeletionSummaryModelFromJson(json);
}

