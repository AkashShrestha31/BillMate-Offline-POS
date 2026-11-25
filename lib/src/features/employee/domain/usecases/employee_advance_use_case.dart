import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_advance_request_params.dart';
import 'package:hotel/src/features/employee/data/models/response/advance_analysis_response.dart';
import 'package:hotel/src/features/employee/domain/repositories/employee_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EmployeeAdvanceUseCase
    implements
        BaseUseCase<EmployeeAdvanceRequestParams,
            ApiResponse<AdvanceAnalysisResponse>> {
  final EmployeeRepository _employeeRepository;

  EmployeeAdvanceUseCase(this._employeeRepository);

  @override
  Future<Either<AppError, ApiResponse<AdvanceAnalysisResponse>>> execute(
          EmployeeAdvanceRequestParams param) =>
      _employeeRepository.getEmployeeAdvance(params: param);
}
