// employee_outstanding_request_params.dart
import 'package:hotel/src/core/extensions/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_outstanding_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EmployeeOutstandingRequestParams {
  final String? acceptLanguage;
  final String? endDate;
  final String? partyRole;
  final String searchTerm;
  final String? startDate;
  final bool? outstandingOnly;
  /// Required by API for `parties/search` — scopes outstanding parties to this employee.
  final int? employeeId;

  EmployeeOutstandingRequestParams({
    this.acceptLanguage = 'en',
    this.endDate,
    this.partyRole = 'all',
    this.searchTerm = '',
    this.startDate,
    this.outstandingOnly = true,
    this.employeeId,
  });

  /// Factory method to create an instance from a JSON map
  factory EmployeeOutstandingRequestParams.fromJson(
          Map<String, dynamic> json) =>
      _$EmployeeOutstandingRequestParamsFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() =>
      _$EmployeeOutstandingRequestParamsToJson(this);

  /// Convert the object into query parameters, including only non-null values
  Map<String, dynamic> toQueryParams() {
    final queryParams = <String, dynamic>{};

    if (acceptLanguage.isNotNullNotEmpty)
      queryParams['accept-language'] = acceptLanguage!;
    if (endDate.isNotNullNotEmpty) queryParams['end_date'] = endDate!;
    if (partyRole.isNotNullNotEmpty) queryParams['party_role'] = partyRole!;
    queryParams['search_term'] = searchTerm;
    if (startDate.isNotNullNotEmpty) queryParams['start_date'] = startDate!;
    queryParams['outstanding_only'] = outstandingOnly!;
    if (employeeId != null) queryParams['employee_id'] = employeeId.toString();

    return queryParams;
  }

  /// Copy with method for immutability
  EmployeeOutstandingRequestParams copyWith({
    String? acceptLanguage,
    String? endDate,
    String? partyRole,
    String? searchTerm,
    String? startDate,
    bool? outstandingOnly,
    int? employeeId,
  }) {
    return EmployeeOutstandingRequestParams(
      acceptLanguage: acceptLanguage ?? this.acceptLanguage,
      endDate: endDate ?? this.endDate,
      partyRole: partyRole ?? this.partyRole,
      searchTerm: searchTerm ?? this.searchTerm,
      startDate: startDate ?? this.startDate,
      outstandingOnly: outstandingOnly ?? this.outstandingOnly,
      employeeId: employeeId ?? this.employeeId,
    );
  }
}
