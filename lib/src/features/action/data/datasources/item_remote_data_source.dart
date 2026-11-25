import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/helpers/item_search_helper.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/action/data/models/request/delete_item_request.dart';
import 'package:hotel/src/features/action/data/models/request/item_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/bulk_create_items_request.dart';
import 'package:hotel/src/features/action/data/models/request/create_item_request.dart';
import 'package:hotel/src/features/action/data/models/request/merge_items_bulk_operation_request.dart';
import 'package:hotel/src/features/action/data/models/request/update_item_request.dart';
import 'package:hotel/src/features/action/data/models/response/bulk_create_items_response.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:hotel/src/features/action/data/models/response/item_update_response_model.dart';
import 'package:hotel/src/features/action/data/models/response/merge_items_bulk_operation_response.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ItemRemoteDataSource {
  Future<ApiResponse<ItemResponseModel>> getItems({required ItemRequestParams params});
  Future<ApiResponse<ItemResponseModel>> getItemById({required String id});
  Future<ItemModel?> findItemByBarcode(String barcode, {String? forFilter});
  Future<ApiResponse<ItemModel>> createItem({required ItemModel request, String? imagePath});
  Future<ApiResponse<ItemUpdateResponseModel>> updateItem({
    required CreateItemRequest request,
    String? imagePath,
  });
  Future<ApiResponse<void>> deleteItem({required DeleteItemRequest request});
  Future<ApiResponse<MergeItemsBulkOperationResponse>> mergeItemsBulkOperation({
    required MergeItemsBulkOperationRequest request,
  });
  Future<ApiResponse<BulkCreateItemsResponse>> bulkCreateItems({
    required BulkCreateItemsRequest request,
  });
  Future<void> setItemFavorite({
    required String itemName,
    required bool isFavorite,
  });
}

// @LazySingleton(as: ItemRemoteDataSource) — replaced by ItemLocalDataSource
class ItemRemoteSourceImpl implements ItemRemoteDataSource {
  ItemRemoteSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  static String _multipartFilename(String filePath) {
    final normalized = filePath.replaceAll(r'\', '/');
    final i = normalized.lastIndexOf('/');
    return i >= 0 ? normalized.substring(i + 1) : normalized;
  }

  /// Multipart item endpoints expect scalar fields as strings (OpenAPI `type: string`).
  Map<String, dynamic> _stringifyFormValues(Map<String, dynamic> map) {
    final out = <String, dynamic>{};
    for (final e in map.entries) {
      final v = e.value;
      if (v == null) continue;
      if (v is String) {
        out[e.key] = v;
      } else if (v is num || v is bool) {
        out[e.key] = v.toString();
      } else {
        out[e.key] = v.toString();
      }
    }
    return out;
  }

  Future<FormData> _itemModelToFormData(ItemModel request, String imagePath) async {
    final map = Map<String, dynamic>.from(request.toJson())..removeWhere((_, v) => v == null);
    map.remove('image');
    final formData = FormData.fromMap(_stringifyFormValues(map));
    final path = imagePath.trim();
    if (path.isNotEmpty) {
      final file = File(path);
      if (await file.exists()) {
        formData.files.add(
          MapEntry(
            'image',
            await MultipartFile.fromFile(
              path,
              filename: _multipartFilename(path),
            ),
          ),
        );
      }
    }
    return formData;
  }

  Future<FormData> _createItemRequestToFormData(CreateItemRequest request, String imagePath) async {
    final map = Map<String, dynamic>.from(request.toJson())..removeWhere((_, v) => v == null);
    map.remove('image');
    final formData = FormData.fromMap(_stringifyFormValues(map));
    final path = imagePath.trim();
    if (path.isNotEmpty) {
      final file = File(path);
      if (await file.exists()) {
        formData.files.add(
          MapEntry(
            'image',
            await MultipartFile.fromFile(
              path,
              filename: _multipartFilename(path),
            ),
          ),
        );
      }
    }
    return formData;
  }

  @override
  Future<ApiResponse<ItemResponseModel>> getItems({required ItemRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.item}",
        queryParameters: params.toQueryParams(),
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          data: ItemResponseModel.fromJson(response.data),
          message: 'Items fetched successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to fetch items');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ItemModel?> findItemByBarcode(
    String barcode, {
    String? forFilter,
  }) async {
    final code = barcode.trim();
    if (code.isEmpty) return null;
    final response = await getItems(
      params: ItemRequestParams(search: code, page: 1, perPage: 50),
    );
    return itemMatchingScannedCode(
      response.data.data,
      code,
      forFilter: forFilter,
    );
  }

  @override
  Future<ApiResponse<ItemResponseModel>> getItemById({required String id}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.fetchItem}/$id",
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          data: ItemResponseModel.fromJson(response.data),
          message: 'Item fetched successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to fetch item');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<ItemModel>> createItem({required ItemModel request, String? imagePath}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final path = imagePath?.trim();
      final hasImage = path != null && path.isNotEmpty;
      final Object data =
          hasImage ? await _itemModelToFormData(request, path) : request.toJson();
      final response = await _dio.post(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.item}",
        data: data,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return ApiResponse(
          data: ItemModel.fromJson(response.data['item']),
          message: response.data['message'],
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to create item');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<ItemUpdateResponseModel>> updateItem({
    required CreateItemRequest request,
    String? imagePath,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final path = imagePath?.trim();
      final hasImage = path != null && path.isNotEmpty;
      final Object data =
          hasImage ? await _createItemRequestToFormData(request, path) : request.toJson();
      final response = await _dio.put(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.item}",
        data: data,
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          data: ItemUpdateResponseModel.fromJson(response.data),
          message: 'Item updated successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to update item');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<void>> deleteItem({required DeleteItemRequest request}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.delete(
        options: options,
        data: request.toJson(),
        "${dotenv.env['BASE_URL']}${ApiEndPoints.item}",
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        return ApiResponse(
          data: null,
          message: 'Item deleted successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to delete item');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<MergeItemsBulkOperationResponse>> mergeItemsBulkOperation({
    required MergeItemsBulkOperationRequest request,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.itemBulkOperations}",
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          data: MergeItemsBulkOperationResponse.fromJson(response.data),
          message: response.data['message'] ?? 'Items merged successfully',
          success: true,
        );
      } else {
        throw const AppException(message: 'Failed to merge items');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<BulkCreateItemsResponse>> bulkCreateItems({
    required BulkCreateItemsRequest request,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        options: options,
        "${dotenv.env['BASE_URL']}${ApiEndPoints.itemBulkCreate}",
        data: request.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final raw = response.data;
        if (raw is! Map) {
          throw const AppException(message: 'Invalid bulk create response');
        }
        return ApiResponse(
          data: BulkCreateItemsResponse.fromJson(Map<String, dynamic>.from(raw)),
          message: raw['message']?.toString() ?? 'Items created',
          success: true,
        );
      }
      throw const AppException(message: 'Failed to bulk create items');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<void> setItemFavorite({
    required String itemName,
    required bool isFavorite,
  }) async {}
}
