import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/employee/data/datasources/employee_remote_data_source.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_advance_request_params.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_outstanding_request_params.dart';
import 'package:hotel/src/features/employee/data/models/response/advance_analysis_response.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_outstanding_response.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_outstanding_result.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EmployeeRemoteDataSource)
class EmployeeLocalDataSource implements EmployeeRemoteDataSource {
  @override
  Future<ApiResponse<EmployeeOutstandingResult>> getEmployeeOutstanding({
    required EmployeeOutstandingRequestParams params,
  }) async {
    final result = EmployeeOutstandingSearchResult(
      EmployeeOutstandingResponse(
        searchDetails: SearchDetails(
          searchTerm: params.searchTerm,
          partyRoleFilter: params.partyRole ?? '',
          totalFound: 0,
        ),
        roleSummary: RoleSummary(
          customerCount: 0, supplierCount: 0, employeeCount: 0,
          otherCount: 0, totalOutstanding: 0.0,
        ),
        outstandingByRole: OutstandingByRole(
          customerOutstanding: 0.0, supplierOutstanding: 0.0,
          employeeOutstanding: 0.0, otherOutstanding: 0.0,
        ),
        partiesByRole: PartiesByRole(
          customerParties: [], supplierParties: [],
          employeeParties: [], otherParties: [],
        ),
      ),
    );
    return ApiResponse(data: result, message: '', success: true);
  }

  @override
  Future<ApiResponse<AdvanceAnalysisResponse>> getEmployeeAdvance({
    required EmployeeAdvanceRequestParams params,
  }) async {
    return ApiResponse(
      data: AdvanceAnalysisResponse(
        analysisData: [],
        summary: AdvanceSummary(
          totalInvoices: 0, totalEmployees: 0, totalDepartments: 0,
          totalItems: 0, grandTotalAmount: 0.0, grandTotalQuantity: 0,
          overallAverageAmount: 0.0, grandTotalDiscount: 0.0,
        ),
        topEmployees: [],
        topDepartments: [],
        filtersApplied: FiltersApplied(
          employees: [], employeeId: null, itemSearch: null,
          startDate: null, endDate: null, groupBy: 'month',
          sortBy: 'amount', sortOrder: 'desc', limit: null,
        ),
        metadata: AdvanceMetadata(
          totalRecords: 0, groupBy: 'month', hasLimit: false,
        ),
      ),
      message: '',
      success: true,
    );
  }
}
