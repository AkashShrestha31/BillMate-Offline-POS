import 'package:dartz/dartz.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_bulk_edit_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_bulk_edit_response_model.dart';
import 'package:hotel/src/features/reconciliation/domain/repositories/previous_stock_edit_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';

@lazySingleton
class PreviousStockEditUseCase {
  final PreviousStockEditRepository _repository;

  PreviousStockEditUseCase(this._repository);

  Future<Either<AppError, PreviousStockBulkEditResponseModel>> execute({
    required PreviousStockBulkEditRequestParams params,
  }) =>
      _repository.bulkEditPreviousStock(params: params);
}
