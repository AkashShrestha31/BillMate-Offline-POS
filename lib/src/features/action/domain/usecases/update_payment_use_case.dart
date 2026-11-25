import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/action/data/models/request/payment_request_model.dart';
import 'package:hotel/src/features/action/data/models/response/payment_response_model.dart';
import 'package:hotel/src/features/action/domain/repositories/payment_repository.dart';
import 'package:injectable/injectable.dart';

class UpdatePaymentParams {
  final PaymentRequestModel request;

  const UpdatePaymentParams({required this.request});
}

@lazySingleton
class UpdatePaymentUseCase implements BaseUseCase<PaymentRequestModel, PaymentResponseModel> {
  final PaymentRepository _repository;

  UpdatePaymentUseCase(this._repository);

  @override
  Future<Either<AppError, PaymentResponseModel>> execute(PaymentRequestModel param) =>
      _repository.updatePayment(param);
}
