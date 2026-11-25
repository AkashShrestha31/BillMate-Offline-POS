part of 'employee_outstanding_cubit.dart';

@freezed
class EmployeeOutstandingState with _$EmployeeOutstandingState {
  const factory EmployeeOutstandingState.initial() = _Initial;

  const factory EmployeeOutstandingState.loading() = _Loading;

  const factory EmployeeOutstandingState.noInternet() = _NoInternet;

  const factory EmployeeOutstandingState.error({required String message}) =
      _Error;

  const factory EmployeeOutstandingState.success(
          {required ApiResponse<EmployeeOutstandingResult> responseModel}) =
      _Success;
}
