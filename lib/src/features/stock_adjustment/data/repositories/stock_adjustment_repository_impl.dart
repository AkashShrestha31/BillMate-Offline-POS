import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/stock_adjustment/data/datasources/stock_adjustment_remote_data_source.dart';
import 'package:hotel/src/features/stock_adjustment/data/models/request/stock_adjustment_request_params.dart';
import 'package:hotel/src/features/stock_adjustment/data/models/response/stock_adjustment_response_model.dart';
import 'package:hotel/src/features/stock_adjustment/domain/repositories/stock_adjustment_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: StockAdjustmentRepository)
class StockAdjustmentRepositoryImpl implements StockAdjustmentRepository {
  StockAdjustmentRepositoryImpl(this._remoteDataSource);

  final StockAdjustmentRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppError, ApiResponse<StockAdjustmentResponseModel>>>
      createStockAdjustment(
          {required StockAdjustmentRequestParams params}) async {
          try {
        final response =
            await _remoteDataSource.createStockAdjustment(params: params);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }

  @override
  Future<Either<AppError, ApiResponse<List<StockAdjustmentResponseModel>>>>
      getStockAdjustments({
    int? page,
    int? perPage,
    String? sortOrder,
  }) async {
          try {
        final response = await _remoteDataSource.getStockAdjustments(
          page: page,
          perPage: perPage,
          sortOrder: sortOrder,
        );
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }
}
