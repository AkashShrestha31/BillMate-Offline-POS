import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/internet/internet_info.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/liquor/data/datasources/liquor_remote_data_source.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_create_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_update_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/pricing_create_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/pricing_update_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/response/liquor_response_model.dart';
import 'package:hotel/src/features/liquor/domain/repositories/liquor_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LiquorRepository)
class LiquorRepositoryImpl implements LiquorRepository {
  LiquorRepositoryImpl(this._dataSource, this._internetInfo);

  final LiquorRemoteDataSource _dataSource;
  // Kept for constructor compatibility with generated DI wiring.
  // ignore: unused_field
  final InternetInfo _internetInfo;

  @override
  Future<Either<AppError, ApiResponse<LiquorResponseModel>>> getLiquorItems({
    required LiquorRequestParams params,
  }) async {
    try {
      final response = await _dataSource.getLiquorItems(params: params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<String>>> createLiquorItem({
    required LiquorCreateRequestParams params,
  }) async {
    try {
      final response = await _dataSource.createLiquorItem(params: params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<String>>> updateLiquorItem({
    required LiquorUpdateRequestParams params,
  }) async {
    try {
      final response = await _dataSource.updateLiquorItem(params: params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<String>>> deleteLiquorItem({
    required int id,
  }) async {
    try {
      final response = await _dataSource.deleteLiquorItem(id: id);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<void>>> createPricing({
    required PricingCreateRequestParams params,
  }) async {
    try {
      final response = await _dataSource.createPricing(params: params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<void>>> updatePricing({
    required PricingUpdateRequestParams params,
  }) async {
    try {
      final response = await _dataSource.updatePricing(params: params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
