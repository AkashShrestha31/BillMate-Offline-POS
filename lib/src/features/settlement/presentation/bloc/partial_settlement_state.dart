part of 'partial_settlement_cubit.dart';

@freezed
class PartialSettlementState with _$PartialSettlementState {
  const factory PartialSettlementState.initial() = _Initial;
  const factory PartialSettlementState.loading() = _Loading;
  const factory PartialSettlementState.noInternet() = _NoInternet;
  const factory PartialSettlementState.error({required String message}) = _Error;
  const factory PartialSettlementState.success({
    required PartialSettlementResponseModel responseModel
  }) = _Success;
}
