// employee_advance_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_advance_request_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/employee/data/models/response/advance_analysis_response.dart';
import 'package:hotel/src/features/employee/domain/usecases/employee_advance_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/services/response/api_response.dart';

part 'employee_advance_state.dart';
part 'employee_advance_cubit.freezed.dart';

@injectable
class EmployeeAdvanceCubit extends Cubit<EmployeeAdvanceState> {
  EmployeeAdvanceCubit(this._useCase)
      : super(const EmployeeAdvanceState.initial());

  final EmployeeAdvanceUseCase _useCase;

  void getEmployeeAdvance(
      {required EmployeeAdvanceRequestParams params}) async {
    emit(const EmployeeAdvanceState.loading());
    emit(
      (await _useCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              EmployeeAdvanceState.error(message: serverError),
          noInternet: () => const EmployeeAdvanceState.noInternet(),
        ),
        (data) {
          return EmployeeAdvanceState.success(responseModel: data);
        },
      ),
    );
  }
}
