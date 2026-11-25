import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_bulk_edit_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_bulk_edit_response_model.dart';

abstract class PreviousStockEditRepository {
  Future<Either<AppError, PreviousStockBulkEditResponseModel>> bulkEditPreviousStock({
    required PreviousStockBulkEditRequestParams params,
  });
}
