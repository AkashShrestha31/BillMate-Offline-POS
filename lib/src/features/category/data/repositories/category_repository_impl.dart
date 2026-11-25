import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/category/data/datasources/category_remote_data_source.dart';
import 'package:hotel/src/features/category/data/models/category_model.dart';
import 'package:hotel/src/features/category/domain/repositories/category_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._remote);
  final CategoryRemoteDataSource _remote;

  @override
  Future<Either<AppError, List<CategoryModel>>> getCategories({
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final response = await _remote.getCategories(
        search: search,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );
      return right(response.data);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, CategoryModel>> createCategory(String name) async {
    try {
      final category = await _remote.createCategory(name: name);
      return right(category);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, void>> renameCategory({required String oldName, required String newName}) async {
    try {
      await _remote.renameCategory(oldName: oldName, newName: newName);
      return right(null);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, void>> deleteCategory({
    required String name,
    required bool confirmDelete,
    bool forceDelete = false,
    String? transferItemsTo,
  }) async {
    try {
      await _remote.deleteCategory(
        name: name,
        confirmDelete: confirmDelete,
        forceDelete: forceDelete,
        transferItemsTo: transferItemsTo,
      );
      return right(null);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
