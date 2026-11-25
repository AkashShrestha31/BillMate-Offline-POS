import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/category/data/datasources/category_remote_data_source.dart';
import 'package:hotel/src/features/category/data/models/category_list_response.dart';
import 'package:hotel/src/features/category/data/models/category_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoryRemoteDataSource)
class CategoryLocalDataSource implements CategoryRemoteDataSource {
  CategoryLocalDataSource(this._db);
  final LocalDb _db;

  @override
  Future<CategoryListResponse> getCategories({String? search, String? sortBy, String? sortOrder}) async {
    try {
      final rows = await _db.query('Category', orderBy: 'name ASC');
      final cats = rows.map((r) => CategoryModel(
        id: r['id'] as int,
        name: r['name'] as String,
        created: r['created'] as String?,
        modified: r['modified'] as String?,
      )).toList();
      return CategoryListResponse(success: true, count: cats.length, data: cats);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<CategoryModel> createCategory({required String name}) async {
    try {
      await getIt<FreemiumGateService>().assertCan(FreemiumFeature.category);
      final now = DateTime.now().toIso8601String();
      final db = await _db.database;
      final id = await db.insert('Category', {'name': name, 'created': now, 'modified': now});
      return CategoryModel(id: id, name: name, created: now, modified: now);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> renameCategory({required String oldName, required String newName}) async {
    try {
      final db = await _db.database;
      await db.update('Category', {'name': newName, 'modified': DateTime.now().toIso8601String()},
          where: 'name = ?', whereArgs: [oldName]);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<void> deleteCategory({
    required String name,
    required bool confirmDelete,
    bool forceDelete = false,
    String? transferItemsTo,
  }) async {
    try {
      final db = await _db.database;
      await db.transaction((txn) async {
        const itemMatch =
            'LOWER(TRIM(IFNULL(category, ""))) = LOWER(TRIM(?)) OR LOWER(TRIM(IFNULL(category, ""))) = LOWER(TRIM(?))';
        final sourceArgs = [name, _categoryDisplayName(name)];
        final countRows = await txn.rawQuery(
          'SELECT COUNT(*) AS count FROM Item WHERE $itemMatch',
          sourceArgs,
        );
        final rawCount = countRows.first['count'];
        final itemCount = rawCount is int
            ? rawCount
            : int.tryParse('$rawCount') ?? 0;

        final target = transferItemsTo?.trim();
        if (itemCount > 0) {
          if (target == null || target.isEmpty) {
            throw const AppException(
              message: 'Move items to another category before deleting.',
            );
          }
          final targetRows = await txn.query(
            'Item',
            columns: ['category'],
            where: itemMatch,
            whereArgs: [target, _categoryDisplayName(target)],
            limit: 1,
          );
          final targetValue = targetRows.isNotEmpty
              ? (targetRows.first['category'] as String? ?? target)
              : target;
          await txn.update(
            'Item',
            {
              'category': targetValue,
              'modified': DateTime.now().toIso8601String(),
            },
            where: itemMatch,
            whereArgs: sourceArgs,
          );
        }
        await txn.delete('Category', where: 'name = ?', whereArgs: [name]);
      });
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException(message: e.toString());
    }
  }
}

String _categoryDisplayName(String fullName) {
  final idx = fullName.indexOf(' - ');
  if (idx >= 0 && idx + 3 < fullName.length) {
    return fullName.substring(idx + 3).trim();
  }
  return fullName;
}
