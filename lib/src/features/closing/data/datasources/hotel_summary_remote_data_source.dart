import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/closing/data/models/request/hotel_summary_request_params.dart';
import 'package:hotel/src/features/closing/data/models/response/hotel_summary_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class HotelSummaryRemoteDataSource {
  // READ Operations
  Future<ApiResponse<HotelSummaryResponseModel>> getHotelSummaries({required HotelSummaryRequestParams params});
  Future<HotelSummaryResponseModel> getHotelSummaryById(int id);

  // CREATE Operation
  Future<HotelSummaryResponseModel> createHotelSummary(CreateHotelSummaryRequest request);

  // UPDATE Operation
  Future<HotelSummaryResponseModel> updateHotelSummary(int id, CreateHotelSummaryRequest request);

  // DELETE Operation
  Future<void> deleteHotelSummary(int id);
}

// @LazySingleton(as: HotelSummaryRemoteDataSource) - Local datasource handles offline-first summary.
class HotelSummaryRemoteSourceImpl implements HotelSummaryRemoteDataSource {
  HotelSummaryRemoteSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<ApiResponse<HotelSummaryResponseModel>> getHotelSummaries({required HotelSummaryRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.hotelSummary}",
        queryParameters: params.toQueryParams(),
      );

      if (response.statusCode == 200) {
        return ApiResponse(
          data: HotelSummaryResponseModel.fromJson(response.data),
          message: 'Hotel summaries fetched successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to fetch hotel summaries');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<HotelSummaryResponseModel> getHotelSummaryById(int id) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.hotelSummary}$id/",
        options: options,
      );

      if (response.statusCode == 200) {
        return HotelSummaryResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to fetch Closing summary details');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<HotelSummaryResponseModel> createHotelSummary(CreateHotelSummaryRequest request) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.hotelSummary}",
        data: request.toJson(),
        options: options,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return HotelSummaryResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to create Closing summary');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<HotelSummaryResponseModel> updateHotelSummary(int id, CreateHotelSummaryRequest request) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.hotelSummary}$id/",
        data: request.toJson(),
        options: options,
      );

      if (response.statusCode == 200) {
        return HotelSummaryResponseModel.fromJson(response.data);
      } else {
        throw const AppException(message: 'Failed to update Closing summary');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<void> deleteHotelSummary(int id) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.delete(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.hotelSummary}$id/",
        options: options,
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw const AppException(message: 'Failed to delete Closing summary');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}

@LazySingleton(as: HotelSummaryRemoteDataSource)
class HotelSummaryLocalDataSource implements HotelSummaryRemoteDataSource {
  HotelSummaryLocalDataSource(this._db);

  final LocalDb _db;

  @override
  Future<ApiResponse<HotelSummaryResponseModel>> getHotelSummaries({
    required HotelSummaryRequestParams params,
  }) async {
    try {
      final queryDate = (params.date?.trim().isNotEmpty ?? false)
          ? params.date!.trim()
          : DateTime.now().toIso8601String().substring(0, 10);
      final openingBalance = _toDouble(params.openingAmount);
      final totalAvailableAmount = _toDouble(params.totalAvailableAmount);
      final payCashGetQr = _toDouble(params.payCashGetQrExchange);
      final payQrGetCash = _toDouble(params.payQrGetCashExchange);
      final shouldSave = params.save == true;

      final paymentDetailsByInvoice = await _paymentDetailsByInvoiceName();

      // 1) Sales (non-returned)
      final salesRows = await _db.rawQuery(
        '''
        SELECT name, COALESCE(party, '') AS party, date,
               COALESCE(CAST(grandTotal AS REAL), 0) AS grandTotal,
               COALESCE(CAST(netTotal AS REAL), 0) AS netTotal,
               COALESCE(CAST(discountAmount AS REAL), 0) AS discountAmount,
               COALESCE(CAST(outstandingAmount AS REAL), 0) AS outstandingAmount
        FROM SalesInvoice
        WHERE date(date) = date(?) AND cancelled = 0 AND COALESCE(isReturned, 0) = 0
        ORDER BY name
        ''',
        [queryDate],
      );

      double totalSales = 0;
      double totalDiscount = 0;
      double unpaidAmount = 0;
      final salesList = <SalesInvoice>[];

      for (final row in salesRows) {
        final invoiceId = (row['name'] ?? '').toString();
        final itemDiscount = await _invoiceItemDiscountSum(
          table: 'SalesInvoiceItem',
          invoiceName: invoiceId,
        );
        final discount = _toDouble(row['discountAmount']) + itemDiscount;
        totalSales += _toDouble(row['grandTotal']);
        totalDiscount += discount;
        unpaidAmount += _toDouble(row['outstandingAmount']);

        salesList.add(
          SalesInvoice(
            id: invoiceId,
            party: _resolvePartyName(
              (row['party'] ?? '').toString(),
              fallback: 'Walk-in Customer',
            ),
            date: (row['date'] ?? '').toString(),
            totalAmount: _toInt(row['grandTotal']),
            totalAmountWithDiscount: _toInt(row['netTotal']),
            discountAmount: _toInt(discount),
            paymentDetails: paymentDetailsByInvoice[invoiceId] ?? const [],
          ),
        );
      }

      // 2) Payment breakdown for same-day receives on non-return sales
      final receiveRows = await _db.rawQuery(
        '''
        SELECT p.paymentMethod, COALESCE(SUM(CAST(pf.amount AS REAL)), 0) AS amount
        FROM Payment p
        JOIN PaymentFor pf ON p.name = pf.parent
        JOIN SalesInvoice si ON pf.referenceName = si.name
        WHERE date(p.date) = date(?) AND date(si.date) = date(?)
          AND p.cancelled = 0 AND p.paymentType = 'Receive'
          AND COALESCE(si.isReturned, 0) = 0
        GROUP BY p.paymentMethod
        ''',
        [queryDate, queryDate],
      );

      double salesCashAmount = 0;
      double salesQrAmount = 0;
      double salesTransferAmount = 0;
      for (final row in receiveRows) {
        final method = (row['paymentMethod'] ?? '').toString().toLowerCase();
        final amount = _toDouble(row['amount']);
        if (method == 'cash') {
          salesCashAmount += amount;
        } else if (method == 'transfer' || method == 'bank') {
          salesTransferAmount += amount;
        } else {
          salesQrAmount += amount;
        }
      }

      // 3) Subtract return payouts from same day
      final returnPayRows = await _db.rawQuery(
        '''
        SELECT p.paymentMethod, COALESCE(SUM(CAST(pf.amount AS REAL)), 0) AS amount
        FROM Payment p
        JOIN PaymentFor pf ON p.name = pf.parent
        JOIN SalesInvoice si ON pf.referenceName = si.name
        WHERE date(p.date) = date(?) AND p.cancelled = 0 AND p.paymentType = 'Pay'
          AND COALESCE(si.isReturned, 0) = 1
        GROUP BY p.paymentMethod
        ''',
        [queryDate],
      );
      for (final row in returnPayRows) {
        final method = (row['paymentMethod'] ?? '').toString().toLowerCase();
        final amount = _toDouble(row['amount']);
        if (method == 'cash') {
          salesCashAmount = (salesCashAmount - amount).clamp(0.0, double.infinity);
        } else if (method == 'transfer' || method == 'bank') {
          salesTransferAmount =
              (salesTransferAmount - amount).clamp(0.0, double.infinity);
        } else {
          salesQrAmount = (salesQrAmount - amount).clamp(0.0, double.infinity);
        }
      }

      // 4) Purchases and expenses
      final purchaseRows = await _db.rawQuery(
        '''
        SELECT name, COALESCE(party, '') AS party, date,
               COALESCE(CAST(grandTotal AS REAL), 0) AS grandTotal,
               COALESCE(CAST(netTotal AS REAL), 0) AS netTotal,
               COALESCE(CAST(discountAmount AS REAL), 0) AS discountAmount,
               COALESCE(CAST(outstandingAmount AS REAL), 0) AS outstandingAmount,
               COALESCE(isReturned, 0) AS isReturned
        FROM PurchaseInvoice
        WHERE date(date) = date(?) AND cancelled = 0
        ORDER BY name
        ''',
        [queryDate],
      );

      double totalExpenses = 0;
      final purchaseList = <PurchaseInvoice>[];
      for (final row in purchaseRows) {
        final invoiceId = (row['name'] ?? '').toString();
        final isReturned = _toInt(row['isReturned']) == 1;
        if (!isReturned) {
          totalExpenses += _toDouble(row['grandTotal']);
        }
        final itemDiscount = await _invoiceItemDiscountSum(
          table: 'PurchaseInvoiceItem',
          invoiceName: invoiceId,
        );
        final discount = _toDouble(row['discountAmount']) + itemDiscount;
        purchaseList.add(
          PurchaseInvoice(
            id: invoiceId,
            party: _resolvePartyName(
              (row['party'] ?? '').toString(),
              fallback: 'Unknown Supplier',
            ),
            date: (row['date'] ?? '').toString(),
            totalAmount: _toInt(row['grandTotal']),
            totalAmountWithDiscount: _toInt(row['netTotal']),
            discountAmount: _toInt(discount),
            paymentDetails: paymentDetailsByInvoice[invoiceId] ?? const [],
          ),
        );
      }

      // Expense payment split
      final expensePayRows = await _db.rawQuery(
        '''
        SELECT p.paymentMethod, COALESCE(SUM(CAST(pf.amount AS REAL)), 0) AS amount
        FROM Payment p
        JOIN PaymentFor pf ON p.name = pf.parent
        JOIN PurchaseInvoice pi ON pf.referenceName = pi.name
        WHERE date(p.date) = date(?) AND date(pi.date) = date(?)
          AND p.cancelled = 0 AND p.paymentType = 'Pay'
          AND COALESCE(pi.isReturned, 0) = 0
        GROUP BY p.paymentMethod
        ''',
        [queryDate, queryDate],
      );

      double totalExpensesCash = 0;
      double totalExpensesQr = 0;
      double totalExpensesTransfer = 0;
      for (final row in expensePayRows) {
        final method = (row['paymentMethod'] ?? '').toString().toLowerCase();
        final amount = _toDouble(row['amount']);
        if (method == 'cash') {
          totalExpensesCash += amount;
        } else if (method == 'transfer' || method == 'bank') {
          totalExpensesTransfer += amount;
        } else {
          totalExpensesQr += amount;
        }
      }

      // 5) Credit payments (old sales paid today)
      final creditRows = await _db.rawQuery(
        '''
        SELECT si.name AS invoiceId, COALESCE(si.party, '') AS party, si.date AS salesDate,
               COALESCE(CAST(si.grandTotal AS REAL), 0) AS grandTotal,
               COALESCE(CAST(si.discountAmount AS REAL), 0) AS discountAmount,
               COALESCE(CAST(si.outstandingAmount AS REAL), 0) AS outstandingAmount,
               p.name AS paymentId, p.paymentMethod, p.date AS paymentDate,
               COALESCE(CAST(pf.amount AS REAL), 0) AS paymentAmount
        FROM Payment p
        JOIN PaymentFor pf ON p.name = pf.parent
        JOIN SalesInvoice si ON pf.referenceName = si.name
        WHERE date(p.date) = date(?) AND date(si.date) < date(?)
          AND p.cancelled = 0 AND p.paymentType = 'Receive'
        ORDER BY si.name, p.date
        ''',
        [queryDate, queryDate],
      );

      double creditCash = 0;
      double creditQr = 0;
      double creditDiscount = 0;
      final creditByInvoice = <String, CreditPayment>{};
      final creditPaymentsMap = <String, List<PaymentDetail>>{};
      final creditTotalPaid = <String, double>{};

      for (final row in creditRows) {
        final invoiceId = (row['invoiceId'] ?? '').toString();
        final payment = PaymentDetail(
          paymentId: (row['paymentId'] ?? '').toString(),
          paymentMethod: (row['paymentMethod'] ?? '').toString(),
          paymentDate: (row['paymentDate'] ?? '').toString(),
          paymentAmount: _toInt(row['paymentAmount']),
        );
        final method = payment.paymentMethod.toLowerCase();
        final paid = _toDouble(row['paymentAmount']);
        if (method == 'cash') {
          creditCash += paid;
        } else {
          creditQr += paid;
        }
        creditPaymentsMap.putIfAbsent(invoiceId, () => []).add(payment);
        creditTotalPaid[invoiceId] = (creditTotalPaid[invoiceId] ?? 0) + paid;
        creditByInvoice.putIfAbsent(
          invoiceId,
          () => CreditPayment(
            invoiceId: invoiceId,
            party: _resolvePartyName(
              (row['party'] ?? '').toString(),
              fallback: 'Walk-in Customer',
            ),
            salesDate: (row['salesDate'] ?? '').toString(),
            invoiceAmount: _toInt(row['grandTotal']),
            originalDiscount: _toInt(row['discountAmount']),
            outstandingAmount: _toInt(row['outstandingAmount']),
            totalPayments: 0,
            creditDiscountGiven: 0,
            payments: const [],
          ),
        );
      }

      final creditList = <CreditPayment>[];
      for (final entry in creditByInvoice.entries) {
        final base = entry.value;
        final paid = creditTotalPaid[entry.key] ?? 0;
        final diff = _toDouble(base.outstandingAmount) - paid;
        final givenDiscount = diff > 0 ? diff : 0;
        creditDiscount += givenDiscount;
        creditList.add(
          CreditPayment(
            invoiceId: base.invoiceId,
            party: base.party,
            salesDate: base.salesDate,
            invoiceAmount: base.invoiceAmount,
            originalDiscount: base.originalDiscount,
            outstandingAmount: base.outstandingAmount,
            totalPayments: _toInt(paid),
            creditDiscountGiven: _toInt(givenDiscount),
            payments: creditPaymentsMap[entry.key] ?? const [],
          ),
        );
      }

      // 6) Closing balance (backend formula)
      final closingBalance = openingBalance +
          salesCashAmount +
          creditCash -
          totalExpensesCash +
          payQrGetCash -
          payCashGetQr;

      double lostAmount = 0;
      double extraAmount = 0;
      if (params.totalAvailableAmount != null) {
        if (totalAvailableAmount > closingBalance) {
          extraAmount = totalAvailableAmount - closingBalance;
        } else if (totalAvailableAmount < closingBalance) {
          lostAmount = closingBalance - totalAvailableAmount;
        }
      } else {
        final prior = await _db.query(
          'DailyCashSummary',
          where: 'date = ?',
          whereArgs: [queryDate],
          limit: 1,
        );
        if (prior.isNotEmpty) {
          lostAmount = _toDouble(prior.first['lost_money']);
          extraAmount = _toDouble(prior.first['extra_money']);
        }
      }

      // 7) Save daily summary when requested
      if (shouldSave) {
        final row = {
          'date': queryDate,
          'opening_balance': openingBalance,
          'sales_amount': totalSales,
          'qr_amount': salesQrAmount,
          'cash_amount': salesCashAmount,
          'discount': totalDiscount,
          'expenses': totalExpenses,
          'un_paid': unpaidAmount,
          'credit_paid_cash': creditCash,
          'credit_qr': creditQr,
          'pay_cash_get_qr_exchange': payCashGetQr,
          'pay_qr_get_cash_exchange': payQrGetCash,
          'closing_balance': closingBalance,
          'lost_money': lostAmount,
          'extra_money': extraAmount,
          'created_by': 'local_user',
          'modified_by': 'local_user',
          'created_at': DateTime.now().toIso8601String(),
          'modified_at': DateTime.now().toIso8601String(),
        };
        await _db.upsert('DailyCashSummary', row);
      }

      final model = HotelSummaryResponseModel(
        success: true,
        queryDate: queryDate,
        summary: SalesSummary(
          openingBalance: _toInt(openingBalance),
          totalSales: _toInt(totalSales),
          salesQrAmount: _toInt(salesQrAmount),
          salesTransferAmount: _toInt(salesTransferAmount),
          salesCashAmount: _toInt(salesCashAmount),
          totalDiscount: _toInt(totalDiscount),
          totalExpenses: _toInt(totalExpenses),
          totalExpensesQr: _toInt(totalExpensesQr),
          totalExpensesTransfer: _toInt(totalExpensesTransfer),
          totalExpensesCash: _toInt(totalExpensesCash),
          unpaidAmount: _toInt(unpaidAmount),
          creditCash: _toInt(creditCash),
          creditQr: _toInt(creditQr),
          lostAmount: _toInt(lostAmount),
          extraAmount: _toInt(extraAmount),
          creditDiscount: _toInt(creditDiscount),
          closingBalance: _toInt(closingBalance),
          payCashGetQrExchange: payCashGetQr,
          payQrGetCashExchange: payQrGetCash,
        ),
        salesList: salesList,
        creditList: creditList,
        purchaseList: purchaseList,
      );

      return ApiResponse(
        data: model,
        message: 'Loaded from local database',
        success: true,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<HotelSummaryResponseModel> getHotelSummaryById(int id) async {
    throw const AppException(message: 'Not supported in local mode');
  }

  @override
  Future<HotelSummaryResponseModel> createHotelSummary(
    CreateHotelSummaryRequest request,
  ) async {
    throw const AppException(message: 'Not supported in local mode');
  }

  @override
  Future<HotelSummaryResponseModel> updateHotelSummary(
    int id,
    CreateHotelSummaryRequest request,
  ) async {
    throw const AppException(message: 'Not supported in local mode');
  }

  @override
  Future<void> deleteHotelSummary(int id) async {
    throw const AppException(message: 'Not supported in local mode');
  }

  Future<Map<String, List<PaymentDetail>>> _paymentDetailsByInvoiceName() async {
    final rows = await _db.rawQuery(
      '''
      SELECT pf.referenceName AS referenceName, p.name AS paymentId, p.paymentMethod, p.date AS paymentDate,
             COALESCE(CAST(pf.amount AS REAL), 0) AS amount
      FROM Payment p
      JOIN PaymentFor pf ON p.name = pf.parent
      WHERE p.cancelled = 0
      ORDER BY p.date
      ''',
    );
    final map = <String, List<PaymentDetail>>{};
    for (final r in rows) {
      final ref = (r['referenceName'] ?? '').toString();
      map.putIfAbsent(ref, () => []);
      map[ref]!.add(
        PaymentDetail(
          paymentId: (r['paymentId'] ?? '').toString(),
          paymentMethod: (r['paymentMethod'] ?? '').toString(),
          paymentDate: (r['paymentDate'] ?? '').toString(),
          paymentAmount: _toInt(r['amount']),
        ),
      );
    }
    return map;
  }

  Future<double> _invoiceItemDiscountSum({
    required String table,
    required String invoiceName,
  }) async {
    final rows = await _db.rawQuery(
      'SELECT COALESCE(SUM(CAST(itemDiscountAmount AS REAL)), 0) AS total FROM $table WHERE parent = ?',
      [invoiceName],
    );
    return _toDouble(rows.first['total']);
  }

  int _toInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is num) return v.round();
    return double.tryParse(v.toString())?.round() ?? 0;
  }

  double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is double) return v;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  String _resolvePartyName(String raw, {required String fallback}) {
    final name = raw.trim();
    if (name.isNotEmpty) return name;
    return fallback;
  }
}
