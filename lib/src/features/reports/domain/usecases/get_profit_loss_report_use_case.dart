import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/reports/data/models/request/profit_loss_report_request.dart';
import 'package:hotel/src/features/reports/data/models/response/profit_loss_report_response.dart';
import 'package:hotel/src/features/reports/domain/repositories/reports_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProfitLossReportUseCase {
  GetProfitLossReportUseCase(this._repository);

  final ReportsRepository _repository;

  Future<Either<AppError, ProfitLossReportResponse>> execute(
    ProfitLossReportRequest request,
  ) {
    return _repository.getProfitLossReport(request);
  }
}
