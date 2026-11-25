import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_outstanding_request_params.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_outstanding_result.dart';
import 'package:hotel/src/features/employee/domain/repositories/employee_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EmployeeOutstandingUseCase
    implements
        BaseUseCase<EmployeeOutstandingRequestParams,
            ApiResponse<EmployeeOutstandingResult>> {
  final EmployeeRepository _employeeRepository;

  EmployeeOutstandingUseCase(this._employeeRepository);

  @override
  Future<Either<AppError, ApiResponse<EmployeeOutstandingResult>>> execute(
          EmployeeOutstandingRequestParams param) =>
      _employeeRepository.getEmployeeOutstanding(params: param);
}
