import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_response_model.dart';
import 'package:hotel/src/features/dashboard/domain/repositories/dashboard_summary_page_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HotelSalesUseCase extends BaseUseCase<HotelSalesRequestParams,
    ApiResponse<HotelSalesResponseModel>> {
  HotelSalesUseCase(this._repository);

  final DashboardSummaryPageRepository _repository;

  @override
  Future<Either<AppError, ApiResponse<HotelSalesResponseModel>>> execute(
          HotelSalesRequestParams params) =>
      _repository.getHotelSales(params: params);
}
