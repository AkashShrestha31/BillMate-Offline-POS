import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_request_params.freezed.dart';
part 'employee_request_params.g.dart';

@freezed
class EmployeeRequestParams with _$EmployeeRequestParams {
  const factory EmployeeRequestParams({
    @JsonKey(name: 'employee_code') String? employeeCode,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? email,
    String? phone,
    String? address,
    @JsonKey(name: 'date_of_birth') String? dateOfBirth,
    @JsonKey(name: 'hire_date') String? hireDate,
    String? department,
    String? position,
    @JsonKey(name: 'employment_type') String? employmentType,
    @JsonKey(name: 'employment_status') String? employmentStatus,
    @JsonKey(name: 'basic_salary') double? basicSalary,
    @JsonKey(name: 'hourly_rate') double? hourlyRate,
    @JsonKey(name: 'working_hours_per_day') double? workingHoursPerDay,
    @JsonKey(name: 'working_days_per_week') int? workingDaysPerWeek,
    @JsonKey(name: 'manager_id') int? managerId,
    @JsonKey(name: 'emergency_contact_name') String? emergencyContactName,
    @JsonKey(name: 'emergency_contact_phone') String? emergencyContactPhone,
    @JsonKey(name: 'bank_account_number') String? bankAccountNumber,
    @JsonKey(name: 'bank_name') String? bankName,
    @JsonKey(name: 'national_id') String? nationalId,
    @JsonKey(name: 'tax_id') String? taxId,
    String? notes,
    @JsonKey(name: 'profile_image') String? profileImage,
  }) = _EmployeeRequestParams;

  factory EmployeeRequestParams.fromJson(Map<String, dynamic> json) =>
      _$EmployeeRequestParamsFromJson(json);
}
