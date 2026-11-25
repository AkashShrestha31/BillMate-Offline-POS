import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/hotel_summary/data/datasources/daily_cash_summary_remote_data_source.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_request_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_query_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/response/daily_cash_summary_response_model.dart';
import 'package:hotel/src/features/hotel_summary/domain/repositories/daily_cash_summary_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DailyCashSummaryRepository)
class DailyCashSummaryRepositoryImpl implements DailyCashSummaryRepository {
  DailyCashSummaryRepositoryImpl(this._remoteDataSource);

  final DailyCashSummaryRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppError, DailyCashSummaryResponseModel>> createDailySummary({required DailyCashSummaryRequestParams params}) async {
          try {
        final response = await _remoteDataSource.createDailySummary(params: params);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }

  @override
  Future<Either<AppError, DailyCashSummaryResponseModel>> getDailySummaries({required DailyCashSummaryQueryParams params}) async {
          try {
        final response = await _remoteDataSource.getDailySummaries(params: params);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }

  @override
  Future<Either<AppError, DailyCashSummaryResponseModel>> updateDailySummary({required DailyCashSummaryRequestParams params}) async {
          try {
        final response = await _remoteDataSource.updateDailySummary(params: params);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }

  @override
  Future<Either<AppError, DailyCashSummaryResponseModel>> deleteDailySummary({required int id}) async {
          try {
        final response = await _remoteDataSource.deleteDailySummary(id: id);
        return right(response);
      } on AppException catch (e) {
        return left(AppError.serverError(message: e.message));
      }
  }
}
