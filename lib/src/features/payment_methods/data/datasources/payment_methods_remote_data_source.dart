import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_method_item.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_method_request.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_methods_query.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_methods_response.dart';
import 'package:injectable/injectable.dart';

abstract class PaymentMethodsRemoteDataSource {
  Future<PaymentMethodsResponse> getPaymentMethods(PaymentMethodsQuery query);
  Future<PaymentMethodItem> getPaymentMethod(String name);
  Future<PaymentMethodItem> createPaymentMethod(PaymentMethodRequest request);
  Future<PaymentMethodItem> updatePaymentMethod({
    required String name,
    required PaymentMethodRequest request,
  });
  Future<void> deletePaymentMethod(String name);
}

// @LazySingleton(as: PaymentMethodsRemoteDataSource)
class PaymentMethodsRemoteDataSourceImpl implements PaymentMethodsRemoteDataSource {
  PaymentMethodsRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  String get _base => dotenv.env['BASE_URL'] ?? '';

  Future<Options> _options() => scaffoldKey.currentContext!.authorizedOptions;

  PaymentMethodItem _parseItem(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) {
      return PaymentMethodItem.fromJson(data);
    }
    if (json.containsKey('name')) {
      return PaymentMethodItem.fromJson(json);
    }
    throw const AppException(message: 'Invalid payment method response');
  }

  @override
  Future<PaymentMethodsResponse> getPaymentMethods(PaymentMethodsQuery query) async {
    try {
      final response = await _dio.get(
        '$_base${ApiEndPoints.paymentMethodsList}',
        queryParameters: query.toQueryParameters(),
        options: await _options(),
      );

      if (response.statusCode == 200) {
        final raw = response.data;
        if (raw is! Map) {
          throw const AppException(message: 'Invalid payment methods response');
        }
        return PaymentMethodsResponse.fromJson(Map<String, dynamic>.from(raw));
      }
      throw const AppException(message: 'Failed to load payment methods');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<PaymentMethodItem> getPaymentMethod(String name) async {
    try {
      final response = await _dio.get(
        '$_base${ApiEndPoints.paymentMethodByName(name)}',
        options: await _options(),
      );
      if (response.statusCode == 200 && response.data is Map) {
        return _parseItem(Map<String, dynamic>.from(response.data as Map));
      }
      throw const AppException(message: 'Payment method not found');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<PaymentMethodItem> createPaymentMethod(PaymentMethodRequest request) async {
    try {
      final response = await _dio.post(
        '$_base${ApiEndPoints.paymentMethodsList}',
        data: request.toJson(),
        options: await _options(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map) {
          return _parseItem(Map<String, dynamic>.from(response.data as Map));
        }
        return PaymentMethodItem(
          name: request.name,
          type: request.type,
          account: request.account,
        );
      }
      throw const AppException(message: 'Failed to create payment method');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<PaymentMethodItem> updatePaymentMethod({
    required String name,
    required PaymentMethodRequest request,
  }) async {
    try {
      final response = await _dio.put(
        '$_base${ApiEndPoints.paymentMethodByName(name)}',
        data: request.toJson(),
        options: await _options(),
      );
      if (response.statusCode == 200) {
        if (response.data is Map) {
          return _parseItem(Map<String, dynamic>.from(response.data as Map));
        }
        return PaymentMethodItem(
          name: request.name,
          type: request.type,
          account: request.account,
        );
      }
      throw const AppException(message: 'Failed to update payment method');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<void> deletePaymentMethod(String name) async {
    try {
      await _dio.delete(
        '$_base${ApiEndPoints.paymentMethodByName(name)}',
        options: await _options(),
      );
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
