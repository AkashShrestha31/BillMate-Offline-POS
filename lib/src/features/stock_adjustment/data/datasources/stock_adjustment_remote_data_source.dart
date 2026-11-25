import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/stock_adjustment/data/models/request/stock_adjustment_request_params.dart';
import 'package:hotel/src/features/stock_adjustment/data/models/response/stock_adjustment_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class StockAdjustmentRemoteDataSource {
  Future<ApiResponse<StockAdjustmentResponseModel>> createStockAdjustment(
      {required StockAdjustmentRequestParams params});

  Future<ApiResponse<List<StockAdjustmentResponseModel>>> getStockAdjustments({
    int? page,
    int? perPage,
    String? sortOrder,
  });
}

// @LazySingleton(as: StockAdjustmentRemoteDataSource)
class StockAdjustmentRemoteSourceImpl
    implements StockAdjustmentRemoteDataSource {
  StockAdjustmentRemoteSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<ApiResponse<StockAdjustmentResponseModel>> createStockAdjustment(
      {required StockAdjustmentRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.stockAdjustment}",
        options: options,
        data: params.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          data: StockAdjustmentResponseModel.fromJson(response.data),
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
  Future<ApiResponse<List<StockAdjustmentResponseModel>>> getStockAdjustments({
    int? page,
    int? perPage,
    String? sortOrder,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final queryParams = <String, dynamic>{};

      if (page != null) queryParams['page'] = page;
      if (perPage != null) queryParams['per_page'] = perPage;
      if (sortOrder != null) queryParams['sort_order'] = sortOrder;

      final response = await _dio.get(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.stockAdjustment}",
        options: options,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final adjustments = data
            .map((item) => StockAdjustmentResponseModel.fromJson(item))
            .toList();

        return ApiResponse(
          data: adjustments,
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
}
