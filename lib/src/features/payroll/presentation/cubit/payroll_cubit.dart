import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/request/generate_payroll_request.dart';
import '../../data/models/request/payroll_query_params.dart';
import '../../data/models/request/update_payment_request.dart';
import '../../data/models/request/delete_payroll_request.dart';
import '../../data/models/response/generate_payroll_response.dart';
import '../../data/models/response/payroll_list_response.dart';
import '../../data/models/response/update_payment_response.dart';
import '../../data/models/response/delete_payroll_response.dart';
import '../../domain/usecases/payroll_use_cases.dart';

part 'payroll_state.dart';
part 'payroll_cubit.freezed.dart';

@injectable
class PayrollCubit extends Cubit<PayrollState> {
  PayrollCubit(
    this._generatePayrollUseCase,
    this._getPayrollsUseCase,
    this._updatePaymentStatusUseCase,
    this._deletePayrollUseCase,
  ) : super(const PayrollState.initial());

  final GeneratePayrollUseCase _generatePayrollUseCase;
  final GetPayrollsUseCase _getPayrollsUseCase;
  final UpdatePaymentStatusUseCase _updatePaymentStatusUseCase;
  final DeletePayrollUseCase _deletePayrollUseCase;

  void generatePayroll({required GeneratePayrollRequest request}) async {
    emit(const PayrollState.loading());

    emit(
      (await _generatePayrollUseCase.execute(request: request)).fold(
        (error) => error.when(
          serverError: (serverError) => PayrollState.error(message: serverError),
          noInternet: () => const PayrollState.noInternet(),
        ),
        (data) => PayrollState.generated(response: data),
      ),
    );
  }

  void getPayrolls({required PayrollQueryParams params}) async {
    emit(const PayrollState.loading());

    emit(
      (await _getPayrollsUseCase.execute(params: params)).fold(
        (error) => error.when(
          serverError: (serverError) => PayrollState.error(message: serverError),
          noInternet: () => const PayrollState.noInternet(),
        ),
        (data) => PayrollState.loaded(response: data),
      ),
    );
  }

  void updatePaymentStatus({required UpdatePaymentRequest request}) async {
    emit(const PayrollState.loading());

    emit(
      (await _updatePaymentStatusUseCase.execute(request: request)).fold(
        (error) => error.when(
          serverError: (serverError) => PayrollState.error(message: serverError),
          noInternet: () => const PayrollState.noInternet(),
        ),
        (data) => PayrollState.paymentUpdated(response: data),
      ),
    );
  }

  void deletePayroll({required DeletePayrollRequest request}) async {
    emit(const PayrollState.loading());

    emit(
      (await _deletePayrollUseCase.execute(request: request)).fold(
        (error) => error.when(
          serverError: (serverError) => PayrollState.error(message: serverError),
          noInternet: () => const PayrollState.noInternet(),
        ),
        (data) => PayrollState.deleted(response: data),
      ),
    );
  }

  void reset() {
    emit(const PayrollState.initial());
  }
}
