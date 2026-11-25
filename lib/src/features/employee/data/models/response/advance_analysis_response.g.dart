// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advance_analysis_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdvanceAnalysisResponseImpl _$$AdvanceAnalysisResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AdvanceAnalysisResponseImpl(
      analysisData: (json['analysis_data'] as List<dynamic>)
          .map((e) => AdvanceAnalysisData.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: AdvanceSummary.fromJson(json['summary'] as Map<String, dynamic>),
      topEmployees: (json['top_employees'] as List<dynamic>)
          .map((e) => TopEmployee.fromJson(e as Map<String, dynamic>))
          .toList(),
      topDepartments: (json['top_departments'] as List<dynamic>)
          .map((e) => TopDepartment.fromJson(e as Map<String, dynamic>))
          .toList(),
      filtersApplied: FiltersApplied.fromJson(
          json['filters_applied'] as Map<String, dynamic>),
      metadata:
          AdvanceMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AdvanceAnalysisResponseImplToJson(
        _$AdvanceAnalysisResponseImpl instance) =>
    <String, dynamic>{
      'analysis_data': instance.analysisData,
      'summary': instance.summary,
      'top_employees': instance.topEmployees,
      'top_departments': instance.topDepartments,
      'filters_applied': instance.filtersApplied,
      'metadata': instance.metadata,
    };

_$AdvanceAnalysisDataImpl _$$AdvanceAnalysisDataImplFromJson(
        Map<String, dynamic> json) =>
    _$AdvanceAnalysisDataImpl(
      employeeId: (json['employee_id'] as num).toInt(),
      employeeCode: json['employee_code'] as String,
      employeeName: json['employee_name'] as String,
      partyId: json['party_id'] as String,
      department: json['department'] as String,
      position: json['position'] as String,
      basicSalary: (json['basic_salary'] as num).toDouble(),
      invoiceCount: (json['invoice_count'] as num).toInt(),
      totalQuantity: (json['total_quantity'] as num).toInt(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      averageAmount: (json['average_amount'] as num).toDouble(),
      averageRate: (json['average_rate'] as num).toDouble(),
      totalDiscount: (json['total_discount'] as num).toDouble(),
      firstPurchaseDate: DateTime.parse(json['first_purchase_date'] as String),
      lastPurchaseDate: DateTime.parse(json['last_purchase_date'] as String),
      invoices: (json['invoices'] as List<dynamic>)
          .map((e) => Invoice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AdvanceAnalysisDataImplToJson(
        _$AdvanceAnalysisDataImpl instance) =>
    <String, dynamic>{
      'employee_id': instance.employeeId,
      'employee_code': instance.employeeCode,
      'employee_name': instance.employeeName,
      'party_id': instance.partyId,
      'department': instance.department,
      'position': instance.position,
      'basic_salary': instance.basicSalary,
      'invoice_count': instance.invoiceCount,
      'total_quantity': instance.totalQuantity,
      'total_amount': instance.totalAmount,
      'average_amount': instance.averageAmount,
      'average_rate': instance.averageRate,
      'total_discount': instance.totalDiscount,
      'first_purchase_date': instance.firstPurchaseDate.toIso8601String(),
      'last_purchase_date': instance.lastPurchaseDate.toIso8601String(),
      'invoices': instance.invoices,
    };

_$InvoiceImpl _$$InvoiceImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceImpl(
      invoiceName: json['invoice_name'] as String,
      numberSeries: json['number_series'] as String,
      supplierName: json['supplier_name'] as String,
      employeeName: json['employee_name'] as String,
      employeeCode: json['employee_code'] as String,
      invoiceDate: DateTime.parse(json['invoice_date'] as String),
      grandTotal: json['grand_total'] as String,
      netTotal: json['net_total'] as String,
      baseGrandTotal: json['base_grand_total'] as String,
      discountAmount: json['discount_amount'] as String,
      discountPercent: (json['discount_percent'] as num).toInt(),
      outstandingAmount: json['outstanding_amount'] as String,
      currency: json['currency'] as String,
      exchangeRate: (json['exchange_rate'] as num).toInt(),
      isSubmitted: (json['is_submitted'] as num).toInt(),
      createdDate: DateTime.parse(json['created_date'] as String),
      createdBy: json['created_by'] as String,
    );

Map<String, dynamic> _$$InvoiceImplToJson(_$InvoiceImpl instance) =>
    <String, dynamic>{
      'invoice_name': instance.invoiceName,
      'number_series': instance.numberSeries,
      'supplier_name': instance.supplierName,
      'employee_name': instance.employeeName,
      'employee_code': instance.employeeCode,
      'invoice_date': instance.invoiceDate.toIso8601String(),
      'grand_total': instance.grandTotal,
      'net_total': instance.netTotal,
      'base_grand_total': instance.baseGrandTotal,
      'discount_amount': instance.discountAmount,
      'discount_percent': instance.discountPercent,
      'outstanding_amount': instance.outstandingAmount,
      'currency': instance.currency,
      'exchange_rate': instance.exchangeRate,
      'is_submitted': instance.isSubmitted,
      'created_date': instance.createdDate.toIso8601String(),
      'created_by': instance.createdBy,
    };

_$AdvanceSummaryImpl _$$AdvanceSummaryImplFromJson(Map<String, dynamic> json) =>
    _$AdvanceSummaryImpl(
      totalInvoices: (json['total_invoices'] as num).toInt(),
      totalEmployees: (json['total_employees'] as num).toInt(),
      totalDepartments: (json['total_departments'] as num).toInt(),
      totalItems: (json['total_items'] as num).toInt(),
      grandTotalAmount: (json['grand_total_amount'] as num).toDouble(),
      grandTotalQuantity: (json['grand_total_quantity'] as num).toInt(),
      overallAverageAmount: (json['overall_average_amount'] as num).toDouble(),
      grandTotalDiscount: (json['grand_total_discount'] as num).toDouble(),
      earliestPurchase: json['earliest_purchase'] == null
          ? null
          : DateTime.parse(json['earliest_purchase'] as String),
      latestPurchase: json['latest_purchase'] == null
          ? null
          : DateTime.parse(json['latest_purchase'] as String),
    );

Map<String, dynamic> _$$AdvanceSummaryImplToJson(
        _$AdvanceSummaryImpl instance) =>
    <String, dynamic>{
      'total_invoices': instance.totalInvoices,
      'total_employees': instance.totalEmployees,
      'total_departments': instance.totalDepartments,
      'total_items': instance.totalItems,
      'grand_total_amount': instance.grandTotalAmount,
      'grand_total_quantity': instance.grandTotalQuantity,
      'overall_average_amount': instance.overallAverageAmount,
      'grand_total_discount': instance.grandTotalDiscount,
      'earliest_purchase': instance.earliestPurchase?.toIso8601String(),
      'latest_purchase': instance.latestPurchase?.toIso8601String(),
    };

_$TopEmployeeImpl _$$TopEmployeeImplFromJson(Map<String, dynamic> json) =>
    _$TopEmployeeImpl(
      employeeName: json['employee_name'] as String?,
      employeeCode: json['employee_code'] as String?,
      department: json['department'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      totalQuantity: (json['total_quantity'] as num?)?.toInt(),
      invoiceCount: (json['invoice_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TopEmployeeImplToJson(_$TopEmployeeImpl instance) =>
    <String, dynamic>{
      'employee_name': instance.employeeName,
      'employee_code': instance.employeeCode,
      'department': instance.department,
      'total_amount': instance.totalAmount,
      'total_quantity': instance.totalQuantity,
      'invoice_count': instance.invoiceCount,
    };

_$TopDepartmentImpl _$$TopDepartmentImplFromJson(Map<String, dynamic> json) =>
    _$TopDepartmentImpl(
      department: json['department'] as String,
      employeeCount: (json['employee_count'] as num).toInt(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      totalQuantity: (json['total_quantity'] as num).toInt(),
      invoiceCount: (json['invoice_count'] as num).toInt(),
    );

Map<String, dynamic> _$$TopDepartmentImplToJson(_$TopDepartmentImpl instance) =>
    <String, dynamic>{
      'department': instance.department,
      'employee_count': instance.employeeCount,
      'total_amount': instance.totalAmount,
      'total_quantity': instance.totalQuantity,
      'invoice_count': instance.invoiceCount,
    };

_$FiltersAppliedImpl _$$FiltersAppliedImplFromJson(Map<String, dynamic> json) =>
    _$FiltersAppliedImpl(
      employees: (json['employees'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      employeeId: _filtersEmployeeIdFromJson(json['employee_id']),
      itemSearch: json['item_search'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      groupBy: json['group_by'] as String,
      sortBy: json['sort_by'] as String,
      sortOrder: json['sort_order'] as String,
      limit: (json['limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FiltersAppliedImplToJson(
        _$FiltersAppliedImpl instance) =>
    <String, dynamic>{
      'employees': instance.employees,
      'employee_id': instance.employeeId,
      'item_search': instance.itemSearch,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'group_by': instance.groupBy,
      'sort_by': instance.sortBy,
      'sort_order': instance.sortOrder,
      'limit': instance.limit,
    };

_$AdvanceMetadataImpl _$$AdvanceMetadataImplFromJson(
        Map<String, dynamic> json) =>
    _$AdvanceMetadataImpl(
      totalRecords: (json['total_records'] as num).toInt(),
      groupBy: json['group_by'] as String,
      hasLimit: json['has_limit'] as bool,
    );

Map<String, dynamic> _$$AdvanceMetadataImplToJson(
        _$AdvanceMetadataImpl instance) =>
    <String, dynamic>{
      'total_records': instance.totalRecords,
      'group_by': instance.groupBy,
      'has_limit': instance.hasLimit,
    };
