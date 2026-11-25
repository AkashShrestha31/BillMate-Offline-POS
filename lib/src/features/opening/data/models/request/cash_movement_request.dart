import 'package:freezed_annotation/freezed_annotation.dart';

part 'cash_movement_request.freezed.dart';
part 'cash_movement_request.g.dart';

@freezed
class CashMovementRequest with _$CashMovementRequest {
  const factory CashMovementRequest({
    @JsonKey(name: 'register_id') required int registerId,
    @JsonKey(name: 'movement_type') required String movementType,
    required double amount,
    String? reason,
    @JsonKey(name: 'reference_id') String? referenceId,
    @JsonKey(name: 'created_by') required String createdBy,
  }) = _CashMovementRequest;

  factory CashMovementRequest.fromJson(Map<String, dynamic> json) =>
      _$CashMovementRequestFromJson(json);
}
