import 'package:json_annotation/json_annotation.dart';
import 'category_model.dart';

part 'category_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CategoryListResponse {
  final bool success;
  final int? count;
  final Map<String, dynamic>? filtersApplied;
  final List<CategoryModel> data;

  CategoryListResponse({
    required this.success,
    this.count,
    this.filtersApplied,
    required this.data,
  });

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryListResponseToJson(this);
}
