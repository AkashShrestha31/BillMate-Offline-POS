part of 'party_cubit.dart';

@freezed
class PartyState with _$PartyState {
  const factory PartyState.initial() = _Initial;
  const factory PartyState.loading() = _Loading;
  const factory PartyState.noInternet() = _NoInternet;
  const factory PartyState.error({required String message}) = _Error;
  const factory PartyState.success(
      {required ApiResponse<PartyResponseModel> response}) = _Success;
  const factory PartyState.detailSuccess(
      {required ApiResponse<PartyResponseModel> response}) = _DetailSuccess;
  const factory PartyState.created(
      {required ApiResponse<PartyResponseModel> response}) = _Created;
  const factory PartyState.updated(
      {required ApiResponse<PartyUpdateResponseModel> response}) = _Updated;
  const factory PartyState.deleted() = _Deleted;
}
