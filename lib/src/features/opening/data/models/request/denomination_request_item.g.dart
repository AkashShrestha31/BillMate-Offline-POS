// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'denomination_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DenominationRequestItemImpl _$$DenominationRequestItemImplFromJson(
        Map<String, dynamic> json) =>
    _$DenominationRequestItemImpl(
      denomination: (json['denomination'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$$DenominationRequestItemImplToJson(
        _$DenominationRequestItemImpl instance) =>
    <String, dynamic>{
      'denomination': instance.denomination,
      'quantity': instance.quantity,
      'type': instance.type,
    };
