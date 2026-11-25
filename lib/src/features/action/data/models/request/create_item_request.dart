import 'package:json_annotation/json_annotation.dart';

part 'create_item_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class CreateItemRequest {
  final String? id; // Added for identification
  final String name;
  final String? newName;
  final String? itemType;
  @JsonKey(name: 'for')
  final String forFilter;
  final String unit;
  final double rate;
  final int? totalSales;
  final String? description;
  final String? hsnCode;
  final String? barcode; // Added from CreateItemRequest
  final String? incomeAccount; // Added from CreateItemRequest
  final String? expenseAccount; // Added from CreateItemRequest
  final String? tax; // Added from CreateItemRequest
  final int? trackItem;
  final int? hasBatch;
  final int? hasSerialNumber;
  final String? image; // Added from CreateItemRequest
  final String? createdBy; // Added from CreateItemRequest
  final String? createdAt; // Optional timestamp
  final String? updatedAt; // Optional timestamp
  final String? category;

  CreateItemRequest({
    this.id,
    required this.name,
    this.newName,
    required this.itemType,
    required this.forFilter,
    required this.unit,
    required this.rate,
    this.totalSales,
    this.description,
    this.hsnCode,
    this.barcode,
    this.incomeAccount,
    this.expenseAccount,
    this.tax,
    this.trackItem,
    this.hasBatch,
    this.hasSerialNumber,
    this.image,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory CreateItemRequest.fromJson(Map<String, dynamic> json) => _$CreateItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateItemRequestToJson(this);
}