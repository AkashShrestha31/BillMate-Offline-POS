import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_direct_report_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_report_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_upload_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_response_model.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_report_response.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_upload_response.dart';

abstract class ReconciliationRepository {
  Future<Either<AppError, ApiResponse<ReconciliationUploadResponse>>>
      uploadReconciliationData({
    required ReconciliationUploadRequest request,
  });
  Future<Either<AppError, ApiResponse<ReconciliationReportResponse>>>
      generateReconciliationReport({
    required ReconciliationReportRequest request,
  });
  Future<Either<AppError, ApiResponse<ReconciliationReportResponse>>>
      generateDirectReconciliationReport({
    required ReconciliationDirectReportRequest request,
  });
  Future<Either<AppError, ApiResponse<PreviousStockResponseModel>>>
      getPreviousStock({required PreviousStockRequestParams params});
}
