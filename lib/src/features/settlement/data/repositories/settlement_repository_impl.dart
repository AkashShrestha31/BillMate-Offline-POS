import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/settlement/data/datasources/settlement_remote_data_source.dart';
import 'package:hotel/src/features/settlement/data/models/request/settlement_request_params.dart';
import 'package:hotel/src/features/settlement/data/models/response/settlement_response_model.dart';
import 'package:hotel/src/features/settlement/domain/repositories/settlement_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SettlementRepository)
class SettlementRepositoryImpl implements SettlementRepository {
  SettlementRepositoryImpl(this._settlementRemoteSource);

  final SettlementRemoteDataSource _settlementRemoteSource;

  @override
  Future<Either<AppError, ApiResponse<SettlementResponseModel>>>
      createSettlement({required SettlementRequestParams params}) async {
          try {
        final response =
            await _settlementRemoteSource.createSettlement(params: params);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }
}
