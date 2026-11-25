// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_item_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteItemRequest _$DeleteItemRequestFromJson(Map<String, dynamic> json) =>
    DeleteItemRequest(
      itemName: json['item_name'] as String,
      confirmDelete: json['confirm_delete'] as bool,
      forceDelete: json['force_delete'] as bool,
      deleteStockEntries: json['delete_stock_entries'] as bool,
      deletedBy: json['deleted_by'] as String,
    );

Map<String, dynamic> _$DeleteItemRequestToJson(DeleteItemRequest instance) =>
    <String, dynamic>{
      'item_name': instance.itemName,
      'confirm_delete': instance.confirmDelete,
      'force_delete': instance.forceDelete,
      'delete_stock_entries': instance.deleteStockEntries,
      'deleted_by': instance.deletedBy,
    };
