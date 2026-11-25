import 'package:hotel/src/core/extensions/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'liquor_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LiquorRequestParams {
  final int? page;
  final int? perPage;
  final String? brand;
  final String? category;
  final String? name;
  final String? location;
  final String? sortBy;
  final String? sortOrder;
  final double? minPrice;
  final double? maxPrice;
  final double? minMargin;
  final double? maxMargin;

  LiquorRequestParams({
    this.page = 1,
    this.perPage = 10,
    this.brand,
    this.category,
    this.name,
    this.location,
    this.sortBy,
    this.sortOrder = 'desc',
    this.minPrice,
    this.maxPrice,
    this.minMargin,
    this.maxMargin,
  });

  factory LiquorRequestParams.fromJson(Map<String, dynamic> json) =>
      _$LiquorRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$LiquorRequestParamsToJson(this);

  Map<String, String> toQueryParams() {
    final queryParams = <String, String>{};

    if (page != null) queryParams['page'] = page.toString();
    if (perPage != null) queryParams['per_page'] = perPage.toString();
    if (brand.isNotNullNotEmpty) queryParams['brand'] = brand!;
    if (category.isNotNullNotEmpty) queryParams['category'] = category!;
    if (name.isNotNullNotEmpty) queryParams['name'] = name!;
    if (location.isNotNullNotEmpty) queryParams['location'] = location!;
    if (sortBy.isNotNullNotEmpty) queryParams['sort_by'] = sortBy!;
    if (sortOrder.isNotNullNotEmpty) queryParams['sort_order'] = sortOrder!;
    if (minPrice != null) queryParams['min_price'] = minPrice.toString();
    if (maxPrice != null) queryParams['max_price'] = maxPrice.toString();
    if (minMargin != null) queryParams['min_margin'] = minMargin.toString();
    if (maxMargin != null) queryParams['max_margin'] = maxMargin.toString();

    return queryParams;
  }

  static LiquorRequestParams whiskey({
    int page = 1,
    int perPage = 10,
    String? brand,
    String sortOrder = 'desc',
  }) {
    return LiquorRequestParams(
      page: page,
      perPage: perPage,
      category: 'Whiskey',
      brand: brand,
      sortOrder: sortOrder,
    );
  }

  static LiquorRequestParams vodka({
    int page = 1,
    int perPage = 10,
    String? brand,
    String sortOrder = 'desc',
  }) {
    return LiquorRequestParams(
      page: page,
      perPage: perPage,
      category: 'Vodka',
      brand: brand,
      sortOrder: sortOrder,
    );
  }

  static LiquorRequestParams rum({
    int page = 1,
    int perPage = 10,
    String? brand,
    String sortOrder = 'desc',
  }) {
    return LiquorRequestParams(
      page: page,
      perPage: perPage,
      category: 'Rum',
      brand: brand,
      sortOrder: sortOrder,
    );
  }
}
