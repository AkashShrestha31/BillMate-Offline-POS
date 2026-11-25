import 'package:hotel/src/core/extensions/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'party_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PartyRequestParams {
  final int? page;
  final int? perPage;
  final String? partyType;
  /// Local SQLite: match any of these party `role` values (lowercase).
  final List<String>? partyRoles;
  /// Party list filter, e.g. `1` = active (`/api/parties/?status=1&role=employee`).
  final int? status;
  final String? search;
  final String? sortBy;
  final String? sortOrder;

  PartyRequestParams({
    this.page,
    this.perPage = 10,
    this.partyType,
    this.partyRoles,
    this.status,
    this.search,
    this.sortBy = 'name',
    this.sortOrder = 'asc',
  });

  /// Factory method to create an instance from a JSON map
  factory PartyRequestParams.fromJson(Map<String, dynamic> json) =>
      _$PartyRequestParamsFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$PartyRequestParamsToJson(this);

  /// Convert the object into query parameters, including only non-null values
  Map<String, String> toQueryParams() {
    final queryParams = <String, String>{};
    if (page != null) queryParams['page'] = page.toString();
    if (perPage != null) queryParams['per_page'] = perPage.toString();
    if (partyType.isNotNullNotEmpty) queryParams['role'] = partyType!;
    if (status != null) queryParams['status'] = status.toString();
    if (search.isNotNullNotEmpty) queryParams['search'] = search!;
    if (sortBy.isNotNullNotEmpty) queryParams['sort_by'] = sortBy!;
    if (sortOrder.isNotNullNotEmpty) queryParams['sort_order'] = sortOrder!;
    return queryParams;
  }
}
