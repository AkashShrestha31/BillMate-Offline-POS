import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_delete_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class PreviousStockDeleteRemoteDataSource {
  Future<PreviousStockDeleteResponseModel> deletePreviousStockByDate({
    required String confirm,
    required String reportingDate,
  });
}

class PreviousStockDeleteRemoteDataSourceImpl
    implements PreviousStockDeleteRemoteDataSource {
  PreviousStockDeleteRemoteDataSourceImpl(@Named('authenticated') Dio dio)
      : _dio = dio;

  final Dio _dio;

  @override
  Future<PreviousStockDeleteResponseModel> deletePreviousStockByDate({
    required String confirm,
    required String reportingDate,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;

      final response = await _dio.delete(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.previousStockDeleteByDate}",
        queryParameters: {
          'confirm': confirm,
          'reporting_date': reportingDate,
        },
      );

      if (response.statusCode == 200) {
        return PreviousStockDeleteResponseModel.fromJson(response.data);
      } else {
        throw const AppException(
            message: 'Failed to delete previous stock items');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}

