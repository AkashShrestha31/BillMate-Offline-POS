import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/party/data/datasources/party_remote_data_source.dart';
import 'package:hotel/src/features/party/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/delete_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/party/data/models/request/reconcile_party_request_params.dart';
import 'package:hotel/src/features/party/data/models/request/update_party_request.dart';
import 'package:hotel/src/features/party/data/models/response/party_create_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_delete_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_detail_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_list_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_update_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/reconcile_party_response.dart';
import 'package:hotel/src/features/party/domain/repositories/party_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PartyRepository)
class PartyRepositoryImpl implements PartyRepository {
  PartyRepositoryImpl(this._dataSource);
  final PartyRemoteDataSource _dataSource;

  @override
  Future<Either<AppError, PartyListResponseModel>> getPartyList({
    required PartyRequestParams params,
  }) async {
    try {
      final response = await _dataSource.getPartyList(params: params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, PartyCreateResponseModel>> createParty({
    required CreatePartyRequest request,
    String? imagePath,
  }) async {
    try {
      final response = await _dataSource.createParty(
        request: request,
        imagePath: imagePath,
      );
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, PartyDetailResponseModel>> getPartyDetail({
    required String name,
  }) async {
    try {
      final response = await _dataSource.getPartyDetail(name: name);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, PartyUpdateResponseModel>> updateParty({
    required UpdatePartyRequest request,
    String? imagePath,
    bool clearPartyImage = false,
  }) async {
    try {
      final response = await _dataSource.updateParty(
        request: request,
        imagePath: imagePath,
        clearPartyImage: clearPartyImage,
      );
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, PartyDeleteResponseModel>> deleteParty({
    required DeletePartyRequest request,
  }) async {
    try {
      final response = await _dataSource.deleteParty(request: request);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ReconcilePartyResponse>> reconcileParty({
    required ReconcilePartyRequestParams params,
  }) async {
    try {
      final response = await _dataSource.reconcileParty(params: params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
