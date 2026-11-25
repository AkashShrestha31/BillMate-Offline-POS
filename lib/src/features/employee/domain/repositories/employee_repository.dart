import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_outstanding_request_params.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_advance_request_params.dart';
import 'package:hotel/src/features/employee/data/models/response/advance_analysis_response.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_outstanding_result.dart';

abstract class EmployeeRepository {
  Future<Either<AppError, ApiResponse<EmployeeOutstandingResult>>>
      getEmployeeOutstanding(
          {required EmployeeOutstandingRequestParams params});

  Future<Either<AppError, ApiResponse<AdvanceAnalysisResponse>>>
      getEmployeeAdvance({required EmployeeAdvanceRequestParams params});
}
