// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_expense_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateExpenseResponseModel _$CreateExpenseResponseModelFromJson(
        Map<String, dynamic> json) =>
    CreateExpenseResponseModel(
      message: json['message'] as String,
      expenseNumber: json['expense_number'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CreateExpenseResponseModelToJson(
        CreateExpenseResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'expense_number': instance.expenseNumber,
      'total_amount': instance.totalAmount,
      'status': instance.status,
    };
