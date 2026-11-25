import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_response_model.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_response_model.dart';

abstract class DashboardSummaryPageRepository {
  Future<Either<AppError, ApiResponse<DashboardSummaryPageResponseModel>>>
      getDashboardSummaryPage(
          {required DashboardSummaryPageRequestParams params});
  Future<Either<AppError, ApiResponse<HotelSalesResponseModel>>> getHotelSales(
      {required HotelSalesRequestParams params});
}
