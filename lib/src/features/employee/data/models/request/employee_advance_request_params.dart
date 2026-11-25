// employee_advance_request_params.dart
import 'package:hotel/src/core/extensions/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_advance_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EmployeeAdvanceRequestParams {
  final String? acceptLanguage;
  final String? invoiceType;
  final String? partyName;
  final String? endDate;
  final String? groupBy;
  final String? itemSearch;
  final String? items;
  final int? limit;
  final String? sortBy;
  final String? sortOrder;
  final String? startDate;
  final String? suppliers;
  /// API query `employee_id` — limits analysis to one employee.
  final int? employeeId;
  final String? department;
  final String? advanceType;

  EmployeeAdvanceRequestParams({
    this.acceptLanguage = 'en',
    this.invoiceType = 'all',
    this.partyName,
    this.endDate,
    this.groupBy,
    this.itemSearch,
    this.items,
    this.limit,
    this.sortBy = 'total_amount',
    this.sortOrder = 'desc',
    this.startDate,
    this.suppliers,
    this.employeeId,
    this.department,
    this.advanceType,
  });

  /// Factory method to create an instance from a JSON map
  factory EmployeeAdvanceRequestParams.fromJson(Map<String, dynamic> json) =>
      _$EmployeeAdvanceRequestParamsFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$EmployeeAdvanceRequestParamsToJson(this);

  /// Convert the object into query parameters, including only non-null values
  Map<String, String> toQueryParams() {
    final queryParams = <String, String>{};

    if (acceptLanguage.isNotNullNotEmpty)
      queryParams['accept-language'] = acceptLanguage!;
    if (invoiceType.isNotNullNotEmpty)
      queryParams['invoice_type'] = invoiceType!;
    if (partyName.isNotNullNotEmpty) queryParams['party_name'] = partyName!;
    if (endDate.isNotNullNotEmpty) queryParams['end_date'] = endDate!;
    if (groupBy.isNotNullNotEmpty) queryParams['group_by'] = groupBy!;
    if (itemSearch.isNotNullNotEmpty) queryParams['item_search'] = itemSearch!;
    if (items.isNotNullNotEmpty) queryParams['items'] = items!;
    if (limit != null) queryParams['limit'] = limit.toString();
    if (sortBy.isNotNullNotEmpty) queryParams['sort_by'] = sortBy!;
    if (sortOrder.isNotNullNotEmpty) queryParams['sort_order'] = sortOrder!;
    if (startDate.isNotNullNotEmpty) queryParams['start_date'] = startDate!;
    if (suppliers.isNotNullNotEmpty) queryParams['suppliers'] = suppliers!;
    if (employeeId != null) queryParams['employee_id'] = employeeId.toString();
    if (department.isNotNullNotEmpty) queryParams['department'] = department!;
    if (advanceType.isNotNullNotEmpty)
      queryParams['advance_type'] = advanceType!;

    return queryParams;
  }
}
