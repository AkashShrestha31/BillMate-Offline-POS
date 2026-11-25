import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/internet/internet_info.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/closing/data/datasources/hotel_summary_remote_data_source.dart';
import 'package:hotel/src/features/closing/data/models/request/hotel_summary_request_params.dart';
import 'package:hotel/src/features/closing/data/models/response/hotel_summary_response_model.dart';
import 'package:hotel/src/features/closing/domain/repositories/hotel_summary_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HotelSummaryRepository)
class HotelSummaryRepositoryImpl implements HotelSummaryRepository {
  HotelSummaryRepositoryImpl(this._remoteDataSource, this._internetInfo);

  final HotelSummaryRemoteDataSource _remoteDataSource;
  final InternetInfo _internetInfo;

  @override
  Future<Either<AppError, ApiResponse<HotelSummaryResponseModel>>> getHotelSummaries({required HotelSummaryRequestParams params}) async {
    // Hotel summary is sourced from local DB in offline-first mode.
    try {
      final response = await _remoteDataSource.getHotelSummaries(params: params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, HotelSummaryResponseModel>> getHotelSummaryById(int id) async {
    if (await _internetInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getHotelSummaryById(id);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }

  @override
  Future<Either<AppError, HotelSummaryResponseModel>> createHotelSummary(CreateHotelSummaryRequest request) async {
    if (await _internetInfo.isConnected) {
      try {
        final response = await _remoteDataSource.createHotelSummary(request);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }

  @override
  Future<Either<AppError, HotelSummaryResponseModel>> updateHotelSummary(int id, CreateHotelSummaryRequest request) async {
    if (await _internetInfo.isConnected) {
      try {
        final response = await _remoteDataSource.updateHotelSummary(id, request);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }

  @override
  Future<Either<AppError, void>> deleteHotelSummary(int id) async {
    if (await _internetInfo.isConnected) {
      try {
        await _remoteDataSource.deleteHotelSummary(id);
        return right(null);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
    } else {
      return left(const AppError.noInternet());
    }
  }
}
