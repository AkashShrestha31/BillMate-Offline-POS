import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_delete_response_model.dart';

abstract class PreviousStockDeleteRepository {
  Future<Either<AppError, PreviousStockDeleteResponseModel>>
      deletePreviousStockByDate({
    required String confirm,
    required String reportingDate,
  });
}

