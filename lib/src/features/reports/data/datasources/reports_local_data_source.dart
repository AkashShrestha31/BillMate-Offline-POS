import 'package:hotel/src/core/constants/month_api_keys.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/reports/data/datasources/reports_remote_data_source.dart';
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
import 'package:intl/intl.dart';

/// Offline P&amp;L / analytics from local SQLite ([SalesInvoice], [PurchaseInvoice]).
@LazySingleton(as: ReportsRemoteDataSource)
class ReportsLocalDataSource implements ReportsRemoteDataSource {
  ReportsLocalDataSource(this._db);

  final LocalDb _db;
  static const _submittedFilter = 'submitted = 1';

  @override
  Future<ProfitLossReportResponse> fetchProfitLossReport(
    ProfitLossReportRequest request,
  ) async {
    try {
      final range = _resolvePnlRange(request);
      final sales = await _sumInvoices(
        table: 'SalesInvoice',
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      );
      final purchase = await _sumInvoices(
        table: 'PurchaseInvoice',
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      );
      final gross = sales - purchase;
      final margin = sales == 0 ? 0.0 : (gross / sales) * 100;

      final trendData = await _buildPnlTrend(
        range: range,
        groupBy: request.trendGroupBy(),
      );

      final revenueLines = [
        {'label': 'Sales revenue', 'amount': sales},
      ];
      final expenseLines = [
        {'label': 'Purchase expenses', 'amount': purchase},
      ];

      final summary = <String, dynamic>{
        'revenue': {'total': sales},
        'expenses': {'total': purchase},
        'profit': {
          'gross_profit': gross,
          'gross_margin_percent': margin,
        },
        'total_revenue': sales,
        'total_expenses': purchase,
        'net_profit': gross,
      };

      return ProfitLossReportResponse(
        summary: summary,
        trend: {'data': trendData},
        statement: {
          'statement': {
            'revenue': {
              'subtotal': sales,
              'lines': revenueLines,
            },
            'expenses': {
              'subtotal': purchase,
              'lines': expenseLines,
            },
            'gross_profit': {
              'amount': gross,
              'margin_percent': margin,
            },
          },
        },
        expense: {
          'total_expenses': purchase,
          'total': purchase,
          'by_category': await _expenseByCategory(range),
        },
        revenue: {
          'summary': {'total_revenue': sales},
          'total': sales,
          'by_category': await _revenueByCategory(range),
        },
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<StatementReportResponse> fetchStatementReport(
    StatementReportRequest request,
  ) async {
    try {
      final range = _resolveStatementRange(request);
      final groupBy = request.trendGroupBy();

      final cashIn = await _sumPayments(
        range: range,
        paymentType: 'Receive',
        cashOnly: true,
      );
      final cashOut = await _sumPayments(
        range: range,
        paymentType: 'Pay',
        cashOnly: true,
      );
      final bankIn = await _sumPayments(
        range: range,
        paymentType: 'Receive',
        cashOnly: false,
      );
      final bankOut = await _sumPayments(
        range: range,
        paymentType: 'Pay',
        cashOnly: false,
      );

      final dailyAgg = await _aggregateDailyCashSummary(range);
      final monthlyOpeningBalances =
          await _buildMonthlyOpeningBalances(request, range);
      final latestClosing = await _latestDailyClosingBalance(range);

      final cashBalance = latestClosing ?? (cashIn - cashOut);
      final bankBalance = bankIn - bankOut;
      final totalBalance = cashBalance + bankBalance;

      final cashTrend = await _buildPaymentTrend(
        range: range,
        groupBy: groupBy,
        cashOnly: true,
      );
      final bankTrend = await _buildPaymentTrend(
        range: range,
        groupBy: groupBy,
        cashOnly: false,
      );
      final dailyTrend = await _buildDailyCashTrend(range: range, groupBy: groupBy);

      return StatementReportResponse(
        overview: {
          'totals': {
            'total_cash_balance': cashBalance,
            'total_bank_balance': bankBalance,
            'total_balance': totalBalance,
          },
          'cash_balance': cashBalance,
          'bank_balance': bankBalance,
          'total_balance': totalBalance,
        },
        cashSummary: {
          'summary': {
            'total_in': cashIn,
            'total_out': cashOut,
            'net': cashIn - cashOut,
          },
        },
        cashTrend: {'data': cashTrend},
        bankSummary: {
          'summary': {
            'total_in': bankIn,
            'total_out': bankOut,
            'net': bankIn - bankOut,
          },
        },
        bankTrend: {'data': bankTrend},
        dailySummary: {
          'summary': dailyAgg,
          'monthly_opening_balances': monthlyOpeningBalances,
        },
        dailyTrend: {'data': dailyTrend},
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<AnalyticsReportResponse> fetchAnalyticsReport(
    AnalyticsReportRequest request,
  ) async {
    try {
      if (request.tabIndex == 2) {
        return _fetchAnalyticsDashboard(request);
      }
      final isPurchase = request.tabIndex == 0;
      final range = _resolveAnalyticsRange(request);
      final table = isPurchase ? 'PurchaseInvoice' : 'SalesInvoice';

      final total = await _sumInvoices(
        table: table,
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      );
      final invoiceCount = await _countInvoices(
        table: table,
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      );
      final outstanding = await _sumOutstanding(
        table: table,
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      );

      final summary = isPurchase
          ? <String, dynamic>{
              'total_purchases': total,
              'total_amount': total,
              'total': total,
              'grand_total': total,
              'total_invoices': invoiceCount,
              'invoice_count': invoiceCount,
              'count': invoiceCount,
              'outstanding': outstanding,
              'unpaid': outstanding,
            }
          : <String, dynamic>{
              'total_sales': total,
              'total_amount': total,
              'total': total,
              'grand_total': total,
              'total_invoices': invoiceCount,
              'invoice_count': invoiceCount,
              'count': invoiceCount,
              'outstanding': outstanding,
              'unpaid': outstanding,
            };

      final trendData = await _buildAnalyticsTrend(
        table: table,
        range: range,
        groupBy: request.trendView() == 'monthly' ? 'month' : 'day',
      );

      final itemTable =
          isPurchase ? 'PurchaseInvoiceItem' : 'SalesInvoiceItem';
      final items = await _topItems(
        invoiceTable: table,
        itemTable: itemTable,
        range: range,
        limit: 20,
      );
      final categories = await _topCategories(
        invoiceTable: table,
        itemTable: itemTable,
        range: range,
      );
      final parties = await _topParties(
        table: table,
        range: range,
        limit: 10,
      );

      return AnalyticsReportResponse(
        dashboard: const {},
        summary: summary,
        trend: {'data': trendData},
        items: {'data': items, 'results': items, 'items': items},
        categories: {'data': categories, 'results': categories},
        parties: {'data': parties, 'results': parties},
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  Future<AnalyticsReportResponse> _fetchAnalyticsDashboard(
    AnalyticsReportRequest request,
  ) async {
    final range = _resolveAnalyticsRange(request);
    final sales = await _sumInvoices(
      table: 'SalesInvoice',
      datePrefix: range.dateLikePrefix,
      dateFrom: range.dateFrom,
      dateTo: range.dateTo,
    );
    final purchase = await _sumInvoices(
      table: 'PurchaseInvoice',
      datePrefix: range.dateLikePrefix,
      dateFrom: range.dateFrom,
      dateTo: range.dateTo,
    );
    final gross = sales - purchase;
    final margin = sales == 0 ? 0.0 : (gross / sales) * 100;

    return AnalyticsReportResponse(
      dashboard: {
        'sales': {
          'total': sales,
          'total_amount': sales,
          'total_sales': sales,
          'amount': sales,
        },
        'purchase': {
          'total': purchase,
          'total_amount': purchase,
          'total_purchases': purchase,
          'amount': purchase,
        },
        'gross_profit': gross,
        'profit': gross,
        'net': gross,
        'gross_margin_percent': margin,
        'gross_margin': margin,
        'margin_percent': margin,
      },
      summary: const {},
      trend: const {},
      items: const {},
      categories: const {},
      parties: const {},
    );
  }

  // ---------- Period helpers ----------

  _DateRange _resolvePnlRange(ProfitLossReportRequest request) {
    switch (request.mode) {
      case 'month':
        return _monthRange(request.year, request.month);
      case 'month_range':
        return _monthRangeSpan(
          request.year,
          request.monthFrom,
          request.monthTo,
        );
      case 'custom':
        return _customRange(request.customStart, request.customEnd);
      case 'year':
      default:
        return _yearRange(request.year);
    }
  }

  _DateRange _resolveStatementRange(StatementReportRequest request) {
    switch (request.mode) {
      case 'day':
        final d = DateFormat('yyyy-MM-dd').format(request.day);
        return _DateRange(dateFrom: d, dateTo: d);
      case 'month':
        return _monthRange(request.year, request.month);
      case 'month_range':
        return _monthRangeSpan(
          request.year,
          request.monthFrom,
          request.monthTo,
        );
      case 'year':
      default:
        return _yearRange(request.year);
    }
  }

  _DateRange _resolveAnalyticsRange(AnalyticsReportRequest request) {
    switch (request.mode) {
      case 'day':
        final d = DateFormat('yyyy-MM-dd').format(request.day);
        return _DateRange(dateLikePrefix: '$d%');
      case 'month':
        return _monthRange(request.year, request.month);
      case 'year':
      default:
        return _yearRange(request.year);
    }
  }

  _DateRange _yearRange(int year) => _DateRange(dateLikePrefix: '$year%');

  _DateRange _monthRange(int year, int month) {
    final mm = month.toString().padLeft(2, '0');
    return _DateRange(dateLikePrefix: '$year-$mm%');
  }

  _DateRange _monthRangeSpan(int year, int fromMonth, int toMonth) {
    final start = DateTime(year, fromMonth, 1);
    final end = DateTime(year, toMonth + 1, 0);
    return _DateRange(
      dateFrom: DateFormat('yyyy-MM-dd').format(start),
      dateTo: DateFormat('yyyy-MM-dd').format(end),
    );
  }

  _DateRange _customRange(DateTime start, DateTime end) {
    return _DateRange(
      dateFrom: DateFormat('yyyy-MM-dd').format(start),
      dateTo: DateFormat('yyyy-MM-dd').format(end),
    );
  }

  String _dateWhere({
    String column = 'date',
    String? datePrefix,
    String? dateFrom,
    String? dateTo,
  }) {
    if (datePrefix != null) {
      return '$column LIKE ? AND $_submittedFilter';
    }
    return 'substr($column, 1, 10) >= ? AND substr($column, 1, 10) <= ? AND $_submittedFilter';
  }

  List<dynamic> _dateArgs({
    String? datePrefix,
    String? dateFrom,
    String? dateTo,
  }) {
    if (datePrefix != null) return [datePrefix];
    return [dateFrom!, dateTo!];
  }

  static const _paymentSubmittedFilter = 'submitted = 1';
  static const _cashMethodSql =
      "LOWER(TRIM(paymentMethod)) IN ('cash', 'cash in hand')";

  String _paymentDateWhere({
    String? datePrefix,
    String? dateFrom,
    String? dateTo,
  }) {
    if (datePrefix != null) {
      return "date LIKE ? AND $_paymentSubmittedFilter";
    }
    return "date >= ? AND date <= ? AND $_paymentSubmittedFilter";
  }

  String _dailyDateWhere({
    String? datePrefix,
    String? dateFrom,
    String? dateTo,
  }) {
    if (datePrefix != null) {
      return 'date LIKE ?';
    }
    return 'date >= ? AND date <= ?';
  }

  Future<double> _sumPayments({
    required _DateRange range,
    required String paymentType,
    required bool cashOnly,
  }) async {
    final methodClause =
        cashOnly ? _cashMethodSql : "NOT ($_cashMethodSql)";
    final rows = await _db.rawQuery(
      'SELECT COALESCE(SUM(CAST(amount AS REAL)), 0) AS total '
      'FROM Payment WHERE ${_paymentDateWhere(datePrefix: range.dateLikePrefix, dateFrom: range.dateFrom, dateTo: range.dateTo)} '
      "AND paymentType = ? AND $methodClause",
      [
        ..._dateArgs(
          datePrefix: range.dateLikePrefix,
          dateFrom: range.dateFrom,
          dateTo: range.dateTo,
        ),
        paymentType,
      ],
    );
    return _d(rows.first['total']);
  }

  Future<Map<String, dynamic>> _aggregateDailyCashSummary(_DateRange range) async {
    final rows = await _db.rawQuery(
      '''
      SELECT
        COALESCE(SUM(sales_amount), 0) AS sales_amount,
        COALESCE(SUM(cash_amount), 0) AS cash_amount,
        COALESCE(SUM(qr_amount), 0) AS qr_amount,
        COALESCE(SUM(expenses), 0) AS expenses,
        COALESCE(SUM(un_paid), 0) AS un_paid,
        COALESCE(SUM(discount), 0) AS discount,
        COALESCE(SUM(closing_balance), 0) AS closing_balance_sum,
        COUNT(*) AS days,
        (
          SELECT opening_balance
          FROM DailyCashSummary
          WHERE ${_dailyDateWhere(datePrefix: range.dateLikePrefix, dateFrom: range.dateFrom, dateTo: range.dateTo)}
          ORDER BY date ASC
          LIMIT 1
        ) AS opening_balance
      FROM DailyCashSummary
      WHERE ${_dailyDateWhere(datePrefix: range.dateLikePrefix, dateFrom: range.dateFrom, dateTo: range.dateTo)}
      ''',
      _dateArgs(
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      ),
    );
    if (rows.isEmpty) return {};
    final r = rows.first;
    return {
      'sales_amount': _d(r['sales_amount']),
      'cash_amount': _d(r['cash_amount']),
      'qr_amount': _d(r['qr_amount']),
      'expenses': _d(r['expenses']),
      'un_paid': _d(r['un_paid']),
      'discount': _d(r['discount']),
      'closing_balance': _d(r['closing_balance_sum']),
      'opening_balance': _d(r['opening_balance']),
      'days': _d(r['days']).round(),
    };
  }

  List<int> _monthsInStatementRequest(StatementReportRequest request) {
    switch (request.mode) {
      case 'year':
        return List.generate(12, (i) => i + 1);
      case 'month_range':
        return List.generate(
          request.monthTo - request.monthFrom + 1,
          (i) => request.monthFrom + i,
        );
      case 'month':
        return [request.month];
      default:
        return const [];
    }
  }

  Future<Map<String, double>> _openingBalancesByMonth(_DateRange range) async {
    final rows = await _db.rawQuery(
      '''
      SELECT substr(d.date, 1, 7) AS period, d.opening_balance
      FROM DailyCashSummary d
      INNER JOIN (
        SELECT substr(date, 1, 7) AS period, MIN(date) AS min_date
        FROM DailyCashSummary
        WHERE ${_dailyDateWhere(datePrefix: range.dateLikePrefix, dateFrom: range.dateFrom, dateTo: range.dateTo)}
        GROUP BY period
      ) first ON d.date = first.min_date
      ORDER BY period
      ''',
      _dateArgs(
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      ),
    );
    return {
      for (final r in rows)
        r['period']?.toString() ?? '': _d(r['opening_balance']),
    };
  }

  Future<List<Map<String, dynamic>>> _buildMonthlyOpeningBalances(
    StatementReportRequest request,
    _DateRange range,
  ) async {
    final months = _monthsInStatementRequest(request);
    if (months.isEmpty) return const [];

    final byPeriod = await _openingBalancesByMonth(range);
    return months.map((month) {
      final period = '${request.year}-${month.toString().padLeft(2, '0')}';
      final balance = byPeriod[period];
      return <String, dynamic>{
        'period': period,
        'period_label': _periodLabel(period, 'month'),
        'opening_balance': balance,
        'has_data': balance != null,
      };
    }).toList();
  }

  Future<double?> _latestDailyClosingBalance(_DateRange range) async {
    final rows = await _db.rawQuery(
      '''
      SELECT closing_balance
      FROM DailyCashSummary
      WHERE ${_dailyDateWhere(datePrefix: range.dateLikePrefix, dateFrom: range.dateFrom, dateTo: range.dateTo)}
      ORDER BY date DESC
      LIMIT 1
      ''',
      _dateArgs(
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      ),
    );
    if (rows.isEmpty) return null;
    return _d(rows.first['closing_balance']);
  }

  Future<List<Map<String, dynamic>>> _buildPaymentTrend({
    required _DateRange range,
    required String groupBy,
    required bool cashOnly,
  }) async {
    final periodExpr =
        groupBy == 'day' ? 'date' : "substr(date, 1, 7)";
    final methodClause =
        cashOnly ? _cashMethodSql : "NOT ($_cashMethodSql)";
    final rows = await _db.rawQuery(
      '''
      SELECT $periodExpr AS period,
        COALESCE(SUM(CASE WHEN paymentType = 'Receive' THEN CAST(amount AS REAL) ELSE 0 END), 0) AS total_in,
        COALESCE(SUM(CASE WHEN paymentType = 'Pay' THEN CAST(amount AS REAL) ELSE 0 END), 0) AS total_out
      FROM Payment
      WHERE ${_paymentDateWhere(datePrefix: range.dateLikePrefix, dateFrom: range.dateFrom, dateTo: range.dateTo)}
        AND $methodClause
      GROUP BY period
      ORDER BY period
      ''',
      _dateArgs(
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      ),
    );
    return rows.map((r) {
      final period = r['period']?.toString() ?? '';
      return <String, dynamic>{
        'period': period,
        'period_label': _periodLabel(period, groupBy),
        'total_in': _d(r['total_in']),
        'total_out': _d(r['total_out']),
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> _buildDailyCashTrend({
    required _DateRange range,
    required String groupBy,
  }) async {
    final periodExpr =
        groupBy == 'day' ? 'date' : "substr(date, 1, 7)";
    final openingByPeriod = await _openingBalancesForTrend(range, groupBy);
    final rows = await _db.rawQuery(
      '''
      SELECT $periodExpr AS period,
        COALESCE(SUM(cash_amount), 0) AS total_cash,
        COALESCE(SUM(qr_amount), 0) AS total_qr
      FROM DailyCashSummary
      WHERE ${_dailyDateWhere(datePrefix: range.dateLikePrefix, dateFrom: range.dateFrom, dateTo: range.dateTo)}
      GROUP BY period
      ORDER BY period
      ''',
      _dateArgs(
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      ),
    );
    return rows.map((r) {
      final period = r['period']?.toString() ?? '';
      return <String, dynamic>{
        'period': period,
        'period_label': _periodLabel(period, groupBy),
        'total_cash': _d(r['total_cash']),
        'total_qr': _d(r['total_qr']),
        if (openingByPeriod.containsKey(period))
          'opening_balance': openingByPeriod[period],
      };
    }).toList();
  }

  Future<Map<String, double>> _openingBalancesForTrend(
    _DateRange range,
    String groupBy,
  ) async {
    if (groupBy == 'month') {
      return _openingBalancesByMonth(range);
    }
    final rows = await _db.rawQuery(
      '''
      SELECT date AS period, opening_balance
      FROM DailyCashSummary
      WHERE ${_dailyDateWhere(datePrefix: range.dateLikePrefix, dateFrom: range.dateFrom, dateTo: range.dateTo)}
      ORDER BY date
      ''',
      _dateArgs(
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      ),
    );
    return {
      for (final r in rows)
        r['period']?.toString() ?? '': _d(r['opening_balance']),
    };
  }

  Future<double> _sumInvoices({
    required String table,
    String? datePrefix,
    String? dateFrom,
    String? dateTo,
  }) async {
    final rows = await _db.rawQuery(
      'SELECT COALESCE(SUM(CAST(grandTotal AS REAL)), 0) AS total '
      'FROM $table WHERE ${_dateWhere(datePrefix: datePrefix, dateFrom: dateFrom, dateTo: dateTo)}',
      _dateArgs(datePrefix: datePrefix, dateFrom: dateFrom, dateTo: dateTo),
    );
    return _d(rows.first['total']);
  }

  Future<int> _countInvoices({
    required String table,
    String? datePrefix,
    String? dateFrom,
    String? dateTo,
  }) async {
    final rows = await _db.rawQuery(
      'SELECT COUNT(*) AS c FROM $table '
      'WHERE ${_dateWhere(datePrefix: datePrefix, dateFrom: dateFrom, dateTo: dateTo)}',
      _dateArgs(datePrefix: datePrefix, dateFrom: dateFrom, dateTo: dateTo),
    );
    return _d(rows.first['c']).round();
  }

  Future<double> _sumOutstanding({
    required String table,
    String? datePrefix,
    String? dateFrom,
    String? dateTo,
  }) async {
    final rows = await _db.rawQuery(
      'SELECT COALESCE(SUM(CAST(outstandingAmount AS REAL)), 0) AS total '
      'FROM $table WHERE ${_dateWhere(datePrefix: datePrefix, dateFrom: dateFrom, dateTo: dateTo)} '
      'AND CAST(outstandingAmount AS REAL) > 0',
      _dateArgs(datePrefix: datePrefix, dateFrom: dateFrom, dateTo: dateTo),
    );
    return _d(rows.first['total']);
  }

  Future<List<Map<String, dynamic>>> _buildPnlTrend({
    required _DateRange range,
    required String groupBy,
  }) async {
    final periodExpr =
        groupBy == 'day' ? 'substr(date, 1, 10)' : 'substr(date, 1, 7)';
    final salesRows = await _groupedTotals(
      table: 'SalesInvoice',
      periodExpr: periodExpr,
      range: range,
    );
    final purchaseRows = await _groupedTotals(
      table: 'PurchaseInvoice',
      periodExpr: periodExpr,
      range: range,
    );

    final periods = <String>{
      ...salesRows.keys,
      ...purchaseRows.keys,
    }.toList()
      ..sort();

    return periods.map((period) {
      return <String, dynamic>{
        'period': period,
        'period_label': _periodLabel(period, groupBy),
        'revenue': salesRows[period] ?? 0.0,
        'expenses': purchaseRows[period] ?? 0.0,
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> _buildAnalyticsTrend({
    required String table,
    required _DateRange range,
    required String groupBy,
  }) async {
    final periodExpr =
        groupBy == 'day' ? 'substr(date, 1, 10)' : 'substr(date, 1, 7)';
    final totals = await _groupedTotals(
      table: table,
      periodExpr: periodExpr,
      range: range,
    );
    final countRows = await _groupedCounts(
      table: table,
      periodExpr: periodExpr,
      range: range,
    );

    final periods = totals.keys.toList()..sort();
    return periods.map((period) {
      final amount = totals[period] ?? 0.0;
      return <String, dynamic>{
        'period': period,
        'period_label': _periodLabel(period, groupBy),
        'label': _periodLabel(period, groupBy),
        'amount': amount,
        'total': amount,
        'total_amount': amount,
        'value': amount,
        'invoice_count': countRows[period] ?? 0,
        'count': countRows[period] ?? 0,
      };
    }).toList();
  }

  Future<Map<String, double>> _groupedTotals({
    required String table,
    required String periodExpr,
    required _DateRange range,
  }) async {
    final rows = await _db.rawQuery(
      'SELECT $periodExpr AS period, '
      'COALESCE(SUM(CAST(grandTotal AS REAL)), 0) AS total '
      'FROM $table WHERE ${_dateWhere(datePrefix: range.dateLikePrefix, dateFrom: range.dateFrom, dateTo: range.dateTo)} '
      'GROUP BY period ORDER BY period',
      _dateArgs(
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      ),
    );
    return {
      for (final r in rows)
        r['period'] as String: _d(r['total']),
    };
  }

  Future<Map<String, int>> _groupedCounts({
    required String table,
    required String periodExpr,
    required _DateRange range,
  }) async {
    final rows = await _db.rawQuery(
      'SELECT $periodExpr AS period, COUNT(*) AS c '
      'FROM $table WHERE ${_dateWhere(datePrefix: range.dateLikePrefix, dateFrom: range.dateFrom, dateTo: range.dateTo)} '
      'GROUP BY period ORDER BY period',
      _dateArgs(
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      ),
    );
    return {
      for (final r in rows) r['period'] as String: _d(r['c']).round(),
    };
  }

  Future<List<Map<String, dynamic>>> _topCategories({
    required String invoiceTable,
    required String itemTable,
    required _DateRange range,
  }) {
    return _linesByCategory(
      invoiceTable: invoiceTable,
      itemTable: itemTable,
      range: range,
    );
  }

  Future<List<Map<String, dynamic>>> _revenueByCategory(_DateRange range) async {
    return _linesByCategory(
      invoiceTable: 'SalesInvoice',
      itemTable: 'SalesInvoiceItem',
      range: range,
    );
  }

  Future<List<Map<String, dynamic>>> _expenseByCategory(_DateRange range) async {
    return _linesByCategory(
      invoiceTable: 'PurchaseInvoice',
      itemTable: 'PurchaseInvoiceItem',
      range: range,
    );
  }

  Future<List<Map<String, dynamic>>> _linesByCategory({
    required String invoiceTable,
    required String itemTable,
    required _DateRange range,
  }) async {
    final rows = await _db.rawQuery(
      '''
      SELECT COALESCE(it.category, 'Uncategorized') AS category,
             COALESCE(SUM(CAST(li.amount AS REAL)), 0) AS total
      FROM $itemTable li
      INNER JOIN $invoiceTable inv ON inv.name = li.parent
      LEFT JOIN Item it ON it.name = li.item
      WHERE ${_dateWhere(column: 'inv.date', datePrefix: range.dateLikePrefix, dateFrom: range.dateFrom, dateTo: range.dateTo)}
      GROUP BY category
      ORDER BY total DESC
      LIMIT 12
      ''',
      _dateArgs(
        datePrefix: range.dateLikePrefix,
        dateFrom: range.dateFrom,
        dateTo: range.dateTo,
      ),
    );
    return rows
        .map(
          (r) => <String, dynamic>{
            'category': r['category']?.toString() ?? 'Uncategorized',
            'total': _d(r['total']),
          },
        )
        .toList();
  }

  Future<List<Map<String, dynamic>>> _topItems({
    required String invoiceTable,
    required String itemTable,
    required _DateRange range,
    required int limit,
  }) async {
    final rows = await _db.rawQuery(
      '''
      SELECT li.item AS name,
             COALESCE(SUM(CAST(li.amount AS REAL)), 0) AS total,
             COALESCE(SUM(li.quantity), 0) AS qty
      FROM $itemTable li
      INNER JOIN $invoiceTable inv ON inv.name = li.parent
      WHERE ${_dateWhere(column: 'inv.date', datePrefix: range.dateLikePrefix, dateFrom: range.dateFrom, dateTo: range.dateTo)}
      GROUP BY li.item
      ORDER BY total DESC
      LIMIT ?
      ''',
      [
        ..._dateArgs(
          datePrefix: range.dateLikePrefix,
          dateFrom: range.dateFrom,
          dateTo: range.dateTo,
        ),
        limit,
      ],
    );
    return rows
        .map(
          (r) => <String, dynamic>{
            'name': r['name']?.toString() ?? 'Item',
            'item': r['name']?.toString() ?? 'Item',
            'amount': _d(r['total']),
            'total': _d(r['total']),
            'total_amount': _d(r['total']),
            'quantity': _d(r['qty']),
          },
        )
        .toList();
  }

  Future<List<Map<String, dynamic>>> _topParties({
    required String table,
    required _DateRange range,
    required int limit,
  }) async {
    final rows = await _db.rawQuery(
      '''
      SELECT party AS name,
             COALESCE(SUM(CAST(grandTotal AS REAL)), 0) AS total,
             COUNT(*) AS invoice_count
      FROM $table
      WHERE ${_dateWhere(datePrefix: range.dateLikePrefix, dateFrom: range.dateFrom, dateTo: range.dateTo)}
      GROUP BY party
      ORDER BY total DESC
      LIMIT ?
      ''',
      [
        ..._dateArgs(
          datePrefix: range.dateLikePrefix,
          dateFrom: range.dateFrom,
          dateTo: range.dateTo,
        ),
        limit,
      ],
    );
    return rows
        .map(
          (r) => <String, dynamic>{
            'name': r['name']?.toString() ?? 'Party',
            'party': r['name']?.toString() ?? 'Party',
            'amount': _d(r['total']),
            'total': _d(r['total']),
            'total_amount': _d(r['total']),
            'invoice_count': _d(r['invoice_count']).round(),
            'count': _d(r['invoice_count']).round(),
          },
        )
        .toList();
  }

  String _periodLabel(String period, String groupBy) {
    if (groupBy == 'day' && period.length >= 10) {
      try {
        return DateFormat('MMM d').format(DateTime.parse(period.substring(0, 10)));
      } catch (_) {
        return period;
      }
    }
    if (period.length >= 7) {
      final parts = period.split('-');
      if (parts.length >= 2) {
        final month = int.tryParse(parts[1]) ?? 1;
        if (month >= 1 && month <= 12) {
          return MonthApiKeys.all[month - 1];
        }
      }
    }
    return period;
  }

  double _d(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }
}

class _DateRange {
  const _DateRange({this.dateLikePrefix, this.dateFrom, this.dateTo});

  final String? dateLikePrefix;
  final String? dateFrom;
  final String? dateTo;
}
