import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_details_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_details_response_model.dart';

abstract class PreviousStockDetailsRemoteDataSource {
  Future<PreviousStockDetailsResponseModel> getPreviousStockDetails({
    required PreviousStockDetailsRequestParams params,
  });
}

class PreviousStockDetailsRemoteDataSourceImpl implements PreviousStockDetailsRemoteDataSource {
  PreviousStockDetailsRemoteDataSourceImpl(
    @Named('authenticated') Dio dio,
  ) : _dio = dio;

  final Dio _dio;

  @override
  Future<PreviousStockDetailsResponseModel> getPreviousStockDetails({
    required PreviousStockDetailsRequestParams params,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, dynamic>{
        'reporting_date': params.reportingDate,
      };
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      print("Fafafa ");
      // Make API request
      final response = await _dio.get(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.previousStockDetails}?reporting_date=${params.reportingDate}",
        options: options
      );


      if (response.statusCode == 200) {
        return PreviousStockDetailsResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to fetch previous stock details');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
