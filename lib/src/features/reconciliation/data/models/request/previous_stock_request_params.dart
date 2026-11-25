import 'package:hotel/src/core/extensions/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'previous_stock_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PreviousStockRequestParams {
  final String? acceptLanguage;
  final String? endDate;
  final String? items;
  final int? limit;
  final String? locations;
  final bool? onlyActive;
  final String? sortOrder;
  final String? startDate;

  PreviousStockRequestParams({
    this.acceptLanguage = 'en',
    this.endDate,
    this.items,
    this.limit,
    this.locations,
    this.onlyActive = true,
    this.sortOrder = 'desc',
    this.startDate,
  });

  /// Factory method to create an instance from a JSON map
  factory PreviousStockRequestParams.fromJson(Map<String, dynamic> json) =>
      _$PreviousStockRequestParamsFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$PreviousStockRequestParamsToJson(this);

  /// Convert the object into query parameters, including only non-null values
  Map<String, String> toQueryParams() {
    final queryParams = <String, String>{};

    if (acceptLanguage.isNotNullNotEmpty)
      queryParams['accept-language'] = acceptLanguage!;
    if (endDate.isNotNullNotEmpty) queryParams['end_date'] = endDate!;
    if (items.isNotNullNotEmpty) queryParams['items'] = items!;
    if (limit != null) queryParams['limit'] = limit.toString();
    if (locations.isNotNullNotEmpty) queryParams['locations'] = locations!;
    if (onlyActive != null) queryParams['only_active'] = onlyActive.toString();
    if (sortOrder.isNotNullNotEmpty) queryParams['sort_order'] = sortOrder!;
    if (startDate.isNotNullNotEmpty) queryParams['start_date'] = startDate!;

    return queryParams;
  }

  /// Copy with method for immutability
  PreviousStockRequestParams copyWith({
    String? acceptLanguage,
    String? endDate,
    String? items,
    int? limit,
    String? locations,
    bool? onlyActive,
    String? sortOrder,
    String? startDate,
  }) {
    return PreviousStockRequestParams(
      acceptLanguage: acceptLanguage ?? this.acceptLanguage,
      endDate: endDate ?? this.endDate,
      items: items ?? this.items,
      limit: limit ?? this.limit,
      locations: locations ?? this.locations,
      onlyActive: onlyActive ?? this.onlyActive,
      sortOrder: sortOrder ?? this.sortOrder,
      startDate: startDate ?? this.startDate,
    );
  }
}
