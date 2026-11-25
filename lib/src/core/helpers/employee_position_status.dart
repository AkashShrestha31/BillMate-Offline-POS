import 'package:hotel/src/features/employee_management/data/models/response/employee_model.dart';

/// Known employee positions used for UI / access checks.
abstract final class EmployeePosition {
  static const supervisor = 'Supervisor';
  static const manager = 'Manager';
  static const chef = 'Chef';
}

/// Whether [position] is Supervisor or Manager (invoice month nav, revenue views, etc.).
bool isEmployeeSupervisorOrManager(String? position) {
  final p = position?.trim();
  if (p == null || p.isEmpty) return false;
  return p == EmployeePosition.supervisor || p == EmployeePosition.manager;
}

/// Same check using loaded [employee] from the dashboard cubit.
bool isEmployeeSupervisorOrManagerFrom(EmployeeModel? employee) =>
    isEmployeeSupervisorOrManager(employee?.position);
