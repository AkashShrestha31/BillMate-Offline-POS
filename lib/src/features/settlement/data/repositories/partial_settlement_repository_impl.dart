import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/settlement/data/datasources/partial_settlement_remote_data_source.dart';
import 'package:hotel/src/features/settlement/data/models/request/partial_settlement_request_params.dart';
import 'package:hotel/src/features/settlement/data/models/response/partial_settlement_response_model.dart';
import 'package:hotel/src/features/settlement/domain/repositories/partial_settlement_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PartialSettlementRepository)
class PartialSettlementRepositoryImpl implements PartialSettlementRepository {
  PartialSettlementRepositoryImpl(this._remoteDataSource);

  final PartialSettlementRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppError, PartialSettlementResponseModel>> partialSettlement({
    required PartialSettlementRequestParams params
  }) async {
          try {
        final response = await _remoteDataSource.partialSettlement(params: params);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }
}
