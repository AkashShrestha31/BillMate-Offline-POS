import 'package:freezed_annotation/freezed_annotation.dart';

part 'payroll_query_params.freezed.dart';
part 'payroll_query_params.g.dart';

@freezed
class PayrollQueryParams with _$PayrollQueryParams {
  const factory PayrollQueryParams({
    @JsonKey(name: 'employee_id') int? employeeId,
    @JsonKey(name: 'payroll_month') String? payrollMonth,
    @JsonKey(name: 'payment_status') String? paymentStatus,
    int? year,
    int? page,
    @JsonKey(name: 'per_page') int? perPage,
  }) = _PayrollQueryParams;

  factory PayrollQueryParams.fromJson(Map<String, dynamic> json) =>
      _$PayrollQueryParamsFromJson(json);
}
