import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/settlement/data/models/request/settlement_request_params.dart';
import 'package:hotel/src/features/settlement/data/models/response/settlement_response_model.dart';
import 'package:hotel/src/features/settlement/domain/repositories/settlement_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SettlementUseCase
    implements
        BaseUseCase<SettlementRequestParams,
            ApiResponse<SettlementResponseModel>> {
  final SettlementRepository _settlementRepository;

  SettlementUseCase(this._settlementRepository);

  @override
  Future<Either<AppError, ApiResponse<SettlementResponseModel>>> execute(
          SettlementRequestParams param) =>
      _settlementRepository.createSettlement(params: param);
}
