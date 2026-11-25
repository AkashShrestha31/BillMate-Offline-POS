// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_register_query_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CashRegisterQueryParamsImpl _$$CashRegisterQueryParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$CashRegisterQueryParamsImpl(
      registerId: (json['register_id'] as num?)?.toInt(),
      registerName: json['register_name'] as String?,
      shiftDate: json['shift_date'] as String?,
      status: json['status'] as String?,
      dateFrom: json['date_from'] as String?,
      dateTo: json['date_to'] as String?,
    );

Map<String, dynamic> _$$CashRegisterQueryParamsImplToJson(
        _$CashRegisterQueryParamsImpl instance) =>
    <String, dynamic>{
      'register_id': instance.registerId,
      'register_name': instance.registerName,
      'shift_date': instance.shiftDate,
      'status': instance.status,
      'date_from': instance.dateFrom,
      'date_to': instance.dateTo,
    };
