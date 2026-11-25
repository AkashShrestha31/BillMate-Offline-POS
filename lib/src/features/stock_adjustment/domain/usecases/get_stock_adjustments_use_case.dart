import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/stock_adjustment/data/models/response/stock_adjustment_response_model.dart';
import 'package:hotel/src/features/stock_adjustment/domain/repositories/stock_adjustment_repository.dart';
import 'package:injectable/injectable.dart';

class GetStockAdjustmentsParams {
  final int? page;
  final int? perPage;
  final String? sortOrder;

  GetStockAdjustmentsParams({
    this.page,
    this.perPage,
    this.sortOrder,
  });
}

@lazySingleton
class GetStockAdjustmentsUseCase
    implements
        BaseUseCase<GetStockAdjustmentsParams,
            ApiResponse<List<StockAdjustmentResponseModel>>> {
  final StockAdjustmentRepository _repository;

  GetStockAdjustmentsUseCase(this._repository);

  @override
  Future<Either<AppError, ApiResponse<List<StockAdjustmentResponseModel>>>>
      execute(GetStockAdjustmentsParams param) =>
          _repository.getStockAdjustments(
            page: param.page,
            perPage: param.perPage,
            sortOrder: param.sortOrder,
          );
}
