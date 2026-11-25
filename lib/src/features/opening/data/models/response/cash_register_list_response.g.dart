// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_register_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CashRegisterListResponseImpl _$$CashRegisterListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CashRegisterListResponseImpl(
      success: json['success'] as bool,
      count: (json['count'] as num?)?.toInt(),
      registers: (json['registers'] as List<dynamic>?)
          ?.map((e) => CashRegisterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      register: json['register'] == null
          ? null
          : CashRegisterModel.fromJson(
              json['register'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$CashRegisterListResponseImplToJson(
        _$CashRegisterListResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'registers': instance.registers,
      'register': instance.register,
      'message': instance.message,
    };
