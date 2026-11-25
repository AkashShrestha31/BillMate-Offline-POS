import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_payroll_response.freezed.dart';
part 'delete_payroll_response.g.dart';

@freezed
class DeletePayrollResponse with _$DeletePayrollResponse {
  const factory DeletePayrollResponse({
    required bool success,
    required String message,
  }) = _DeletePayrollResponse;

  factory DeletePayrollResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePayrollResponseFromJson(json);
}
