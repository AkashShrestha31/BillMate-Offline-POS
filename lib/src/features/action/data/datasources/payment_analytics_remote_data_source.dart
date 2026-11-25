import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/action/data/models/request/payment_analytics_request_model.dart';
import 'package:hotel/src/features/action/data/models/response/payment_analytics_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class PaymentAnalyticsRemoteDataSource {
  Future<PaymentAnalyticsResponseModel> getPaymentAnalytics(PaymentAnalyticsRequestModel request);
}

// @LazySingleton(as: PaymentAnalyticsRemoteDataSource)
class PaymentAnalyticsRemoteSourceImpl implements PaymentAnalyticsRemoteDataSource {
  PaymentAnalyticsRemoteSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<PaymentAnalyticsResponseModel> getPaymentAnalytics(PaymentAnalyticsRequestModel request) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.paymentAnalytics}",
        queryParameters: request.toJson(),
        options: options,
      );

      if (response.statusCode == 200) {
        return PaymentAnalyticsResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
