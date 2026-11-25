import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/action/data/datasources/party_remote_data_source.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/action/data/models/request/party_update_request_params.dart';
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart';
import 'package:hotel/src/features/action/data/models/response/party_update_response_model.dart';
import 'package:hotel/src/features/action/domain/repositories/party_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PartyRepository)
class PartyRepositoryImpl implements PartyRepository {
  PartyRepositoryImpl(this._dataSource);
  final PartyRemoteDataSource _dataSource;

  @override
  Future<Either<AppError, ApiResponse<PartyResponseModel>>> getParties({
    required PartyRequestParams params,
  }) async {
    try {
      final response = await _dataSource.getParties(params: params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<PartyResponseModel>>> getPartyById({
    required String id,
  }) async {
    try {
      final response = await _dataSource.getPartyById(id: id);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<PartyResponseModel>>> createParty({
    required CreatePartyRequest request,
  }) async {
    try {
      final response = await _dataSource.createParty(request: request);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<PartyUpdateResponseModel>>> updateParty({
    required PartyUpdateRequestParams request,
  }) async {
    try {
      final response = await _dataSource.updateParty(request: request);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<void>>> deleteParty({
    required String id,
  }) async {
    try {
      final response = await _dataSource.deleteParty(id: id);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
