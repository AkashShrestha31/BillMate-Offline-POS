// employee_outstanding_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_outstanding_request_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_outstanding_result.dart';
import 'package:hotel/src/features/employee/domain/usecases/employee_outstanding_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/services/response/api_response.dart';

part 'employee_outstanding_state.dart';
part 'employee_outstanding_cubit.freezed.dart';

@injectable
class EmployeeOutstandingCubit extends Cubit<EmployeeOutstandingState> {
  EmployeeOutstandingCubit(this._useCase)
      : super(const EmployeeOutstandingState.initial());

  final EmployeeOutstandingUseCase _useCase;

  void getEmployeeOutstanding({
    required EmployeeOutstandingRequestParams params,
    /// When false, keeps the previous UI (e.g. success list) while a new search runs.
    bool emitLoading = true,
  }) async {
    if (emitLoading) {
      emit(const EmployeeOutstandingState.loading());
    }
    emit(
      (await _useCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              EmployeeOutstandingState.error(message: serverError),
          noInternet: () => const EmployeeOutstandingState.noInternet(),
        ),
        (data) {
          return EmployeeOutstandingState.success(responseModel: data);
        },
      ),
    );
  }
}
