import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_create_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_update_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/pricing_create_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/pricing_update_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/response/liquor_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class LiquorRemoteDataSource {
  Future<ApiResponse<LiquorResponseModel>> getLiquorItems({required LiquorRequestParams params});
  Future<ApiResponse<String>> createLiquorItem({required LiquorCreateRequestParams params});
  Future<ApiResponse<String>> updateLiquorItem({required LiquorUpdateRequestParams params});
  Future<ApiResponse<String>> deleteLiquorItem({required int id});
  Future<ApiResponse<void>> createPricing({required PricingCreateRequestParams params});
  Future<ApiResponse<void>> updatePricing({required PricingUpdateRequestParams params});
}

// @LazySingleton(as: LiquorRemoteDataSource) — local datasource is used for offline-first mode.
class LiquorRemoteDataSourceImpl implements LiquorRemoteDataSource {
  LiquorRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<ApiResponse<LiquorResponseModel>> getLiquorItems({required LiquorRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.liquorItems}",
        queryParameters: params.toQueryParams(),
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          data: LiquorResponseModel.fromJson(response.data),
          message: '',
          success: true,
        );
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<String>> createLiquorItem({required LiquorCreateRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.liquorItems}",
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        return ApiResponse(
          data: response.data["message"],
          message: 'Liquor item created successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<String>> updateLiquorItem({required LiquorUpdateRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.liquorItems}",
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          data: response.data['message'],
          message: 'Liquor item updated successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<String>> deleteLiquorItem({required int id}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.delete(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.liquorItems}",
        queryParameters: {'id': id},
      );
      if (response.statusCode == 200) {
        return  ApiResponse(
          data: response.data["message"],
          message: 'Liquor item deleted successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<void>> createPricing({required PricingCreateRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.liquorPricing}",
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        return const ApiResponse(
          data: null,
          message: 'Pricing created successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<void>> updatePricing({required PricingUpdateRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.liquorPricing}",
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        return const ApiResponse(
          data: null,
          message: 'Pricing updated successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
