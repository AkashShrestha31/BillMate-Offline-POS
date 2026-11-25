import 'package:freezed_annotation/freezed_annotation.dart';
import 'payroll_model.dart';

part 'payroll_list_response_model.freezed.dart';
part 'payroll_list_response_model.g.dart';

@freezed
class PayrollListResponseModel with _$PayrollListResponseModel {
  const factory PayrollListResponseModel({
    required bool success,
    required int count,
    Map<String, dynamic>? summary,
    @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
    @JsonKey(name: 'payroll_records') required List<PayrollModel> payrollRecords,
  }) = _PayrollListResponseModel;

  factory PayrollListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PayrollListResponseModelFromJson(json);
}
