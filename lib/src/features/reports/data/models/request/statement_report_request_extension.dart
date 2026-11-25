import 'package:hotel/src/features/reports/data/models/request/statement_report_request.dart';

extension StatementReportRequestX on StatementReportRequest {
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
      case 'month_range':
        return {'year': year, 'month_from': monthFrom, 'month_to': monthTo};
      case 'year':
      default:
        return {'year': year};
    }
  }

  String trendGroupBy() {
    if (mode == 'day') return 'day';
    if (mode == 'month') return 'day';
    if (mode == 'year') return 'month';
    if (mode == 'month_range') return monthFrom == monthTo ? 'day' : 'month';
    return 'month';
  }
}
