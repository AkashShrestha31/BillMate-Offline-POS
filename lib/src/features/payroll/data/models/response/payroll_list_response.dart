import 'package:freezed_annotation/freezed_annotation.dart';
import 'payroll_model.dart';
import 'payroll_summary_model.dart';
import 'filters_applied_model.dart';

part 'payroll_list_response.freezed.dart';
part 'payroll_list_response.g.dart';

@freezed
class PayrollListResponse with _$PayrollListResponse {
  const factory PayrollListResponse({
    required bool success,
    required int count,
    required PayrollSummaryModel summary,
    @JsonKey(name: 'filters_applied') required FiltersAppliedModel filtersApplied,
    @JsonKey(name: 'payroll_records') required List<PayrollModel> payrollRecords,
  }) = _PayrollListResponse;

  factory PayrollListResponse.fromJson(Map<String, dynamic> json) =>
      _$PayrollListResponseFromJson(json);
}