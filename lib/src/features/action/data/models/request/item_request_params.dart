import 'package:hotel/src/core/extensions/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemRequestParams {
  final String? acceptLanguage;
  final String? category;
  final bool? excludeZeroSales;
  final String? forFilter;
  final String? itemType;
  final int? page;
  final int? perPage;
  final String? search;
  final String? sortBy;
  final String? sortOrder;
  final bool? favoritesOnly;
  final bool? repeatedSales;

  ItemRequestParams({
    this.acceptLanguage,
    this.category,
    this.excludeZeroSales = false,
    this.forFilter,
    this.itemType,
    this.page = 1,
    this.perPage = 10,
    this.search,
    this.sortBy = 'name',
    this.sortOrder = 'asc',
    this.favoritesOnly,
    this.repeatedSales,
  });

  factory ItemRequestParams.fromJson(Map<String, dynamic> json) =>
      _$ItemRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemRequestParamsToJson(this);

  Map<String, String> toQueryParams() {
    final queryParams = <String, String>{};

    if (acceptLanguage.isNotNullNotEmpty) {
      queryParams['accept-language'] = acceptLanguage!;
    }
    if (category.isNotNullNotEmpty) {
      queryParams['category'] = category!;
    }
    if (excludeZeroSales != null) {
      queryParams['exclude_zero_sales'] = excludeZeroSales.toString();
    }
    if (forFilter.isNotNullNotEmpty) {
      queryParams['for'] = forFilter!;
    }
    if (itemType.isNotNullNotEmpty) {
      queryParams['item_type'] = itemType!;
    }
    if (page != null) {
      queryParams['page'] = page.toString();
    }
    if (perPage != null) {
      queryParams['per_page'] = perPage.toString();
    }
    if (search.isNotNullNotEmpty) {
      queryParams['search'] = search!;
    }
    if (sortBy.isNotNullNotEmpty) {
      queryParams['sort_by'] = sortBy!;
    }
    if (sortOrder.isNotNullNotEmpty) {
      queryParams['sort_order'] = sortOrder!;
    }
    if (favoritesOnly != null) {
      queryParams['favorites_only'] = favoritesOnly.toString();
    }
    if (repeatedSales != null) {
      queryParams['repeated_sales'] = repeatedSales.toString();
    }

    return queryParams;
  }

  ItemRequestParams copyWith({
    String? acceptLanguage,
    String? category,
    bool? excludeZeroSales,
    String? forFilter,
    String? itemType,
    int? page,
    int? perPage,
    String? search,
    String? sortBy,
    String? sortOrder,
    bool? favoritesOnly,
    bool? repeatedSales,
  }) {
    return ItemRequestParams(
      acceptLanguage: acceptLanguage ?? this.acceptLanguage,
      category: category ?? this.category,
      excludeZeroSales: excludeZeroSales ?? this.excludeZeroSales,
      forFilter: forFilter ?? this.forFilter,
      itemType: itemType ?? this.itemType,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      search: search ?? this.search,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      favoritesOnly: favoritesOnly ?? this.favoritesOnly,
      repeatedSales: repeatedSales ?? this.repeatedSales,
    );
  }
}
