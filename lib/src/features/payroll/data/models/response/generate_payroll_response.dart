import 'package:freezed_annotation/freezed_annotation.dart';
import 'payroll_model.dart';

part 'generate_payroll_response.freezed.dart';
part 'generate_payroll_response.g.dart';

@freezed
class GeneratePayrollResponse with _$GeneratePayrollResponse {
  const factory GeneratePayrollResponse({
    required bool success,
    required String message,
    required PayrollModel payroll,
  }) = _GeneratePayrollResponse;

  factory GeneratePayrollResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneratePayrollResponseFromJson(json);
}
