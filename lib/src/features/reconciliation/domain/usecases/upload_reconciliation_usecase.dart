// Usage Example in Use Case
import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_upload_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_upload_response.dart';
import 'package:hotel/src/features/reconciliation/domain/repositories/reconciliation_repository.dart';
import 'package:injectable/injectable.dart';

// Use Case for Upload Reconciliation Data
@injectable
class UploadReconciliationDataUseCase {
  final ReconciliationRepository _repository;

  UploadReconciliationDataUseCase(this._repository);

  Future<Either<AppError, ApiResponse<ReconciliationUploadResponse>>> call({
    required ReconciliationUploadRequest request,
  }) async {
    return await _repository.uploadReconciliationData(request: request);
  }
}
