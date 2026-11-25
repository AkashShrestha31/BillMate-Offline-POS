// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodItem _$PaymentMethodItemFromJson(Map<String, dynamic> json) =>
    PaymentMethodItem(
      name: json['name'] as String,
      type: json['type'] as String,
      account: json['account'] as String?,
    );

Map<String, dynamic> _$PaymentMethodItemToJson(PaymentMethodItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      if (instance.account case final value?) 'account': value,
    };
