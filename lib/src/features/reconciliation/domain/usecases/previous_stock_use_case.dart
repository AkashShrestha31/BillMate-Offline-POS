import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_response_model.dart';
import 'package:hotel/src/features/reconciliation/domain/repositories/reconciliation_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PreviousStockUseCase
    implements
        BaseUseCase<PreviousStockRequestParams,
            ApiResponse<PreviousStockResponseModel>> {
  final ReconciliationRepository _repository;

  PreviousStockUseCase(this._repository);

  @override
  Future<Either<AppError, ApiResponse<PreviousStockResponseModel>>> execute(
          PreviousStockRequestParams param) =>
      _repository.getPreviousStock(params: param);
}
