import 'package:freezed_annotation/freezed_annotation.dart';

part 'payroll_request_params.freezed.dart';
part 'payroll_request_params.g.dart';

@freezed
class PayrollRequestParams with _$PayrollRequestParams {
  const factory PayrollRequestParams({
    @JsonKey(name: 'employee_id') required int employeeId,
    @JsonKey(name: 'payroll_month') required String payrollMonth,
    double? bonus,
    @JsonKey(name: 'additional_allowances') double? additionalAllowances,
    @JsonKey(name: 'additional_deductions') double? additionalDeductions,
  }) = _PayrollRequestParams;

  factory PayrollRequestParams.fromJson(Map<String, dynamic> json) =>
      _$PayrollRequestParamsFromJson(json);
}
