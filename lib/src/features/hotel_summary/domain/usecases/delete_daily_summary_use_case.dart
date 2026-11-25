import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/hotel_summary/data/models/response/daily_cash_summary_response_model.dart';
import 'package:hotel/src/features/hotel_summary/domain/repositories/daily_cash_summary_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteDailySummaryUseCase implements BaseUseCase<int, DailyCashSummaryResponseModel> {
  final DailyCashSummaryRepository _repository;
  DeleteDailySummaryUseCase(this._repository);

  @override
  Future<Either<AppError, DailyCashSummaryResponseModel>> execute(int param) =>
      _repository.deleteDailySummary(id: param);
}
