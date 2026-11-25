import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/closing/domain/repositories/hotel_summary_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteHotelSummaryUseCase implements BaseUseCase<int, void> {
  final HotelSummaryRepository _repository;
  DeleteHotelSummaryUseCase(this._repository);

  @override
  Future<Either<AppError, void>> execute(int param) =>
      _repository.deleteHotelSummary(param);
}
