import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/liquor/data/datasources/liquor_remote_data_source.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_create_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/liquor_update_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/pricing_create_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/request/pricing_update_request_params.dart';
import 'package:hotel/src/features/liquor/data/models/response/liquor_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton(as: LiquorRemoteDataSource)
class LiquorLocalDataSourceImpl implements LiquorRemoteDataSource {
  LiquorLocalDataSourceImpl(this._db);

  final LocalDb _db;

  Future<String> _createdBy() async =>
      await SessionHelper.getUserIdentifierForPermissionsApi() ?? 'local_user';

  String _now() => DateTime.now().toIso8601String();

  String _today() {
    final n = DateTime.now();
    return '${n.year.toString().padLeft(4, '0')}-'
        '${n.month.toString().padLeft(2, '0')}-'
        '${n.day.toString().padLeft(2, '0')}';
  }

  Future<void> _ensureCategory(
    Database db, {
    required String name,
    String? description,
    required String createdBy,
    required String now,
  }) async {
    final existing = await db.rawQuery(
      'SELECT id FROM LiquorCategory WHERE LOWER(name) = LOWER(?) AND isActive = 1 LIMIT 1',
      [name],
    );
    if (existing.isNotEmpty) return;

    await db.insert('LiquorCategory', {
      'name': name,
      'description': description ?? '',
      'isActive': 1,
      'createdBy': createdBy,
      'created': now,
      'modified': now,
    });
  }

  Future<List<String>> _distinctBrands(Database db) async {
    final rows = await db.rawQuery(
      "SELECT DISTINCT brand FROM LiquorItem WHERE brand IS NOT NULL AND brand != '' AND isActive = 1 ORDER BY brand",
    );
    return rows.map((r) => (r['brand'] ?? '').toString()).toList();
  }

  Map<String, dynamic> _rowToItemJson(
    Map<String, dynamic> row,
    Map<String, int> brandNameToId,
  ) {
    final brandName = (row['brandName'] ?? '').toString();
    final purchase = (row['purchasePrice'] as num?)?.toDouble() ?? 0;
    final selling = (row['sellingPrice'] as num?)?.toDouble() ?? 0;
    final marginAmt = (row['marginAmount'] as num?)?.toDouble() ??
        (selling - purchase);
    final marginPct = (row['marginPercentage'] as num?)?.toDouble() ??
        (selling > 0 ? (marginAmt / selling) * 100 : 0);

    return {
      'itemId': row['itemId'],
      'itemName': row['itemName'],
      'volume': row['volume'] ?? '',
      'itemDescription': row['itemDescription'],
      'itemCreated': row['itemCreated'] ?? _now(),
      'itemIsActive': row['itemIsActive'] ?? 1,
      'categoryId': row['categoryId'] ?? 0,
      'categoryName': row['categoryName'] ?? '',
      'categoryDescription': row['categoryDescription'],
      'categoryIsActive': row['categoryIsActive'] ?? 1,
      'brandId': brandNameToId[brandName] ?? 0,
      'brandName': brandName,
      'pricingId': row['pricingId'] ?? 0,
      'purchasePrice': purchase,
      'sellingPrice': selling,
      'marginAmount': marginAmt,
      'marginPercentage': marginPct,
      'effectiveFrom': row['effectiveFrom'] ?? _today(),
      'effectiveTo': row['effectiveTo'],
      'pricingLocation': row['pricingLocation'] ?? 'Main Bar',
      'pricingNotes': row['pricingNotes'],
      'pricingIsActive': row['pricingIsActive'] ?? 1,
      'pricingCreated': row['pricingCreated'] ?? _now(),
    };
  }

  List<LiquorItem> _applyClientFilters(
    List<LiquorItem> items,
    LiquorRequestParams params,
  ) {
    var filtered = items;

    if (params.name != null && params.name!.trim().isNotEmpty) {
      final q = params.name!.toLowerCase();
      filtered = filtered
          .where((i) => i.name.toLowerCase().contains(q))
          .toList();
    }
    if (params.location != null && params.location!.trim().isNotEmpty) {
      final loc = params.location!.toLowerCase();
      filtered = filtered
          .where((i) => i.location.toLowerCase() == loc)
          .toList();
    }
    if (params.minPrice != null) {
      filtered =
          filtered.where((i) => i.sellingPrice >= params.minPrice!).toList();
    }
    if (params.maxPrice != null) {
      filtered =
          filtered.where((i) => i.sellingPrice <= params.maxPrice!).toList();
    }
    if (params.minMargin != null) {
      filtered = filtered
          .where((i) => i.marginPercentage >= params.minMargin!)
          .toList();
    }
    if (params.maxMargin != null) {
      filtered = filtered
          .where((i) => i.marginPercentage <= params.maxMargin!)
          .toList();
    }

    final page = params.page ?? 1;
    final perPage = params.perPage ?? 100;
    if (perPage <= 0) return filtered;

    final start = (page - 1) * perPage;
    if (start >= filtered.length) return [];
    final end = (start + perPage).clamp(0, filtered.length);
    return filtered.sublist(start, end);
  }

  @override
  Future<ApiResponse<LiquorResponseModel>> getLiquorItems({
    required LiquorRequestParams params,
  }) async {
    try {
      final db = await _db.database;

      final where = <String>['li.isActive = 1'];
      final args = <dynamic>[];

      if (params.category != null && params.category!.trim().isNotEmpty) {
        where.add('li.category = ?');
        args.add(params.category!.trim());
      }
      if (params.brand != null && params.brand!.trim().isNotEmpty) {
        where.add('li.brand = ?');
        args.add(params.brand!.trim());
      }

      final sql = '''
        SELECT
          li.id AS itemId,
          li.name AS itemName,
          li.category AS categoryName,
          li.brand AS brandName,
          li.volume,
          li.description AS itemDescription,
          li.created AS itemCreated,
          li.isActive AS itemIsActive,
          lc.id AS categoryId,
          lc.description AS categoryDescription,
          lc.isActive AS categoryIsActive,
          lp.id AS pricingId,
          lp.purchasePrice,
          lp.sellingPrice,
          lp.marginAmount,
          lp.marginPercentage,
          lp.effectiveFrom,
          lp.effectiveTo,
          lp.location AS pricingLocation,
          lp.notes AS pricingNotes,
          lp.isActive AS pricingIsActive,
          lp.created AS pricingCreated
        FROM LiquorItem li
        LEFT JOIN LiquorCategory lc ON lc.name = li.category AND lc.isActive = 1
        LEFT JOIN LiquorPricing lp ON lp.itemName = li.name AND lp.isActive = 1
        WHERE ${where.join(' AND ')}
        ORDER BY li.category, li.brand, li.name, lp.effectiveFrom DESC
      ''';

      final rows = await db.rawQuery(sql, args);
      final brands = await _distinctBrands(db);
      final brandNameToId = {
        for (var i = 0; i < brands.length; i++) brands[i]: i + 1,
      };

      final seenItemIds = <int>{};
      final items = <LiquorItem>[];

      for (final row in rows) {
        final itemId = (row['itemId'] as num?)?.toInt();
        if (itemId == null || seenItemIds.contains(itemId)) continue;
        seenItemIds.add(itemId);

        final pricingId = row['pricingId'];
        if (pricingId == null) continue;

        items.add(
          LiquorItem.fromJson(_rowToItemJson(row, brandNameToId)),
        );
      }

      final paged = _applyClientFilters(items, params);

      return ApiResponse(
        data: LiquorResponseModel(items: paged, count: paged.length),
        message: '',
        success: true,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<String>> createLiquorItem({
    required LiquorCreateRequestParams params,
  }) async {
    try {
      final db = await _db.database;
      final createdBy = await _createdBy();
      final now = _now();

      final existing = await db.rawQuery(
        'SELECT id FROM LiquorItem WHERE LOWER(name) = LOWER(?) LIMIT 1',
        [params.name],
      );
      if (existing.isNotEmpty) {
        throw const AppException(message: 'Item with this name already exists');
      }

      await _ensureCategory(
        db,
        name: params.category,
        description: params.categoryDescription,
        createdBy: createdBy,
        now: now,
      );

      final itemId = await db.insert('LiquorItem', {
        'name': params.name,
        'category': params.category,
        'brand': params.brand,
        'volume': params.volume,
        'description': params.description,
        'isActive': 1,
        'createdBy': createdBy,
        'created': now,
        'modified': now,
      });

      final pricing = params.pricing;
      final purchase = pricing.purchasePrice.toDouble();
      final selling = pricing.sellingPrice.toDouble();
      final marginAmount = selling - purchase;
      final marginPercentage =
          selling > 0 ? (marginAmount / selling) * 100 : 0;

      await db.insert('LiquorPricing', {
        'itemName': params.name,
        'purchasePrice': purchase,
        'sellingPrice': selling,
        'marginAmount': marginAmount,
        'marginPercentage': double.parse(marginPercentage.toStringAsFixed(2)),
        'effectiveFrom': pricing.effectiveFrom.isNotEmpty
            ? pricing.effectiveFrom
            : _today(),
        'effectiveTo': pricing.effectiveTo.isNotEmpty ? pricing.effectiveTo : null,
        'location': pricing.location.isNotEmpty ? pricing.location : 'Main Bar',
        'notes': pricing.notes,
        'isActive': 1,
        'createdBy': createdBy,
        'created': now,
        'modified': now,
      });

      return ApiResponse(
        data: 'Item created successfully (id: $itemId)',
        message: 'Liquor item created successfully',
        success: true,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<String>> updateLiquorItem({
    required LiquorUpdateRequestParams params,
  }) async {
    try {
      final db = await _db.database;
      final createdBy = await _createdBy();
      final now = _now();

      final existing = await db.rawQuery(
        'SELECT id, name FROM LiquorItem WHERE id = ? LIMIT 1',
        [params.itemId],
      );
      if (existing.isEmpty) {
        throw const AppException(message: 'Item not found');
      }

      final oldName = existing.first['name'] as String;
      final newName = params.itemName.trim();

      if (newName.toLowerCase() != oldName.toLowerCase()) {
        final conflict = await db.rawQuery(
          'SELECT id FROM LiquorItem WHERE LOWER(name) = LOWER(?) AND id != ? AND isActive = 1 LIMIT 1',
          [newName, params.itemId],
        );
        if (conflict.isNotEmpty) {
          throw AppException(message: "Another item with name '$newName' already exists");
        }
      }

      await _ensureCategory(
        db,
        name: params.categoryName,
        description: params.categoryDescription,
        createdBy: createdBy,
        now: now,
      );

      if (params.categoryId > 0 && params.categoryName.isNotEmpty) {
        await db.update(
          'LiquorCategory',
          {
            'name': params.categoryName,
            if (params.categoryDescription != null)
              'description': params.categoryDescription,
            if (params.categoryIsActive != null)
              'isActive': params.categoryIsActive,
            'modified': now,
          },
          where: 'id = ?',
          whereArgs: [params.categoryId],
        );
      }

      await db.update(
        'LiquorItem',
        {
          'name': newName,
          'category': params.categoryName,
          'brand': params.brandName,
          'volume': params.volume,
          'description': params.itemDescription,
          'isActive': params.itemIsActive,
          'modified': now,
        },
        where: 'id = ?',
        whereArgs: [params.itemId],
      );

      if (newName != oldName) {
        await db.update(
          'LiquorPricing',
          {'itemName': newName, 'modified': now},
          where: 'itemName = ?',
          whereArgs: [oldName],
        );
      }

      final purchase = params.purchasePrice.toDouble();
      final selling = params.sellingPrice.toDouble();
      final marginAmount = params.marginAmount.toDouble();
      final marginPercentage = params.marginPercentage ??
          (selling > 0 ? (marginAmount / selling) * 100 : 0);

      if (params.pricingId > 0) {
        await db.update(
          'LiquorPricing',
          {
            'purchasePrice': purchase,
            'sellingPrice': selling,
            'marginAmount': marginAmount,
            'marginPercentage': marginPercentage,
            if (params.effectiveFrom != null) 'effectiveFrom': params.effectiveFrom,
            'effectiveTo': params.effectiveTo,
            'location': params.pricingLocation ?? 'Main Bar',
            'notes': params.pricingNotes,
            if (params.pricingIsActive != null) 'isActive': params.pricingIsActive,
            'modified': now,
          },
          where: 'id = ?',
          whereArgs: [params.pricingId],
        );
      }

      return const ApiResponse(
        data: 'Item updated successfully',
        message: 'Liquor item updated successfully',
        success: true,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<String>> deleteLiquorItem({required int id}) async {
    try {
      final db = await _db.database;

      final existing = await db.rawQuery(
        'SELECT name FROM LiquorItem WHERE id = ? LIMIT 1',
        [id],
      );
      if (existing.isEmpty) {
        throw const AppException(message: 'Item not found');
      }

      final itemName = existing.first['name'] as String;

      await db.delete(
        'LiquorPricing',
        where: 'itemName = ?',
        whereArgs: [itemName],
      );
      await db.delete(
        'LiquorItem',
        where: 'id = ?',
        whereArgs: [id],
      );

      return const ApiResponse(
        data: 'Item deleted successfully',
        message: 'Liquor item deleted successfully',
        success: true,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<void>> createPricing({
    required PricingCreateRequestParams params,
  }) async {
    try {
      final db = await _db.database;
      final createdBy = await _createdBy();
      final now = _now();

      final item = await db.rawQuery(
        'SELECT id FROM LiquorItem WHERE name = ? AND isActive = 1 LIMIT 1',
        [params.itemName],
      );
      if (item.isEmpty) {
        throw AppException(message: "Item '${params.itemName}' not found");
      }

      final purchase = params.purchasePrice;
      final selling = params.sellingPrice;
      final marginAmount = selling - purchase;
      final marginPercentage =
          selling > 0 ? (marginAmount / selling) * 100 : 0;

      await db.insert('LiquorPricing', {
        'itemName': params.itemName,
        'purchasePrice': purchase,
        'sellingPrice': selling,
        'marginAmount': marginAmount,
        'marginPercentage': double.parse(marginPercentage.toStringAsFixed(2)),
        'effectiveFrom':
            params.effectiveFrom.isNotEmpty ? params.effectiveFrom : _today(),
        'location': params.location.isNotEmpty ? params.location : 'Main Bar',
        'notes': params.notes,
        'isActive': 1,
        'createdBy': createdBy,
        'created': now,
        'modified': now,
      });

      return const ApiResponse(
        data: null,
        message: 'Pricing created successfully',
        success: true,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<ApiResponse<void>> updatePricing({
    required PricingUpdateRequestParams params,
  }) async {
    try {
      final db = await _db.database;
      final now = _now();

      final existing = await db.rawQuery(
        'SELECT purchasePrice, sellingPrice FROM LiquorPricing WHERE id = ? LIMIT 1',
        [params.id],
      );
      if (existing.isEmpty) {
        throw const AppException(message: 'Pricing record not found');
      }

      final purchase =
          params.purchasePrice ?? (existing.first['purchasePrice'] as num).toDouble();
      final selling =
          params.sellingPrice ?? (existing.first['sellingPrice'] as num).toDouble();
      final marginAmount = selling - purchase;
      final marginPercentage =
          selling > 0 ? (marginAmount / selling) * 100 : 0;

      await db.update(
        'LiquorPricing',
        {
          'purchasePrice': purchase,
          'sellingPrice': selling,
          'marginAmount': marginAmount,
          'marginPercentage': double.parse(marginPercentage.toStringAsFixed(2)),
          if (params.location != null) 'location': params.location,
          if (params.notes != null) 'notes': params.notes,
          'modified': now,
        },
        where: 'id = ?',
        whereArgs: [params.id],
      );

      return const ApiResponse(
        data: null,
        message: 'Pricing updated successfully',
        success: true,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
