part of 'liquor_cubit.dart';

@freezed
class LiquorState with _$LiquorState {
  const factory LiquorState.initial() = _Initial;
  const factory LiquorState.loading() = _Loading;
  const factory LiquorState.noInternet() = _NoInternet;
  const factory LiquorState.error({required String message}) = _Error;
  const factory LiquorState.success({required ApiResponse<LiquorResponseModel> liquorResponseModel}) = _Success;
  const factory LiquorState.created({required ApiResponse<String> liquorItem}) = _Created;
  const factory LiquorState.updated({required ApiResponse<String> liquorItem}) = _Updated;
  const factory LiquorState.deleted({required ApiResponse<String> liquorItem}) = _Deleted;
}
