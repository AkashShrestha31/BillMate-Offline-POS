// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_request_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeRequestParamsImpl _$$EmployeeRequestParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeeRequestParamsImpl(
      employeeCode: json['employee_code'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      hireDate: json['hire_date'] as String?,
      department: json['department'] as String?,
      position: json['position'] as String?,
      employmentType: json['employment_type'] as String?,
      employmentStatus: json['employment_status'] as String?,
      basicSalary: (json['basic_salary'] as num?)?.toDouble(),
      hourlyRate: (json['hourly_rate'] as num?)?.toDouble(),
      workingHoursPerDay: (json['working_hours_per_day'] as num?)?.toDouble(),
      workingDaysPerWeek: (json['working_days_per_week'] as num?)?.toInt(),
      managerId: (json['manager_id'] as num?)?.toInt(),
      emergencyContactName: json['emergency_contact_name'] as String?,
      emergencyContactPhone: json['emergency_contact_phone'] as String?,
      bankAccountNumber: json['bank_account_number'] as String?,
      bankName: json['bank_name'] as String?,
      nationalId: json['national_id'] as String?,
      taxId: json['tax_id'] as String?,
      notes: json['notes'] as String?,
      profileImage: json['profile_image'] as String?,
    );

Map<String, dynamic> _$$EmployeeRequestParamsImplToJson(
        _$EmployeeRequestParamsImpl instance) =>
    <String, dynamic>{
      'employee_code': instance.employeeCode,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'date_of_birth': instance.dateOfBirth,
      'hire_date': instance.hireDate,
      'department': instance.department,
      'position': instance.position,
      'employment_type': instance.employmentType,
      'employment_status': instance.employmentStatus,
      'basic_salary': instance.basicSalary,
      'hourly_rate': instance.hourlyRate,
      'working_hours_per_day': instance.workingHoursPerDay,
      'working_days_per_week': instance.workingDaysPerWeek,
      'manager_id': instance.managerId,
      'emergency_contact_name': instance.emergencyContactName,
      'emergency_contact_phone': instance.emergencyContactPhone,
      'bank_account_number': instance.bankAccountNumber,
      'bank_name': instance.bankName,
      'national_id': instance.nationalId,
      'tax_id': instance.taxId,
      'notes': instance.notes,
      'profile_image': instance.profileImage,
    };
