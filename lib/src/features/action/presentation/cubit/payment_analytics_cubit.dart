import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/action/data/models/request/payment_analytics_request_model.dart';
import 'package:hotel/src/features/action/data/models/response/payment_analytics_response_model.dart';
import 'package:hotel/src/features/action/domain/usecases/payment_analytics_use_case.dart';
import 'package:injectable/injectable.dart';

part 'payment_analytics_state.dart';
part 'payment_analytics_cubit.freezed.dart';

@injectable
class PaymentAnalyticsCubit extends Cubit<PaymentAnalyticsState> {
  PaymentAnalyticsCubit(this._useCase) : super(const PaymentAnalyticsState.initial());

  final PaymentAnalyticsUseCase _useCase;

  void getPaymentAnalytics(PaymentAnalyticsRequestModel request) async {
    emit(const PaymentAnalyticsState.loading());
    emit(
      (await _useCase.execute(request)).fold(
        (error) => error.when(
          serverError: (serverError) => PaymentAnalyticsState.error(message: serverError),
          noInternet: () => const PaymentAnalyticsState.noInternet(),
        ),
        (data) => PaymentAnalyticsState.success(responseModel: data),
      ),
    );
  }

  void resetState() {
    emit(const PaymentAnalyticsState.initial());
  }
}
