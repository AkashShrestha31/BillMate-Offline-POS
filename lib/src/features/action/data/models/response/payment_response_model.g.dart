// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResponseModel _$PaymentResponseModelFromJson(
        Map<String, dynamic> json) =>
    PaymentResponseModel(
      message: json['message'] as String,
      updatedPayment: UpdatedPayment.fromJson(
          json['updated_payment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentResponseModelToJson(
        PaymentResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'updated_payment': instance.updatedPayment,
    };

UpdatedPayment _$UpdatedPaymentFromJson(Map<String, dynamic> json) =>
    UpdatedPayment(
      name: json['name'] as String,
      date: json['date'] as String,
      paymentType: json['payment_type'] as String,
      paymentMethod: json['payment_method'] as String,
    );

Map<String, dynamic> _$UpdatedPaymentToJson(UpdatedPayment instance) =>
    <String, dynamic>{
      'name': instance.name,
      'date': instance.date,
      'payment_type': instance.paymentType,
      'payment_method': instance.paymentMethod,
    };

PaymentListResponseModel _$PaymentListResponseModelFromJson(
        Map<String, dynamic> json) =>
    PaymentListResponseModel(
      payments: (json['payments'] as List<dynamic>)
          .map((e) => UpdatedPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['total_count'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaymentListResponseModelToJson(
        PaymentListResponseModel instance) =>
    <String, dynamic>{
      'payments': instance.payments,
      'total_count': instance.totalCount,
      'current_page': instance.currentPage,
      'total_pages': instance.totalPages,
    };
