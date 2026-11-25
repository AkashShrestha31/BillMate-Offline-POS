import 'package:freezed_annotation/freezed_annotation.dart';

part 'payroll_model.freezed.dart';
part 'payroll_model.g.dart';

@freezed
class PayrollModel with _$PayrollModel {
  const factory PayrollModel({
    required int id,
    @JsonKey(name: 'employee_id') required int employeeId,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'payroll_month') required String payrollMonth,
    @JsonKey(name: 'pay_period_start') required String payPeriodStart,
    @JsonKey(name: 'pay_period_end') required String payPeriodEnd,
    @JsonKey(name: 'total_working_days') required int totalWorkingDays,
    @JsonKey(name: 'days_present') required int daysPresent,
    @JsonKey(name: 'days_absent') required int daysAbsent,
    @JsonKey(name: 'sick_days') required int sickDays,
    @JsonKey(name: 'vacation_days') required int vacationDays,
    @JsonKey(name: 'total_hours_worked') required double totalHoursWorked,
    @JsonKey(name: 'regular_hours') required double regularHours,
    @JsonKey(name: 'overtime_hours') required double overtimeHours,
    @JsonKey(name: 'basic_salary') required double basicSalary,
    @JsonKey(name: 'overtime_pay') required double overtimePay,
    required double allowances,
    required double bonus,
    @JsonKey(name: 'gross_pay') required double grossPay,
    @JsonKey(name: 'tax_deduction') required double taxDeduction,
    @JsonKey(name: 'insurance_deduction') required double insuranceDeduction,
    @JsonKey(name: 'provident_fund') required double providentFund,
    @JsonKey(name: 'other_deductions') required double otherDeductions,
    @JsonKey(name: 'total_deductions') required double totalDeductions,
    @JsonKey(name: 'net_pay') required double netPay,
    @JsonKey(name: 'payment_date') String? paymentDate,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'payment_status') required String paymentStatus,
    @JsonKey(name: 'bank_reference') String? bankReference,
    String? notes,
    @JsonKey(name: 'is_approved') required bool isApproved,
    String? created,
    String? modified,
  }) = _PayrollModel;

  factory PayrollModel.fromJson(Map<String, dynamic> json) =>
      _$PayrollModelFromJson(json);
}
