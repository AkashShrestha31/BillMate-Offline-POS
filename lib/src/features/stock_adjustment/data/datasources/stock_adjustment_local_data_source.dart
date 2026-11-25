import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';
import 'package:hotel/src/features/setup/domain/local_books_schema_ensurer.dart';
import 'package:hotel/src/features/stock_adjustment/data/datasources/stock_adjustment_remote_data_source.dart';
import 'package:hotel/src/features/stock_adjustment/data/models/request/stock_adjustment_request_params.dart';
import 'package:hotel/src/features/stock_adjustment/data/models/response/stock_adjustment_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton(as: StockAdjustmentRemoteDataSource)
class StockAdjustmentLocalDataSource implements StockAdjustmentRemoteDataSource {
  LiveStockTrackingService? get _stock {
    if (!getIt.isRegistered<LiveStockTrackingService>()) return null;
    return getIt<LiveStockTrackingService>();
  }

  LocalDb get _db => getIt<LocalDb>();

  @override
  Future<ApiResponse<StockAdjustmentResponseModel>> createStockAdjustment({
    required StockAdjustmentRequestParams params,
  }) async {
    final db = await _db.database;
    final path = await LocalDb.databasePath();
    await LocalBooksSchemaEnsurer.ensureAllTables(db, databasePath: path);

    final tracking = _stock;
    final records = <AdjustmentRecord>[];
    var totalVariance = 0;
    final now = DateTime.now();
    final nowIso = now.toIso8601String();
    const createdBy = 'local_user';

    for (var i = 0; i < params.adjustments.length; i++) {
      final item = params.adjustments[i];
      final location = item.location.trim().isEmpty
          ? LiveStockTrackingService.defaultLocation
          : item.location.trim();
      await tracking?.ensureLocation(location);
      if (tracking == null) {
        await _ensureLocation(db, location, createdBy, nowIso);
      }

      final previous = item.currentQuantity;
      final adjusted = item.adjustedQuantity;
      final variance = adjusted - previous;
      totalVariance += variance;
      final adjName =
          'SADJ-${now.millisecondsSinceEpoch}-${i + 1}';
      final reason = item.reason ?? params.reason ?? 'Stock adjustment';

      await db.insert(
        'StockAdjustment',
        {
          'name': adjName,
          'adjustmentDate': params.adjustmentDate,
          'adjustmentType': 'Stock Reconciliation',
          'item': item.item,
          'location': location,
          'batchNumber': item.batchNumber,
          'previousQuantity': previous,
          'adjustedQuantity': adjusted,
          'variance': variance,
          'currentRate': item.rate,
          'adjustmentValue': variance * item.rate,
          'reason': reason,
          'notes': params.notes,
          'adjustedBy': createdBy,
          'isApproved': 1,
          'createdBy': createdBy,
          'modifiedBy': createdBy,
          'created': nowIso,
          'modified': nowIso,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      if (tracking != null && tracking.enabled) {
        await tracking.reconcileToCount(
          itemName: item.item,
          location: location,
          countedQty: adjusted.toDouble(),
          referenceType: 'StockAdjustment',
          referenceName: adjName,
          reason: reason,
          writeSnapshot: false,
          persistAdjustment: false,
          refresh: false,
        );
      }

      records.add(
        AdjustmentRecord(
          item: item.item,
          location: location,
          batchNumber: item.batchNumber,
          previousQuantity: previous,
          adjustedQuantity: adjusted,
          variance: variance,
          adjustmentValue: variance * item.rate,
          reason: reason,
        ),
      );
    }

    await tracking?.refreshCache();

    return ApiResponse(
      data: StockAdjustmentResponseModel(
        success: true,
        message: 'Stock adjustment recorded locally',
        adjustmentsMade: records.length,
        totalVarianceCorrected: totalVariance.abs(),
        adjustmentRecords: records,
        adjustmentDate: params.adjustmentDate,
      ),
      message: 'Stock adjustment recorded',
      success: true,
    );
  }

  @override
  Future<ApiResponse<List<StockAdjustmentResponseModel>>> getStockAdjustments({
    int? page,
    int? perPage,
    String? sortOrder,
  }) async {
    try {
      final db = await _db.database;
      final path = await LocalDb.databasePath();
      await LocalBooksSchemaEnsurer.ensureAllTables(db, databasePath: path);
      final rows = await db.query(
        'StockAdjustment',
        orderBy: 'adjustmentDate DESC, created DESC',
      );
      if (rows.isEmpty) {
        return ApiResponse(data: [], message: 'No adjustments', success: true);
      }

      final grouped = <String, List<Map<String, Object?>>>{};
      for (final row in rows) {
        final date = (row['adjustmentDate'] ?? '').toString();
        grouped.putIfAbsent(date, () => []).add(row);
      }

      final desc = (sortOrder ?? 'desc').toLowerCase() != 'asc';
      final dates = grouped.keys.toList()
        ..sort((a, b) => desc ? b.compareTo(a) : a.compareTo(b));
      final offset = ((page ?? 1) - 1) * (perPage ?? dates.length);
      final sliced = perPage == null
          ? dates
          : dates.skip(offset.clamp(0, dates.length)).take(perPage).toList();

      final models = sliced.map((date) {
        final items = grouped[date]!;
        var variance = 0;
        final records = items.map((row) {
          final previous = _toInt(row['previousQuantity']);
          final adjusted = _toInt(row['adjustedQuantity']);
          final rowVariance = _toInt(row['variance']);
          variance += rowVariance;
          return AdjustmentRecord(
            item: (row['item'] ?? '').toString(),
            location: (row['location'] ?? '').toString(),
            batchNumber: (row['batchNumber'] ?? '').toString(),
            previousQuantity: previous,
            adjustedQuantity: adjusted,
            variance: rowVariance,
            adjustmentValue: _toDouble(row['adjustmentValue']),
            reason: row['reason']?.toString(),
          );
        }).toList();
        return StockAdjustmentResponseModel(
          success: true,
          message: '',
          adjustmentsMade: records.length,
          totalVarianceCorrected: variance.abs(),
          adjustmentRecords: records,
          adjustmentDate: date,
        );
      }).toList();

      return ApiResponse(data: models, message: '', success: true);
    } catch (_) {
      return ApiResponse(data: [], message: 'No adjustments', success: true);
    }
  }

  Future<void> _ensureLocation(
    Database db,
    String location,
    String createdBy,
    String nowIso,
  ) async {
    final existing = await db.query(
      'Location',
      where: 'name = ?',
      whereArgs: [location],
      limit: 1,
    );
    if (existing.isNotEmpty) return;
    await db.insert('Location', {
      'name': location,
      'created': nowIso,
      'modified': nowIso,
      'createdBy': createdBy,
      'modifiedBy': createdBy,
    });
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.round();
    return int.tryParse(value.toString()) ??
        (double.tryParse(value.toString()) ?? 0).round();
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }
}
