import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/helpers/logged_in_profile_store.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/request/employee_request_params.dart';
import '../../data/models/response/employees_list_response_model.dart';
import '../../data/models/response/employee_model.dart';
import '../../data/models/response/common_success_response_model.dart';
import '../../domain/usecases/get_employees_use_case.dart';
import '../../domain/usecases/create_employee_use_case.dart';
import '../../domain/repositories/employee_management_repository.dart';

part 'employee_state.dart';
part 'employee_cubit.freezed.dart';

@injectable
class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit(
    this._getEmployeesUseCase,
    this._createEmployeeUseCase,
    this._repository,
  ) : super(const EmployeeState.initial());

  final GetEmployeesUseCase _getEmployeesUseCase;
  final CreateEmployeeUseCase _createEmployeeUseCase;
  final EmployeeManagementRepository _repository;

  void getEmployees({
    String? department,
    String? position,
    String? employmentStatus,
    String? employmentType,
  }) async {
    emit(const EmployeeState.loading());

    emit(
      (await _getEmployeesUseCase.execute(
        department: department,
        position: position,
        employmentStatus: employmentStatus,
        employmentType: employmentType,
      ))
          .fold(
        (error) => error.when(
          serverError: (serverError) =>
              EmployeeState.error(message: serverError),
          noInternet: () => const EmployeeState.noInternet(),
        ),
        (data) => EmployeeState.loaded(response: data),
      ),
    );
  }

  Future<void> getEmployeeById(dynamic id) async {
    emit(const EmployeeState.loading());

    emit(
      (await _repository.getEmployeeById(id)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              EmployeeState.error(message: serverError),
          noInternet: () => const EmployeeState.noInternet(),
        ),
        (data) {
          loggedInProfileStore.captureIfLoggedInUser(data);
          return EmployeeState.employeeDetail(employee: data);
        },
      ),
    );
  }

  void createEmployee({
    required EmployeeRequestParams params,
    required int isActive,
  }) async {
    emit(const EmployeeState.submitting());

    emit(
      (await _createEmployeeUseCase.execute(params: params, isActive: isActive)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              EmployeeState.error(message: serverError),
          noInternet: () => const EmployeeState.noInternet(),
        ),
        (data) => EmployeeState.submitSuccess(response: data),
      ),
    );
  }

  void updateEmployee({
    required int id,
    required EmployeeRequestParams params,
    required int isActive,
  }) async {
    emit(const EmployeeState.submitting());

    emit(
      (await _repository.updateEmployee(id, params, isActive: isActive)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              EmployeeState.error(message: serverError),
          noInternet: () => const EmployeeState.noInternet(),
        ),
        (data) {
          loggedInProfileStore.refreshAfterEmployeeUpdate(id);
          return EmployeeState.submitSuccess(response: data);
        },
      ),
    );
  }

  void deleteEmployee(int id) async {
    print("fafafaf");
    emit(const EmployeeState.submitting());

    emit(
      (await _repository.deleteEmployee(id)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              EmployeeState.error(message: serverError),
          noInternet: () => const EmployeeState.noInternet(),
        ),
        (data) => EmployeeState.submitSuccess(response: data),
      ),
    );
  }

  void reset() {
    emit(const EmployeeState.initial());
  }
}
