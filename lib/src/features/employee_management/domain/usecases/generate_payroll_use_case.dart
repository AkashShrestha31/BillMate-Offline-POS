import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import '../../data/models/request/payroll_request_params.dart';
import '../../data/models/response/common_success_response_model.dart';
import '../repositories/employee_management_repository.dart';

@lazySingleton
class GeneratePayrollUseCase {
  final EmployeeManagementRepository _repository;

  GeneratePayrollUseCase(this._repository);

  Future<Either<AppError, CommonSuccessResponseModel>> execute({
    required PayrollRequestParams params,
  }) =>
      _repository.generatePayroll(params);
}
