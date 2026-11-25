// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_movement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CashMovementRequestImpl _$$CashMovementRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CashMovementRequestImpl(
      registerId: (json['register_id'] as num).toInt(),
      movementType: json['movement_type'] as String,
      amount: (json['amount'] as num).toDouble(),
      reason: json['reason'] as String?,
      referenceId: json['reference_id'] as String?,
      createdBy: json['created_by'] as String,
    );

Map<String, dynamic> _$$CashMovementRequestImplToJson(
        _$CashMovementRequestImpl instance) =>
    <String, dynamic>{
      'register_id': instance.registerId,
      'movement_type': instance.movementType,
      'amount': instance.amount,
      'reason': instance.reason,
      'reference_id': instance.referenceId,
      'created_by': instance.createdBy,
    };
