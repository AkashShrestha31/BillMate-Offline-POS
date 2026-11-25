import 'package:freezed_annotation/freezed_annotation.dart';

part 'payroll_summary_model.freezed.dart';
part 'payroll_summary_model.g.dart';

@freezed
class PayrollSummaryModel with _$PayrollSummaryModel {
  const factory PayrollSummaryModel({
    @JsonKey(name: 'total_gross_pay') required double totalGrossPay,
    @JsonKey(name: 'total_net_pay') required double totalNetPay,
    @JsonKey(name: 'total_deductions') @Default(0.0) double totalDeductions, // Add default
  }) = _PayrollSummaryModel;

  factory PayrollSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$PayrollSummaryModelFromJson(json);
}