import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/dashboard/data/datasources/dashboard_summary_page_remote_data_source.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_response_model.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@LazySingleton(as: DashboardSummaryPageRemoteDataSource)
class DashboardSummaryPageLocalDataSource
    implements DashboardSummaryPageRemoteDataSource {
  DashboardSummaryPageLocalDataSource(this._db);
  final LocalDb _db;

  @override
  Future<ApiResponse<DashboardSummaryPageResponseModel>> getDashboardSummaryPage(
      DashboardSummaryPageRequestParams params) async {
    try {
      final now = DateTime.now();
      final today = DateFormat('yyyy-MM-dd').format(now);
      final monthPrefix = DateFormat('yyyy-MM').format(now);
      final yearPrefix = DateFormat('yyyy').format(now);

      // Today sales
      final todaySalesRows = await _db.rawQuery(
        "SELECT COALESCE(SUM(CAST(grandTotal AS REAL)), 0) as total FROM SalesInvoice WHERE date LIKE ? AND submitted = 1",
        ['$today%'],
      );
      final todaySales = _toDouble(todaySalesRows.first['total']);

      // Today purchases
      final todayPurchaseRows = await _db.rawQuery(
        "SELECT COALESCE(SUM(CAST(grandTotal AS REAL)), 0) as total FROM PurchaseInvoice WHERE date LIKE ? AND submitted = 1",
        ['$today%'],
      );
      final todayPurchase = _toDouble(todayPurchaseRows.first['total']);

      // Today unpaid sales
      final todayUnpaidRows = await _db.rawQuery(
        "SELECT COALESCE(SUM(CAST(outstandingAmount AS REAL)), 0) as total FROM SalesInvoice WHERE date LIKE ? AND submitted = 1 AND CAST(outstandingAmount AS REAL) > 0",
        ['$today%'],
      );
      final todayUnpaidSales = _toDouble(todayUnpaidRows.first['total']);

      // Today unpaid purchases
      final todayUnpaidPurchaseRows = await _db.rawQuery(
        "SELECT COALESCE(SUM(CAST(outstandingAmount AS REAL)), 0) as total FROM PurchaseInvoice WHERE date LIKE ? AND submitted = 1 AND CAST(outstandingAmount AS REAL) > 0",
        ['$today%'],
      );
      final todayUnpaidPurchase = _toDouble(todayUnpaidPurchaseRows.first['total']);

      // Month sales
      final monthSalesRows = await _db.rawQuery(
        "SELECT COALESCE(SUM(CAST(grandTotal AS REAL)), 0) as total FROM SalesInvoice WHERE date LIKE ? AND submitted = 1",
        ['$monthPrefix%'],
      );
      final monthSales = _toDouble(monthSalesRows.first['total']);

      // Month purchases
      final monthPurchaseRows = await _db.rawQuery(
        "SELECT COALESCE(SUM(CAST(grandTotal AS REAL)), 0) as total FROM PurchaseInvoice WHERE date LIKE ? AND submitted = 1",
        ['$monthPrefix%'],
      );
      final monthPurchase = _toDouble(monthPurchaseRows.first['total']);

      // Month unpaid sales
      final monthUnpaidRows = await _db.rawQuery(
        "SELECT COALESCE(SUM(CAST(outstandingAmount AS REAL)), 0) as total FROM SalesInvoice WHERE date LIKE ? AND submitted = 1 AND CAST(outstandingAmount AS REAL) > 0",
        ['$monthPrefix%'],
      );
      final monthUnpaidSales = _toDouble(monthUnpaidRows.first['total']);

      // Month unpaid purchases
      final monthUnpaidPurchaseRows = await _db.rawQuery(
        "SELECT COALESCE(SUM(CAST(outstandingAmount AS REAL)), 0) as total FROM PurchaseInvoice WHERE date LIKE ? AND submitted = 1 AND CAST(outstandingAmount AS REAL) > 0",
        ['$monthPrefix%'],
      );
      final monthUnpaidPurchase = _toDouble(monthUnpaidPurchaseRows.first['total']);

      // Year sales
      final yearSalesRows = await _db.rawQuery(
        "SELECT COALESCE(SUM(CAST(grandTotal AS REAL)), 0) as total FROM SalesInvoice WHERE date LIKE ? AND submitted = 1",
        ['$yearPrefix%'],
      );
      final yearSales = _toDouble(yearSalesRows.first['total']);

      // Year purchases
      final yearPurchaseRows = await _db.rawQuery(
        "SELECT COALESCE(SUM(CAST(grandTotal AS REAL)), 0) as total FROM PurchaseInvoice WHERE date LIKE ? AND submitted = 1",
        ['$yearPrefix%'],
      );
      final yearPurchase = _toDouble(yearPurchaseRows.first['total']);

      // Year unpaid
      final yearUnpaidSalesRows = await _db.rawQuery(
        "SELECT COALESCE(SUM(CAST(outstandingAmount AS REAL)), 0) as total FROM SalesInvoice WHERE date LIKE ? AND submitted = 1 AND CAST(outstandingAmount AS REAL) > 0",
        ['$yearPrefix%'],
      );
      final yearUnpaidSales = _toDouble(yearUnpaidSalesRows.first['total']);

      final yearUnpaidPurchaseRows = await _db.rawQuery(
        "SELECT COALESCE(SUM(CAST(outstandingAmount AS REAL)), 0) as total FROM PurchaseInvoice WHERE date LIKE ? AND submitted = 1 AND CAST(outstandingAmount AS REAL) > 0",
        ['$yearPrefix%'],
      );
      final yearUnpaidPurchase = _toDouble(yearUnpaidPurchaseRows.first['total']);

      // Daily breakdown for requested month
      final dailyMonth = params.dailyMonth ?? DateFormat('yyyy-MM').format(now);
      final dailySalesRows = await _db.rawQuery(
        "SELECT substr(date,1,10) as day, COALESCE(SUM(CAST(grandTotal AS REAL)),0) as total FROM SalesInvoice WHERE date LIKE ? AND submitted = 1 GROUP BY day ORDER BY day",
        ['$dailyMonth%'],
      );
      final monthDailySales = <String, double>{
        for (final r in dailySalesRows)
          r['day'] as String: _toDouble(r['total']),
      };

      final dailyPurchaseRows = await _db.rawQuery(
        "SELECT substr(date,1,10) as day, COALESCE(SUM(CAST(grandTotal AS REAL)),0) as total FROM PurchaseInvoice WHERE date LIKE ? AND submitted = 1 GROUP BY day ORDER BY day",
        ['$dailyMonth%'],
      );
      final monthDailyPurchase = <String, double>{
        for (final r in dailyPurchaseRows)
          r['day'] as String: _toDouble(r['total']),
      };

      // Year monthly breakdown
      final yearMonthlyRows = await _db.rawQuery(
        "SELECT substr(date,1,7) as month, COALESCE(SUM(CAST(grandTotal AS REAL)),0) as total FROM SalesInvoice WHERE date LIKE ? AND submitted = 1 GROUP BY month ORDER BY month",
        ['$yearPrefix%'],
      );
      final yearAllSales = <String, double>{
        for (final r in yearMonthlyRows)
          r['month'] as String: _toDouble(r['total']),
      };

      final response = DashboardSummaryPageResponseModel(
        todaySales: todaySales,
        todayPurchase: todayPurchase,
        todayUnpaidSales: todayUnpaidSales,
        todayUnpaidPurchase: todayUnpaidPurchase,
        monthSales: monthSales,
        monthPurchase: monthPurchase,
        monthUnpaidSales: monthUnpaidSales,
        monthUnpaidPurchase: monthUnpaidPurchase,
        yearSalesSales: yearSales,
        yearsPurchase: yearPurchase,
        yearUnpaidSales: yearUnpaidSales,
        yearUnpaidPurchase: yearUnpaidPurchase,
        yearAllSales: yearAllSales,
        monthDailySales: monthDailySales,
        monthDailyPurchase: monthDailyPurchase,
      );

      return ApiResponse(data: response, message: '', success: true);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<HotelSalesResponseModel>> getHotelSales(
      HotelSalesRequestParams params) async {
    try {
      final conditions = <String>[];
      final args = <dynamic>[];

      if (params.startDate != null) {
        conditions.add('date >= ?');
        args.add(DateFormat('yyyy-MM-dd').format(params.startDate!));
      }
      if (params.endDate != null) {
        conditions.add('date <= ?');
        args.add(DateFormat('yyyy-MM-dd').format(params.endDate!));
      }

      final where = conditions.isNotEmpty ? conditions.join(' AND ') : null;
      final page = params.page ?? 1;
      final pageSize = params.pageSize ?? 20;
      final offset = (page - 1) * pageSize;

      final rows = await _db.query(
        'DailyCashSummary',
        where: where,
        whereArgs: args.isNotEmpty ? args : null,
        orderBy: 'date DESC',
        limit: pageSize,
        offset: offset,
      );

      final total = await _db.count('DailyCashSummary', where: where, whereArgs: args.isNotEmpty ? args : null);

      final results = rows.map((r) => SalesReport(
        id: r['id'] as int,
        date: DateTime.tryParse(r['date'] as String? ?? '') ?? DateTime.now(),
        openingBalance: _toDouble(r['opening_balance']),
        salesAmount: _toDouble(r['sales_amount']),
        qrAmount: _toDouble(r['qr_amount']),
        cashAmount: _toDouble(r['cash_amount']),
        discount: _toDouble(r['discount']),
        expenses: _toDouble(r['expenses']),
        unPaid: _toDouble(r['un_paid']),
        unPaidDiscount: _toDouble(r['un_paid_discount']),
        creditPaidCash: _toDouble(r['credit_paid_cash']),
        creditQr: _toDouble(r['credit_qr']),
        closingBalance: _toDouble(r['closing_balance']),
        lostMoney: _toDouble(r['lost_money']),
      )).toList();

      return ApiResponse(
        data: HotelSalesResponseModel(
          count: total,
          next: null,
          previous: null,
          results: results,
        ),
        message: '',
        success: true,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }
}
