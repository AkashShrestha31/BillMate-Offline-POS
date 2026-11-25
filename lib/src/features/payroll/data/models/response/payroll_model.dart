// payroll_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payroll_model.freezed.dart';
part 'payroll_model.g.dart';

@freezed
class PayrollModel with _$PayrollModel {
  const factory PayrollModel({
    required int id,
    @JsonKey(name: 'employee_id') int? employeeId,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'employee_code') @Default('') String employeeCode,
    @Default('') String department,
    @Default('') String position,
    @JsonKey(name: 'payroll_month') required String payrollMonth,
    @JsonKey(name: 'pay_period_start') @Default('') String payPeriodStart,
    @JsonKey(name: 'pay_period_end') @Default('') String payPeriodEnd,

    // Attendance fields - from attendance_summary
    @JsonKey(name: 'total_working_days') int? totalWorkingDays,
    @JsonKey(name: 'days_present') int? daysPresent,
    @JsonKey(name: 'days_absent') int? daysAbsent,
    @JsonKey(name: 'sick_days') int? sickDays,
    @JsonKey(name: 'vacation_days') int? vacationDays,

    // Hours fields - from hours_summary
    @JsonKey(name: 'total_hours_worked') double? totalHoursWorked,
    @JsonKey(name: 'regular_hours') double? regularHours,
    @JsonKey(name: 'overtime_hours') double? overtimeHours,

    // Earnings fields - from earnings
    @JsonKey(name: 'basic_salary') double? basicSalary,
    @JsonKey(name: 'overtime_pay') double? overtimePay,
    double? allowances,
    double? bonus,
    @JsonKey(name: 'gross_pay') double? grossPay,

    // Deductions fields - from deductions
    @JsonKey(name: 'tax_deduction') double? taxDeduction,
    @JsonKey(name: 'insurance_deduction') double? insuranceDeduction,
    @JsonKey(name: 'provident_fund') double? providentFund,
    @JsonKey(name: 'other_deductions') double? otherDeductions,
    @JsonKey(name: 'total_deductions') double? totalDeductions,
    @JsonKey(name: 'net_pay') double? netPay,

    // Payment info fields
    @JsonKey(name: 'payment_date') String? paymentDate,
    @JsonKey(name: 'payment_method') @Default('') String paymentMethod,
    @JsonKey(name: 'payment_status') @Default('') String paymentStatus,
    @JsonKey(name: 'bank_reference') String? bankReference,

    // Metadata
    String? notes,
    @JsonKey(name: 'generated_by') String? generatedBy,
    @JsonKey(name: 'approved_by') String? approvedBy,
    @JsonKey(name: 'paid_by') String? paidBy,
    @JsonKey(name: 'is_approved') @Default(false) bool isApproved,
    @Default('') String created,
    @Default('') String modified,

    // Additional fields from API response
    @JsonKey(name: 'attendance_summary') Map<String, dynamic>? attendanceSummary,
    @JsonKey(name: 'hours_summary') Map<String, dynamic>? hoursSummary,
    Map<String, dynamic>? earnings,
    Map<String, dynamic>? deductions,
  }) = _PayrollModel;

  factory PayrollModel.fromJson(Map<String, dynamic> json) =>
      _$PayrollModelFromJson(json);
}