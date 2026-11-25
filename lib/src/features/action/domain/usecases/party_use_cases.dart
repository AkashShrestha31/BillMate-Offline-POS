import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/action/data/models/request/party_update_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/update_party_request.dart';
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart';
import 'package:hotel/src/features/action/data/models/response/party_update_response_model.dart';
import 'package:hotel/src/features/action/domain/repositories/party_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPartiesUseCase
    implements
        BaseUseCase<PartyRequestParams, ApiResponse<PartyResponseModel>> {
  final PartyRepository _repository;
  GetPartiesUseCase(this._repository);

  @override
  Future<Either<AppError, ApiResponse<PartyResponseModel>>> execute(
          PartyRequestParams params) =>
      _repository.getParties(params: params);
}

@lazySingleton
class GetPartyByIdUseCase {
  final PartyRepository _repository;
  GetPartyByIdUseCase(this._repository);

  Future<Either<AppError, ApiResponse<PartyResponseModel>>> execute(
          String id) =>
      _repository.getPartyById(id: id);
}

@lazySingleton
class CreatePartyUseCase
    implements
        BaseUseCase<CreatePartyRequest, ApiResponse<PartyResponseModel>> {
  final PartyRepository _repository;
  CreatePartyUseCase(this._repository);

  @override
  Future<Either<AppError, ApiResponse<PartyResponseModel>>> execute(
          CreatePartyRequest request) =>
      _repository.createParty(request: request);
}

@lazySingleton
class UpdatePartyUseCase {
  final PartyRepository _repository;
  UpdatePartyUseCase(this._repository);

  Future<Either<AppError, ApiResponse<PartyUpdateResponseModel>>> execute({
    required PartyUpdateRequestParams request,
  }) =>
      _repository.updateParty(request: request);
}

@lazySingleton
class DeletePartyUseCase {
  final PartyRepository _repository;
  DeletePartyUseCase(this._repository);

  Future<Either<AppError, ApiResponse<void>>> execute(String id) =>
      _repository.deleteParty(id: id);
}
