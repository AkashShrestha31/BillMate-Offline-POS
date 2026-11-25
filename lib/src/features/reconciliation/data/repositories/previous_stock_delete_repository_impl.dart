import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/reconciliation/data/datasources/previous_stock_delete_remote_data_source.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_delete_response_model.dart';
import 'package:hotel/src/features/reconciliation/domain/repositories/previous_stock_delete_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PreviousStockDeleteRepository)
class PreviousStockDeleteRepositoryImpl
    implements PreviousStockDeleteRepository {
  PreviousStockDeleteRepositoryImpl(
      this._remoteDataSource);

  final PreviousStockDeleteRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppError, PreviousStockDeleteResponseModel>>
      deletePreviousStockByDate({
    required String confirm,
    required String reportingDate,
  }) async {
          try {
        final response = await _remoteDataSource.deletePreviousStockByDate(
          confirm: confirm,
          reportingDate: reportingDate,
        );
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }
}

