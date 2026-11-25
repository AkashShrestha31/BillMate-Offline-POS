// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'previous_stock_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviousStockResponseModel _$PreviousStockResponseModelFromJson(
        Map<String, dynamic> json) =>
    PreviousStockResponseModel(
      uniqueReportingDates: (json['unique_reporting_dates'] as List<dynamic>)
          .map((e) => ReportingDateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalUniqueDates: (json['total_unique_dates'] as num).toInt(),
      returnedCount: (json['returned_count'] as num).toInt(),
      filtersApplied: FiltersAppliedModel.fromJson(
          json['filters_applied'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreviousStockResponseModelToJson(
        PreviousStockResponseModel instance) =>
    <String, dynamic>{
      'unique_reporting_dates': instance.uniqueReportingDates,
      'total_unique_dates': instance.totalUniqueDates,
      'returned_count': instance.returnedCount,
      'filters_applied': instance.filtersApplied,
    };

ReportingDateModel _$ReportingDateModelFromJson(Map<String, dynamic> json) =>
    ReportingDateModel(
      reportingDate: json['reporting_date'] as String,
      recordCount: (json['record_count'] as num).toInt(),
      uniqueItems: (json['unique_items'] as num).toInt(),
      uniqueLocations: (json['unique_locations'] as num).toInt(),
      totalQuantity: (json['total_quantity'] as num).toInt(),
      totalValue: (json['total_value'] as num).toDouble(),
      uploadersCount: (json['uploaders_count'] as num).toInt(),
    );

Map<String, dynamic> _$ReportingDateModelToJson(ReportingDateModel instance) =>
    <String, dynamic>{
      'reporting_date': instance.reportingDate,
      'record_count': instance.recordCount,
      'unique_items': instance.uniqueItems,
      'unique_locations': instance.uniqueLocations,
      'total_quantity': instance.totalQuantity,
      'total_value': instance.totalValue,
      'uploaders_count': instance.uploadersCount,
    };

FiltersAppliedModel _$FiltersAppliedModelFromJson(Map<String, dynamic> json) =>
    FiltersAppliedModel(
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      locations: json['locations'] as String?,
      items: json['items'] as String?,
      sortOrder: json['sort_order'] as String,
      limit: json['limit'] as String?,
      onlyActive: json['only_active'] as bool,
    );

Map<String, dynamic> _$FiltersAppliedModelToJson(
        FiltersAppliedModel instance) =>
    <String, dynamic>{
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'locations': instance.locations,
      'items': instance.items,
      'sort_order': instance.sortOrder,
      'limit': instance.limit,
      'only_active': instance.onlyActive,
    };
