import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/stock_adjustment/data/models/request/stock_adjustment_request_params.dart';
import 'package:hotel/src/features/stock_adjustment/data/models/response/stock_adjustment_response_model.dart';

abstract class StockAdjustmentRepository {
  Future<Either<AppError, ApiResponse<StockAdjustmentResponseModel>>>
      createStockAdjustment({required StockAdjustmentRequestParams params});

  Future<Either<AppError, ApiResponse<List<StockAdjustmentResponseModel>>>>
      getStockAdjustments({
    int? page,
    int? perPage,
    String? sortOrder,
  });
}
