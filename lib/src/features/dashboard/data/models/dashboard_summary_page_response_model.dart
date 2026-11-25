/// Dashboard summary from [GET] `dashboard-summary/`.
///
/// Supports current API shape (`year_sales`, `breakdown.daily_sales`, etc.)
/// and legacy keys (`year_sales_sales`, `month_daily_sales`, …).
class DashboardSummaryPageResponseModel {
  const DashboardSummaryPageResponseModel({
    required this.todaySales,
    required this.todayPurchase,
    required this.todayUnpaidSales,
    required this.todayUnpaidPurchase,
    required this.monthSales,
    required this.monthPurchase,
    this.monthSalesKey,
    this.monthPurchaseKey,
    required this.monthUnpaidSales,
    required this.monthUnpaidPurchase,
    required this.yearSalesSales,
    required this.yearsPurchase,
    required this.yearUnpaidSales,
    required this.yearUnpaidPurchase,
    required this.yearAllSales,
    required this.monthDailySales,
    required this.monthDailyPurchase,
  });

  final double todaySales;
  final double todayPurchase;
  final double todayUnpaidSales;
  final double todayUnpaidPurchase;
  final double monthSales;
  final double monthPurchase;
  /// When API sends `month_sales` as `{ "key", "amount" }`, this is the label (e.g. Outstanding).
  final String? monthSalesKey;
  /// When API sends `month_purchase` as `{ "key", "amount" }`, this is the label (e.g. Advance).
  final String? monthPurchaseKey;
  final double monthUnpaidSales;
  final double monthUnpaidPurchase;
  final double yearSalesSales;
  final double yearsPurchase;
  final double yearUnpaidSales;
  final double yearUnpaidPurchase;
  final Map<String, double> yearAllSales;
  final Map<String, double> monthDailySales;
  final Map<String, double> monthDailyPurchase;

  /// Value for the month revenue overview card (prefers API `month_sales` when keyed or non-zero).
  double get monthRevenueOverviewAmount {
    if (monthSalesKey != null) return monthSales;
    if (monthSales != 0) return monthSales;
    return monthDailySales.values.fold(0.0, (a, b) => a + b);
  }

  /// Value for the month expense overview card (prefers API `month_purchase` when keyed or non-zero).
  double get monthExpenseOverviewAmount {
    if (monthPurchaseKey != null) return monthPurchase;
    if (monthPurchase != 0) return monthPurchase;
    return monthDailyPurchase.values.fold(0.0, (a, b) => a + b);
  }

  /// Card heading: API metric name when `month_sales` is an object with `key`.
  String get monthRevenueOverviewTitle => monthSalesKey ?? 'Month Revenue';

  String get monthExpenseOverviewTitle => monthPurchaseKey ?? 'Month Expenses';

  factory DashboardSummaryPageResponseModel.fromJson(Map<String, dynamic> json) {
    final root = _dashboardSummaryJsonRoot(json);

    Map<String, dynamic>? _asStringKeyMap(dynamic raw) {
      if (raw == null) return null;
      if (raw is Map<String, dynamic>) return raw;
      if (raw is Map) {
        return raw.map((k, v) => MapEntry(k.toString(), v));
      }
      return null;
    }

    Map<String, double> parseNumMap(dynamic raw) {
      final m = _asStringKeyMap(raw);
      if (m == null) return {};
      return m.map((k, v) => MapEntry(k, _toDouble(v)));
    }

    final breakdown = _asStringKeyMap(root['breakdown']);
    var dailySales = parseNumMap(breakdown?['daily_sales']);
    var dailyPurchase = parseNumMap(breakdown?['daily_purchase']);
    if (dailySales.isEmpty) {
      dailySales = parseNumMap(root['month_daily_sales']);
    }
    if (dailyPurchase.isEmpty) {
      dailyPurchase = parseNumMap(root['month_daily_purchase']);
    }

    var monthlyYearSales = parseNumMap(root['current_year_monthly_sales']);
    if (monthlyYearSales.isEmpty) {
      monthlyYearSales = parseNumMap(root['year_all_sales']);
    }

    final monthSalesParsed = _parseMonthKeyedMetric(root['month_sales']);
    final monthPurchaseParsed = _parseMonthKeyedMetric(root['month_purchase']);

    return DashboardSummaryPageResponseModel(
      todaySales: _toDouble(root['today_sales']),
      todayPurchase: _toDouble(root['today_purchase']),
      todayUnpaidSales: _toDouble(root['today_unpaid_sales']),
      todayUnpaidPurchase: _toDouble(root['today_unpaid_purchase']),
      monthSales: monthSalesParsed.amount,
      monthPurchase: monthPurchaseParsed.amount,
      monthSalesKey: monthSalesParsed.key,
      monthPurchaseKey: monthPurchaseParsed.key,
      monthUnpaidSales: _toDouble(root['month_unpaid_sales']),
      monthUnpaidPurchase: _toDouble(root['month_unpaid_purchase']),
      yearSalesSales: _toDouble(root['year_sales'] ?? root['year_sales_sales']),
      yearsPurchase: _toDouble(root['year_purchase'] ?? root['years_purchase']),
      yearUnpaidSales: _toDouble(root['year_unpaid_sales']),
      yearUnpaidPurchase: _toDouble(root['year_unpaid_purchase']),
      yearAllSales: monthlyYearSales,
      monthDailySales: dailySales,
      monthDailyPurchase: dailyPurchase,
    );
  }

  Map<String, dynamic> toJson() => {
        'today_sales': todaySales,
        'today_purchase': todayPurchase,
        'today_unpaid_sales': todayUnpaidSales,
        'today_unpaid_purchase': todayUnpaidPurchase,
        'month_sales': monthSalesKey != null
            ? {'key': monthSalesKey, 'amount': monthSales.toString()}
            : monthSales,
        'month_purchase': monthPurchaseKey != null
            ? {'key': monthPurchaseKey, 'amount': monthPurchase.toString()}
            : monthPurchase,
        'month_unpaid_sales': monthUnpaidSales,
        'month_unpaid_purchase': monthUnpaidPurchase,
        'year_sales': yearSalesSales,
        'year_purchase': yearsPurchase,
        'year_unpaid_sales': yearUnpaidSales,
        'year_unpaid_purchase': yearUnpaidPurchase,
        'current_year_monthly_sales': yearAllSales,
        'breakdown': {
          'daily_sales': monthDailySales,
          'daily_purchase': monthDailyPurchase,
        },
      };
}

double _toDouble(dynamic v) {
  if (v == null) return 0.0;
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v) ?? 0.0;
  return 0.0;
}

/// Use nested `data` when the server wraps the payload as `{ success, data: { … } }`.
Map<String, dynamic> _dashboardSummaryJsonRoot(Map<String, dynamic> json) {
  final data = json['data'];
  if (data is Map) {
    final map = Map<String, dynamic>.from(data);
    if (map.containsKey('month_sales') ||
        map.containsKey('today_sales') ||
        map.containsKey('breakdown')) {
      return map;
    }
  }
  return json;
}

/// API may send `month_sales` / `month_purchase` as a number, string, or `{ "key", "amount" }`.
({double amount, String? key}) _parseMonthKeyedMetric(dynamic raw) {
  if (raw == null) return (amount: 0.0, key: null);
  if (raw is Map) {
    final m = Map<String, dynamic>.from(raw);
    final rawKey = m['key'];
    final keyStr = rawKey == null ? null : rawKey.toString().trim();
    final key = (keyStr == null || keyStr.isEmpty) ? null : keyStr;
    final amount = _toDouble(m['amount'] ?? m['value']);
    return (amount: amount, key: key);
  }
  return (amount: _toDouble(raw), key: null);
}
