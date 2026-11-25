import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/category/data/models/category_list_response.dart';
import 'package:hotel/src/features/category/data/models/category_model.dart';
import 'package:injectable/injectable.dart';

abstract class CategoryRemoteDataSource {
  Future<CategoryListResponse> getCategories({
    String? search,
    String? sortBy,
    String? sortOrder,
  });
  Future<CategoryModel> createCategory({required String name});
  Future<void> renameCategory({required String oldName, required String newName});
  Future<void> deleteCategory({
    required String name,
    required bool confirmDelete,
    bool forceDelete = false,
    String? transferItemsTo,
  });
}

// @LazySingleton(as: CategoryRemoteDataSource)
class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  CategoryRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<CategoryListResponse> getCategories({
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final query = <String, dynamic>{};
      if (search != null && search.isNotEmpty) query['search'] = search;
      if (sortBy != null) query['sort_by'] = sortBy;
      if (sortOrder != null) query['sort_order'] = sortOrder;
      final response = await _dio.get<Map<String, dynamic>>(
        '${dotenv.env['BASE_URL']}${ApiEndPoints.categories}',
        options: options,
        queryParameters: query.isNotEmpty ? query : null,
      );
      if (response.data == null) throw const AppException(message: 'Empty response');
      return CategoryListResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CategoryModel> createCategory({required String name}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post<Map<String, dynamic>>(
        '${dotenv.env['BASE_URL']}${ApiEndPoints.categories}',
        options: options,
        data: {'name': name},
      );
      if (response.data == null) throw const AppException(message: 'Empty response');
      final category = response.data!['category'] as Map<String, dynamic>?;
      if (category == null) throw const AppException(message: 'Missing category in response');
      return CategoryModel.fromJson(category);
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<void> renameCategory({required String oldName, required String newName}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      await _dio.put<Map<String, dynamic>>(
        '${dotenv.env['BASE_URL']}${ApiEndPoints.categories}',
        options: options,
        data: {'old_name': oldName, 'new_name': newName},
      );
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
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
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      await _dio.delete<Map<String, dynamic>>(
        '${dotenv.env['BASE_URL']}${ApiEndPoints.categories}',
        options: options,
        data: {
          'name': name,
          'confirm_delete': confirmDelete,
          if (forceDelete) 'force_delete': true,
          if (transferItemsTo != null && transferItemsTo.trim().isNotEmpty)
            'transfer_items_to': transferItemsTo.trim(),
        },
      );
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
