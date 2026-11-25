part of 'server_to_client_cubit.dart';

@freezed
class ServerToClientState with _$ServerToClientState {
  const factory ServerToClientState.initial() = _Initial;
  const factory ServerToClientState.loading() = _Loading;
  const factory ServerToClientState.noInternet() = _NoInternet;
  const factory ServerToClientState.error({required String message}) = _Error;
  const factory ServerToClientState.success({
    required ServerToClientResponseModel responseModel
  }) = _Success;
}
