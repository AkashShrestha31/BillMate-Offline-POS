import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_bulk_edit_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_bulk_edit_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';

abstract class PreviousStockEditRemoteDataSource {
  Future<PreviousStockBulkEditResponseModel> bulkEditPreviousStock({
    required PreviousStockBulkEditRequestParams params,
  });
}

class PreviousStockEditRemoteDataSourceImpl implements PreviousStockEditRemoteDataSource {
  PreviousStockEditRemoteDataSourceImpl(
    @Named('authenticated') Dio dio,
  ) : _dio = dio;

  final Dio _dio;

  @override
  Future<PreviousStockBulkEditResponseModel> bulkEditPreviousStock({
    required PreviousStockBulkEditRequestParams params,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;

      final response = await _dio.post(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.previousStockBulkEdit}",
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        return PreviousStockBulkEditResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to update previous stock items');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
