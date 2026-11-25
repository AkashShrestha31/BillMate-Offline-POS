import 'package:hotel/src/features/reports/data/models/request/analytics_report_request.dart';

extension AnalyticsReportRequestX on AnalyticsReportRequest {
  Map<String, dynamic> periodQuery() {
    switch (mode) {
      case 'day':
        return {
          'year': day.year,
          'month': day.month,
          'day': day.day,
        };
      case 'month':
        return {'year': year, 'month': month};
      case 'year':
      default:
        return {'year': year};
    }
  }

  /// API `type` for purchase/sales tabs.
  String get analyticsType => tabIndex == 0 ? 'purchase' : 'sales';

  String trendView() => mode == 'year' ? 'monthly' : 'daily';

  String tableView() => tabIndex == 0 ? 'suppliers' : 'parties';
}
