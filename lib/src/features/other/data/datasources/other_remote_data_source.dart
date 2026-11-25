import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/other/data/models/item_counter_request_params.dart';
import 'package:hotel/src/features/other/data/models/item_counter_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class OtherRemoteDataSource {
  Future<ApiResponse<ItemCounterResponseModel>> getItemCounter(
      ItemCounterRequestParams params);
}

// @LazySingleton(as: OtherRemoteDataSource)
class OtherRemoteDataSourceImpl implements OtherRemoteDataSource {
  OtherRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<ApiResponse<ItemCounterResponseModel>> getItemCounter(
      ItemCounterRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
          options: options,
          "${dotenv.env['BASE_URL']}${ApiEndPoints.itemCounter}");
      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final itemCounterResponse =
            ItemCounterResponseModel.fromJson(responseData);
        return ApiResponse<ItemCounterResponseModel>(
          data: itemCounterResponse,
          message: '',
          success: true,
        );
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioError catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
