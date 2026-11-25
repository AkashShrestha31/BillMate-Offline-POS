import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import '../../data/models/response/leave_applications_list_response_model.dart';
import '../repositories/employee_management_repository.dart';

@lazySingleton
class GetLeaveApplicationsUseCase {
  final EmployeeManagementRepository _repository;

  GetLeaveApplicationsUseCase(this._repository);

  Future<Either<AppError, LeaveApplicationsListResponseModel>> execute({
    int? employeeId,
    String? status,
    int? leaveTypeId,
    String? dateFrom,
    String? dateTo,
  }) =>
      _repository.getLeaveApplications(
        employeeId: employeeId,
        status: status,
        leaveTypeId: leaveTypeId,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );
}
