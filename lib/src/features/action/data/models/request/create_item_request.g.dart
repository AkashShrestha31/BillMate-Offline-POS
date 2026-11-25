// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_item_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateItemRequest _$CreateItemRequestFromJson(Map<String, dynamic> json) =>
    CreateItemRequest(
      id: json['id'] as String?,
      name: json['name'] as String,
      newName: json['new_name'] as String?,
      itemType: json['item_type'] as String?,
      forFilter: json['for'] as String,
      unit: json['unit'] as String,
      rate: (json['rate'] as num).toDouble(),
      totalSales: (json['total_sales'] as num?)?.toInt(),
      description: json['description'] as String?,
      hsnCode: json['hsn_code'] as String?,
      barcode: json['barcode'] as String?,
      incomeAccount: json['income_account'] as String?,
      expenseAccount: json['expense_account'] as String?,
      tax: json['tax'] as String?,
      trackItem: (json['track_item'] as num?)?.toInt(),
      hasBatch: (json['has_batch'] as num?)?.toInt(),
      hasSerialNumber: (json['has_serial_number'] as num?)?.toInt(),
      image: json['image'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$CreateItemRequestToJson(CreateItemRequest instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      'name': instance.name,
      if (instance.newName case final value?) 'new_name': value,
      if (instance.itemType case final value?) 'item_type': value,
      'for': instance.forFilter,
      'unit': instance.unit,
      'rate': instance.rate,
      if (instance.totalSales case final value?) 'total_sales': value,
      if (instance.description case final value?) 'description': value,
      if (instance.hsnCode case final value?) 'hsn_code': value,
      if (instance.barcode case final value?) 'barcode': value,
      if (instance.incomeAccount case final value?) 'income_account': value,
      if (instance.expenseAccount case final value?) 'expense_account': value,
      if (instance.tax case final value?) 'tax': value,
      if (instance.trackItem case final value?) 'track_item': value,
      if (instance.hasBatch case final value?) 'has_batch': value,
      if (instance.hasSerialNumber case final value?)
        'has_serial_number': value,
      if (instance.image case final value?) 'image': value,
      if (instance.createdBy case final value?) 'created_by': value,
      if (instance.createdAt case final value?) 'created_at': value,
      if (instance.updatedAt case final value?) 'updated_at': value,
      if (instance.category case final value?) 'category': value,
    };
