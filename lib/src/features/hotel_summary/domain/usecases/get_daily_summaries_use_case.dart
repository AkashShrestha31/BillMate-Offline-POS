import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_query_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/response/daily_cash_summary_response_model.dart';
import 'package:hotel/src/features/hotel_summary/domain/repositories/daily_cash_summary_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDailySummariesUseCase implements BaseUseCase<DailyCashSummaryQueryParams, DailyCashSummaryResponseModel> {
  final DailyCashSummaryRepository _repository;
  GetDailySummariesUseCase(this._repository);

  @override
  Future<Either<AppError, DailyCashSummaryResponseModel>> execute(DailyCashSummaryQueryParams param) =>
      _repository.getDailySummaries(params: param);
}
