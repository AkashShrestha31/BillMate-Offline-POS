import 'package:freezed_annotation/freezed_annotation.dart';

part 'advance_analysis_response.freezed.dart';
part 'advance_analysis_response.g.dart';

/// API may return [employee_id] as int, num, or string (e.g. `"9"`).
int? _filtersEmployeeIdFromJson(Object? value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

@freezed
class AdvanceAnalysisResponse with _$AdvanceAnalysisResponse {
  const factory AdvanceAnalysisResponse({
    @JsonKey(name: 'analysis_data')
    required List<AdvanceAnalysisData> analysisData,
    required AdvanceSummary summary,
    @JsonKey(name: 'top_employees') required List<TopEmployee> topEmployees,
    @JsonKey(name: 'top_departments') required List<TopDepartment> topDepartments,
    @JsonKey(name: 'filters_applied') required FiltersApplied filtersApplied,
    required AdvanceMetadata metadata,
  }) = _AdvanceAnalysisResponse;

  factory AdvanceAnalysisResponse.fromJson(Map<String, dynamic> json) =>
      _$AdvanceAnalysisResponseFromJson(json);
}

@freezed
class AdvanceAnalysisData with _$AdvanceAnalysisData {
  const factory AdvanceAnalysisData({
    @JsonKey(name: 'employee_id') required int employeeId,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'party_id') required String partyId,
    required String department,
    required String position,
    @JsonKey(name: 'basic_salary') required double basicSalary,
    @JsonKey(name: 'invoice_count') required int invoiceCount,
    @JsonKey(name: 'total_quantity') required int totalQuantity,
    @JsonKey(name: 'total_amount') required double totalAmount,
    @JsonKey(name: 'average_amount') required double averageAmount,
    @JsonKey(name: 'average_rate') required double averageRate,
    @JsonKey(name: 'total_discount') required double totalDiscount,
    @JsonKey(name: 'first_purchase_date') required DateTime firstPurchaseDate,
    @JsonKey(name: 'last_purchase_date') required DateTime lastPurchaseDate,
    required List<Invoice> invoices,
  }) = _AdvanceAnalysisData;

  factory AdvanceAnalysisData.fromJson(Map<String, dynamic> json) =>
      _$AdvanceAnalysisDataFromJson(json);
}

@freezed
class Invoice with _$Invoice {
  const factory Invoice({
    @JsonKey(name: 'invoice_name') required String invoiceName,
    @JsonKey(name: 'number_series') required String numberSeries,
    @JsonKey(name: 'supplier_name') required String supplierName,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'invoice_date') required DateTime invoiceDate,
    @JsonKey(name: 'grand_total') required String grandTotal,
    @JsonKey(name: 'net_total') required String netTotal,
    @JsonKey(name: 'base_grand_total') required String baseGrandTotal,
    @JsonKey(name: 'discount_amount') required String discountAmount,
    @JsonKey(name: 'discount_percent') required int discountPercent,
    @JsonKey(name: 'outstanding_amount') required String outstandingAmount,
    required String currency,
    @JsonKey(name: 'exchange_rate') required int exchangeRate,
    @JsonKey(name: 'is_submitted') required int isSubmitted,
    @JsonKey(name: 'created_date') required DateTime createdDate,
    @JsonKey(name: 'created_by') required String createdBy,
  }) = _Invoice;

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
}

@freezed
class AdvanceSummary with _$AdvanceSummary {
  const factory AdvanceSummary({
    @JsonKey(name: 'total_invoices') required int totalInvoices,
    @JsonKey(name: 'total_employees') required int totalEmployees,
    @JsonKey(name: 'total_departments') required int totalDepartments,
    @JsonKey(name: 'total_items') required int totalItems,
    @JsonKey(name: 'grand_total_amount') required double grandTotalAmount,
    @JsonKey(name: 'grand_total_quantity') required int grandTotalQuantity,
    @JsonKey(name: 'overall_average_amount')
    required double overallAverageAmount,
    @JsonKey(name: 'grand_total_discount') required double grandTotalDiscount,
    @JsonKey(name: 'earliest_purchase') DateTime? earliestPurchase,
    @JsonKey(name: 'latest_purchase') DateTime? latestPurchase,
  }) = _AdvanceSummary;

  factory AdvanceSummary.fromJson(Map<String, dynamic> json) =>
      _$AdvanceSummaryFromJson(json);
}

@freezed
class TopEmployee with _$TopEmployee {
  const factory TopEmployee({
    @JsonKey(name: 'employee_name') String? employeeName,
    @JsonKey(name: 'employee_code') String? employeeCode,
    String? department,
    @JsonKey(name: 'total_amount') double? totalAmount,
    @JsonKey(name: 'total_quantity') int? totalQuantity,
    @JsonKey(name: 'invoice_count') int? invoiceCount,
  }) = _TopEmployee;

  factory TopEmployee.fromJson(Map<String, dynamic> json) =>
      _$TopEmployeeFromJson(json);
}

@freezed
class TopDepartment with _$TopDepartment {
  const factory TopDepartment({
    required String department,
    @JsonKey(name: 'employee_count') required int employeeCount,
    @JsonKey(name: 'total_amount') required double totalAmount,
    @JsonKey(name: 'total_quantity') required int totalQuantity,
    @JsonKey(name: 'invoice_count') required int invoiceCount,
  }) = _TopDepartment;

  factory TopDepartment.fromJson(Map<String, dynamic> json) =>
      _$TopDepartmentFromJson(json);
}

@freezed
class FiltersApplied with _$FiltersApplied {
  const factory FiltersApplied({
    required List<String>? employees,
    @JsonKey(name: 'employee_id', fromJson: _filtersEmployeeIdFromJson)
    required int? employeeId,
    @JsonKey(name: 'item_search') required String? itemSearch,
    @JsonKey(name: 'start_date') required String? startDate,
    @JsonKey(name: 'end_date') required String? endDate,
    @JsonKey(name: 'group_by') required String groupBy,
    @JsonKey(name: 'sort_by') required String sortBy,
    @JsonKey(name: 'sort_order') required String sortOrder,
    required int? limit,
  }) = _FiltersApplied;

  factory FiltersApplied.fromJson(Map<String, dynamic> json) =>
      _$FiltersAppliedFromJson(json);
}

@freezed
class AdvanceMetadata with _$AdvanceMetadata {
  const factory AdvanceMetadata({
    @JsonKey(name: 'total_records') required int totalRecords,
    @JsonKey(name: 'group_by') required String groupBy,
    @JsonKey(name: 'has_limit') required bool hasLimit,
  }) = _AdvanceMetadata;

  factory AdvanceMetadata.fromJson(Map<String, dynamic> json) =>
      _$AdvanceMetadataFromJson(json);
}