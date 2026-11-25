import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import '../../data/models/response/employees_list_response_model.dart';
import '../repositories/employee_management_repository.dart';

@lazySingleton
class GetEmployeesUseCase {
  final EmployeeManagementRepository _repository;

  GetEmployeesUseCase(this._repository);

  Future<Either<AppError, EmployeesListResponseModel>> execute({
    String? department,
    String? position,
    String? employmentStatus,
    String? employmentType,
  }) =>
      _repository.getEmployees(
        department: department,
        position: position,
        employmentStatus: employmentStatus,
        employmentType: employmentType,
      );
}
