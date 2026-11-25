import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/closing/data/models/response/hotel_summary_response_model.dart';
import 'package:hotel/src/features/closing/domain/repositories/hotel_summary_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetHotelSummaryByIdUseCase implements BaseUseCase<int, HotelSummaryResponseModel> {
  final HotelSummaryRepository _repository;
  GetHotelSummaryByIdUseCase(this._repository);

  @override
  Future<Either<AppError, HotelSummaryResponseModel>> execute(int param) =>
      _repository.getHotelSummaryById(param);
}
