import 'package:hotel/src/features/employee/data/models/response/employee_outstanding_response.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_party_outstanding_response.dart';

/// Discriminates multi-party search vs per-employee lookup from `parties/search`.
sealed class EmployeeOutstandingResult {
  const EmployeeOutstandingResult();

  T when<T>({
    required T Function(EmployeeOutstandingResponse response) search,
    required T Function(EmployeePartyOutstandingResponse response) employeePartyLookup,
  }) {
    final self = this;
    if (self is EmployeeOutstandingSearchResult) {
      return search(self.response);
    }
    if (self is EmployeeOutstandingEmployeePartyLookupResult) {
      return employeePartyLookup(self.response);
    }
    throw StateError('Unknown EmployeeOutstandingResult');
  }
}

final class EmployeeOutstandingSearchResult extends EmployeeOutstandingResult {
  const EmployeeOutstandingSearchResult(this.response);
  final EmployeeOutstandingResponse response;
}

final class EmployeeOutstandingEmployeePartyLookupResult extends EmployeeOutstandingResult {
  const EmployeeOutstandingEmployeePartyLookupResult(this.response);
  final EmployeePartyOutstandingResponse response;
}
