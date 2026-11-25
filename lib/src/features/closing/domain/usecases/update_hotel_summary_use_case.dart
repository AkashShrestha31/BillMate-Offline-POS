import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/closing/data/models/request/hotel_summary_request_params.dart';
import 'package:hotel/src/features/closing/data/models/response/hotel_summary_response_model.dart';
import 'package:hotel/src/features/closing/domain/repositories/hotel_summary_repository.dart';
import 'package:injectable/injectable.dart';

class UpdateHotelSummaryParams {
  final int id;
  final CreateHotelSummaryRequest request;

  UpdateHotelSummaryParams({required this.id, required this.request});
}

@lazySingleton
class UpdateHotelSummaryUseCase implements BaseUseCase<UpdateHotelSummaryParams, HotelSummaryResponseModel> {
  final HotelSummaryRepository _repository;
  UpdateHotelSummaryUseCase(this._repository);

  @override
  Future<Either<AppError, HotelSummaryResponseModel>> execute(UpdateHotelSummaryParams param) =>
      _repository.updateHotelSummary(param.id, param.request);
}
