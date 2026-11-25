import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_model.freezed.dart';
part 'employee_model.g.dart';

/// API may return `is_active` as bool (`true`/`false`) or legacy int (`0`/`1`).
bool? employeeIsActiveFromJson(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is num) return value != 0;
  return null;
}

@freezed
class EmployeeModel with _$EmployeeModel {
  const factory EmployeeModel({
    required int id,
    @JsonKey(name: 'employee_code') required String employeeCode,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'full_name') required String fullName,
    String? email, // ✅ FIXED: Made nullable to handle null from API
    String? phone,
    String? address,
    @JsonKey(name: 'date_of_birth') String? dateOfBirth,
    @JsonKey(name: 'hire_date') required String hireDate,
    required String department,
    required String position,
    @JsonKey(name: 'employment_type') required String employmentType,
    @JsonKey(name: 'employment_status') required String employmentStatus,
    @JsonKey(name: 'basic_salary') required double basicSalary,
    @JsonKey(name: 'hourly_rate') double? hourlyRate,
    @JsonKey(name: 'working_hours_per_day') double? workingHoursPerDay,
    @JsonKey(name: 'working_days_per_week') int? workingDaysPerWeek,
    @JsonKey(name: 'manager_id') int? managerId,
    @JsonKey(name: 'manager_name') String? managerName,
    @JsonKey(name: 'emergency_contact_name') String? emergencyContactName,
    @JsonKey(name: 'emergency_contact_phone') String? emergencyContactPhone,
    @JsonKey(name: 'bank_account_number') String? bankAccountNumber,
    @JsonKey(name: 'bank_name') String? bankName,
    @JsonKey(name: 'national_id') String? nationalId,
    @JsonKey(name: 'tax_id') String? taxId,
    @JsonKey(name: 'profile_image') String? profileImage,
    String? notes,
    @JsonKey(name: 'is_active', fromJson: employeeIsActiveFromJson) bool? isActive,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'modified_by') String? modifiedBy,
    String? created,
    String? modified,
  }) = _EmployeeModel;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);
}

extension EmployeeModelDisplay on EmployeeModel {
  /// Prefer first + last name; [fullName] can be stale after edits in local DB.
  String get displayName {
    final composed = '$firstName $lastName'.trim();
    return composed.isNotEmpty ? composed : fullName;
  }
}