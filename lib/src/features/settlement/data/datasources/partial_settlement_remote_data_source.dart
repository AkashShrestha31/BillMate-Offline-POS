import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/settlement/data/models/request/partial_settlement_request_params.dart';
import 'package:hotel/src/features/settlement/data/models/response/partial_settlement_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class PartialSettlementRemoteDataSource {
  Future<PartialSettlementResponseModel> partialSettlement({required PartialSettlementRequestParams params});
}

// @LazySingleton(as: PartialSettlementRemoteDataSource)
class PartialSettlementRemoteSourceImpl implements PartialSettlementRemoteDataSource {
  PartialSettlementRemoteSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<PartialSettlementResponseModel> partialSettlement({required PartialSettlementRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.partialSettlement}",
        options: options,
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        return PartialSettlementResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
