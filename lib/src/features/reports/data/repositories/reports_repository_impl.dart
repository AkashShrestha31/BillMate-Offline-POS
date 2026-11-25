import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/reports/data/datasources/reports_remote_data_source.dart';
import 'package:hotel/src/features/reports/data/models/request/analytics_report_request.dart';
import 'package:hotel/src/features/reports/data/models/request/profit_loss_report_request.dart';
import 'package:hotel/src/features/reports/data/models/request/statement_report_request.dart';
import 'package:hotel/src/features/reports/data/models/response/analytics_report_response.dart';
import 'package:hotel/src/features/reports/data/models/response/profit_loss_report_response.dart';
import 'package:hotel/src/features/reports/data/models/response/statement_report_response.dart';
import 'package:hotel/src/features/reports/domain/repositories/reports_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ReportsRepository)
class ReportsRepositoryImpl implements ReportsRepository {
  ReportsRepositoryImpl(this._remote);

  final ReportsRemoteDataSource _remote;

  Future<Either<AppError, T>> _guard<T>(Future<T> Function() run) async {
    try {
      final data = await run();
      return right(data);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ProfitLossReportResponse>> getProfitLossReport(
    ProfitLossReportRequest request,
  ) {
    return _guard(() => _remote.fetchProfitLossReport(request));
  }

  @override
  Future<Either<AppError, StatementReportResponse>> getStatementReport(
    StatementReportRequest request,
  ) {
    return _guard(() => _remote.fetchStatementReport(request));
  }

  @override
  Future<Either<AppError, AnalyticsReportResponse>> getAnalyticsReport(
    AnalyticsReportRequest request,
  ) {
    return _guard(() => _remote.fetchAnalyticsReport(request));
  }
}
