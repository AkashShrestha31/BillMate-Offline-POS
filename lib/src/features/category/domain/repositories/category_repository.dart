import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/category/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<Either<AppError, List<CategoryModel>>> getCategories({
    String? search,
    String? sortBy,
    String? sortOrder,
  });
  Future<Either<AppError, CategoryModel>> createCategory(String name);
  Future<Either<AppError, void>> renameCategory({required String oldName, required String newName});
  Future<Either<AppError, void>> deleteCategory({
    required String name,
    required bool confirmDelete,
    bool forceDelete = false,
    String? transferItemsTo,
  });
}
