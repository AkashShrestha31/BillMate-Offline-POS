// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OpenRegisterRequestImpl _$$OpenRegisterRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$OpenRegisterRequestImpl(
      registerName: json['register_name'] as String,
      shiftDate: json['shift_date'] as String,
      openingAmount: (json['opening_amount'] as num).toDouble(),
      openingNote: json['opening_note'] as String?,
      openedBy: json['opened_by'] as String,
      denominations: (json['denominations'] as List<dynamic>?)
          ?.map((e) =>
              DenominationRequestItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$OpenRegisterRequestImplToJson(
        _$OpenRegisterRequestImpl instance) =>
    <String, dynamic>{
      'register_name': instance.registerName,
      'shift_date': instance.shiftDate,
      'opening_amount': instance.openingAmount,
      'opening_note': instance.openingNote,
      'opened_by': instance.openedBy,
      if (instance.denominations case final value?) 'denominations': value,
    };
