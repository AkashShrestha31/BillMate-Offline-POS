import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/reports/data/models/request/analytics_report_request.dart';
import 'package:hotel/src/features/reports/data/models/request/analytics_report_request_extension.dart';
import 'package:hotel/src/features/reports/data/models/request/profit_loss_report_request.dart';
import 'package:hotel/src/features/reports/data/models/request/profit_loss_report_request_extension.dart';
import 'package:hotel/src/features/reports/data/models/request/statement_report_request.dart';
import 'package:hotel/src/features/reports/data/models/request/statement_report_request_extension.dart';
import 'package:hotel/src/features/reports/data/models/response/analytics_report_response.dart';
import 'package:hotel/src/features/reports/data/models/response/profit_loss_report_response.dart';
import 'package:hotel/src/features/reports/data/models/response/statement_report_response.dart';
import 'package:injectable/injectable.dart';

abstract class ReportsRemoteDataSource {
  Future<ProfitLossReportResponse> fetchProfitLossReport(ProfitLossReportRequest request);

  Future<StatementReportResponse> fetchStatementReport(StatementReportRequest request);

  Future<AnalyticsReportResponse> fetchAnalyticsReport(AnalyticsReportRequest request);
}

// @LazySingleton(as: ReportsRemoteDataSource)
class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource {
  ReportsRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  Future<Map<String, dynamic>> _get(String path, Map<String, dynamic> query) async {
    final sanitized = Map<String, dynamic>.from(query)
      ..removeWhere((_, value) => value == null || (value is String && value.trim().isEmpty));
    final context = scaffoldKey.currentContext;
    final options = context != null ? await context.authorizedOptions : Options();
    final response = await _dio.get(path, queryParameters: sanitized, options: options);
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return <String, dynamic>{'data': data};
  }

  @override
  Future<ProfitLossReportResponse> fetchProfitLossReport(ProfitLossReportRequest request) async {
    try {
      final base = request.periodQuery();
      final groupBy = request.trendGroupBy();
      final responses = await Future.wait([
        _get(ApiEndPoints.pnlUnified, {...base, 'view': 'summary'}),
        _get(ApiEndPoints.pnlUnified, {...base, 'view': 'trend', 'group_by': groupBy}),
        _get(ApiEndPoints.pnlUnified, {...base, 'view': 'statement'}),
        _get(ApiEndPoints.pnlUnified, {...base, 'view': 'expense'}),
        _get(ApiEndPoints.pnlUnified, {...base, 'view': 'revenue'}),
      ]);
      return ProfitLossReportResponse(
        summary: responses[0],
        trend: responses[1],
        statement: responses[2],
        expense: responses[3],
        revenue: responses[4],
      );
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<StatementReportResponse> fetchStatementReport(StatementReportRequest request) async {
    try {
      final base = request.periodQuery();
      final groupBy = request.trendGroupBy();
      final responses = await Future.wait([
        _get(ApiEndPoints.cashBankUnified, {...base, 'view': 'overview'}),
        _get(ApiEndPoints.cashBankUnified, {...base, 'view': 'cash_summary'}),
        _get(ApiEndPoints.cashBankUnified, {...base, 'view': 'cash_trend', 'group_by': groupBy}),
        _get(ApiEndPoints.cashBankUnified, {...base, 'view': 'bank_summary'}),
        _get(ApiEndPoints.cashBankUnified, {...base, 'view': 'bank_trend', 'group_by': groupBy}),
        _get(ApiEndPoints.cashBankUnified, {...base, 'view': 'daily_summary'}),
        _get(ApiEndPoints.cashBankUnified, {...base, 'view': 'daily_trend', 'group_by': groupBy}),
      ]);
      return StatementReportResponse(
        overview: responses[0],
        cashSummary: responses[1],
        cashTrend: responses[2],
        bankSummary: responses[3],
        bankTrend: responses[4],
        dailySummary: responses[5],
        dailyTrend: responses[6],
      );
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<AnalyticsReportResponse> fetchAnalyticsReport(AnalyticsReportRequest request) async {
    try {
      if (request.tabIndex == 2) {
        final dashboard =
            await _get(ApiEndPoints.analyticsUnified, {'type': 'dashboard', ...request.periodQuery()});
        return AnalyticsReportResponse(
          dashboard: dashboard,
          summary: const {},
          trend: const {},
          items: const {},
          categories: const {},
          parties: const {},
        );
      }
      final base = request.periodQuery();
      final type = request.analyticsType;
      final trendView = request.trendView();
      final tableView = request.tableView();
      final responses = await Future.wait([
        _get(ApiEndPoints.analyticsUnified, {'type': type, 'view': 'summary', ...base}),
        _get(ApiEndPoints.analyticsUnified, {'type': type, 'view': trendView, ...base}),
        _get(ApiEndPoints.analyticsUnified, {'type': type, 'view': 'items', 'limit': 20, ...base}),
        _get(ApiEndPoints.analyticsUnified, {'type': type, 'view': 'categories', ...base}),
        _get(ApiEndPoints.analyticsUnified, {'type': type, 'view': tableView, 'limit': 10, ...base}),
      ]);
      return AnalyticsReportResponse(
        dashboard: const {},
        summary: responses[0],
        trend: responses[1],
        items: responses[2],
        categories: responses[3],
        parties: responses[4],
      );
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
