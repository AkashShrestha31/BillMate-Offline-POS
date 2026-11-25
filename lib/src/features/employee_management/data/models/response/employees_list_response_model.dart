import 'package:freezed_annotation/freezed_annotation.dart';
import 'employee_model.dart';

part 'employees_list_response_model.freezed.dart';
part 'employees_list_response_model.g.dart';

@freezed
class EmployeesListResponseModel with _$EmployeesListResponseModel {
  const factory EmployeesListResponseModel({
    required bool success,
    required int count,
    @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
    required List<EmployeeModel> employees,
  }) = _EmployeesListResponseModel;

  factory EmployeesListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeesListResponseModelFromJson(json);
}
