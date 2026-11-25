// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_outstanding_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeOutstandingRequestParams _$EmployeeOutstandingRequestParamsFromJson(
        Map<String, dynamic> json) =>
    EmployeeOutstandingRequestParams(
      acceptLanguage: json['accept_language'] as String? ?? 'en',
      endDate: json['end_date'] as String?,
      partyRole: json['party_role'] as String? ?? 'all',
      searchTerm: json['search_term'] as String? ?? '',
      startDate: json['start_date'] as String?,
      outstandingOnly: json['outstanding_only'] as bool? ?? true,
      employeeId: (json['employee_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EmployeeOutstandingRequestParamsToJson(
        EmployeeOutstandingRequestParams instance) =>
    <String, dynamic>{
      'accept_language': instance.acceptLanguage,
      'end_date': instance.endDate,
      'party_role': instance.partyRole,
      'search_term': instance.searchTerm,
      'start_date': instance.startDate,
      'outstanding_only': instance.outstandingOnly,
      'employee_id': instance.employeeId,
    };
