import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/action/data/models/request/payment_request_model.dart';
import 'package:hotel/src/features/action/data/models/response/payment_response_model.dart';
import 'package:hotel/src/features/action/domain/usecases/update_payment_use_case.dart';
import 'package:injectable/injectable.dart';

part 'payment_state.dart';
part 'payment_cubit.freezed.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._updateUseCase) : super(const PaymentState.initial());

  final UpdatePaymentUseCase _updateUseCase;

  void updatePayment(PaymentRequestModel request) async {
    emit(const PaymentState.loading());
    emit(
      (await _updateUseCase.execute(request)).fold(
            (error) => error.when(
          serverError: (serverError) => PaymentState.error(message: serverError),
          noInternet: () => const PaymentState.noInternet(),
        ),
            (data) => PaymentState.loaded(payment: data),
      ),
    );
  }

  void resetState() {
    emit(const PaymentState.initial());
  }
}