import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/services/token_storage.dart';
import 'package:hotel/src/features/employee_management/data/models/response/employee_model.dart';
import 'package:hotel/src/features/employee_management/domain/repositories/employee_management_repository.dart';
import 'package:hotel/src/features/employee_management/presentation/bloc/employee_cubit.dart';

/// Caches the logged-in user's [EmployeeModel] and refreshes app-scoped [EmployeeCubit].
class LoggedInProfileStore {
  EmployeeModel? _employee;
  EmployeeCubit? _appEmployeeCubit;

  EmployeeModel? get employee => _employee;

  String get displayName {
    final e = _employee;
    if (e == null) return '';
    return e.displayName;
  }

  void bindAppEmployeeCubit(EmployeeCubit cubit) => _appEmployeeCubit = cubit;

  void clear() {
    _employee = null;
    _appEmployeeCubit = null;
  }

  /// Call when [EmployeeCubit] loads employee detail (e.g. dashboard by login email).
  Future<void> captureIfLoggedInUser(EmployeeModel employee) async {
    if (!await _matchesLoggedInUser(employee)) return;
    _employee = employee;
  }

  /// After editing an employee, refresh session if it is the logged-in user.
  Future<void> refreshAfterEmployeeUpdate(int employeeId) async {
    final loginEmail = await SessionHelper.getLoggedInEmail();
    if (loginEmail == null) return;

    final result = await getIt<EmployeeManagementRepository>().getEmployeeById(employeeId);
    await result.fold((_) async {}, (employee) async {
      if (!_isSelfAfterUpdate(employee, loginEmail, employeeId)) return;

      final newEmail = employee.email?.trim().toLowerCase() ?? '';
      if (newEmail.isNotEmpty && newEmail != loginEmail) {
        await TokenStorage.saveUserLoginEmail(newEmail);
      }

      _employee = employee;
      await _appEmployeeCubit?.getEmployeeById(employee.id);
    });
  }

  bool _isSelfAfterUpdate(EmployeeModel employee, String loginEmail, int editedId) {
    if (_employee != null && employee.id == _employee!.id) return true;
    if (employee.id == editedId) {
      final empEmail = employee.email?.trim().toLowerCase() ?? '';
      if (empEmail == loginEmail) return true;
      if (_employee?.id == editedId) return true;
    }
    final empEmail = employee.email?.trim().toLowerCase() ?? '';
    return empEmail.isNotEmpty && empEmail == loginEmail;
  }

  Future<bool> _matchesLoggedInUser(EmployeeModel employee) async {
    final loginEmail = await SessionHelper.getLoggedInEmail();
    if (loginEmail == null) return false;
    final empEmail = employee.email?.trim().toLowerCase() ?? '';
    return empEmail.isNotEmpty && empEmail == loginEmail;
  }
}

LoggedInProfileStore get loggedInProfileStore => getIt<LoggedInProfileStore>();
