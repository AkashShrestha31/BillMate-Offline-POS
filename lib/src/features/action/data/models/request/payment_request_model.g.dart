// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentRequestModel _$PaymentRequestModelFromJson(Map<String, dynamic> json) =>
    PaymentRequestModel(
      paymentName: json['payment_name'] as String?,
      party: json['party'] as String?,
      date: json['date'] as String?,
      paymentType: json['payment_type'] as String?,
      account: json['account'] as String?,
      paymentAccount: json['payment_account'] as String?,
      paymentMethod: json['payment_method'] as String?,
      clearanceDate: json['clearance_date'] as String?,
      referenceId: json['reference_id'] as String?,
      referenceDate: json['reference_date'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      writeoff: json['writeoff'] as String?,
      attachment: json['attachment'] as String?,
      referenceType: json['reference_type'] as String?,
      modifiedBy: json['modified_by'] as String?,
    );

Map<String, dynamic> _$PaymentRequestModelToJson(
        PaymentRequestModel instance) =>
    <String, dynamic>{
      if (instance.paymentName case final value?) 'payment_name': value,
      if (instance.party case final value?) 'party': value,
      if (instance.date case final value?) 'date': value,
      if (instance.paymentType case final value?) 'payment_type': value,
      if (instance.account case final value?) 'account': value,
      if (instance.paymentAccount case final value?) 'payment_account': value,
      if (instance.paymentMethod case final value?) 'payment_method': value,
      if (instance.clearanceDate case final value?) 'clearance_date': value,
      if (instance.referenceId case final value?) 'reference_id': value,
      if (instance.referenceDate case final value?) 'reference_date': value,
      if (instance.amount case final value?) 'amount': value,
      if (instance.writeoff case final value?) 'writeoff': value,
      if (instance.attachment case final value?) 'attachment': value,
      if (instance.referenceType case final value?) 'reference_type': value,
      if (instance.modifiedBy case final value?) 'modified_by': value,
    };
