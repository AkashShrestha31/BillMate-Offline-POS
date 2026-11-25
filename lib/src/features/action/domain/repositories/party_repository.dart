import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/action/data/models/request/party_update_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/update_party_request.dart';
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart';
import 'package:hotel/src/features/action/data/models/response/party_update_response_model.dart';

abstract class PartyRepository {
  Future<Either<AppError, ApiResponse<PartyResponseModel>>> getParties({
    required PartyRequestParams params,
  });

  Future<Either<AppError, ApiResponse<PartyResponseModel>>> getPartyById({
    required String id,
  });

  Future<Either<AppError, ApiResponse<PartyResponseModel>>> createParty({
    required CreatePartyRequest request,
  });

  Future<Either<AppError, ApiResponse<PartyUpdateResponseModel>>> updateParty({
    required PartyUpdateRequestParams request,
  });

  Future<Either<AppError, ApiResponse<void>>> deleteParty({
    required String id,
  });
}
