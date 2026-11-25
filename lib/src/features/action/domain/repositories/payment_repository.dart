import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/action/data/models/request/payment_request_model.dart';
import 'package:hotel/src/features/action/data/models/response/payment_response_model.dart';

abstract class PaymentRepository {
  Future<Either<AppError, PaymentResponseModel>> updatePayment( PaymentRequestModel request);
}
