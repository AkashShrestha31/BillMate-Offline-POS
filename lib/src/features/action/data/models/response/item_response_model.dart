import 'package:json_annotation/json_annotation.dart';

part 'item_response_model.g.dart';

double _doubleFromJson(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0;
  return 0;
}

int? _intNullableFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

bool _boolFromJson(dynamic value) {
  if (value == true || value == 1 || value == '1' || value == 'true') return true;
  return false;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemResponseModel {
  final List<ItemModel> data;
  final PaginationModel pagination;
  final FiltersAppliedModel filtersApplied;
  final SummaryModel summary;
  final AvailableFiltersModel availableFilters;

  ItemResponseModel({
    required this.data,
    required this.pagination,
    required this.filtersApplied,
    required this.summary,
    required this.availableFilters,
  });

  factory ItemResponseModel.fromJson(Map<String, dynamic> json) => _$ItemResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemResponseModelToJson(this);
}

@JsonSerializable( includeIfNull: false)
class ItemModel {
  final String? id; // Added for identification
  final String name;
  final String? newName;
  final String? itemType;
  @JsonKey(name: 'for')
  final String forFilter;
  final String unit;
  @JsonKey(fromJson: _doubleFromJson)
  final double rate;
  @JsonKey(fromJson: _intNullableFromJson)
  final int? totalSales;
  final String? description;
  final String? hsnCode;
  final String? barcode; // Added from CreateItemRequest
  final String? incomeAccount; // Added from CreateItemRequest
  final String? expenseAccount; // Added from CreateItemRequest
  final String? tax; // Added from CreateItemRequest
  @JsonKey(fromJson: _intNullableFromJson)
  final int? trackItem;
  @JsonKey(fromJson: _intNullableFromJson)
  final int? hasBatch;
  @JsonKey(fromJson: _intNullableFromJson)
  final int? hasSerialNumber;
  final String? image; // Added from CreateItemRequest
  final String? createdBy; // Added from CreateItemRequest
  final String? createdAt; // Optional timestamp
  final String? updatedAt; // Optional timestamp
  final String? category;
  @JsonKey(fromJson: _boolFromJson)
  final bool isFavorite;

  ItemModel({
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
    this.isFavorite = false,
  });

  ItemModel copyWith({
    int? totalSales,
    bool? isFavorite,
  }) {
    return ItemModel(
      id: id,
      name: name,
      newName: newName,
      itemType: itemType,
      forFilter: forFilter,
      unit: unit,
      rate: rate,
      totalSales: totalSales ?? this.totalSales,
      description: description,
      hsnCode: hsnCode,
      barcode: barcode,
      incomeAccount: incomeAccount,
      expenseAccount: expenseAccount,
      tax: tax,
      trackItem: trackItem,
      hasBatch: hasBatch,
      hasSerialNumber: hasSerialNumber,
      image: image,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      category: category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PaginationModel {
  final int currentPage;
  final int perPage;
  final int totalPages;
  final int totalRows;

  PaginationModel({
    required this.currentPage,
    required this.perPage,
    required this.totalPages,
    required this.totalRows,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) => _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FiltersAppliedModel {
  final String? search;
  final String? itemType;
  @JsonKey(name: 'for')
  final String? forFilter;
  final bool excludeZeroSales;
  final String sortBy;
  final String sortOrder;

  FiltersAppliedModel({
    this.search,
    this.itemType,
    this.forFilter,
    required this.excludeZeroSales,
    required this.sortBy,
    required this.sortOrder,
  });

  factory FiltersAppliedModel.fromJson(Map<String, dynamic> json) => _$FiltersAppliedModelFromJson(json);

  Map<String, dynamic> toJson() => _$FiltersAppliedModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SummaryModel {
  final int totalItems;
  final int itemsWithSales;
  final int totalSalesQuantity;
  final double averageSalesPerItem;

  SummaryModel({
    required this.totalItems,
    required this.itemsWithSales,
    required this.totalSalesQuantity,
    required this.averageSalesPerItem,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) => _$SummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AvailableFiltersModel {
  final List<String> forOptions;

  AvailableFiltersModel({
    required this.forOptions,
  });

  factory AvailableFiltersModel.fromJson(Map<String, dynamic> json) => _$AvailableFiltersModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableFiltersModelToJson(this);
}
