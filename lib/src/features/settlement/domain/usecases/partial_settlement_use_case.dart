import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/settlement/data/models/request/partial_settlement_request_params.dart';
import 'package:hotel/src/features/settlement/data/models/response/partial_settlement_response_model.dart';
import 'package:hotel/src/features/settlement/domain/repositories/partial_settlement_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PartialSettlementUseCase implements BaseUseCase<PartialSettlementRequestParams, PartialSettlementResponseModel> {
  final PartialSettlementRepository _repository;

  PartialSettlementUseCase(this._repository);

  @override
  Future<Either<AppError, PartialSettlementResponseModel>> execute(PartialSettlementRequestParams param) =>
      _repository.partialSettlement(params: param);
}
