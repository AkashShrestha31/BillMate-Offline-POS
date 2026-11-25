import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/party/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/party/data/models/request/reconcile_party_request_params.dart';
import 'package:hotel/src/features/party/data/models/request/update_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/delete_party_request.dart';
import 'package:hotel/src/features/party/data/models/response/party_create_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_list_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_detail_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_update_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_delete_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/reconcile_party_response.dart';

abstract class PartyRepository {
  Future<Either<AppError, PartyListResponseModel>> getPartyList({
    required PartyRequestParams params,
  });

  Future<Either<AppError, PartyDetailResponseModel>> getPartyDetail({
    required String name,
  });

  Future<Either<AppError, PartyUpdateResponseModel>> updateParty({
    required UpdatePartyRequest request,
    String? imagePath,
    bool clearPartyImage = false,
  });

  Future<Either<AppError, PartyCreateResponseModel>> createParty({
    required CreatePartyRequest request,
    String? imagePath,
  });

  Future<Either<AppError, PartyDeleteResponseModel>> deleteParty({
    required DeletePartyRequest request,
  });
  Future<Either<AppError, ReconcilePartyResponse>> reconcileParty({
    required ReconcilePartyRequestParams params,
  });
}
