import 'package:intl/intl.dart';
import 'package:hotel/src/features/reports/data/models/request/profit_loss_report_request.dart';

/// Maps [ProfitLossReportRequest] to API query fragments (not part of JSON body).
extension ProfitLossReportRequestX on ProfitLossReportRequest {
  Map<String, dynamic> periodQuery() {
    final df = DateFormat('yyyy-MM-dd');
    switch (mode) {
      case 'month':
        return {'year': year, 'month': month};
      case 'month_range':
        return {'year': year, 'month_from': monthFrom, 'month_to': monthTo};
      case 'custom':
        return {
          'date_from': df.format(customStart),
          'date_to': df.format(customEnd),
        };
      case 'year':
      default:
        return {'year': year};
    }
  }

  String trendGroupBy() {
    if (mode == 'month') return 'day';
    if (mode == 'year') return 'month';
    if (mode == 'month_range') return monthFrom == monthTo ? 'day' : 'month';
    final days = customEnd.difference(customStart).inDays + 1;
    if (days <= 31) return 'day';
    if (days <= 365 * 5) return 'month';
    return 'year';
  }
}
