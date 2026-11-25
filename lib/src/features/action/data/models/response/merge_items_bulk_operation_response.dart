import 'package:freezed_annotation/freezed_annotation.dart';

part 'merge_items_bulk_operation_response.freezed.dart';
part 'merge_items_bulk_operation_response.g.dart';

@freezed
class MergeItemsBulkOperationResponse with _$MergeItemsBulkOperationResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory MergeItemsBulkOperationResponse({
    required bool success,
    required String message,
    @JsonKey(name: 'source_item') String? sourceItem,
    @JsonKey(name: 'target_item') String? targetItem,
    @JsonKey(name: 'merged_data') Map<String, dynamic>? mergedData,
  }) = _MergeItemsBulkOperationResponse;

  factory MergeItemsBulkOperationResponse.fromJson(Map<String, dynamic> json) =>
      _$MergeItemsBulkOperationResponseFromJson(json);
}

