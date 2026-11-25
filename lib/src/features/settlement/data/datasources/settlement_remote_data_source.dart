import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/settlement/data/models/request/settlement_request_params.dart';
import 'package:hotel/src/features/settlement/data/models/response/settlement_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class SettlementRemoteDataSource {
  Future<ApiResponse<SettlementResponseModel>> createSettlement(
      {required SettlementRequestParams params});
}

// @LazySingleton(as: SettlementRemoteDataSource)
class SettlementRemoteDataSourceImpl implements SettlementRemoteDataSource {
  SettlementRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<ApiResponse<SettlementResponseModel>> createSettlement(
      {required SettlementRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.settlement}",
        data: params.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          data: SettlementResponseModel.fromJson(response.data),
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
