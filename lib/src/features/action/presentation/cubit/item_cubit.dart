import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/open_facts_barcode_lookup.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/action/data/datasources/item_remote_data_source.dart';
import 'package:hotel/src/features/action/data/models/request/bulk_create_items_request.dart';
import 'package:hotel/src/features/action/data/models/request/delete_item_request.dart';
import 'package:hotel/src/features/action/data/models/request/item_request_params.dart';
import 'package:hotel/src/features/action/data/models/request/create_item_request.dart';
import 'package:hotel/src/features/action/data/models/request/merge_items_bulk_operation_request.dart';
import 'package:hotel/src/features/action/data/models/request/update_item_request.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:hotel/src/features/action/data/models/response/item_update_response_model.dart';
import 'package:hotel/src/features/action/data/models/response/merge_items_bulk_operation_response.dart';
import 'package:hotel/src/features/action/domain/usecases/item_use_cases.dart';
import 'package:injectable/injectable.dart';

part 'item_state.dart';
part 'item_cubit.freezed.dart';

@injectable
class ItemCubit extends Cubit<ItemState> {
  ItemCubit(
    this._getItemsUseCase,
    this._getItemByIdUseCase,
    this._createItemUseCase,
    this._updateItemUseCase,
    this._deleteItemUseCase,
    this._mergeItemsBulkOperationUseCase,
    this._bulkCreateItemsUseCase,
  ) : super(const ItemState.initial());

  final GetItemsUseCase _getItemsUseCase;
  final GetItemByIdUseCase _getItemByIdUseCase;
  final CreateItemUseCase _createItemUseCase;
  final UpdateItemUseCase _updateItemUseCase;
  final DeleteItemUseCase _deleteItemUseCase;
  final MergeItemsBulkOperationUseCase _mergeItemsBulkOperationUseCase;
  final BulkCreateItemsUseCase _bulkCreateItemsUseCase;
  final StreamController<int> _favoriteChanges = StreamController<int>.broadcast();
  int _favoriteVersion = 0;

  /// Fires after a favorite is saved so other screens can refresh.
  Stream<int> get favoriteChanges => _favoriteChanges.stream;

  @override
  Future<void> close() {
    _favoriteChanges.close();
    return super.close();
  }

  // Pagination state
  List<ItemModel> _allItems = [];
  int _currentPage = 1;
  bool _hasMoreData = true;
  bool _isLoadingMore = false;
  ItemRequestParams? _lastParams;
  PaginationModel? _lastPagination;
  ItemResponseModel? _lastSuccessResponse;

  Future<void> getItems({
    required ItemRequestParams params,
    bool isLoadMore = false,
  }) async {
    // Prevent multiple simultaneous load more requests
    if (isLoadMore && _isLoadingMore) return;

    // If it's a new request (not load more), reset pagination
    if (!isLoadMore) {
      _allItems = [];
      _currentPage = 1;
      _hasMoreData = true;
      _isLoadingMore = false;
      _lastParams = params;
      emit(const ItemState.loading());
    } else {
      // Check if we have more data to load
      if (!_hasMoreData) return;
      _isLoadingMore = true;
    }

    // Create params with updated page number
    final updatedParams = ItemRequestParams(
      page: _currentPage,
      perPage: params.perPage ?? 10,
      search: params.search,
      itemType: params.itemType,
      forFilter: params.forFilter,
      excludeZeroSales: params.excludeZeroSales,
      sortBy: params.sortBy,
      sortOrder: params.sortOrder,
      category: params.category,
      favoritesOnly: params.favoritesOnly,
      repeatedSales: params.repeatedSales,
    );

    final result = await _getItemsUseCase.execute(updatedParams);

    result.fold(
      (error) {
        _isLoadingMore = false;
        emit(
          error.when(
            serverError: (serverError) => ItemState.error(message: serverError),
            noInternet: () => const ItemState.noInternet(),
          ),
        );
      },
      (data) {
        // Add new items to the list
        if (isLoadMore) {
          _allItems.addAll(data.data.data);
        } else {
          _allItems = data.data.data;
        }

        // Store pagination info
        _lastPagination = data.data.pagination;

        // Check if there's more data
        _hasMoreData =
            data.data.pagination.currentPage < data.data.pagination.totalPages;

        // Increment page for next load
        if (_hasMoreData) {
          _currentPage++;
        }

        _isLoadingMore = false;

        // Create updated response with all accumulated items
        final updatedResponse = ItemResponseModel(
          data: _allItems,
          pagination: data.data.pagination,
          filtersApplied: data.data.filtersApplied,
          summary: data.data.summary,
          availableFilters: data.data.availableFilters,
        );
        _lastSuccessResponse = updatedResponse;

        emit(ItemState.success(
          response: updatedResponse,
          hasMore: _hasMoreData,
        ));
      },
    );
  }

  void loadMoreItems() {
    if (_lastParams != null && _hasMoreData && !_isLoadingMore) {
      getItems(params: _lastParams!, isLoadMore: true);
    }
  }

  /// Lookup without changing list UI state.
  ///
  /// Tries the saved barcode, HSN, description, and item name. A retail
  /// barcode that is not stored on an item is also resolved through the
  /// product name, then matched to a local item.
  Future<ItemModel?> findByBarcode(String code, {String? forFilter}) async {
    final trimmed = code.trim();
    if (trimmed.isEmpty) return null;
    try {
      final local = await getIt<ItemRemoteDataSource>().findItemByBarcode(
        trimmed,
        forFilter: forFilter,
      );
      if (local != null) return local;
    } catch (_) {}

    final digits = trimmed.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 8) return null;
    try {
      final title = await OpenFactsBarcodeLookup().lookupDisplayName(
        digits,
        timeout: const Duration(seconds: 4),
        maxSources: 1,
      );
      final productName = title?.trim() ?? '';
      if (productName.isEmpty) return null;
      return await getIt<ItemRemoteDataSource>().findItemByBarcode(
        productName,
        forFilter: forFilter,
      );
    } catch (_) {
      return null;
    }
  }

  Future<bool> setFavorite({
    required String itemName,
    required bool isFavorite,
  }) async {
    final name = itemName.trim();
    if (name.isEmpty) return false;
    try {
      await getIt<ItemRemoteDataSource>().setItemFavorite(
        itemName: name,
        isFavorite: isFavorite,
      );
    } catch (_) {
      return false;
    }
    _allItems = _allItems
        .map((item) =>
            item.name == name ? item.copyWith(isFavorite: isFavorite) : item)
        .toList();
    if (_lastParams?.favoritesOnly == true && !isFavorite) {
      _allItems.removeWhere((item) => item.name == name);
    }
    final previous = _lastSuccessResponse;
    if (previous != null) {
      final updated = ItemResponseModel(
        data: _allItems,
        pagination: previous.pagination,
        filtersApplied: previous.filtersApplied,
        summary: previous.summary,
        availableFilters: previous.availableFilters,
      );
      _lastSuccessResponse = updated;
      emit(ItemState.success(response: updated, hasMore: _hasMoreData));
    }
    if (!_favoriteChanges.isClosed) {
      _favoriteVersion++;
      _favoriteChanges.add(_favoriteVersion);
    }
    return true;
  }

  /// Favorites for the quick-add strip. Does not replace the current item list.
  Future<List<ItemModel>> fetchFavoriteItems(
      {required String forFilter}) async {
    final result = await _getItemsUseCase.execute(
      ItemRequestParams(
        page: 1,
        perPage: 24,
        forFilter: forFilter,
        favoritesOnly: true,
        excludeZeroSales: false,
        sortBy: 'name',
        sortOrder: 'asc',
      ),
    );
    return result.fold(
      (_) => _allItems.where((item) => item.isFavorite).toList(),
      (data) => data.data.data,
    );
  }

  void getItemById({required String id}) async {
    emit(const ItemState.loading());
    emit(
      (await _getItemByIdUseCase.execute(id)).fold(
        (error) => error.when(
          serverError: (serverError) => ItemState.error(message: serverError),
          noInternet: () => const ItemState.noInternet(),
        ),
        (data) => ItemState.detailSuccess(response: data.data),
      ),
    );
  }

  void createItem({required ItemModel request, String? imagePath}) async {
    emit(const ItemState.loading());

    final result =
        await _createItemUseCase.execute(request, imagePath: imagePath);

    result.fold(
      (error) {
        emit(
          error.when(
            serverError: (serverError) => ItemState.error(message: serverError),
            noInternet: () => const ItemState.noInternet(),
          ),
        );
      },
      (data) {
        emit(ItemState.created(response: data.data));

        // Refresh the list after creation
        if (_lastParams != null) {
          Future.delayed(const Duration(milliseconds: 500), () {
            getItems(params: _lastParams!);
          });
        }
      },
    );
  }

  void updateItem(
      {required CreateItemRequest request, String? imagePath}) async {
    emit(const ItemState.loading());

    final result = await _updateItemUseCase.execute(
        request: request, imagePath: imagePath);

    result.fold(
      (error) {
        emit(
          error.when(
            serverError: (serverError) => ItemState.error(message: serverError),
            noInternet: () => const ItemState.noInternet(),
          ),
        );
      },
      (data) {
        emit(ItemState.updated(response: data.data));

        // Silently patch the updated item in the current list (no full reload)
        final updatedItem = data.data.item;
        if (updatedItem != null &&
            _allItems.isNotEmpty &&
            _lastSuccessResponse != null) {
          final oldName = request.name;
          final newName = updatedItem.name;
          final idx = _allItems
              .indexWhere((i) => i.name == oldName || i.name == newName);
          if (idx >= 0) {
            _allItems = List<ItemModel>.from(_allItems);
            _allItems[idx] = updatedItem;
            final patchedResponse = ItemResponseModel(
              data: _allItems,
              pagination: _lastSuccessResponse!.pagination,
              filtersApplied: _lastSuccessResponse!.filtersApplied,
              summary: _lastSuccessResponse!.summary,
              availableFilters: _lastSuccessResponse!.availableFilters,
            );
            _lastSuccessResponse = patchedResponse;
            emit(ItemState.success(
                response: patchedResponse, hasMore: _hasMoreData));
          }
        }
      },
    );
  }

  void deleteItem({required DeleteItemRequest request}) async {
    emit(const ItemState.loading());

    final result = await _deleteItemUseCase.execute(request);

    result.fold(
      (error) {
        emit(
          error.when(
            serverError: (serverError) => ItemState.error(message: serverError),
            noInternet: () => const ItemState.noInternet(),
          ),
        );
      },
      (data) {
        emit(const ItemState.deleted());

        // Refresh the list after deletion
        if (_lastParams != null) {
          Future.delayed(const Duration(milliseconds: 500), () {
            getItems(params: _lastParams!);
          });
        }
      },
    );
  }

  Future<String?> bulkCreateItems(
      {required BulkCreateItemsRequest request}) async {
    final result = await _bulkCreateItemsUseCase.execute(request);
    String? errorMessage;

    await result.fold(
      (error) async {
        errorMessage = error.when(
          serverError: (message) => message,
          noInternet: () => 'No internet connection',
        );
      },
      (data) async {
        if (_lastParams != null) {
          // Wait for the list refresh before returning success, so
          // callers (BulkAddItemsPage) can pop only after items are updated.
          await getItems(params: _lastParams!);
        }
      },
    );

    return errorMessage;
  }

  void mergeItemsBulkOperation({
    required MergeItemsBulkOperationRequest request,
  }) async {
    emit(const ItemState.loading());
    emit(
      (await _mergeItemsBulkOperationUseCase.execute(request: request)).fold(
        (error) => error.when(
          serverError: (serverError) => ItemState.error(message: serverError),
          noInternet: () => const ItemState.noInternet(),
        ),
        (data) => ItemState.mergeItemsSuccess(response: data.data),
      ),
    );
  }

  void resetState() {
    _allItems = [];
    _currentPage = 1;
    _hasMoreData = true;
    _isLoadingMore = false;
    _lastParams = null;
    _lastPagination = null;
    _lastSuccessResponse = null;
    emit(const ItemState.initial());
  }

  // Helper getters
  bool get hasMore => _hasMoreData;
  bool get isLoadingMore => _isLoadingMore;
  int get currentPage => _currentPage;
  int get totalItems => _allItems.length;
  PaginationModel? get paginationInfo => _lastPagination;
}
