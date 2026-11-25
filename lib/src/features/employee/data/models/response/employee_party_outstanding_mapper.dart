import 'package:hotel/src/features/employee/data/models/response/employee_outstanding_response.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_party_outstanding_response.dart';

extension EmployeePartyOutstandingResponseMapper on EmployeePartyOutstandingResponse {
  /// Flat shape used by settlement screens and shared [Party] lists.
  EmployeeOutstandingResponse toLegacyEmployeeOutstandingResponse() {
    final p = partyDetails;
    var outstanding = p.outstandingAmount;
    if (outstanding == 0) {
      outstanding = summary.totalOutstandingAmount;
    }

    final byRole = OutstandingByRole(
      customerOutstanding: 0,
      supplierOutstanding: 0,
      employeeOutstanding: outstanding,
      otherOutstanding: 0,
    );

    final roleSummary = RoleSummary(
      customerCount: 0,
      supplierCount: 0,
      employeeCount: 1,
      otherCount: 0,
      totalOutstanding: outstanding,
    );

    const searchDetails = SearchDetails(
      searchTerm: '',
      partyRoleFilter: 'all',
      totalFound: 1,
    );

    final party = Party(
      name: p.name,
      role: p.role,
      email: p.email,
      phone: p.phone,
      currency: p.currency,
      outstandingAmount: outstanding,
      outstandingByRole: byRole,
      created: DateTime.tryParse(p.created) ?? DateTime.fromMillisecondsSinceEpoch(0),
      modified: DateTime.tryParse(p.modified) ?? DateTime.fromMillisecondsSinceEpoch(0),
    );

    return EmployeeOutstandingResponse(
      searchDetails: searchDetails,
      roleSummary: roleSummary,
      outstandingByRole: byRole,
      partiesByRole: PartiesByRole(
        customerParties: const [],
        supplierParties: const [],
        employeeParties: [party],
        otherParties: const [],
      ),
    );
  }
}
