part of 'settlement_cubit.dart';

@freezed
class SettlementState with _$SettlementState {
  const factory SettlementState.initial() = _Initial;

  const factory SettlementState.loading() = _Loading;

  const factory SettlementState.noInternet() = _NoInternet;

  const factory SettlementState.error({required String message}) = _Error;

  const factory SettlementState.success(
      {required ApiResponse<SettlementResponseModel> responseModel}) = _Success;
}
