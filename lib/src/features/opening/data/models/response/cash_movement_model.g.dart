// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_movement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CashMovementModelImpl _$$CashMovementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CashMovementModelImpl(
      id: (json['id'] as num).toInt(),
      registerId: (json['register_id'] as num).toInt(),
      movementType: json['movement_type'] as String,
      amount: (json['amount'] as num).toDouble(),
      reason: json['reason'] as String?,
      referenceId: json['reference_id'] as String?,
      createdBy: json['created_by'] as String?,
      created: json['created'] as String?,
    );

Map<String, dynamic> _$$CashMovementModelImplToJson(
        _$CashMovementModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'register_id': instance.registerId,
      'movement_type': instance.movementType,
      'amount': instance.amount,
      'reason': instance.reason,
      'reference_id': instance.referenceId,
      'created_by': instance.createdBy,
      'created': instance.created,
    };
