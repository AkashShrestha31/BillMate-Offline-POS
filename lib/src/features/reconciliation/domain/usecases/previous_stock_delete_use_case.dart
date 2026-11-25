import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_delete_response_model.dart';
import 'package:hotel/src/features/reconciliation/domain/repositories/previous_stock_delete_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PreviousStockDeleteUseCase {
  final PreviousStockDeleteRepository _repository;

  PreviousStockDeleteUseCase(this._repository);

  Future<Either<AppError, PreviousStockDeleteResponseModel>> execute({
    required String reportingDate,
  }) async {
    return await _repository.deletePreviousStockByDate(
      confirm: 'yes',
      reportingDate: reportingDate,
    );
  }
}

