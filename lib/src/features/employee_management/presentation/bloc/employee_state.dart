part of 'employee_cubit.dart';

@freezed
class EmployeeState with _$EmployeeState {
  const factory EmployeeState.initial() = _Initial;
  const factory EmployeeState.loading() = _Loading;
  const factory EmployeeState.submitting() = _Submitting;
  const factory EmployeeState.noInternet() = _NoInternet;
  const factory EmployeeState.error({required String message}) = _Error;
  const factory EmployeeState.loaded({
    required EmployeesListResponseModel response,
  }) = _Loaded;
  const factory EmployeeState.employeeDetail({
    required EmployeeModel employee,
  }) = _EmployeeDetail;
  const factory EmployeeState.submitSuccess({
    required CommonSuccessResponseModel response,
  }) = _SubmitSuccess;
}
