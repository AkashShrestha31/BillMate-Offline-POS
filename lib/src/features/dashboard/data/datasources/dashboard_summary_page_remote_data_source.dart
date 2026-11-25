import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_response_model.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Abstract class for remote data source related to the dashboard summary.
abstract class DashboardSummaryPageRemoteDataSource {
  Future<ApiResponse<DashboardSummaryPageResponseModel>> getDashboardSummaryPage(
      DashboardSummaryPageRequestParams params);
  Future<ApiResponse<HotelSalesResponseModel>> getHotelSales(HotelSalesRequestParams params);
}

// @LazySingleton(as: DashboardSummaryPageRemoteDataSource) — replaced by DashboardSummaryPageLocalDataSource
class DashboardSummaryPageRemoteDataSourceImpl implements DashboardSummaryPageRemoteDataSource {
  DashboardSummaryPageRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<ApiResponse<DashboardSummaryPageResponseModel>> getDashboardSummaryPage(
      DashboardSummaryPageRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      // Web-specific handling: Ensure we're handling Dio requests correctly in web environments
      final response = await _dio.get(
          options: options,
          "${dotenv.env['BASE_URL']}${ApiEndPoints.dashboardSummaryPage}",
          queryParameters: params.toQueryParams());

      // final response = await _dio.get(
      //   ApiEndPoints.dashboardSummaryPage,
      // );

      // Check if the response is successful
      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final dashboardSummaryPageResponse = DashboardSummaryPageResponseModel.fromJson(responseData);
        return ApiResponse<DashboardSummaryPageResponseModel>(
          data: dashboardSummaryPageResponse,
          message: '',
          success: true,
        );
      } else {
        // Handle error if status code is not 200
        throw const AppException(message: 'Unknown Error');
      }
    } on DioError catch (e) {
      print("DioError: $e");
      // Handle Dio errors, like network errors, timeout, etc.
      throw AppException.fromDioError(e);
    } catch (e) {
      // Handle any other errors
      print("General Error: $e");
      throw AppException(message: 'An unexpected error occurred');
    }
  }

  @override
  Future<ApiResponse<HotelSalesResponseModel>> getHotelSales(HotelSalesRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get("${dotenv.env['BASE_URL']}${ApiEndPoints.hotelSales}", options: options);
      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final hotelSalesResponse = HotelSalesResponseModel.fromJson(responseData);
        return ApiResponse<HotelSalesResponseModel>(
          data: hotelSalesResponse,
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
