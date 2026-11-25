import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_details_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_details_response_model.dart';

abstract class PreviousStockDetailsRepository {
  Future<Either<AppError, PreviousStockDetailsResponseModel>> getPreviousStockDetails({
    required PreviousStockDetailsRequestParams params,
  });
}
