import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
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
import 'package:hotel/src/features/action/domain/repositories/item_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetItemsUseCase implements BaseUseCase<ItemRequestParams, ApiResponse<ItemResponseModel>> {
  final ItemRepository _repository;
  GetItemsUseCase(this._repository);

  @override
  Future<Either<AppError, ApiResponse<ItemResponseModel>>> execute(ItemRequestParams params) =>
      _repository.getItems(params: params);
}

@lazySingleton
class GetItemByIdUseCase {
  final ItemRepository _repository;
  GetItemByIdUseCase(this._repository);

  Future<Either<AppError, ApiResponse<ItemResponseModel>>> execute(String id) => _repository.getItemById(id: id);
}

@lazySingleton
class CreateItemUseCase implements BaseUseCase<ItemModel, ApiResponse<ItemModel>> {
  final ItemRepository _repository;
  CreateItemUseCase(this._repository);

  @override
  Future<Either<AppError, ApiResponse<ItemModel>>> execute(ItemModel request, {String? imagePath}) =>
      _repository.createItem(request: request, imagePath: imagePath);
}

@lazySingleton
class UpdateItemUseCase {
  final ItemRepository _repository;
  UpdateItemUseCase(this._repository);

  Future<Either<AppError, ApiResponse<ItemUpdateResponseModel>>> execute({
    required CreateItemRequest request,
    String? imagePath,
  }) =>
      _repository.updateItem(request: request, imagePath: imagePath);
}

@lazySingleton
class DeleteItemUseCase {
  final ItemRepository _repository;
  DeleteItemUseCase(this._repository);

  Future<Either<AppError, ApiResponse<void>>> execute(DeleteItemRequest request) =>
      _repository.deleteItem(request: request);
}

@lazySingleton
class MergeItemsBulkOperationUseCase {
  final ItemRepository _repository;
  MergeItemsBulkOperationUseCase(this._repository);

  Future<Either<AppError, ApiResponse<MergeItemsBulkOperationResponse>>> execute({
    required MergeItemsBulkOperationRequest request,
  }) =>
      _repository.mergeItemsBulkOperation(request: request);
}

@lazySingleton
class BulkCreateItemsUseCase {
  final ItemRepository _repository;
  BulkCreateItemsUseCase(this._repository);

  Future<Either<AppError, ApiResponse<BulkCreateItemsResponse>>> execute(
    BulkCreateItemsRequest request,
  ) =>
      _repository.bulkCreateItems(request: request);
}
