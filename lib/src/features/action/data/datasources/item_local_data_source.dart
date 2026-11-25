import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/helpers/item_image_helper.dart';
import 'package:hotel/src/core/helpers/item_search_helper.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';
import 'package:hotel/src/features/action/data/datasources/item_remote_data_source.dart';
import 'package:hotel/src/features/action/data/models/request/delete_item_request.dart';
import 'package:hotel/src/features/action/data/models/request/item_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/bulk_create_items_request.dart';
import 'package:hotel/src/features/action/data/models/request/create_item_request.dart';
import 'package:hotel/src/features/action/data/models/request/merge_items_bulk_operation_request.dart';
import 'package:hotel/src/features/action/data/models/response/bulk_create_items_response.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:hotel/src/features/action/data/models/response/item_update_response_model.dart';
import 'package:hotel/src/features/action/data/models/response/merge_items_bulk_operation_response.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton(as: ItemRemoteDataSource)
class ItemLocalDataSource implements ItemRemoteDataSource {
  ItemLocalDataSource(this._db);
  final LocalDb _db;

  @override
  Future<ApiResponse<ItemResponseModel>> getItems({
    required ItemRequestParams params,
  }) async {
    try {
      final conditions = <String>[];
      final args = <dynamic>[];

      if (params.forFilter != null && params.forFilter!.isNotEmpty) {
        conditions.add('"for" = ?');
        args.add(params.forFilter);
      }
      if (params.category != null && params.category!.isNotEmpty) {
        final raw = params.category!.trim().toLowerCase();
        final separator = params.category!.indexOf(' - ');
        final display = separator >= 0 && separator + 3 < params.category!.length
            ? params.category!.substring(separator + 3).trim().toLowerCase()
            : raw;
        conditions.add(
          '(LOWER(TRIM(IFNULL(category, \'\'))) = ? '
          'OR LOWER(TRIM(IFNULL(category, \'\'))) = ? '
          'OR LOWER(TRIM(IFNULL(category, \'\'))) LIKE ?)',
        );
        args.add(raw);
        args.add(display);
        args.add('% - $display');
      }
      if (params.search != null && params.search!.isNotEmpty) {
        final rawSearch = params.search!.trim();
        final term = '%$rawSearch%';
        conditions.add(
          '(name LIKE ? OR barcode LIKE ? OR hsnCode LIKE ? '
          'OR LOWER(TRIM(IFNULL(barcode, \'\'))) = ?)',
        );
        args.addAll([term, term, term, rawSearch.toLowerCase()]);
      }
      if (params.itemType != null && params.itemType!.isNotEmpty) {
        conditions.add('itemType = ?');
        args.add(params.itemType);
      }
      if (params.favoritesOnly == true) {
        conditions.add('IFNULL(isFavorite, 0) = 1');
      }

      final where = conditions.isNotEmpty ? conditions.join(' AND ') : null;
      final page = params.page ?? 1;
      final perPage = params.perPage ?? 10;
      final offset = (page - 1) * perPage;

      List<ItemModel> items;
      int total;

      if (params.repeatedSales == true) {
        final ranked = await _repeatedSalesRanks(
          forFilter: params.forFilter,
        );
        if (ranked.isEmpty) {
          return _emptyItemsResponse(params, page: page, perPage: perPage);
        }
        final names = ranked.keys.toList();
        final inPlaceholders = List.filled(names.length, '?').join(',');
        final repeatedWhere = [
          if (where != null) '($where)',
          'name IN ($inPlaceholders)',
        ].join(' AND ');
        final repeatedArgs = [...args, ...names];
        final rows = await _db.query(
          'Item',
          where: repeatedWhere,
          whereArgs: repeatedArgs,
        );
        final mapped = rows.map((r) {
          final name = r['name'] as String;
          return _rowToItemModel(r, totalSales: ranked[name]);
        }).toList()
          ..sort((a, b) => (b.totalSales ?? 0).compareTo(a.totalSales ?? 0));
        total = mapped.length;
        final end = (offset + perPage).clamp(0, total);
        items = offset >= total ? const [] : mapped.sublist(offset, end);
      } else {
        final rows = await _db.query(
          'Item',
          where: where,
          whereArgs: args.isNotEmpty ? args : null,
          orderBy: 'name ASC',
          limit: perPage,
          offset: offset,
        );
        total = await _db.count(
          'Item',
          where: where,
          whereArgs: args.isNotEmpty ? args : null,
        );
        items = rows.map((r) => _rowToItemModel(r)).toList();
      }

      final totalPages = total == 0 ? 0 : (total / perPage).ceil();

      final response = ItemResponseModel(
        data: items,
        pagination: PaginationModel(
          currentPage: page,
          perPage: perPage,
          totalPages: totalPages,
          totalRows: total,
        ),
        filtersApplied: FiltersAppliedModel(
          search: params.search,
          itemType: params.itemType,
          forFilter: params.forFilter,
          excludeZeroSales: params.excludeZeroSales ?? false,
          sortBy: params.sortBy ?? 'name',
          sortOrder: params.sortOrder ?? 'asc',
        ),
        summary: SummaryModel(
          totalItems: total,
          itemsWithSales: 0,
          totalSalesQuantity: 0,
          averageSalesPerItem: 0,
        ),
        availableFilters: AvailableFiltersModel(forOptions: []),
      );

      return ApiResponse(data: response, message: 'Items fetched', success: true);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ItemModel?> findItemByBarcode(
    String barcode, {
    String? forFilter,
  }) async {
    final code = barcode.trim();
    if (code.isEmpty) return null;
    try {
      final rows = await _itemScanRows();
      final light = <ItemModel>[];
      for (final row in rows) {
        final name = row['name']?.toString().trim() ?? '';
        if (name.isEmpty) continue;
        light.add(
          ItemModel(
            name: name,
            itemType: 'Product',
            forFilter: (row['purpose'] ?? row['for'])?.toString() ?? 'Both',
            unit: 'Unit',
            rate: 0,
            barcode: row['barcode']?.toString(),
            hsnCode: row['hsnCode']?.toString(),
            description: row['description']?.toString(),
          ),
        );
      }
      var match = itemMatchingScannedCode(light, code, forFilter: forFilter);
      match ??= await _itemNamedBySerial(code);
      if (match == null) return null;
      final full = await _db.query(
        'Item',
        where: 'name = ?',
        whereArgs: [match.name],
        limit: 1,
      );
      if (full.isEmpty) return null;
      return _rowToItemModel(full.first);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  Future<List<Map<String, Object?>>> _itemScanRows() async {
    try {
      return await _db.rawQuery(
        'SELECT name, IFNULL(barcode, \'\') AS barcode, '
        'IFNULL(hsnCode, \'\') AS hsnCode, '
        'IFNULL(description, \'\') AS description, '
        'IFNULL("for", \'Both\') AS purpose FROM Item',
      );
    } catch (_) {
      return _db.rawQuery(
        'SELECT name, IFNULL(description, \'\') AS description, '
        'IFNULL("for", \'Both\') AS purpose FROM Item',
      );
    }
  }

  Future<ItemModel?> _itemNamedBySerial(String code) async {
    final keys = scanLookupKeys(code)
        .map((key) => key.trim().toLowerCase())
        .where((key) => key.isNotEmpty)
        .toSet();
    if (keys.isEmpty) return null;
    try {
      for (final key in keys) {
        final rows = await _db.rawQuery(
          'SELECT item FROM SerialNumber WHERE LOWER(TRIM(name)) = ? LIMIT 1',
          [key],
        );
        if (rows.isEmpty) continue;
        final name = rows.first['item']?.toString().trim();
        if (name == null || name.isEmpty) continue;
        return ItemModel(
          name: name,
          itemType: 'Product',
          forFilter: 'Both',
          unit: 'Unit',
          rate: 0,
        );
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<ApiResponse<ItemResponseModel>> getItemById({required String id}) async {
    try {
      final rows = await _db.query('Item', where: 'id = ?', whereArgs: [id]);
      if (rows.isEmpty) throw const AppException(message: 'Item not found');
      final item = _rowToItemModel(rows.first);
      final response = ItemResponseModel(
        data: [item],
        pagination: PaginationModel(currentPage: 1, perPage: 1, totalPages: 1, totalRows: 1),
        filtersApplied: FiltersAppliedModel(
          search: null, itemType: null, forFilter: null,
          excludeZeroSales: false, sortBy: 'name', sortOrder: 'asc',
        ),
        summary: SummaryModel(totalItems: 1, itemsWithSales: 0, totalSalesQuantity: 0, averageSalesPerItem: 0),
        availableFilters: AvailableFiltersModel(forOptions: []),
      );
      return ApiResponse(data: response, message: 'Item fetched', success: true);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<ItemModel>> createItem({
    required ItemModel request,
    String? imagePath,
  }) async {
    try {
      await getIt<FreemiumGateService>().assertCan(FreemiumFeature.item);
      final now = DateTime.now().toIso8601String();
      final row = {
        'name': request.name,
        'for': request.forFilter,
        'itemType': request.itemType,
        'unit': request.unit,
        'rate': request.rate,
        'description': request.description,
        'incomeAccount': request.incomeAccount,
        'expenseAccount': request.expenseAccount,
        'tax': request.tax,
        'hsnCode': request.hsnCode,
        'barcode': request.barcode,
        'trackItem': _defaultTrackItem(
          itemType: request.itemType,
          explicit: request.trackItem,
        ),
        'hasBatch': request.hasBatch ?? 0,
        'hasSerialNumber': request.hasSerialNumber ?? 0,
        'image': await _saveImageLocally(imagePath),
        'category': request.category,
        'createdBy': request.createdBy ?? 'local_user',
        'modifiedBy': request.createdBy ?? 'local_user',
        'created': now,
        'modified': now,
      };
      final storedImage = row['image'] as String?;
      await _ensureItemReferences(
        category: request.category,
        unit: request.unit,
        createdBy: request.createdBy ?? 'local_user',
      );
      await _db.upsert('Item', row);
      final created = ItemModel(
        id: null,
        name: request.name,
        forFilter: request.forFilter,
        itemType: request.itemType,
        unit: request.unit,
        rate: request.rate,
        description: request.description,
        incomeAccount: request.incomeAccount,
        expenseAccount: request.expenseAccount,
        tax: request.tax,
        hsnCode: request.hsnCode,
        barcode: request.barcode,
        trackItem: _defaultTrackItem(
          itemType: request.itemType,
          explicit: request.trackItem,
        ),
        hasBatch: request.hasBatch,
        hasSerialNumber: request.hasSerialNumber,
        category: request.category,
        image: storedImage,
      );
      return ApiResponse(data: created, message: 'Item created successfully', success: true);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<ItemUpdateResponseModel>> updateItem({
    required CreateItemRequest request,
    String? imagePath,
  }) async {
    try {
      final now = DateTime.now().toIso8601String();
      final db = await _db.database;
      final updates = <String, dynamic>{
        'modified': now,
        if (request.newName != null && request.newName!.trim().isNotEmpty)
          'name': request.newName!.trim(),
        if (request.rate != null) 'rate': request.rate,
        if (request.description != null) 'description': request.description,
        if (request.incomeAccount != null) 'incomeAccount': request.incomeAccount,
        if (request.expenseAccount != null) 'expenseAccount': request.expenseAccount,
        if (request.tax != null) 'tax': request.tax,
        if (request.hsnCode != null) 'hsnCode': request.hsnCode,
        if (request.category != null) 'category': request.category,
        if (imagePath != null) 'image': await _saveImageLocally(imagePath),
      };
      if (request.barcode != null) {
        final sku = request.barcode!.trim();
        updates['barcode'] = sku.isEmpty ? null : sku;
      }
      await db.update('Item', updates, where: 'name = ?', whereArgs: [request.name]);
      return ApiResponse(
        data: ItemUpdateResponseModel(success: true, message: 'Item updated'),
        message: 'Item updated successfully',
        success: true,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<void>> deleteItem({required DeleteItemRequest request}) async {
    try {
      final db = await _db.database;
      await db.delete('Item', where: 'name = ?', whereArgs: [request.itemName]);
      return ApiResponse(data: null, message: 'Item deleted', success: true);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<BulkCreateItemsResponse>> bulkCreateItems({
    required BulkCreateItemsRequest request,
  }) async {
    try {
      final count = request.items.length;
      await getIt<FreemiumGateService>().assertCan(
        FreemiumFeature.item,
        additionalCount: count,
      );
      final now = DateTime.now().toIso8601String();
      int created = 0;
      for (final item in request.items) {
        await _ensureItemReferences(
          category: item.category,
          unit: item.unit,
          createdBy: item.createdBy ?? 'local_user',
        );
        await _db.upsert('Item', {
          'name': item.name,
          'for': item.forFilter,
          'itemType': item.itemType,
          'unit': item.unit,
          'rate': item.rate,
          'description': item.description,
          'incomeAccount': item.incomeAccount,
          'expenseAccount': item.expenseAccount,
          'category': item.category,
          'trackItem': _defaultTrackItem(itemType: item.itemType),
          'createdBy': item.createdBy ?? 'local_user',
          'modifiedBy': item.createdBy ?? 'local_user',
          'created': now,
          'modified': now,
        });
        created++;
      }
      return ApiResponse(
        data: BulkCreateItemsResponse(success: true, count: created, message: '$created items created'),
        message: '$created items created',
        success: true,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<MergeItemsBulkOperationResponse>> mergeItemsBulkOperation({
    required MergeItemsBulkOperationRequest request,
  }) async {
    // Merge: keep target item, delete others
    try {
      final db = await _db.database;
      await db.delete('Item', where: 'name = ?', whereArgs: [request.mergeData.sourceItem]);
      return ApiResponse(
        data: MergeItemsBulkOperationResponse(success: true, message: 'Items merged'),
        message: 'Items merged',
        success: true,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  // ── helpers ─────────────────────────────────────────────────────────────────

  /// Ensures FK targets exist before inserting into [Item].
  Future<void> _ensureItemReferences({
    String? category,
    String? unit,
    required String createdBy,
  }) async {
    final now = DateTime.now().toIso8601String();
    await _db.run((db) async {
      final categoryName = category?.trim();
      if (categoryName != null && categoryName.isNotEmpty) {
        await db.insert(
          'Category',
          {'name': categoryName, 'created': now, 'modified': now},
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }

      final unitName = unit?.trim();
      if (unitName != null && unitName.isNotEmpty) {
        final existing = await db.query(
          'UOM',
          where: 'name = ?',
          whereArgs: [unitName],
          limit: 1,
        );
        if (existing.isEmpty) {
          await db.insert('UOM', {
            'name': unitName,
            'isWhole': 0,
            'created': now,
            'modified': now,
            'createdBy': createdBy,
            'modifiedBy': createdBy,
          });
        }
      }
    });
  }

  /// Stores picked image as `data:<mime>;base64,...` in [Item.image].
  Future<String?> _saveImageLocally(String? imagePath) async {
    return ItemImageHelper.encodeFileForStorage(imagePath);
  }

  ItemModel _rowToItemModel(Map<String, dynamic> r, {int? totalSales}) {
    return ItemModel(
      id: r['id']?.toString(),
      name: r['name'] as String,
      forFilter: r['for'] as String? ?? 'Both',
      itemType: r['itemType'] as String?,
      unit: r['unit'] as String? ?? 'Unit',
      rate: _toDouble(r['rate']),
      description: r['description'] as String?,
      incomeAccount: r['incomeAccount'] as String?,
      expenseAccount: r['expenseAccount'] as String?,
      tax: r['tax'] as String?,
      hsnCode: r['hsnCode'] as String?,
      barcode: r['barcode'] as String?,
      trackItem: _toInt(r['trackItem']),
      hasBatch: _toInt(r['hasBatch']),
      hasSerialNumber: _toInt(r['hasSerialNumber']),
      category: r['category'] as String?,
      image: r['image'] as String?,
      isFavorite: r['isFavorite'] == 1 || r['isFavorite'] == true,
      totalSales: totalSales,
    );
  }

  ApiResponse<ItemResponseModel> _emptyItemsResponse(
    ItemRequestParams params, {
    required int page,
    required int perPage,
  }) {
    return ApiResponse(
      data: ItemResponseModel(
        data: const [],
        pagination: PaginationModel(
          currentPage: page,
          perPage: perPage,
          totalPages: 0,
          totalRows: 0,
        ),
        filtersApplied: FiltersAppliedModel(
          search: params.search,
          itemType: params.itemType,
          forFilter: params.forFilter,
          excludeZeroSales: params.excludeZeroSales ?? false,
          sortBy: params.sortBy ?? 'name',
          sortOrder: params.sortOrder ?? 'asc',
        ),
        summary: SummaryModel(
          totalItems: 0,
          itemsWithSales: 0,
          totalSalesQuantity: 0,
          averageSalesPerItem: 0,
        ),
        availableFilters: AvailableFiltersModel(forOptions: []),
      ),
      message: 'Items fetched',
      success: true,
    );
  }

  Future<Map<String, int>> _repeatedSalesRanks({String? forFilter}) async {
    final purchases = (forFilter ?? '').toLowerCase().startsWith('purch');
    final lineTable = purchases ? 'PurchaseInvoiceItem' : 'SalesInvoiceItem';
    final headerTable = purchases ? 'PurchaseInvoice' : 'SalesInvoice';
    try {
      final rows = await _db.rawQuery(
        'SELECT sii.item AS item, SUM(sii.quantity) AS qty '
        'FROM $lineTable sii '
        'INNER JOIN $headerTable si ON si.name = sii.parent '
        'WHERE IFNULL(si.cancelled, 0) = 0 '
        'GROUP BY sii.item '
        'HAVING SUM(sii.quantity) > 0 '
        'ORDER BY qty DESC',
      );
      final out = <String, int>{};
      for (final row in rows) {
        final name = row['item']?.toString().trim() ?? '';
        if (name.isEmpty) continue;
        final qty = row['qty'];
        out[name] = qty is num ? qty.toInt() : int.tryParse('$qty') ?? 0;
      }
      return out;
    } catch (_) {
      return const {};
    }
  }

  @override
  Future<void> setItemFavorite({
    required String itemName,
    required bool isFavorite,
  }) async {
    final name = itemName.trim();
    if (name.isEmpty) return;
    final db = await _db.database;
    await db.update(
      'Item',
      {
        'isFavorite': isFavorite ? 1 : 0,
        'modified': DateTime.now().toIso8601String(),
      },
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  int _defaultTrackItem({String? itemType, int? explicit}) {
    if (explicit != null) return explicit;
    if ((itemType ?? '').trim().toLowerCase() == 'service') return 0;
    try {
      if (getIt.isRegistered<LiveStockTrackingService>() &&
          getIt<LiveStockTrackingService>().enabled) {
        return 1;
      }
    } catch (_) {}
    return 0;
  }

  int? _toInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString());
  }
}
