import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
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

abstract class ItemRepository {
  Future<Either<AppError, ApiResponse<ItemResponseModel>>> getItems({
    required ItemRequestParams params,
  });

  Future<Either<AppError, ApiResponse<ItemResponseModel>>> getItemById({
    required String id,
  });

  Future<Either<AppError, ItemModel?>> findItemByBarcode(String barcode);

  Future<Either<AppError, ApiResponse<ItemModel>>> createItem({
    required ItemModel request,
    String? imagePath,
  });

  Future<Either<AppError, ApiResponse<ItemUpdateResponseModel>>> updateItem({
    required CreateItemRequest request,
    String? imagePath,
  });

  Future<Either<AppError, ApiResponse<void>>> deleteItem({
    required DeleteItemRequest request,
  });

  Future<Either<AppError, ApiResponse<MergeItemsBulkOperationResponse>>> mergeItemsBulkOperation({
    required MergeItemsBulkOperationRequest request,
  });

  Future<Either<AppError, ApiResponse<BulkCreateItemsResponse>>> bulkCreateItems({
    required BulkCreateItemsRequest request,
  });

  Future<Either<AppError, void>> setItemFavorite({
    required String itemName,
    required bool isFavorite,
  });
}
