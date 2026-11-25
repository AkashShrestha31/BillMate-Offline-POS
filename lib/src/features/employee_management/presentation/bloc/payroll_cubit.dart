import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/request/payroll_request_params.dart';
import '../../data/models/response/payroll_list_response_model.dart';
import '../../data/models/response/payroll_model.dart';
import '../../data/models/response/common_success_response_model.dart';
import '../../domain/usecases/get_payrolls_use_case.dart';
import '../../domain/usecases/generate_payroll_use_case.dart';
import '../../domain/repositories/employee_management_repository.dart';

part 'payroll_state.dart';
part 'payroll_cubit.freezed.dart';

@injectable
class PayrollCubit extends Cubit<PayrollState> {
  PayrollCubit(
    this._getPayrollsUseCase,
    this._generatePayrollUseCase,
    this._repository,
  ) : super(const PayrollState.initial());

  final GetPayrollsUseCase _getPayrollsUseCase;
  final GeneratePayrollUseCase _generatePayrollUseCase;
  final EmployeeManagementRepository _repository;

  void getPayrolls({
    int? employeeId,
    String? payrollMonth,
    String? paymentStatus,
  }) async {
    emit(const PayrollState.loading());

    emit(
      (await _getPayrollsUseCase.execute(
        employeeId: employeeId,
        payrollMonth: payrollMonth,
        paymentStatus: paymentStatus,
      ))
          .fold(
        (error) => error.when(
          serverError: (serverError) =>
              PayrollState.error(message: serverError),
          noInternet: () => const PayrollState.noInternet(),
        ),
        (data) => PayrollState.loaded(response: data),
      ),
    );
  }

  void getPayrollById(int id) async {
    emit(const PayrollState.loading());

    emit(
      (await _repository.getPayrollById(id)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              PayrollState.error(message: serverError),
          noInternet: () => const PayrollState.noInternet(),
        ),
        (data) => PayrollState.payrollDetail(payroll: data),
      ),
    );
  }

  void generatePayroll({required PayrollRequestParams params}) async {
    emit(const PayrollState.submitting());

    emit(
      (await _generatePayrollUseCase.execute(params: params)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              PayrollState.error(message: serverError),
          noInternet: () => const PayrollState.noInternet(),
        ),
        (data) => PayrollState.submitSuccess(response: data),
      ),
    );
  }

  void updatePayroll({
    required int id,
    required PayrollRequestParams params,
  }) async {
    emit(const PayrollState.submitting());

    emit(
      (await _repository.updatePayroll(id, params)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              PayrollState.error(message: serverError),
          noInternet: () => const PayrollState.noInternet(),
        ),
        (data) => PayrollState.submitSuccess(response: data),
      ),
    );
  }

  void reset() {
    emit(const PayrollState.initial());
  }
}
