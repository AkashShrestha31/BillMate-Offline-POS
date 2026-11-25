// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'previous_stock_details_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreviousStockDetailsRequestParamsImpl
    _$$PreviousStockDetailsRequestParamsImplFromJson(
            Map<String, dynamic> json) =>
        _$PreviousStockDetailsRequestParamsImpl(
          reportingDate: json['reporting_date'] as String,
          batchNumber: json['batch_number'] as String?,
          item: json['item'] as String?,
          location: json['location'] as String?,
        );

Map<String, dynamic> _$$PreviousStockDetailsRequestParamsImplToJson(
        _$PreviousStockDetailsRequestParamsImpl instance) =>
    <String, dynamic>{
      'reporting_date': instance.reportingDate,
      'batch_number': instance.batchNumber,
      'item': instance.item,
      'location': instance.location,
    };
