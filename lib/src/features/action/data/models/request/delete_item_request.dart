import 'package:json_annotation/json_annotation.dart';

part 'delete_item_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DeleteItemRequest {
  final String itemName;
  final bool confirmDelete;
  final bool forceDelete;
  final bool deleteStockEntries;
  final String deletedBy;

  DeleteItemRequest({
    required this.itemName,
    required this.confirmDelete,
    required this.forceDelete,
    required this.deleteStockEntries,
    required this.deletedBy,
  });

  factory DeleteItemRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteItemRequestToJson(this);
}