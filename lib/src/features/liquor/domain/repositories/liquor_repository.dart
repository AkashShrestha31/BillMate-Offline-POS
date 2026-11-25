import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_create_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_update_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/pricing_create_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/pricing_update_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/response/liquor_response_model.dart';

abstract class LiquorRepository {
  Future<Either<AppError, ApiResponse<LiquorResponseModel>>> getLiquorItems({required LiquorRequestParams params});
  Future<Either<AppError, ApiResponse<String>>> createLiquorItem({required LiquorCreateRequestParams params});
  Future<Either<AppError, ApiResponse<String>>> updateLiquorItem({required LiquorUpdateRequestParams params});
  Future<Either<AppError, ApiResponse<String>>> deleteLiquorItem({required int id});
  Future<Either<AppError, ApiResponse<void>>> createPricing({required PricingCreateRequestParams params});
  Future<Either<AppError, ApiResponse<void>>> updatePricing({required PricingUpdateRequestParams params});
}
