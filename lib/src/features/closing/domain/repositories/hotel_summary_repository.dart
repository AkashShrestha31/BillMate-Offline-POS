import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/closing/data/models/request/hotel_summary_request_params.dart';
import 'package:hotel/src/features/closing/data/models/response/hotel_summary_response_model.dart';

abstract class HotelSummaryRepository {
  // READ Operations
  Future<Either<AppError, ApiResponse<HotelSummaryResponseModel>>> getHotelSummaries({required HotelSummaryRequestParams params});
  Future<Either<AppError, HotelSummaryResponseModel>> getHotelSummaryById(int id);

  // CREATE Operation
  Future<Either<AppError, HotelSummaryResponseModel>> createHotelSummary(CreateHotelSummaryRequest request);

  // UPDATE Operation
  Future<Either<AppError, HotelSummaryResponseModel>> updateHotelSummary(int id, CreateHotelSummaryRequest request);

  // DELETE Operation
  Future<Either<AppError, void>> deleteHotelSummary(int id);
}
