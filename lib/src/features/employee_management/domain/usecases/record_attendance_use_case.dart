import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import '../../data/models/request/attendance_request_params.dart';
import '../../data/models/response/common_success_response_model.dart';
import '../repositories/employee_management_repository.dart';

@lazySingleton
class RecordAttendanceUseCase {
  final EmployeeManagementRepository _repository;

  RecordAttendanceUseCase(this._repository);

  Future<Either<AppError, CommonSuccessResponseModel>> execute({
    required AttendanceRequestParams params,
  }) =>
      _repository.recordAttendance(params);
}
