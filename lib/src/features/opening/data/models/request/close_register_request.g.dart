// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CloseRegisterRequestImpl _$$CloseRegisterRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CloseRegisterRequestImpl(
      registerId: (json['register_id'] as num).toInt(),
      shiftDate: json['shift_date'] as String,
      closingAmount: (json['closing_amount'] as num).toDouble(),
      closingNote: json['closing_note'] as String?,
      closedBy: json['closed_by'] as String,
      denominations: (json['denominations'] as List<dynamic>?)
          ?.map((e) =>
              DenominationRequestItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CloseRegisterRequestImplToJson(
        _$CloseRegisterRequestImpl instance) =>
    <String, dynamic>{
      'register_id': instance.registerId,
      'shift_date': instance.shiftDate,
      'closing_amount': instance.closingAmount,
      'closing_note': instance.closingNote,
      'closed_by': instance.closedBy,
      if (instance.denominations case final value?) 'denominations': value,
    };
