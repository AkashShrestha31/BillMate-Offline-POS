// reconciliation_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/internet/internet_info.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/reconciliation/data/datasources/reconciliation_remote_datasource.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_direct_report_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_report_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_upload_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_response_model.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_report_response.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_upload_response.dart';
import 'package:hotel/src/features/reconciliation/domain/repositories/reconciliation_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ReconciliationRepository)
class ReconciliationRepositoryImpl implements ReconciliationRepository {
  ReconciliationRepositoryImpl(
      this._reconciliationRemoteSource, this._internetInfo);

  final ReconciliationRemoteDataSource _reconciliationRemoteSource;
  // Kept for constructor compatibility with generated DI wiring.
  // ignore: unused_field
  final InternetInfo _internetInfo;

  @override
  Future<Either<AppError, ApiResponse<ReconciliationUploadResponse>>>
      uploadReconciliationData({
    required ReconciliationUploadRequest request,
  }) async {
    // Reconciliation upload runs against local DB in offline-first mode.
    try {
      final response =
          await _reconciliationRemoteSource.uploadReconciliationData(
        request: request,
      );
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<ReconciliationReportResponse>>>
      generateReconciliationReport({
    required ReconciliationReportRequest request,
  }) async {
    // Reconciliation report generation runs from local DB in offline-first mode.
    try {
      final response =
          await _reconciliationRemoteSource.generateReconciliationReport(
        request: request,
      );
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<ReconciliationReportResponse>>>
      generateDirectReconciliationReport({
    required ReconciliationDirectReportRequest request,
  }) async {
    // Custom/direct reconciliation also runs fully local in offline-first mode.
    try {
      final response = await _reconciliationRemoteSource
          .generateDirectReconciliationReport(
        request: request,
      );
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<PreviousStockResponseModel>>>
      getPreviousStock({required PreviousStockRequestParams params}) async {
    // Previous stock list is sourced from local DB in current mode, so do not
    // gate by network connectivity.
    try {
      final response =
          await _reconciliationRemoteSource.getPreviousStock(params: params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
