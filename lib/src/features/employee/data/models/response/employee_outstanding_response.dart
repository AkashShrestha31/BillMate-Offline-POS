import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_outstanding_response.freezed.dart';
part 'employee_outstanding_response.g.dart';

@freezed
class EmployeeOutstandingResponse with _$EmployeeOutstandingResponse {
  const factory EmployeeOutstandingResponse({
    @JsonKey(name: 'search_details') required SearchDetails searchDetails,
    @JsonKey(name: 'role_summary') required RoleSummary roleSummary,
    @JsonKey(name: 'outstanding_by_role')
    required OutstandingByRole outstandingByRole,
    @JsonKey(name: 'parties_by_role') required PartiesByRole partiesByRole,
  }) = _EmployeeOutstandingResponse;

  factory EmployeeOutstandingResponse.fromJson(Map<String, dynamic> json) =>
      _$EmployeeOutstandingResponseFromJson(json);
}

@freezed
class SearchDetails with _$SearchDetails {
  const factory SearchDetails({
    @JsonKey(name: 'search_term') required String searchTerm,
    @JsonKey(name: 'party_role_filter') required String partyRoleFilter,
    @JsonKey(name: 'total_found') required int totalFound,
  }) = _SearchDetails;

  factory SearchDetails.fromJson(Map<String, dynamic> json) =>
      _$SearchDetailsFromJson(json);
}

@freezed
class RoleSummary with _$RoleSummary {
  const factory RoleSummary({
    @JsonKey(name: 'customer_count') required int customerCount,
    @JsonKey(name: 'supplier_count') required int supplierCount,
    @JsonKey(name: 'employee_count') required int employeeCount,
    @JsonKey(name: 'other_count') required int otherCount,
    @JsonKey(name: 'total_outstanding') required double totalOutstanding,
  }) = _RoleSummary;

  factory RoleSummary.fromJson(Map<String, dynamic> json) =>
      _$RoleSummaryFromJson(json);
}

@freezed
class OutstandingByRole with _$OutstandingByRole {
  const factory OutstandingByRole({
    @JsonKey(name: 'customer_outstanding') required double customerOutstanding,
    @JsonKey(name: 'supplier_outstanding') required double supplierOutstanding,
    @JsonKey(name: 'employee_outstanding') required double employeeOutstanding,
    @JsonKey(name: 'other_outstanding') required double otherOutstanding,
  }) = _OutstandingByRole;

  factory OutstandingByRole.fromJson(Map<String, dynamic> json) =>
      _$OutstandingByRoleFromJson(json);
}

@freezed
class PartiesByRole with _$PartiesByRole {
  const factory PartiesByRole({
    @JsonKey(name: 'customer_parties') required List<Party> customerParties,
    @JsonKey(name: 'supplier_parties') required List<Party> supplierParties,
    @JsonKey(name: 'employee_parties') required List<Party> employeeParties,
    @JsonKey(name: 'other_parties') required List<Party> otherParties,
  }) = _PartiesByRole;

  factory PartiesByRole.fromJson(Map<String, dynamic> json) =>
      _$PartiesByRoleFromJson(json);
}

@freezed
class Party with _$Party {
  const factory Party({
    required String name,
    required String role,
    String? email,
    String? phone,
    required String currency,
    @JsonKey(name: 'outstanding_amount') required double outstandingAmount,
    @JsonKey(name: 'outstanding_by_role')
    required OutstandingByRole outstandingByRole,
    required DateTime created,
    required DateTime modified,
  }) = _Party;

  factory Party.fromJson(Map<String, dynamic> json) => _$PartyFromJson(json);
}
