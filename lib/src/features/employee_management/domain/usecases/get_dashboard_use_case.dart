import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import '../../data/models/response/dashboard_response_model.dart';
import '../repositories/employee_management_repository.dart';

@lazySingleton
class GetDashboardUseCase {
  final EmployeeManagementRepository _repository;

  GetDashboardUseCase(this._repository);

  Future<Either<AppError, DashboardResponseModel>> execute() =>
      _repository.getDashboard();
}
