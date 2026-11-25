import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/action/data/datasources/payment_analytics_remote_data_source.dart';
import 'package:hotel/src/features/action/data/models/request/payment_analytics_request_model.dart';
import 'package:hotel/src/features/action/data/models/response/payment_analytics_response_model.dart';
import 'package:hotel/src/features/action/domain/repositories/payment_analytics_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PaymentAnalyticsRepository)
class PaymentAnalyticsRepositoryImpl implements PaymentAnalyticsRepository {
  PaymentAnalyticsRepositoryImpl(this._remoteDataSource);

  final PaymentAnalyticsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppError, PaymentAnalyticsResponseModel>> getPaymentAnalytics(PaymentAnalyticsRequestModel request) async {
          try {
        final response = await _remoteDataSource.getPaymentAnalytics(request);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }
}
