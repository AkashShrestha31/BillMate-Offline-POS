import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/dashboard/data/datasources/dashboard_summary_page_remote_data_source.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_response_model.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_response_model.dart';
import 'package:hotel/src/features/dashboard/domain/repositories/dashboard_summary_page_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DashboardSummaryPageRepository)
class DashboardSummaryPageRepositoryImpl implements DashboardSummaryPageRepository {
  DashboardSummaryPageRepositoryImpl(this._dataSource);
  final DashboardSummaryPageRemoteDataSource _dataSource;

  @override
  Future<Either<AppError, ApiResponse<DashboardSummaryPageResponseModel>>>
      getDashboardSummaryPage({required DashboardSummaryPageRequestParams params}) async {
    try {
      final response = await _dataSource.getDashboardSummaryPage(params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<HotelSalesResponseModel>>> getHotelSales(
      {required HotelSalesRequestParams params}) async {
    try {
      final response = await _dataSource.getHotelSales(params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
