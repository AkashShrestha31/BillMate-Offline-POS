import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_details_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_details_response_model.dart';
import 'package:hotel/src/features/reconciliation/domain/repositories/previous_stock_details_repository.dart';

@lazySingleton
class PreviousStockDetailsUseCase {
  final PreviousStockDetailsRepository _repository;

  PreviousStockDetailsUseCase(this._repository);

  Future<Either<AppError, PreviousStockDetailsResponseModel>> execute({
    required PreviousStockDetailsRequestParams params,
  }) =>
      _repository.getPreviousStockDetails(params: params);
}
