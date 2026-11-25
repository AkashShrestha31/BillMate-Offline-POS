import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import '../../data/models/response/leave_balance_list_response_model.dart';
import '../repositories/employee_management_repository.dart';

@lazySingleton
class GetLeaveBalanceUseCase {
  final EmployeeManagementRepository _repository;

  GetLeaveBalanceUseCase(this._repository);

  Future<Either<AppError, LeaveBalanceListResponseModel>> execute({
    int? employeeId,
    int? year,
    int? leaveTypeId,
  }) =>
      _repository.getLeaveBalance(
        employeeId: employeeId,
        year: year,
        leaveTypeId: leaveTypeId,
      );
}
