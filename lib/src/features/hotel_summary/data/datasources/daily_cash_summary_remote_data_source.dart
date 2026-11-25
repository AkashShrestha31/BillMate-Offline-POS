import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_request_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_query_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/response/daily_cash_summary_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class DailyCashSummaryRemoteDataSource {
  Future<DailyCashSummaryResponseModel> createDailySummary({required DailyCashSummaryRequestParams params});
  Future<DailyCashSummaryResponseModel> getDailySummaries({required DailyCashSummaryQueryParams params});
  Future<DailyCashSummaryResponseModel> updateDailySummary({required DailyCashSummaryRequestParams params});
  Future<DailyCashSummaryResponseModel> deleteDailySummary({required int id});
}

// @LazySingleton(as: DailyCashSummaryRemoteDataSource)
class DailyCashSummaryRemoteSourceImpl implements DailyCashSummaryRemoteDataSource {
  DailyCashSummaryRemoteSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;
  static const String _baseEndpoint = 'api/hotel/api/daily-cash-summary/';

  @override
  Future<DailyCashSummaryResponseModel> createDailySummary({required DailyCashSummaryRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        "${dotenv.env['BASE_URL']}$_baseEndpoint",
        options: options,
        data: params.toRequestBody(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return DailyCashSummaryResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<DailyCashSummaryResponseModel> getDailySummaries({required DailyCashSummaryQueryParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        "${dotenv.env['BASE_URL']}$_baseEndpoint",
        options: options,
        queryParameters: params.toQueryParams(),
      );

      if (response.statusCode == 200) {
        return DailyCashSummaryResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<DailyCashSummaryResponseModel> updateDailySummary({required DailyCashSummaryRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        "${dotenv.env['BASE_URL']}$_baseEndpoint",
        options: options,
        data: params.toRequestBody(), // ID is included in the request body for PUT
      );

      if (response.statusCode == 200) {
        return DailyCashSummaryResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<DailyCashSummaryResponseModel> deleteDailySummary({required int id}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.delete(
        "${dotenv.env['BASE_URL']}$_baseEndpoint",
        options: options,
        queryParameters: {'id': id.toString()}, // ID is passed as query parameter for DELETE
      );

      if (response.statusCode == 200) {
        return DailyCashSummaryResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
