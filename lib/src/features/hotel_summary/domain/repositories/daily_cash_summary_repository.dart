import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_request_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_query_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/response/daily_cash_summary_response_model.dart';

abstract class DailyCashSummaryRepository {
  Future<Either<AppError, DailyCashSummaryResponseModel>> createDailySummary({required DailyCashSummaryRequestParams params});
  Future<Either<AppError, DailyCashSummaryResponseModel>> getDailySummaries({required DailyCashSummaryQueryParams params});
  Future<Either<AppError, DailyCashSummaryResponseModel>> updateDailySummary({required DailyCashSummaryRequestParams params});
  Future<Either<AppError, DailyCashSummaryResponseModel>> deleteDailySummary({required int id});
}
