import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/reports/data/models/request/statement_report_request.dart';
import 'package:hotel/src/features/reports/data/models/response/statement_report_response.dart';
import 'package:hotel/src/features/reports/domain/repositories/reports_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetStatementReportUseCase {
  GetStatementReportUseCase(this._repository);

  final ReportsRepository _repository;

  Future<Either<AppError, StatementReportResponse>> execute(StatementReportRequest request) {
    return _repository.getStatementReport(request);
  }
}
