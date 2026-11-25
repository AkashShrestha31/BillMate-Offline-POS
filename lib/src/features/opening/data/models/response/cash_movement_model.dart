import 'package:freezed_annotation/freezed_annotation.dart';

part 'cash_movement_model.freezed.dart';
part 'cash_movement_model.g.dart';

@freezed
class CashMovementModel with _$CashMovementModel {
  const factory CashMovementModel({
    required int id,
    @JsonKey(name: 'register_id') required int registerId,
    @JsonKey(name: 'movement_type') required String movementType,
    required double amount,
    String? reason,
    @JsonKey(name: 'reference_id') String? referenceId,
    @JsonKey(name: 'created_by') String? createdBy,
    String? created,
  }) = _CashMovementModel;

  factory CashMovementModel.fromJson(Map<String, dynamic> json) =>
      _$CashMovementModelFromJson(json);
}
