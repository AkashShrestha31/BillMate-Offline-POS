part of 'employee_advance_cubit.dart';

@freezed
class EmployeeAdvanceState with _$EmployeeAdvanceState {
  const factory EmployeeAdvanceState.initial() = _Initial;

  const factory EmployeeAdvanceState.loading() = _Loading;

  const factory EmployeeAdvanceState.noInternet() = _NoInternet;

  const factory EmployeeAdvanceState.error({required String message}) = _Error;

  const factory EmployeeAdvanceState.success(
      {required ApiResponse<AdvanceAnalysisResponse> responseModel}) = _Success;
}
