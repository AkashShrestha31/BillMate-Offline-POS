part of 'category_cubit.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _Initial;
  const factory CategoryState.loading() = _Loading;
  const factory CategoryState.loaded({required List<CategoryModel> categories}) = _Loaded;
  const factory CategoryState.error({required String message}) = _Error;
  const factory CategoryState.createSuccess({required CategoryModel category}) = _CreateSuccess;
  const factory CategoryState.renameSuccess({required String message}) = _RenameSuccess;
  const factory CategoryState.deleteSuccess({required String message}) = _DeleteSuccess;
}
