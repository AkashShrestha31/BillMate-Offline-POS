// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdatePaymentRequestImpl _$$UpdatePaymentRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdatePaymentRequestImpl(
      payrollId: (json['payroll_id'] as num).toInt(),
      paymentDate: json['payment_date'] as String,
      paymentMethod: json['payment_method'] as String?,
      bankReference: json['bank_reference'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$UpdatePaymentRequestImplToJson(
        _$UpdatePaymentRequestImpl instance) =>
    <String, dynamic>{
      'payroll_id': instance.payrollId,
      'payment_date': instance.paymentDate,
      'payment_method': instance.paymentMethod,
      'bank_reference': instance.bankReference,
      'notes': instance.notes,
    };
