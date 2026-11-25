import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/action/data/models/request/payment_analytics_request_model.dart';
import 'package:hotel/src/features/action/data/models/response/payment_analytics_response_model.dart';

abstract class PaymentAnalyticsRepository {
  Future<Either<AppError, PaymentAnalyticsResponseModel>> getPaymentAnalytics(PaymentAnalyticsRequestModel request);
}
