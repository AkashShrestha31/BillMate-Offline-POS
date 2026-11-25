import 'package:hotel/src/features/reconciliation/data/datasources/previous_stock_delete_remote_data_source.dart';
import 'package:hotel/src/features/reconciliation/data/datasources/previous_stock_details_remote_data_source.dart';
import 'package:hotel/src/features/reconciliation/data/datasources/previous_stock_edit_remote_data_source.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_bulk_edit_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/failed_stock_item_model.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_details_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/deletion_summary_model.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/deleted_stock_item_model.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/edit_summary_model.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_bulk_edit_response_model.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_delete_response_model.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_details_response_model.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_item_model.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/updated_stock_item_model.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';
import 'package:injectable/injectable.dart';

LiveStockTrackingService? _liveStockOrNull() {
  if (!getIt.isRegistered<LiveStockTrackingService>()) return null;
  return getIt<LiveStockTrackingService>();
}

@LazySingleton(as: PreviousStockDetailsRemoteDataSource)
class PreviousStockDetailsLocalDataSource implements PreviousStockDetailsRemoteDataSource {
  PreviousStockDetailsLocalDataSource(this._db);

  final LocalDb _db;

  @override
  Future<PreviousStockDetailsResponseModel> getPreviousStockDetails({
    required PreviousStockDetailsRequestParams params,
  }) async {
    final where = <String>['date(reportingDate) = date(?)'];
    final args = <dynamic>[params.reportingDate];

    if (params.batchNumber != null && params.batchNumber!.trim().isNotEmpty) {
      where.add('batchNumber LIKE ?');
      args.add('%${params.batchNumber!.trim()}%');
    }
    if (params.item != null && params.item!.trim().isNotEmpty) {
      where.add('item LIKE ?');
      args.add('%${params.item!.trim()}%');
    }
    if (params.location != null && params.location!.trim().isNotEmpty) {
      where.add('location LIKE ?');
      args.add('%${params.location!.trim()}%');
    }

    final rows = await _db.query(
      'PreviousStock',
      where: where.join(' AND '),
      whereArgs: args,
      orderBy: 'item ASC',
    );

    final items = rows.map(_rowToStockItem).toList();
    return PreviousStockDetailsResponseModel(success: true, stockItems: items);
  }

  PreviousStockItemModel _rowToStockItem(Map<String, dynamic> r) {
    return PreviousStockItemModel(
      name: (r['name'] ?? '').toString(),
      item: (r['item'] ?? '').toString(),
      location: (r['location'] ?? '').toString(),
      reportingDate: (r['reportingDate'] ?? '').toString(),
      previousQuantity: _toDouble(r['previousQuantity']).round(),
      rate: _toDouble(r['rate']),
      value: _toDouble(r['value']),
      batchNumber: (r['batchNumber'] ?? '').toString(),
      expiryDate: (r['expiryDate'] ?? '').toString(),
      isActive: _toBool(r['isActive']),
      uploadDate: (r['uploadDate'] ?? '').toString(),
      uploadedBy: (r['uploadedBy'] ?? '').toString(),
      notes: (r['notes'] ?? '').toString(),
      createdBy: (r['createdBy'] ?? '').toString(),
      modifiedBy: (r['modifiedBy'] ?? '').toString(),
      created: (r['created'] ?? '').toString(),
      modified: (r['modified'] ?? '').toString(),
    );
  }

  double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  bool _toBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is num) return value != 0;
    final text = value.toString().toLowerCase();
    return text == 'true' || text == '1';
  }
}

@LazySingleton(as: PreviousStockDeleteRemoteDataSource)
class PreviousStockDeleteLocalDataSource implements PreviousStockDeleteRemoteDataSource {
  PreviousStockDeleteLocalDataSource(this._db);

  final LocalDb _db;

  @override
  Future<PreviousStockDeleteResponseModel> deletePreviousStockByDate({
    required String confirm,
    required String reportingDate,
  }) async {
    final now = DateTime.now().toIso8601String();
    final rows = await _db.query(
      'PreviousStock',
      where: 'date(reportingDate) = date(?)',
      whereArgs: [reportingDate],
    );

    final deletedCount = rows.length;
    final uniqueItems = rows.map((e) => (e['item'] ?? '').toString()).where((e) => e.isNotEmpty).toSet().length;
    final uniqueLocations =
        rows.map((e) => (e['location'] ?? '').toString()).where((e) => e.isNotEmpty).toSet().length;
    final totalQuantity = rows.fold<int>(
      0,
      (sum, row) => sum + ((_toDouble(row['previousQuantity'])).round()),
    );
    final totalValue = rows.fold<double>(
      0.0,
      (sum, row) => sum + _toDouble(row['value']),
    );
    final uploadedBy = rows.isNotEmpty ? (rows.first['uploadedBy'] ?? '').toString() : '';
    final uploadTime = rows.isNotEmpty ? (rows.first['uploadDate'] ?? now).toString() : now;
    final sampleDeletedItems = rows.take(5).map((row) {
      return DeletedStockItemModel(
        name: (row['name'] ?? '').toString(),
        item: (row['item'] ?? '').toString(),
        location: (row['location'] ?? '').toString(),
        quantity: _toDouble(row['previousQuantity']).round(),
        value: _toDouble(row['value']),
      );
    }).toList();

    final stock = _liveStockOrNull();
    if (stock != null) {
      for (final row in rows) {
        final name = (row['name'] ?? '').toString();
        if (name.isEmpty) continue;
        await stock.reverseDocument(
          referenceType: 'PreviousStock',
          referenceName: name,
          refresh: false,
        );
      }
      await stock.refreshCache();
    }

    final db = await _db.database;
    await db.delete(
      'PreviousStock',
      where: 'date(reportingDate) = date(?)',
      whereArgs: [reportingDate],
    );

    return PreviousStockDeleteResponseModel(
      success: true,
      message: 'Deleted locally',
      deletionSummary: DeletionSummaryModel(
        reportingDate: reportingDate,
        totalRecordsDeleted: deletedCount,
        uniqueItems: uniqueItems,
        uniqueLocations: uniqueLocations,
        totalQuantity: totalQuantity,
        totalValue: totalValue,
        uploadedBy: uploadedBy,
        uploadTime: uploadTime,
        sampleDeletedItems: sampleDeletedItems,
      ),
      deletedCount: deletedCount,
      deletedAt: now,
      deletedBy: 'local_user',
    );
  }

  double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }
}

@LazySingleton(as: PreviousStockEditRemoteDataSource)
class PreviousStockEditLocalDataSource implements PreviousStockEditRemoteDataSource {
  PreviousStockEditLocalDataSource(this._db);

  final LocalDb _db;

  @override
  Future<PreviousStockBulkEditResponseModel> bulkEditPreviousStock({
    required PreviousStockBulkEditRequestParams params,
  }) async {
    final db = await _db.database;
    final now = DateTime.now().toIso8601String();
    final updatedItems = <UpdatedStockItemModel>[];
    final failedItems = <FailedStockItemModel>[];

    for (final stock in params.stockItems) {
      try {
        final existing = await _db.query(
          'PreviousStock',
          where: 'name = ?',
          whereArgs: [stock.name],
          limit: 1,
        );

        if (existing.isEmpty) {
          failedItems.add(FailedStockItemModel(name: stock.name, error: 'Item not found'));
          continue;
        }

        final row = existing.first;
        final oldQty = _toDouble(row['previousQuantity']);
        final quantity = stock.previousQuantity ?? oldQty;
        final rate = stock.rate ?? _toDouble(row['rate']);
        final value = stock.value ?? (quantity * rate);

        await db.update(
          'PreviousStock',
          {
            'previousQuantity': quantity,
            'rate': rate,
            'value': value,
            if (stock.batchNumber != null) 'batchNumber': stock.batchNumber,
            if (stock.expiryDate != null) 'expiryDate': stock.expiryDate,
            if (stock.notes != null) 'notes': stock.notes,
            if (stock.isActive != null) 'isActive': stock.isActive! ? 1 : 0,
            'modifiedBy': 'local_user',
            'modified': now,
          },
          where: 'name = ?',
          whereArgs: [stock.name],
        );

        final tracking = _liveStockOrNull();
        if (tracking != null &&
            tracking.enabled &&
            (quantity - oldQty).abs() > 0.0000001) {
          await tracking.applyCountQuantityChange(
            itemName: (row['item'] ?? '').toString(),
            location: (row['location'] ?? '').toString(),
            referenceName: stock.name,
            oldQty: oldQty,
            newQty: quantity,
          );
        }

        updatedItems.add(
          UpdatedStockItemModel(
            name: (row['name'] ?? '').toString(),
            item: (row['item'] ?? '').toString(),
            location: (row['location'] ?? '').toString(),
            reportingDate: (row['reportingDate'] ?? '').toString(),
            previousQuantity: quantity,
            rate: rate,
            value: value,
            batchNumber: (stock.batchNumber ?? row['batchNumber'] ?? '').toString(),
            expiryDate: (stock.expiryDate ?? row['expiryDate'] ?? '').toString(),
            notes: (stock.notes ?? row['notes'])?.toString(),
            isActive: stock.isActive ?? _toBool(row['isActive']),
            modifiedBy: 'local_user',
            modified: now,
          ),
        );
      } catch (e) {
        failedItems.add(FailedStockItemModel(name: stock.name, error: e.toString()));
      }
    }

    return PreviousStockBulkEditResponseModel(
      success: failedItems.isEmpty,
      message: failedItems.isEmpty ? 'Updated locally' : 'Updated with some failures',
      summary: EditSummaryModel(
        totalRequested: params.stockItems.length,
        successfullyUpdated: updatedItems.length,
        failed: failedItems.length,
      ),
      updatedItems: updatedItems,
      failedItems: failedItems,
    );
  }

  double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  bool _toBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is num) return value != 0;
    final text = value.toString().toLowerCase();
    return text == 'true' || text == '1';
  }
}
