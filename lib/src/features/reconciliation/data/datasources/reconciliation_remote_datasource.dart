import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:excel/excel.dart' hide Border, BorderStyle;
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_direct_report_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_report_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_upload_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_response_model.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_report_response.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_upload_response.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sqflite/sqflite.dart';

abstract class ReconciliationRemoteDataSource {
  Future<ApiResponse<ReconciliationUploadResponse>> uploadReconciliationData({
    required ReconciliationUploadRequest request,
  });
  Future<ApiResponse<ReconciliationReportResponse>>
      generateReconciliationReport({
    required ReconciliationReportRequest request,
  });
  Future<ApiResponse<ReconciliationReportResponse>>
      generateDirectReconciliationReport({
    required ReconciliationDirectReportRequest request,
  });
  Future<ApiResponse<PreviousStockResponseModel>> getPreviousStock(
      {required PreviousStockRequestParams params});
}

// @LazySingleton(as: ReconciliationRemoteDataSource) — replaced by ReconciliationLocalDataSource
class ReconciliationRemoteDataSourceImpl
    implements ReconciliationRemoteDataSource {
  ReconciliationRemoteDataSourceImpl(@Named('authenticated') Dio dio)
      : _dio = dio;

  final Dio _dio;

  @override
  Future<ApiResponse<ReconciliationUploadResponse>> uploadReconciliationData({
    required ReconciliationUploadRequest request,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final formData = await request.toFormData();

      final response = await _dio.post(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.reconciliationUpload}",
        data: formData,
        options: options.copyWith(
          headers: {
            ...options.headers ?? {},
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          data: ReconciliationUploadResponse.fromJson(response.data),
          message: response.data['message'] ?? 'Upload successful',
          success: true,
        );
      } else {
        throw const AppException(message: 'Upload failed');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<ReconciliationReportResponse>>
      generateReconciliationReport({
    required ReconciliationReportRequest request,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;

      final response = await _dio.post(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.reconciliationGenerateReport}",
        data: request.toJson(),
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          data: ReconciliationReportResponse.fromJson(response.data),
          message: response.data['message'] ?? 'Report generated successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to generate report');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<ReconciliationReportResponse>>
      generateDirectReconciliationReport({
    required ReconciliationDirectReportRequest request,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;

      final response = await _dio.post(
        "${dotenv.env['BASE_URL']}${ApiEndPoints.reconciliationDirectReport}",
        data: request.toJson(),
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          data: ReconciliationReportResponse.fromJson(response.data),
          message: response.data['message'] ??
              'Direct report generated successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to generate direct report');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<PreviousStockResponseModel>> getPreviousStock(
      {required PreviousStockRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.previousStock}",
        queryParameters: params.toQueryParams(),
      );

      if (response.statusCode == 200) {
        return ApiResponse(
          data: PreviousStockResponseModel.fromJson(response.data),
          message: '',
          success: true,
        );
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}

@LazySingleton(as: ReconciliationRemoteDataSource)
class ReconciliationLocalDataSource implements ReconciliationRemoteDataSource {
  ReconciliationLocalDataSource(this._db);

  final LocalDb _db;
  final Map<String, bool> _tableExistsCache = {};

  LiveStockTrackingService? _liveStockOrNull() {
    if (!getIt.isRegistered<LiveStockTrackingService>()) return null;
    return getIt<LiveStockTrackingService>();
  }

  @override
  Future<ApiResponse<PreviousStockResponseModel>> getPreviousStock({
    required PreviousStockRequestParams params,
  }) async {
    final where = <String>[];
    final args = <dynamic>[];

    if (params.onlyActive == true) {
      where.add('isActive = 1');
    }
    if (params.startDate != null && params.startDate!.trim().isNotEmpty) {
      where.add('date(reportingDate) >= date(?)');
      args.add(params.startDate!.trim());
    }
    if (params.endDate != null && params.endDate!.trim().isNotEmpty) {
      where.add('date(reportingDate) <= date(?)');
      args.add(params.endDate!.trim());
    }
    final itemFilters = _splitCsv(params.items);
    if (itemFilters.isNotEmpty) {
      where.add('(' + List.filled(itemFilters.length, 'item LIKE ?').join(' OR ') + ')');
      args.addAll(itemFilters.map((e) => '%$e%'));
    }
    final locationFilters = _splitCsv(params.locations);
    if (locationFilters.isNotEmpty) {
      where.add('(' + List.filled(locationFilters.length, 'location LIKE ?').join(' OR ') + ')');
      args.addAll(locationFilters.map((e) => '%$e%'));
    }

    final whereClause = where.isEmpty ? '' : 'WHERE ${where.join(' AND ')}';
    final sort = (params.sortOrder?.toLowerCase() == 'asc') ? 'ASC' : 'DESC';
    final limit = params.limit ?? 100;

    final rows = await _db.rawQuery(
      '''
      SELECT
        date(reportingDate) as reportingDate,
        COUNT(*) as recordCount,
        COUNT(DISTINCT item) as uniqueItems,
        COUNT(DISTINCT location) as uniqueLocations,
        COALESCE(SUM(previousQuantity), 0) as totalQuantity,
        COALESCE(SUM(value), 0) as totalValue,
        COUNT(DISTINCT uploadedBy) as uploadersCount
      FROM PreviousStock
      $whereClause
      GROUP BY date(reportingDate)
      ORDER BY date(reportingDate) $sort
      LIMIT ?
      ''',
      [...args, limit],
    );

    final dates = rows.map((r) {
      return ReportingDateModel(
        reportingDate: (r['reportingDate'] ?? '').toString(),
        recordCount: _toInt(r['recordCount']),
        uniqueItems: _toInt(r['uniqueItems']),
        uniqueLocations: _toInt(r['uniqueLocations']),
        totalQuantity: _toInt(r['totalQuantity']),
        totalValue: _toDouble(r['totalValue']),
        uploadersCount: _toInt(r['uploadersCount']),
      );
    }).toList();

    final response = PreviousStockResponseModel(
      uniqueReportingDates: dates,
      totalUniqueDates: dates.length,
      returnedCount: dates.length,
      filtersApplied: FiltersAppliedModel(
        startDate: params.startDate,
        endDate: params.endDate,
        locations: params.locations,
        items: params.items,
        sortOrder: params.sortOrder ?? 'desc',
        limit: params.limit?.toString(),
        onlyActive: params.onlyActive ?? true,
      ),
    );

    return ApiResponse(
      data: response,
      message: 'Loaded from local database',
      success: true,
    );
  }

  @override
  Future<ApiResponse<ReconciliationUploadResponse>> uploadReconciliationData({
    required ReconciliationUploadRequest request,
  }) async {
    try {
      final file = request.file;
      if (file == null || !file.existsSync()) {
        throw const AppException(message: 'No file provided for upload');
      }

      final parsedRows = await _parseStockUploadFile(file);
      if (parsedRows.isEmpty) {
        throw const AppException(message: 'File has no stock rows to upload');
      }

      final now = DateTime.now().toIso8601String();
      final db = await _db.database;
      int successCount = 0;
      final List<dynamic> failedRecords = [];
      final stock = _liveStockOrNull();
      var postedLiveQty = false;

      for (var i = 0; i < parsedRows.length; i++) {
        final row = parsedRows[i];
        if (row.itemName.isEmpty) continue;

        try {
          final itemName = row.itemName;
          final location = row.location.isEmpty ? 'Stores' : row.location;
          final qty = row.quantity;
          final recordName = '$itemName-$location-${request.reportingDate}';

          await stock?.ensureLocation(location);
          if (request.replaceExisting) {
            await db.delete('PreviousStock', where: 'name = ?', whereArgs: [recordName]);
          }

          final rate = row.rate;
          final rowId = await db.insert('PreviousStock', {
            'name': recordName,
            'item': itemName,
            'location': location,
            'previousQuantity': qty,
            'reportingDate': request.reportingDate,
            'uploadDate': now,
            'uploadedBy': request.uploadedBy,
            if (row.batchNumber != null && row.batchNumber!.isNotEmpty)
              'batchNumber': row.batchNumber,
            if (row.expiryDate != null && row.expiryDate!.isNotEmpty) 'expiryDate': row.expiryDate,
            if (rate != null) 'rate': rate,
            if (rate != null) 'value': qty * rate,
            if (row.notes != null && row.notes!.isNotEmpty) 'notes': row.notes,
            'isActive': 1,
            'createdBy': request.uploadedBy,
            'modifiedBy': request.uploadedBy,
            'created': now,
            'modified': now,
          }, conflictAlgorithm: request.replaceExisting
              ? ConflictAlgorithm.replace
              : ConflictAlgorithm.ignore);
          final wrote = request.replaceExisting || rowId > 0;
          if (!wrote) continue;
          successCount++;
          if (stock != null && stock.enabled) {
            await stock.reconcileToCount(
              itemName: itemName,
              location: location,
              countedQty: qty,
              referenceType: 'PreviousStock',
              referenceName: recordName,
              reason: 'Stock count upload',
              writeSnapshot: false,
              persistAdjustment: false,
              replaceExisting: request.replaceExisting,
              refresh: false,
            );
            postedLiveQty = true;
          }
        } catch (e) {
          failedRecords.add({'row': i + 2, 'error': e.toString()});
        }
      }
      if (postedLiveQty) {
        await stock?.refreshCache();
      }

      return ApiResponse(
        data: ReconciliationUploadResponse(
          success: true,
          message: 'Upload completed. $successCount records uploaded successfully.',
          successfulUploads: successCount,
          failedUploads: failedRecords.length,
          failedRecords: failedRecords,
          reportingDate: request.reportingDate,
          uploadBatch: now,
          uploadType: 'Current Stock Upload',
          note: 'Data saved locally as baseline for reconciliation',
        ),
        message: 'Upload complete',
        success: true,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<ReconciliationReportResponse>> generateReconciliationReport({
    required ReconciliationReportRequest request,
  }) async {
    // Use previous stock from PreviousStock table for the given dates
    try {
      final prevRows = await _db.rawQuery(
        "SELECT item, location, COALESCE(SUM(previousQuantity), 0) as qty FROM PreviousStock WHERE date(reportingDate) = date(?) GROUP BY item, location",
        [request.previousStockDate],
      );
      final currRows = await _db.rawQuery(
        "SELECT item, location, COALESCE(SUM(previousQuantity), 0) as qty FROM PreviousStock WHERE date(reportingDate) = date(?) GROUP BY item, location",
        [request.currentStockDate],
      );

      final previousStock = prevRows.map((r) => StockItem(
        item: r['item'] as String,
        location: r['location'] as String,
        quantity: _toDouble(r['qty']),
      )).toList();

      final currentStock = currRows.map((r) => StockItem(
        item: r['item'] as String,
        location: r['location'] as String,
        quantity: _toDouble(r['qty']),
      )).toList();

      final selectedItems = request.items
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toSet();
      final selectedLocations = request.locations
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toSet();
      final filteredPrevious = previousStock.where((stock) {
        final itemAllowed =
            selectedItems.isEmpty || selectedItems.contains(stock.item);
        final locationAllowed = selectedLocations.isEmpty ||
            selectedLocations.contains(stock.location);
        return itemAllowed && locationAllowed;
      }).toList();
      final filteredCurrent = currentStock.where((stock) {
        final itemAllowed =
            selectedItems.isEmpty || selectedItems.contains(stock.item);
        final locationAllowed = selectedLocations.isEmpty ||
            selectedLocations.contains(stock.location);
        return itemAllowed && locationAllowed;
      }).toList();

      return _computeReconciliation(
        previousStock: filteredPrevious,
        currentStock: filteredCurrent,
        startDate: request.fromDate,
        endDate: request.toDate,
        startingStockDate: request.previousStockDate,
        currentStockDate: request.currentStockDate,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<ReconciliationReportResponse>> generateDirectReconciliationReport({
    required ReconciliationDirectReportRequest request,
  }) async {
    try {
      return _computeReconciliation(
        previousStock: request.previousStock,
        currentStock: request.currentStock,
        startDate: request.startDate,
        endDate: request.endDate,
        startingStockDate: request.startDate,
        currentStockDate: request.endDate,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  Future<ApiResponse<ReconciliationReportResponse>> _computeReconciliation({
    required List<StockItem> previousStock,
    required List<StockItem> currentStock,
    required String startDate,
    required String endDate,
    required String startingStockDate,
    required String currentStockDate,
  }) async {
    final prevMap = {for (final s in previousStock) '${s.item}||${s.location}': s.quantity};
    final currMap = {for (final s in currentStock) '${s.item}||${s.location}': s.quantity};
    final allKeys = {...prevMap.keys, ...currMap.keys};

    final details = <ReconciliationReportDetail>[];
    int over = 0, short = 0, matching = 0;
    double totalVariance = 0, totalOver = 0, totalShort = 0;

    for (final key in allKeys) {
      final parts = key.split('||');
      final itemName = parts[0];
      final location = parts[1];

      final startingStock = prevMap[key] ?? 0.0;
      final actualStock = currMap[key] ?? 0.0;

      // Get item rate
      final rateRows = await _db.rawQuery(
        "SELECT COALESCE(rate, 0) as rate FROM Item WHERE name = ?", [itemName]);
      final itemRate = _toDouble(rateRows.isNotEmpty ? rateRows.first['rate'] : 0);

      // Calculate purchases in period
      final purchaseRows = await _db.rawQuery("""
        SELECT COALESCE(SUM(CAST(pii.quantity AS REAL)), 0) as total
        FROM PurchaseInvoiceItem pii
        JOIN PurchaseInvoice pi ON pii.parent = pi.name
        WHERE pii.item = ? AND date(pi.date) >= date(?) AND date(pi.date) <= date(?)
        AND pi.submitted = 1 AND pi.cancelled = 0
      """, [itemName, startDate, endDate]);
      final totalPurchases = _toDouble(purchaseRows.first['total']);

      // Calculate sales in period
      final salesRows = await _db.rawQuery("""
        SELECT COALESCE(SUM(CAST(sii.quantity AS REAL)), 0) as total
        FROM SalesInvoiceItem sii
        JOIN SalesInvoice si ON sii.parent = si.name
        WHERE sii.item = ? AND date(si.date) >= date(?) AND date(si.date) <= date(?)
        AND si.submitted = 1 AND si.cancelled = 0
      """, [itemName, startDate, endDate]);
      final totalSales = _toDouble(salesRows.first['total']);

      // Backend-equivalent adjustments (safe fallback to 0 if tables missing):
      // Purchase returns, sales returns, stock movement in/out.
      final totalPurchaseReturns = await _sumIfTableExists(
        tableName: 'PurchaseReturnItem',
        sql: """
          SELECT COALESCE(SUM(CAST(pri.quantity AS REAL)), 0) as total
          FROM PurchaseReturnItem pri
          JOIN PurchaseReturn pr ON pri.parent = pr.name
          WHERE pri.item = ? AND date(pr.date) >= date(?) AND date(pr.date) <= date(?)
          AND pr.submitted = 1 AND pr.cancelled = 0
        """,
        args: [itemName, startDate, endDate],
      );
      final totalSalesReturns = await _sumIfTableExists(
        tableName: 'SalesReturnItem',
        sql: """
          SELECT COALESCE(SUM(CAST(sri.quantity AS REAL)), 0) as total
          FROM SalesReturnItem sri
          JOIN SalesReturn sr ON sri.parent = sr.name
          WHERE sri.item = ? AND date(sr.date) >= date(?) AND date(sr.date) <= date(?)
          AND sr.submitted = 1 AND sr.cancelled = 0
        """,
        args: [itemName, startDate, endDate],
      );
      final totalStockIn = await _sumIfTableExists(
        tableName: 'StockMovementItem',
        sql: """
          SELECT COALESCE(SUM(CAST(smi.quantity AS REAL)), 0) as total
          FROM StockMovementItem smi
          JOIN StockMovement sm ON smi.parent = sm.name
          WHERE smi.item = ? AND smi.toLocation = ?
          AND date(sm.date) >= date(?) AND date(sm.date) <= date(?)
          AND sm.submitted = 1 AND sm.cancelled = 0
        """,
        args: [itemName, location, startDate, endDate],
      );
      final totalStockOut = await _sumIfTableExists(
        tableName: 'StockMovementItem',
        sql: """
          SELECT COALESCE(SUM(CAST(smi.quantity AS REAL)), 0) as total
          FROM StockMovementItem smi
          JOIN StockMovement sm ON smi.parent = sm.name
          WHERE smi.item = ? AND smi.fromLocation = ?
          AND date(sm.date) >= date(?) AND date(sm.date) <= date(?)
          AND sm.submitted = 1 AND sm.cancelled = 0
        """,
        args: [itemName, location, startDate, endDate],
      );

      final previousRecords = await _loadStockRecords(
        item: itemName,
        location: location,
        reportingDate: startingStockDate,
      );
      final currentRecords = await _loadStockRecords(
        item: itemName,
        location: location,
        reportingDate: currentStockDate,
      );

      // Match backend formula:
      // Expected = Starting + Purchases - PurchaseReturns + StockIn - Sales + SalesReturns - StockOut
      final expectedStock = startingStock +
          totalPurchases -
          totalPurchaseReturns +
          totalStockIn -
          totalSales +
          totalSalesReturns -
          totalStockOut;
      final variance = actualStock - expectedStock;
      final varianceValue = variance * itemRate;

      String status;
      if (variance > 0) {
        status = 'Over'; over++;
        totalOver += varianceValue;
      } else if (variance < 0) {
        status = 'Short'; short++;
        totalShort += varianceValue.abs();
      } else {
        status = 'Matching'; matching++;
      }
      totalVariance += varianceValue;

      details.add(ReconciliationReportDetail(
        item: itemName,
        location: location,
        startingStock: startingStock.toInt(),
        // Keep report shape compatible; fold returns into net purchase/sales.
        totalPurchases: (totalPurchases - totalPurchaseReturns).toInt(),
        totalSales: (totalSales - totalSalesReturns).toInt(),
        totalStockIn: totalStockIn.toInt(),
        totalStockOut: totalStockOut.toInt(),
        expectedStock: expectedStock.toInt(),
        actualStock: actualStock.toInt(),
        variance: variance.toInt(),
        varianceValue: varianceValue,
        itemRate: itemRate,
        preciousStock: previousRecords,
        currentStock: currentRecords,
        status: status,
        calculationFormula:
            '$startingStock + $totalPurchases - $totalPurchaseReturns + $totalStockIn - $totalSales + $totalSalesReturns - $totalStockOut = $expectedStock',
      ));
    }

    final today = DateTime.now().toIso8601String().substring(0, 10);
    final response = ReconciliationReportResponse(
      success: true,
      reportDate: today,
      period: '$startDate to $endDate',
      startingStockDate: startingStockDate,
      currentStockDate: currentStockDate,
      reconciliationMethod: 'Local SQLite',
      calculationExplanation:
          'Expected Stock = Starting Stock + Purchases + Stock In - Sales - Stock Out',
      summary: ReconciliationReportSummary(
        totalItems: details.length,
        overStockItems: over,
        shortStockItems: short,
        matchingItems: matching,
        totalVarianceValue: totalVariance,
        totalOverValue: totalOver,
        totalShortValue: totalShort,
      ),
      reconciliationDetails: details,
      savedToDatabase: false,
    );

    return ApiResponse(data: response, message: 'Report generated', success: true);
  }

  List<String> _splitCsv(String? input) {
    if (input == null || input.trim().isEmpty) return const [];
    return input
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  Future<bool> _tableExists(String tableName) async {
    final cached = _tableExistsCache[tableName];
    if (cached != null) return cached;
    final rows = await _db.rawQuery(
      "SELECT 1 FROM sqlite_master WHERE type = 'table' AND name = ? LIMIT 1",
      [tableName],
    );
    final exists = rows.isNotEmpty;
    _tableExistsCache[tableName] = exists;
    return exists;
  }

  Future<double> _sumIfTableExists({
    required String tableName,
    required String sql,
    required List<dynamic> args,
  }) async {
    final exists = await _tableExists(tableName);
    if (!exists) return 0.0;
    final rows = await _db.rawQuery(sql, args);
    if (rows.isEmpty) return 0.0;
    return _toDouble(rows.first['total']);
  }

  Future<List<_ParsedStockUploadRow>> _parseStockUploadFile(File file) async {
    final lowerPath = file.path.toLowerCase();
    if (lowerPath.endsWith('.xlsx') || lowerPath.endsWith('.xls')) {
      return _parseExcelStockUploadFile(await file.readAsBytes());
    }
    if (lowerPath.endsWith('.csv')) {
      return _parseCsvStockUploadFile(await file.readAsString(encoding: utf8));
    }
    throw const AppException(
      message: 'Unsupported file type. Use .xlsx, .xls, or .csv',
    );
  }

  List<_ParsedStockUploadRow> _parseExcelStockUploadFile(Uint8List bytes) {
    final excel = Excel.decodeBytes(bytes);
    if (excel.tables.isEmpty) {
      throw const AppException(message: 'Excel file has no sheets');
    }

    final sheet = excel.tables.values.first;
    if (sheet == null || sheet.maxRows < 2) {
      return const [];
    }

    final headers = <String>[];
    for (var col = 0; col < sheet.maxColumns; col++) {
      headers.add(
        _excelCellText(sheet, col, 0).toLowerCase(),
      );
    }

    final columns = _stockColumnIndexes(headers);
    if (columns.itemIdx < 0 || columns.locationIdx < 0 || columns.qtyIdx < 0) {
      throw const AppException(
        message: 'Excel must have item, location, and quantity columns',
      );
    }

    final rows = <_ParsedStockUploadRow>[];
    for (var rowIdx = 1; rowIdx < sheet.maxRows; rowIdx++) {
      final itemName = _excelCellText(sheet, columns.itemIdx, rowIdx);
      if (itemName.isEmpty) continue;

      rows.add(
        _ParsedStockUploadRow(
          itemName: itemName,
          location: _excelCellText(sheet, columns.locationIdx, rowIdx),
          quantity: _parseQuantity(
            _excelCellText(sheet, columns.qtyIdx, rowIdx),
          ),
          batchNumber: columns.batchIdx >= 0
              ? _excelCellText(sheet, columns.batchIdx, rowIdx)
              : null,
          expiryDate: columns.expiryIdx >= 0
              ? _excelCellText(sheet, columns.expiryIdx, rowIdx)
              : null,
          rate: columns.rateIdx >= 0
              ? double.tryParse(_excelCellText(sheet, columns.rateIdx, rowIdx))
              : null,
          notes: columns.notesIdx >= 0
              ? _excelCellText(sheet, columns.notesIdx, rowIdx)
              : null,
        ),
      );
    }
    return rows;
  }

  List<_ParsedStockUploadRow> _parseCsvStockUploadFile(String content) {
    final lines = content.split(RegExp(r'\r?\n'));
    if (lines.isEmpty) return const [];

    final headers = lines.first.split(',').map((e) => e.trim().toLowerCase()).toList();
    final columns = _stockColumnIndexes(headers);
    if (columns.itemIdx < 0 || columns.locationIdx < 0 || columns.qtyIdx < 0) {
      throw const AppException(
        message: 'CSV must have item, location, and quantity columns',
      );
    }

    final rows = <_ParsedStockUploadRow>[];
    for (var i = 1; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;
      final cols = line.split(',');
      final itemName = _csvCol(cols, columns.itemIdx);
      if (itemName.isEmpty) continue;

      rows.add(
        _ParsedStockUploadRow(
          itemName: itemName,
          location: _csvCol(cols, columns.locationIdx),
          quantity: _parseQuantity(_csvCol(cols, columns.qtyIdx)),
          batchNumber:
              columns.batchIdx >= 0 ? _csvCol(cols, columns.batchIdx) : null,
          expiryDate:
              columns.expiryIdx >= 0 ? _csvCol(cols, columns.expiryIdx) : null,
          rate: columns.rateIdx >= 0
              ? double.tryParse(_csvCol(cols, columns.rateIdx))
              : null,
          notes: columns.notesIdx >= 0 ? _csvCol(cols, columns.notesIdx) : null,
        ),
      );
    }
    return rows;
  }

  String _excelCellText(Sheet sheet, int columnIndex, int rowIndex) {
    return sheet
            .cell(CellIndex.indexByColumnRow(
              columnIndex: columnIndex,
              rowIndex: rowIndex,
            ))
            .value
            ?.toString()
            .trim() ??
        '';
  }

  String _csvCol(List<String> cols, int index) {
    if (index < 0 || index >= cols.length) return '';
    return cols[index].trim();
  }

  double _parseQuantity(String raw) {
    if (raw.isEmpty) return 0;
    return double.tryParse(raw) ?? 0;
  }

  _StockColumnIndexes _stockColumnIndexes(List<String> headers) {
    int find(bool Function(String h) test) {
      return headers.indexWhere(test);
    }

    return _StockColumnIndexes(
      itemIdx: find((h) => h.contains('item')),
      locationIdx: find((h) => h.contains('location')),
      qtyIdx: find((h) => h.contains('quantity') || h.contains('qty')),
      batchIdx: find((h) => h.contains('batch')),
      expiryIdx: find((h) => h.contains('expiry')),
      rateIdx: find((h) => h == 'rate' || h.endsWith('_rate')),
      notesIdx: find((h) => h.contains('note')),
    );
  }

  Future<List<StockRecord>> _loadStockRecords({
    required String item,
    required String location,
    required String reportingDate,
  }) async {
    final rows = await _db.rawQuery(
      '''
      SELECT
        name, item, location, previousQuantity, reportingDate, uploadDate,
        uploadedBy, batchNumber, expiryDate, rate, value, notes, isActive,
        createdBy, modifiedBy, created, modified
      FROM PreviousStock
      WHERE item = ? AND location = ? AND date(reportingDate) = date(?)
      ORDER BY datetime(uploadDate) DESC, rowid DESC
      ''',
      [item, location, reportingDate],
    );
    return rows.map((r) {
      return StockRecord(
        name: (r['name'] ?? '').toString(),
        item: (r['item'] ?? '').toString(),
        location: (r['location'] ?? '').toString(),
        previousQuantity: _toInt(r['previousQuantity']),
        reportingDate: (r['reportingDate'] ?? '').toString(),
        uploadDate: (r['uploadDate'] ?? '').toString(),
        uploadedBy: (r['uploadedBy'] ?? '').toString(),
        batchNumber: (r['batchNumber'] ?? '').toString(),
        expiryDate: (r['expiryDate'] ?? '').toString(),
        rate: _toInt(r['rate']),
        value: _toInt(r['value']),
        notes: (r['notes'] ?? '').toString(),
        isActive: _toInt(r['isActive']),
        createdBy: (r['createdBy'] ?? '').toString(),
        modifiedBy: (r['modifiedBy'] ?? '').toString(),
        created: (r['created'] ?? '').toString(),
        modified: (r['modified'] ?? '').toString(),
      );
    }).toList();
  }
}

class _ParsedStockUploadRow {
  const _ParsedStockUploadRow({
    required this.itemName,
    required this.location,
    required this.quantity,
    this.batchNumber,
    this.expiryDate,
    this.rate,
    this.notes,
  });

  final String itemName;
  final String location;
  final double quantity;
  final String? batchNumber;
  final String? expiryDate;
  final double? rate;
  final String? notes;
}

class _StockColumnIndexes {
  const _StockColumnIndexes({
    required this.itemIdx,
    required this.locationIdx,
    required this.qtyIdx,
    required this.batchIdx,
    required this.expiryIdx,
    required this.rateIdx,
    required this.notesIdx,
  });

  final int itemIdx;
  final int locationIdx;
  final int qtyIdx;
  final int batchIdx;
  final int expiryIdx;
  final int rateIdx;
  final int notesIdx;
}
