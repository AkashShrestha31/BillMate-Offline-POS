import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import '../../data/models/response/payroll_list_response_model.dart';
import '../repositories/employee_management_repository.dart';

@lazySingleton
class GetPayrollsUseCase {
  final EmployeeManagementRepository _repository;

  GetPayrollsUseCase(this._repository);

  Future<Either<AppError, PayrollListResponseModel>> execute({
    int? employeeId,
    String? payrollMonth,
    String? paymentStatus,
  }) =>
      _repository.getPayrolls(
        employeeId: employeeId,
        payrollMonth: payrollMonth,
        paymentStatus: paymentStatus,
      );
}
