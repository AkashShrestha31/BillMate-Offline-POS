// employee_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/employee/data/datasources/employee_remote_data_source.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_outstanding_request_params.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_advance_request_params.dart';
import 'package:hotel/src/features/employee/data/models/response/advance_analysis_response.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_outstanding_result.dart';
import 'package:hotel/src/features/employee/domain/repositories/employee_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EmployeeRepository)
class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl(this._employeeRemoteSource);

  final EmployeeRemoteDataSource _employeeRemoteSource;

  @override
  Future<Either<AppError, ApiResponse<EmployeeOutstandingResult>>>
      getEmployeeOutstanding(
          {required EmployeeOutstandingRequestParams params}) async {
          try {
        final response =
            await _employeeRemoteSource.getEmployeeOutstanding(params: params);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }

  @override
  Future<Either<AppError, ApiResponse<AdvanceAnalysisResponse>>>
      getEmployeeAdvance({required EmployeeAdvanceRequestParams params}) async {
          try {
        final response =
            await _employeeRemoteSource.getEmployeeAdvance(params: params);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }
}
