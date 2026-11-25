import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/reports/data/models/request/analytics_report_request.dart';
import 'package:hotel/src/features/reports/data/models/response/analytics_report_response.dart';
import 'package:hotel/src/features/reports/domain/repositories/reports_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAnalyticsReportUseCase {
  GetAnalyticsReportUseCase(this._repository);

  final ReportsRepository _repository;

  Future<Either<AppError, AnalyticsReportResponse>> execute(AnalyticsReportRequest request) {
    return _repository.getAnalyticsReport(request);
  }
}
