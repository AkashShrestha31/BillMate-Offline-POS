import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CategoryModel {
  final int id;
  final String name;
  final String? created;
  final String? modified;
  @JsonKey(name: 'item_count')
  final int? itemCount;

  CategoryModel({
    required this.id,
    required this.name,
    this.created,
    this.modified,
    this.itemCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
