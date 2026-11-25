import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/category/data/models/category_model.dart';
import 'package:hotel/src/features/category/domain/repositories/category_repository.dart';
import 'package:injectable/injectable.dart';

part 'category_state.dart';
part 'category_cubit.freezed.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this._repository) : super(const CategoryState.initial());

  final CategoryRepository _repository;

  Future<void> loadCategories({
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    emit(const CategoryState.loading());
    final result = await _repository.getCategories(
      search: search,
      sortBy: sortBy ?? 'name',
      sortOrder: sortOrder ?? 'asc',
    );
    result.fold(
      (e) => emit(CategoryState.error(
        message: e.when(
          serverError: (m) => m ?? 'Server error',
          noInternet: () => 'No internet',
        ),
      )),
      (list) => emit(CategoryState.loaded(categories: list)),
    );
  }

  Future<void> createCategory(String name) async {
    emit(const CategoryState.loading());
    final result = await _repository.createCategory(name);
    result.fold(
      (e) => emit(CategoryState.error(
        message: e.when(
          serverError: (m) => m ?? 'Server error',
          noInternet: () => 'No internet',
        ),
      )),
      (category) => emit(CategoryState.createSuccess(category: category)),
    );
  }

  Future<void> renameCategory({required String oldName, required String newName}) async {
    emit(const CategoryState.loading());
    final result = await _repository.renameCategory(oldName: oldName, newName: newName);
    result.fold(
      (e) => emit(CategoryState.error(
        message: e.when(
          serverError: (m) => m ?? 'Server error',
          noInternet: () => 'No internet',
        ),
      )),
      (_) => emit(const CategoryState.renameSuccess(message: 'Renamed successfully')),
    );
  }

  Future<void> deleteCategory({
    required String name,
    bool forceDelete = false,
    String? transferItemsTo,
  }) async {
    await deleteCategories(
      names: [name],
      forceDelete: forceDelete,
      transferItemsTo: transferItemsTo,
    );
  }

  Future<void> deleteCategories({
    required List<String> names,
    bool forceDelete = false,
    String? transferItemsTo,
  }) async {
    final unique = names.where((name) => name.trim().isNotEmpty).toSet().toList();
    if (unique.isEmpty) return;
    emit(const CategoryState.loading());
    String? lastError;
    var deleted = 0;
    for (final name in unique) {
      final result = await _repository.deleteCategory(
        name: name,
        confirmDelete: true,
        forceDelete: forceDelete,
        transferItemsTo: transferItemsTo,
      );
      result.fold(
        (e) => lastError = e.when(
          serverError: (m) => m ?? 'Server error',
          noInternet: () => 'No internet',
        ),
        (_) => deleted++,
      );
    }
    if (deleted == 0) {
      emit(CategoryState.error(message: lastError ?? 'Server error'));
      return;
    }
    emit(const CategoryState.deleteSuccess(message: 'Deleted successfully'));
  }
}
