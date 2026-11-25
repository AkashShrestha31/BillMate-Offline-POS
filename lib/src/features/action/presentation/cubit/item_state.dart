part of 'item_cubit.dart';

@freezed
class ItemState with _$ItemState {
  const factory ItemState.initial() = _Initial;
  const factory ItemState.loading() = _Loading;
  const factory ItemState.loadingMore({
    required List<ItemModel> items,
  }) = _LoadingMore;
  const factory ItemState.noInternet() = _NoInternet;
  const factory ItemState.error({required String message}) = _Error;
  const factory ItemState.success({
    required ItemResponseModel response,
    @Default(false) bool hasMore,
  }) = _Success;
  const factory ItemState.detailSuccess({
    required ItemResponseModel response,
  }) = _DetailSuccess;
  const factory ItemState.created({
    required ItemModel response,
  }) = _Created;
  const factory ItemState.updated({
    required ItemUpdateResponseModel response,
  }) = _Updated;
  const factory ItemState.deleted() = _Deleted;
  const factory ItemState.mergeItemsSuccess({
    required MergeItemsBulkOperationResponse response,
  }) = _MergeItemsSuccess;
}
