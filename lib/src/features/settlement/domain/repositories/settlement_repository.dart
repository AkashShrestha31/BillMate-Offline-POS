import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/settlement/data/models/request/settlement_request_params.dart';
import 'package:hotel/src/features/settlement/data/models/response/settlement_response_model.dart';

abstract class SettlementRepository {
  Future<Either<AppError, ApiResponse<SettlementResponseModel>>>
      createSettlement({required SettlementRequestParams params});
}
