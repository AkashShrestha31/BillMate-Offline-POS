import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_report_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_report_response.dart';
import 'package:hotel/src/features/reconciliation/domain/repositories/reconciliation_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GenerateReconciliationReportUseCase {
  final ReconciliationRepository _repository;

  GenerateReconciliationReportUseCase(this._repository);

  Future<Either<AppError, ApiResponse<ReconciliationReportResponse>>> call({
    required ReconciliationReportRequest request,
  }) async {
    return await _repository.generateReconciliationReport(request: request);
  }
}
