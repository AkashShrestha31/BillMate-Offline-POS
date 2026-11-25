import 'package:freezed_annotation/freezed_annotation.dart';

part 'filters_applied_model.freezed.dart';
part 'filters_applied_model.g.dart';

@freezed
class FiltersAppliedModel with _$FiltersAppliedModel {
  const factory FiltersAppliedModel({
    @JsonKey(name: 'employee_id') int? employeeId,
    @JsonKey(name: 'payroll_month') String? payrollMonth,
    @JsonKey(name: 'payment_status') String? paymentStatus,
    int? year,
  }) = _FiltersAppliedModel;

  factory FiltersAppliedModel.fromJson(Map<String, dynamic> json) =>
      _$FiltersAppliedModelFromJson(json);
}
