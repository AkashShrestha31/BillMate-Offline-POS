part of 'party_cubit.dart';

@freezed
class PartyState with _$PartyState {
  const factory PartyState.initial() = _Initial;
  const factory PartyState.loading() = _Loading;
  const factory PartyState.noInternet() = _NoInternet;
  const factory PartyState.error({required String message}) = _Error;
  const factory PartyState.listSuccess({
    required PartyListResponseModel response,
  }) = _ListSuccess;
  const factory PartyState.detailSuccess({
    required PartyDetailResponseModel response,
  }) = _DetailSuccess;
  const factory PartyState.created({
    required PartyCreateResponseModel response,
  }) = _Created;
  const factory PartyState.updated({
    required PartyUpdateResponseModel response,
  }) = _Updated;
  const factory PartyState.deleted({
    required PartyDeleteResponseModel response,
  }) = _Deleted;
  const factory PartyState.reconcile({
    required ReconcilePartyResponse response,
  }) = _Reconcile;
}
