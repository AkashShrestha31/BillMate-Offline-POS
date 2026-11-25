import 'package:freezed_annotation/freezed_annotation.dart';

part 'merge_items_bulk_operation_request.freezed.dart';
part 'merge_items_bulk_operation_request.g.dart';

@freezed
class MergeItemsBulkOperationRequest with _$MergeItemsBulkOperationRequest {
  const factory MergeItemsBulkOperationRequest({
    @JsonKey(name: 'operation') required String operation,
    @JsonKey(name: 'merge_data') required MergeData mergeData,
    @JsonKey(name: 'modifiedBy', includeIfNull: false) String? modifiedBy,
  }) = _MergeItemsBulkOperationRequest;

  factory MergeItemsBulkOperationRequest.fromJson(Map<String, dynamic> json) =>
      _$MergeItemsBulkOperationRequestFromJson(json);
}

@freezed
class MergeData with _$MergeData {
  const factory MergeData({
    @JsonKey(name: 'source_item') required String sourceItem,
    @JsonKey(name: 'target_item') required String targetItem,
  }) = _MergeData;

  factory MergeData.fromJson(Map<String, dynamic> json) =>
      _$MergeDataFromJson(json);
}