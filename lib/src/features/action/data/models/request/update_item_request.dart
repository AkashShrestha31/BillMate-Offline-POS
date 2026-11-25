import 'package:json_annotation/json_annotation.dart';

part 'update_item_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateItemRequest {
  final String oldName;
  final String newName;

  UpdateItemRequest({
    required this.oldName,
    required this.newName,
  });

  factory UpdateItemRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateItemRequestToJson(this);
}
