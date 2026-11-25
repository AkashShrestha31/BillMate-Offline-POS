import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/action/data/datasources/payment_analytics_remote_data_source.dart';
import 'package:hotel/src/features/action/data/models/request/payment_analytics_request_model.dart';
import 'package:hotel/src/features/action/data/models/response/payment_analytics_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PaymentAnalyticsRemoteDataSource)
class PaymentAnalyticsLocalDataSource implements PaymentAnalyticsRemoteDataSource {
  PaymentAnalyticsLocalDataSource(this._db);
  final LocalDb _db;

  @override
  Future<PaymentAnalyticsResponseModel> getPaymentAnalytics(
      PaymentAnalyticsRequestModel request) async {
    try {
      final conditions = <String>['cancelled = 0', 'submitted = 1'];
      final args = <dynamic>[];
      if (request.startDate != null) { conditions.add('date >= ?'); args.add(request.startDate); }
      if (request.endDate != null) { conditions.add('date <= ?'); args.add(request.endDate); }
      final where = conditions.join(' AND ');

      final rows = await _db.rawQuery(
        'SELECT substr(date,1,10) as day, SUM(CAST(amount AS REAL)) as total, COUNT(*) as count FROM Payment WHERE $where GROUP BY day ORDER BY day',
        args.isNotEmpty ? args : null,
      );

      final totalAmount = rows.fold(0.0, (s, r) => s + _d(r['total']));
      final totalCount = rows.fold(0, (s, r) => s + ((r['count'] as int?) ?? 0));

      return PaymentAnalyticsResponseModel(
        reportType: request.reportType,
        data: rows.map((r) => PaymentDayData(
          reportDate: r['day'] as String,
          paymentCount: (r['count'] as int?) ?? 0,
          totalPayments: _d(r['total']),
          averageAmount: totalCount > 0 ? totalAmount / totalCount : 0,
          paymentBreakdown: const PaymentBreakdown(cashPayment: 0, transferPayment: 0, bankPayment: 0, paymentDetails: []),
        )).toList(),
        filters: PaymentFilters(
          startDate: request.startDate,
          endDate: request.endDate,
          paymentType: request.paymentType,
        ),
        summary: PaymentSummary(
          totalPayments: totalCount,
          totalAmount: totalAmount,
          averageAmount: totalCount > 0 ? totalAmount / totalCount : 0,
          paymentMethodBreakdown: const PaymentMethodBreakdown(cashPayment: 0, transferPayment: 0, bankPayment: 0, methods: []),
        ),
        note: 'Local data',
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  double _d(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }
}
