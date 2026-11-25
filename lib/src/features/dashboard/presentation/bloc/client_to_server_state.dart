part of 'client_to_server_cubit.dart';

@freezed
class ClientToServerState with _$ClientToServerState {
  const factory ClientToServerState.initial() = _Initial;
  const factory ClientToServerState.loading() = _Loading;
  const factory ClientToServerState.noInternet() = _NoInternet;
  const factory ClientToServerState.error({required String message}) = _Error;
  const factory ClientToServerState.success(
      {required ClientToServerResponseModel responseModel}) = _Success;
}
