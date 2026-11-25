import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/action/data/models/request/payment_request_model.dart';
import 'package:hotel/src/features/action/data/models/response/payment_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class PaymentRemoteDataSource {

  Future<PaymentResponseModel> updatePayment(PaymentRequestModel request);

}

// @LazySingleton(as: PaymentRemoteDataSource)
class PaymentRemoteSourceImpl implements PaymentRemoteDataSource {
  PaymentRemoteSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;


  @override
  Future<PaymentResponseModel> updatePayment(PaymentRequestModel request) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.patch(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.payments}",
        data: request.toJson(),
        options: options,
      );

      if (response.statusCode == 200) {
        print("The response data is ${response.data["updated_payment"]}");
        return PaymentResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

}
