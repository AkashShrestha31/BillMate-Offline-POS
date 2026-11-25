import 'package:dartz/dartz.dart';
import 'package:hotel/src/features/party/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/reconcile_party_request_params.dart';
import 'package:hotel/src/features/party/data/models/response/party_create_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/reconcile_party_response.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/party/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/party/data/models/request/update_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/delete_party_request.dart';
import 'package:hotel/src/features/party/data/models/response/party_list_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_detail_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_update_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_delete_response_model.dart';
import 'package:hotel/src/features/party/domain/repositories/party_repository.dart';

@lazySingleton
class GetPartyListUseCase {
  final PartyRepository _repository;

  GetPartyListUseCase(this._repository);

  Future<Either<AppError, PartyListResponseModel>> execute({
    required PartyRequestParams params,
  }) =>
      _repository.getPartyList(params: params);
}

@lazySingleton
class GetPartyDetailUseCase {
  final PartyRepository _repository;

  GetPartyDetailUseCase(this._repository);

  Future<Either<AppError, PartyDetailResponseModel>> execute({
    required String name,
  }) =>
      _repository.getPartyDetail(name: name);
}

@lazySingleton
class CreatePartyUseCase {
  final PartyRepository _repository;

  CreatePartyUseCase(this._repository);

  Future<Either<AppError, PartyCreateResponseModel>> execute({
    required CreatePartyRequest request,
    String? imagePath,
  }) =>
      _repository.createParty(request: request, imagePath: imagePath);
}


@lazySingleton
class UpdatePartyUseCase {
  final PartyRepository _repository;

  UpdatePartyUseCase(this._repository);

  Future<Either<AppError, PartyUpdateResponseModel>> execute({
    required UpdatePartyRequest request,
    String? imagePath,
    bool clearPartyImage = false,
  }) =>
      _repository.updateParty(
        request: request,
        imagePath: imagePath,
        clearPartyImage: clearPartyImage,
      );
}

@lazySingleton
class DeletePartyUseCase {
  final PartyRepository _repository;

  DeletePartyUseCase(this._repository);

  Future<Either<AppError, PartyDeleteResponseModel>> execute({
    required DeletePartyRequest request,
  }) =>
      _repository.deleteParty(request: request);


}

@lazySingleton
class ReconcilePartyUseCase {
  final PartyRepository _repository;

  ReconcilePartyUseCase(this._repository);

  Future<Either<AppError, ReconcilePartyResponse>> call({
    required ReconcilePartyRequestParams params,
  }) =>
      _repository.reconcileParty(params: params);
}

