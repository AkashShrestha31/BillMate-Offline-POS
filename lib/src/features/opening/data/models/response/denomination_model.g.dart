// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'denomination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DenominationModelImpl _$$DenominationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DenominationModelImpl(
      denomination: (json['denomination'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$$DenominationModelImplToJson(
        _$DenominationModelImpl instance) =>
    <String, dynamic>{
      'denomination': instance.denomination,
      'quantity': instance.quantity,
      'amount': instance.amount,
      'type': instance.type,
    };
