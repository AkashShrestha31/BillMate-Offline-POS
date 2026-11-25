// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_outstanding_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeOutstandingResponseImpl _$$EmployeeOutstandingResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeeOutstandingResponseImpl(
      searchDetails: SearchDetails.fromJson(
          json['search_details'] as Map<String, dynamic>),
      roleSummary:
          RoleSummary.fromJson(json['role_summary'] as Map<String, dynamic>),
      outstandingByRole: OutstandingByRole.fromJson(
          json['outstanding_by_role'] as Map<String, dynamic>),
      partiesByRole: PartiesByRole.fromJson(
          json['parties_by_role'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EmployeeOutstandingResponseImplToJson(
        _$EmployeeOutstandingResponseImpl instance) =>
    <String, dynamic>{
      'search_details': instance.searchDetails,
      'role_summary': instance.roleSummary,
      'outstanding_by_role': instance.outstandingByRole,
      'parties_by_role': instance.partiesByRole,
    };

_$SearchDetailsImpl _$$SearchDetailsImplFromJson(Map<String, dynamic> json) =>
    _$SearchDetailsImpl(
      searchTerm: json['search_term'] as String,
      partyRoleFilter: json['party_role_filter'] as String,
      totalFound: (json['total_found'] as num).toInt(),
    );

Map<String, dynamic> _$$SearchDetailsImplToJson(_$SearchDetailsImpl instance) =>
    <String, dynamic>{
      'search_term': instance.searchTerm,
      'party_role_filter': instance.partyRoleFilter,
      'total_found': instance.totalFound,
    };

_$RoleSummaryImpl _$$RoleSummaryImplFromJson(Map<String, dynamic> json) =>
    _$RoleSummaryImpl(
      customerCount: (json['customer_count'] as num).toInt(),
      supplierCount: (json['supplier_count'] as num).toInt(),
      employeeCount: (json['employee_count'] as num).toInt(),
      otherCount: (json['other_count'] as num).toInt(),
      totalOutstanding: (json['total_outstanding'] as num).toDouble(),
    );

Map<String, dynamic> _$$RoleSummaryImplToJson(_$RoleSummaryImpl instance) =>
    <String, dynamic>{
      'customer_count': instance.customerCount,
      'supplier_count': instance.supplierCount,
      'employee_count': instance.employeeCount,
      'other_count': instance.otherCount,
      'total_outstanding': instance.totalOutstanding,
    };

_$OutstandingByRoleImpl _$$OutstandingByRoleImplFromJson(
        Map<String, dynamic> json) =>
    _$OutstandingByRoleImpl(
      customerOutstanding: (json['customer_outstanding'] as num).toDouble(),
      supplierOutstanding: (json['supplier_outstanding'] as num).toDouble(),
      employeeOutstanding: (json['employee_outstanding'] as num).toDouble(),
      otherOutstanding: (json['other_outstanding'] as num).toDouble(),
    );

Map<String, dynamic> _$$OutstandingByRoleImplToJson(
        _$OutstandingByRoleImpl instance) =>
    <String, dynamic>{
      'customer_outstanding': instance.customerOutstanding,
      'supplier_outstanding': instance.supplierOutstanding,
      'employee_outstanding': instance.employeeOutstanding,
      'other_outstanding': instance.otherOutstanding,
    };

_$PartiesByRoleImpl _$$PartiesByRoleImplFromJson(Map<String, dynamic> json) =>
    _$PartiesByRoleImpl(
      customerParties: (json['customer_parties'] as List<dynamic>)
          .map((e) => Party.fromJson(e as Map<String, dynamic>))
          .toList(),
      supplierParties: (json['supplier_parties'] as List<dynamic>)
          .map((e) => Party.fromJson(e as Map<String, dynamic>))
          .toList(),
      employeeParties: (json['employee_parties'] as List<dynamic>)
          .map((e) => Party.fromJson(e as Map<String, dynamic>))
          .toList(),
      otherParties: (json['other_parties'] as List<dynamic>)
          .map((e) => Party.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PartiesByRoleImplToJson(_$PartiesByRoleImpl instance) =>
    <String, dynamic>{
      'customer_parties': instance.customerParties,
      'supplier_parties': instance.supplierParties,
      'employee_parties': instance.employeeParties,
      'other_parties': instance.otherParties,
    };

_$PartyImpl _$$PartyImplFromJson(Map<String, dynamic> json) => _$PartyImpl(
      name: json['name'] as String,
      role: json['role'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      currency: json['currency'] as String,
      outstandingAmount: (json['outstanding_amount'] as num).toDouble(),
      outstandingByRole: OutstandingByRole.fromJson(
          json['outstanding_by_role'] as Map<String, dynamic>),
      created: DateTime.parse(json['created'] as String),
      modified: DateTime.parse(json['modified'] as String),
    );

Map<String, dynamic> _$$PartyImplToJson(_$PartyImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
      'email': instance.email,
      'phone': instance.phone,
      'currency': instance.currency,
      'outstanding_amount': instance.outstandingAmount,
      'outstanding_by_role': instance.outstandingByRole,
      'created': instance.created.toIso8601String(),
      'modified': instance.modified.toIso8601String(),
    };
