// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_expense_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateExpenseRequestParams _$CreateExpenseRequestParamsFromJson(
        Map<String, dynamic> json) =>
    CreateExpenseRequestParams(
      expenseNumber: json['expense_number'] as String,
      date: json['date'] as String,
      category: json['category'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              CreateExpenseItemParams.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      paymentMode: json['payment_mode'] as String,
      notes: json['notes'] as String?,
      imageUrls: (json['image_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CreateExpenseRequestParamsToJson(
        CreateExpenseRequestParams instance) =>
    <String, dynamic>{
      'expense_number': instance.expenseNumber,
      'date': instance.date,
      'category': instance.category,
      'items': instance.items,
      'total_amount': instance.totalAmount,
      'payment_mode': instance.paymentMode,
      if (instance.notes case final value?) 'notes': value,
      if (instance.imageUrls case final value?) 'image_urls': value,
    };

CreateExpenseItemParams _$CreateExpenseItemParamsFromJson(
        Map<String, dynamic> json) =>
    CreateExpenseItemParams(
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$CreateExpenseItemParamsToJson(
        CreateExpenseItemParams instance) =>
    <String, dynamic>{
      'description': instance.description,
      'amount': instance.amount,
    };
