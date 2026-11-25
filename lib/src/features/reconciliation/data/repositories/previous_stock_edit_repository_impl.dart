import 'package:dartz/dartz.dart';
import 'package:hotel/src/features/reconciliation/data/datasources/previous_stock_edit_remote_data_source.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_bulk_edit_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_bulk_edit_response_model.dart';
import 'package:hotel/src/features/reconciliation/domain/repositories/previous_stock_edit_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';

@LazySingleton(as: PreviousStockEditRepository)
class PreviousStockEditRepositoryImpl implements PreviousStockEditRepository {
  PreviousStockEditRepositoryImpl(this._remoteDataSource);

  final PreviousStockEditRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppError, PreviousStockBulkEditResponseModel>> bulkEditPreviousStock({
    required PreviousStockBulkEditRequestParams params,
  }) async {
          try {
        final response = await _remoteDataSource.bulkEditPreviousStock(
          params: params,
        );
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }
}
