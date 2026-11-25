import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/action/data/models/request/payment_analytics_request_model.dart';
import 'package:hotel/src/features/action/data/models/response/payment_analytics_response_model.dart';
import 'package:hotel/src/features/action/domain/repositories/payment_analytics_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PaymentAnalyticsUseCase implements BaseUseCase<PaymentAnalyticsRequestModel, PaymentAnalyticsResponseModel> {
  final PaymentAnalyticsRepository _repository;

  PaymentAnalyticsUseCase(this._repository);

  @override
  Future<Either<AppError, PaymentAnalyticsResponseModel>> execute(PaymentAnalyticsRequestModel param) =>
      _repository.getPaymentAnalytics(param);
}
