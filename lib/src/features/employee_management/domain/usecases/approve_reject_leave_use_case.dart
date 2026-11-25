import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import '../../data/models/request/leave_approval_request_params.dart';
import '../../data/models/response/common_success_response_model.dart';
import '../repositories/employee_management_repository.dart';

@lazySingleton
class ApproveRejectLeaveUseCase {
  final EmployeeManagementRepository _repository;

  ApproveRejectLeaveUseCase(this._repository);

  Future<Either<AppError, CommonSuccessResponseModel>> execute({
    required int id,
    required LeaveApprovalRequestParams params,
  }) =>
      _repository.approveRejectLeaveApplication(id, params);
}
