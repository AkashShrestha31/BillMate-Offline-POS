import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/settlement/data/models/request/partial_settlement_request_params.dart';
import 'package:hotel/src/features/settlement/data/models/response/partial_settlement_response_model.dart';

abstract class PartialSettlementRepository {
  Future<Either<AppError, PartialSettlementResponseModel>> partialSettlement({
    required PartialSettlementRequestParams params
  });
}
