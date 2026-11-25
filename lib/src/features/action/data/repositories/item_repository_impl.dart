import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
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
import 'package:hotel/src/features/action/domain/repositories/item_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ItemRepository)
class ItemRepositoryImpl implements ItemRepository {
  ItemRepositoryImpl(this._dataSource);
  final ItemRemoteDataSource _dataSource;

  @override
  Future<Either<AppError, ApiResponse<ItemResponseModel>>> getItems({
    required ItemRequestParams params,
  }) async {
    try {
      final response = await _dataSource.getItems(params: params);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<ItemResponseModel>>> getItemById({
    required String id,
  }) async {
    try {
      final response = await _dataSource.getItemById(id: id);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ItemModel?>> findItemByBarcode(String barcode) async {
    try {
      final item = await _dataSource.findItemByBarcode(barcode);
      return right(item);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<ItemModel>>> createItem({
    required ItemModel request,
    String? imagePath,
  }) async {
    try {
      final response = await _dataSource.createItem(request: request, imagePath: imagePath);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<ItemUpdateResponseModel>>> updateItem({
    required CreateItemRequest request,
    String? imagePath,
  }) async {
    try {
      final response = await _dataSource.updateItem(request: request, imagePath: imagePath);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<void>>> deleteItem({
    required DeleteItemRequest request,
  }) async {
    try {
      final response = await _dataSource.deleteItem(request: request);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<MergeItemsBulkOperationResponse>>> mergeItemsBulkOperation({
    required MergeItemsBulkOperationRequest request,
  }) async {
    try {
      final response = await _dataSource.mergeItemsBulkOperation(request: request);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, ApiResponse<BulkCreateItemsResponse>>> bulkCreateItems({
    required BulkCreateItemsRequest request,
  }) async {
    try {
      final response = await _dataSource.bulkCreateItems(request: request);
      return right(response);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }

  @override
  Future<Either<AppError, void>> setItemFavorite({
    required String itemName,
    required bool isFavorite,
  }) async {
    try {
      await _dataSource.setItemFavorite(
        itemName: itemName,
        isFavorite: isFavorite,
      );
      return right(null);
    } on AppException catch (e) {
      return left(AppError.serverError(message: e.message));
    }
  }
}
