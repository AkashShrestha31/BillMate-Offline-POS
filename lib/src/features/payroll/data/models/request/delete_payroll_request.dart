import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_payroll_request.freezed.dart';
part 'delete_payroll_request.g.dart';

@freezed
class DeletePayrollRequest with _$DeletePayrollRequest {
  const factory DeletePayrollRequest({
    @JsonKey(name: 'payroll_id') required int payrollId,
  }) = _DeletePayrollRequest;

  factory DeletePayrollRequest.fromJson(Map<String, dynamic> json) =>
      _$DeletePayrollRequestFromJson(json);
}
