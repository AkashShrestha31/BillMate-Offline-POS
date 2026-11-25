import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/hotel_summary/data/datasources/daily_cash_summary_remote_data_source.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_query_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_request_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/response/daily_cash_summary_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DailyCashSummaryRemoteDataSource)
class DailyCashSummaryLocalDataSource implements DailyCashSummaryRemoteDataSource {
  DailyCashSummaryLocalDataSource(this._db);
  final LocalDb _db;

  @override
  Future<DailyCashSummaryResponseModel> getDailySummaries({
    required DailyCashSummaryQueryParams params,
  }) async {
    try {
      final conditions = <String>[];
      final args = <dynamic>[];
      if (params.date != null) { conditions.add('date = ?'); args.add(params.date); }
      if (params.startDate != null) { conditions.add('date >= ?'); args.add(params.startDate); }
      if (params.endDate != null) { conditions.add('date <= ?'); args.add(params.endDate); }
      final where = conditions.isNotEmpty ? conditions.join(' AND ') : null;
      final limit = params.limit ?? 20;
      final offset = params.offset ?? 0;
      final rows = await _db.query('DailyCashSummary',
          where: where, whereArgs: args.isNotEmpty ? args : null,
          orderBy: 'date DESC', limit: limit, offset: offset);
      final total = await _db.count('DailyCashSummary', where: where, whereArgs: args.isNotEmpty ? args : null);
      return DailyCashSummaryResponseModel(
        success: true,
        summaries: rows.map(_rowToModel).toList(),
        pagination: PaginationModel(totalCount: total, limit: limit, offset: offset, hasMore: total > offset + limit),
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<DailyCashSummaryResponseModel> createDailySummary({
    required DailyCashSummaryRequestParams params,
  }) async {
    try {
      final db = await _db.database;
      final id = await db.insert('DailyCashSummary', _paramsToRow(params));
      final rows = await _db.query('DailyCashSummary', where: 'id = ?', whereArgs: [id]);
      return DailyCashSummaryResponseModel(success: true, summary: _rowToModel(rows.first));
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<DailyCashSummaryResponseModel> updateDailySummary({
    required DailyCashSummaryRequestParams params,
  }) async {
    try {
      final db = await _db.database;
      await db.update('DailyCashSummary', _paramsToRow(params),
          where: 'id = ?', whereArgs: [params.id]);
      final rows = await _db.query('DailyCashSummary', where: 'id = ?', whereArgs: [params.id]);
      return DailyCashSummaryResponseModel(
          success: true, summary: rows.isNotEmpty ? _rowToModel(rows.first) : null);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<DailyCashSummaryResponseModel> deleteDailySummary({required int id}) async {
    try {
      final db = await _db.database;
      await db.delete('DailyCashSummary', where: 'id = ?', whereArgs: [id]);
      return DailyCashSummaryResponseModel(success: true, deletedId: id);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  DailyCashSummaryModel _rowToModel(Map<String, dynamic> r) => DailyCashSummaryModel(
    id: r['id'] as int,
    date: r['date'] as String,
    openingBalance: _d(r['opening_balance']),
    salesAmount: _d(r['sales_amount']),
    qrAmount: _d(r['qr_amount']),
    cashAmount: _d(r['cash_amount']),
    discount: _d(r['discount']),
    expenses: _d(r['expenses']),
    unPaid: _d(r['un_paid']),
    unPaidDiscount: _d(r['un_paid_discount']),
    creditPaidCash: _d(r['credit_paid_cash']),
    creditQr: _d(r['credit_qr']),
    closingBalance: _d(r['closing_balance']),
    lostMoney: _d(r['lost_money']),
    extraMoney: _d(r['extra_money']),
  );

  Map<String, dynamic> _paramsToRow(DailyCashSummaryRequestParams p) => {
    if (p.date != null) 'date': p.date,
    if (p.openingBalance != null) 'opening_balance': p.openingBalance,
    if (p.salesAmount != null) 'sales_amount': p.salesAmount,
    if (p.qrAmount != null) 'qr_amount': p.qrAmount,
    if (p.cashAmount != null) 'cash_amount': p.cashAmount,
    if (p.expenses != null) 'expenses': p.expenses,
    if (p.unPaid != null) 'un_paid': p.unPaid,
    if (p.closingBalance != null) 'closing_balance': p.closingBalance,
    'modified_at': DateTime.now().toIso8601String(),
  };

  double? _d(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString());
  }
}
