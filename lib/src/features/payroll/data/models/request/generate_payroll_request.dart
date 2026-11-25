import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate_payroll_request.freezed.dart';
part 'generate_payroll_request.g.dart';

@freezed
class GeneratePayrollRequest with _$GeneratePayrollRequest {
  const factory GeneratePayrollRequest({
    @JsonKey(name: 'employee_id') required int employeeId,
    @JsonKey(name: 'add_bonus_day') required bool addBonusDay,
    @JsonKey(name: 'payroll_month') required String payrollMonth,
    double? bonus,
    @JsonKey(name: 'additional_allowances') double? additionalAllowances,
    @JsonKey(name: 'additional_deductions') double? additionalDeductions,
  }) = _GeneratePayrollRequest;

  factory GeneratePayrollRequest.fromJson(Map<String, dynamic> json) =>
      _$GeneratePayrollRequestFromJson(json);
}
