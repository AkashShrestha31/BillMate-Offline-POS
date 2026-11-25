import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/stock_adjustment/data/models/request/stock_adjustment_request_params.dart';
import 'package:hotel/src/features/stock_adjustment/data/models/response/stock_adjustment_response_model.dart';
import 'package:hotel/src/features/stock_adjustment/domain/repositories/stock_adjustment_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateStockAdjustmentUseCase
    implements
        BaseUseCase<StockAdjustmentRequestParams,
            ApiResponse<StockAdjustmentResponseModel>> {
  final StockAdjustmentRepository _repository;

  CreateStockAdjustmentUseCase(this._repository);

  @override
  Future<Either<AppError, ApiResponse<StockAdjustmentResponseModel>>> execute(
          StockAdjustmentRequestParams param) =>
      _repository.createStockAdjustment(params: param);
}
