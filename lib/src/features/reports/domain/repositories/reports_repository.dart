import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/reports/data/models/request/analytics_report_request.dart';
import 'package:hotel/src/features/reports/data/models/request/profit_loss_report_request.dart';
import 'package:hotel/src/features/reports/data/models/request/statement_report_request.dart';
import 'package:hotel/src/features/reports/data/models/response/analytics_report_response.dart';
import 'package:hotel/src/features/reports/data/models/response/profit_loss_report_response.dart';
import 'package:hotel/src/features/reports/data/models/response/statement_report_response.dart';

abstract class ReportsRepository {
  Future<Either<AppError, ProfitLossReportResponse>> getProfitLossReport(
    ProfitLossReportRequest request,
  );

  Future<Either<AppError, StatementReportResponse>> getStatementReport(
    StatementReportRequest request,
  );

  Future<Either<AppError, AnalyticsReportResponse>> getAnalyticsReport(
    AnalyticsReportRequest request,
  );
}
