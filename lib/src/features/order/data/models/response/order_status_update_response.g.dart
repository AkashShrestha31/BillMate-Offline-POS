// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderStatusUpdateResponseImpl _$$OrderStatusUpdateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderStatusUpdateResponseImpl(
      message: json['message'] as String?,
      name: json['name'] as String?,
      orderStatus: json['order_status'] as String?,
      salesInvoiceName: json['sales_invoice_name'] as String?,
      netTotal: _netTotalFromJson(json['net_total']),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$OrderStatusUpdateResponseImplToJson(
        _$OrderStatusUpdateResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'name': instance.name,
      'order_status': instance.orderStatus,
      'sales_invoice_name': instance.salesInvoiceName,
      'net_total': instance.netTotal,
      'note': instance.note,
    };
