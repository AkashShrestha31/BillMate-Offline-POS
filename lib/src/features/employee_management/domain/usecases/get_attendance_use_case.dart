import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import '../../data/models/response/attendance_list_response_model.dart';
import '../repositories/employee_management_repository.dart';

@lazySingleton
class GetAttendanceUseCase {
  final EmployeeManagementRepository _repository;

  GetAttendanceUseCase(this._repository);

  Future<Either<AppError, AttendanceListResponseModel>> execute({
    int? employeeId,
    String? dateFrom,
    String? dateTo,
    String? attendanceStatus,
  }) =>
      _repository.getAttendance(
        employeeId: employeeId,
        dateFrom: dateFrom,
        dateTo: dateTo,
        attendanceStatus: attendanceStatus,
      );
}
