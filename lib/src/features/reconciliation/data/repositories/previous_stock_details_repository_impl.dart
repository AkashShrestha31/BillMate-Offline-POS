import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/reconciliation/data/datasources/previous_stock_details_remote_data_source.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_details_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_details_response_model.dart';
import 'package:hotel/src/features/reconciliation/domain/repositories/previous_stock_details_repository.dart';

@LazySingleton(as: PreviousStockDetailsRepository)
class PreviousStockDetailsRepositoryImpl implements PreviousStockDetailsRepository {
  PreviousStockDetailsRepositoryImpl(this._remoteDataSource);

  final PreviousStockDetailsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppError, PreviousStockDetailsResponseModel>> getPreviousStockDetails({
    required PreviousStockDetailsRequestParams params,
  }) async {
          try {
        final response = await _remoteDataSource.getPreviousStockDetails(
          params: params,
        );
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }
}
