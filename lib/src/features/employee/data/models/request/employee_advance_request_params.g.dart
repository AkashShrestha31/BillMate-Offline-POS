// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_advance_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeAdvanceRequestParams _$EmployeeAdvanceRequestParamsFromJson(
        Map<String, dynamic> json) =>
    EmployeeAdvanceRequestParams(
      acceptLanguage: json['accept_language'] as String? ?? 'en',
      invoiceType: json['invoice_type'] as String? ?? 'all',
      partyName: json['party_name'] as String?,
      endDate: json['end_date'] as String?,
      groupBy: json['group_by'] as String?,
      itemSearch: json['item_search'] as String?,
      items: json['items'] as String?,
      limit: (json['limit'] as num?)?.toInt(),
      sortBy: json['sort_by'] as String? ?? 'total_amount',
      sortOrder: json['sort_order'] as String? ?? 'desc',
      startDate: json['start_date'] as String?,
      suppliers: json['suppliers'] as String?,
      employeeId: (json['employee_id'] as num?)?.toInt(),
      department: json['department'] as String?,
      advanceType: json['advance_type'] as String?,
    );

Map<String, dynamic> _$EmployeeAdvanceRequestParamsToJson(
        EmployeeAdvanceRequestParams instance) =>
    <String, dynamic>{
      'accept_language': instance.acceptLanguage,
      'invoice_type': instance.invoiceType,
      'party_name': instance.partyName,
      'end_date': instance.endDate,
      'group_by': instance.groupBy,
      'item_search': instance.itemSearch,
      'items': instance.items,
      'limit': instance.limit,
      'sort_by': instance.sortBy,
      'sort_order': instance.sortOrder,
      'start_date': instance.startDate,
      'suppliers': instance.suppliers,
      'employee_id': instance.employeeId,
      'department': instance.department,
      'advance_type': instance.advanceType,
    };
