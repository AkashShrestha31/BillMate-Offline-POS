// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) {
  return _EmployeeModel.fromJson(json);
}

/// @nodoc
mixin _$EmployeeModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_code')
  String get employeeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String? get email =>
      throw _privateConstructorUsedError; // ✅ FIXED: Made nullable to handle null from API
  String? get phone => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_of_birth')
  String? get dateOfBirth => throw _privateConstructorUsedError;
  @JsonKey(name: 'hire_date')
  String get hireDate => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;
  @JsonKey(name: 'employment_type')
  String get employmentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'employment_status')
  String get employmentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'basic_salary')
  double get basicSalary => throw _privateConstructorUsedError;
  @JsonKey(name: 'hourly_rate')
  double? get hourlyRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'working_hours_per_day')
  double? get workingHoursPerDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'working_days_per_week')
  int? get workingDaysPerWeek => throw _privateConstructorUsedError;
  @JsonKey(name: 'manager_id')
  int? get managerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'manager_name')
  String? get managerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'emergency_contact_name')
  String? get emergencyContactName => throw _privateConstructorUsedError;
  @JsonKey(name: 'emergency_contact_phone')
  String? get emergencyContactPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'bank_account_number')
  String? get bankAccountNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'bank_name')
  String? get bankName => throw _privateConstructorUsedError;
  @JsonKey(name: 'national_id')
  String? get nationalId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_id')
  String? get taxId => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_image')
  String? get profileImage => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active', fromJson: employeeIsActiveFromJson)
  bool? get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'modified_by')
  String? get modifiedBy => throw _privateConstructorUsedError;
  String? get created => throw _privateConstructorUsedError;
  String? get modified => throw _privateConstructorUsedError;

  /// Serializes this EmployeeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmployeeModelCopyWith<EmployeeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeModelCopyWith<$Res> {
  factory $EmployeeModelCopyWith(
          EmployeeModel value, $Res Function(EmployeeModel) then) =
      _$EmployeeModelCopyWithImpl<$Res, EmployeeModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName,
      @JsonKey(name: 'full_name') String fullName,
      String? email,
      String? phone,
      String? address,
      @JsonKey(name: 'date_of_birth') String? dateOfBirth,
      @JsonKey(name: 'hire_date') String hireDate,
      String department,
      String position,
      @JsonKey(name: 'employment_type') String employmentType,
      @JsonKey(name: 'employment_status') String employmentStatus,
      @JsonKey(name: 'basic_salary') double basicSalary,
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
      @JsonKey(name: 'is_active', fromJson: employeeIsActiveFromJson)
      bool? isActive,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'modified_by') String? modifiedBy,
      String? created,
      String? modified});
}

/// @nodoc
class _$EmployeeModelCopyWithImpl<$Res, $Val extends EmployeeModel>
    implements $EmployeeModelCopyWith<$Res> {
  _$EmployeeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeCode = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? fullName = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? dateOfBirth = freezed,
    Object? hireDate = null,
    Object? department = null,
    Object? position = null,
    Object? employmentType = null,
    Object? employmentStatus = null,
    Object? basicSalary = null,
    Object? hourlyRate = freezed,
    Object? workingHoursPerDay = freezed,
    Object? workingDaysPerWeek = freezed,
    Object? managerId = freezed,
    Object? managerName = freezed,
    Object? emergencyContactName = freezed,
    Object? emergencyContactPhone = freezed,
    Object? bankAccountNumber = freezed,
    Object? bankName = freezed,
    Object? nationalId = freezed,
    Object? taxId = freezed,
    Object? profileImage = freezed,
    Object? notes = freezed,
    Object? isActive = freezed,
    Object? createdBy = freezed,
    Object? modifiedBy = freezed,
    Object? created = freezed,
    Object? modified = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      hireDate: null == hireDate
          ? _value.hireDate
          : hireDate // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      employmentType: null == employmentType
          ? _value.employmentType
          : employmentType // ignore: cast_nullable_to_non_nullable
              as String,
      employmentStatus: null == employmentStatus
          ? _value.employmentStatus
          : employmentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      basicSalary: null == basicSalary
          ? _value.basicSalary
          : basicSalary // ignore: cast_nullable_to_non_nullable
              as double,
      hourlyRate: freezed == hourlyRate
          ? _value.hourlyRate
          : hourlyRate // ignore: cast_nullable_to_non_nullable
              as double?,
      workingHoursPerDay: freezed == workingHoursPerDay
          ? _value.workingHoursPerDay
          : workingHoursPerDay // ignore: cast_nullable_to_non_nullable
              as double?,
      workingDaysPerWeek: freezed == workingDaysPerWeek
          ? _value.workingDaysPerWeek
          : workingDaysPerWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      managerId: freezed == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as int?,
      managerName: freezed == managerName
          ? _value.managerName
          : managerName // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactName: freezed == emergencyContactName
          ? _value.emergencyContactName
          : emergencyContactName // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactPhone: freezed == emergencyContactPhone
          ? _value.emergencyContactPhone
          : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountNumber: freezed == bankAccountNumber
          ? _value.bankAccountNumber
          : bankAccountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      nationalId: freezed == nationalId
          ? _value.nationalId
          : nationalId // ignore: cast_nullable_to_non_nullable
              as String?,
      taxId: freezed == taxId
          ? _value.taxId
          : taxId // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
      modified: freezed == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeeModelImplCopyWith<$Res>
    implements $EmployeeModelCopyWith<$Res> {
  factory _$$EmployeeModelImplCopyWith(
          _$EmployeeModelImpl value, $Res Function(_$EmployeeModelImpl) then) =
      __$$EmployeeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName,
      @JsonKey(name: 'full_name') String fullName,
      String? email,
      String? phone,
      String? address,
      @JsonKey(name: 'date_of_birth') String? dateOfBirth,
      @JsonKey(name: 'hire_date') String hireDate,
      String department,
      String position,
      @JsonKey(name: 'employment_type') String employmentType,
      @JsonKey(name: 'employment_status') String employmentStatus,
      @JsonKey(name: 'basic_salary') double basicSalary,
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
      @JsonKey(name: 'is_active', fromJson: employeeIsActiveFromJson)
      bool? isActive,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'modified_by') String? modifiedBy,
      String? created,
      String? modified});
}

/// @nodoc
class __$$EmployeeModelImplCopyWithImpl<$Res>
    extends _$EmployeeModelCopyWithImpl<$Res, _$EmployeeModelImpl>
    implements _$$EmployeeModelImplCopyWith<$Res> {
  __$$EmployeeModelImplCopyWithImpl(
      _$EmployeeModelImpl _value, $Res Function(_$EmployeeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeCode = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? fullName = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? dateOfBirth = freezed,
    Object? hireDate = null,
    Object? department = null,
    Object? position = null,
    Object? employmentType = null,
    Object? employmentStatus = null,
    Object? basicSalary = null,
    Object? hourlyRate = freezed,
    Object? workingHoursPerDay = freezed,
    Object? workingDaysPerWeek = freezed,
    Object? managerId = freezed,
    Object? managerName = freezed,
    Object? emergencyContactName = freezed,
    Object? emergencyContactPhone = freezed,
    Object? bankAccountNumber = freezed,
    Object? bankName = freezed,
    Object? nationalId = freezed,
    Object? taxId = freezed,
    Object? profileImage = freezed,
    Object? notes = freezed,
    Object? isActive = freezed,
    Object? createdBy = freezed,
    Object? modifiedBy = freezed,
    Object? created = freezed,
    Object? modified = freezed,
  }) {
    return _then(_$EmployeeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      hireDate: null == hireDate
          ? _value.hireDate
          : hireDate // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      employmentType: null == employmentType
          ? _value.employmentType
          : employmentType // ignore: cast_nullable_to_non_nullable
              as String,
      employmentStatus: null == employmentStatus
          ? _value.employmentStatus
          : employmentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      basicSalary: null == basicSalary
          ? _value.basicSalary
          : basicSalary // ignore: cast_nullable_to_non_nullable
              as double,
      hourlyRate: freezed == hourlyRate
          ? _value.hourlyRate
          : hourlyRate // ignore: cast_nullable_to_non_nullable
              as double?,
      workingHoursPerDay: freezed == workingHoursPerDay
          ? _value.workingHoursPerDay
          : workingHoursPerDay // ignore: cast_nullable_to_non_nullable
              as double?,
      workingDaysPerWeek: freezed == workingDaysPerWeek
          ? _value.workingDaysPerWeek
          : workingDaysPerWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      managerId: freezed == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as int?,
      managerName: freezed == managerName
          ? _value.managerName
          : managerName // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactName: freezed == emergencyContactName
          ? _value.emergencyContactName
          : emergencyContactName // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactPhone: freezed == emergencyContactPhone
          ? _value.emergencyContactPhone
          : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountNumber: freezed == bankAccountNumber
          ? _value.bankAccountNumber
          : bankAccountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      nationalId: freezed == nationalId
          ? _value.nationalId
          : nationalId // ignore: cast_nullable_to_non_nullable
              as String?,
      taxId: freezed == taxId
          ? _value.taxId
          : taxId // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
      modified: freezed == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeModelImpl implements _EmployeeModel {
  const _$EmployeeModelImpl(
      {required this.id,
      @JsonKey(name: 'employee_code') required this.employeeCode,
      @JsonKey(name: 'first_name') required this.firstName,
      @JsonKey(name: 'last_name') required this.lastName,
      @JsonKey(name: 'full_name') required this.fullName,
      this.email,
      this.phone,
      this.address,
      @JsonKey(name: 'date_of_birth') this.dateOfBirth,
      @JsonKey(name: 'hire_date') required this.hireDate,
      required this.department,
      required this.position,
      @JsonKey(name: 'employment_type') required this.employmentType,
      @JsonKey(name: 'employment_status') required this.employmentStatus,
      @JsonKey(name: 'basic_salary') required this.basicSalary,
      @JsonKey(name: 'hourly_rate') this.hourlyRate,
      @JsonKey(name: 'working_hours_per_day') this.workingHoursPerDay,
      @JsonKey(name: 'working_days_per_week') this.workingDaysPerWeek,
      @JsonKey(name: 'manager_id') this.managerId,
      @JsonKey(name: 'manager_name') this.managerName,
      @JsonKey(name: 'emergency_contact_name') this.emergencyContactName,
      @JsonKey(name: 'emergency_contact_phone') this.emergencyContactPhone,
      @JsonKey(name: 'bank_account_number') this.bankAccountNumber,
      @JsonKey(name: 'bank_name') this.bankName,
      @JsonKey(name: 'national_id') this.nationalId,
      @JsonKey(name: 'tax_id') this.taxId,
      @JsonKey(name: 'profile_image') this.profileImage,
      this.notes,
      @JsonKey(name: 'is_active', fromJson: employeeIsActiveFromJson)
      this.isActive,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'modified_by') this.modifiedBy,
      this.created,
      this.modified});

  factory _$EmployeeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'employee_code')
  final String employeeCode;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  final String? email;
// ✅ FIXED: Made nullable to handle null from API
  @override
  final String? phone;
  @override
  final String? address;
  @override
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;
  @override
  @JsonKey(name: 'hire_date')
  final String hireDate;
  @override
  final String department;
  @override
  final String position;
  @override
  @JsonKey(name: 'employment_type')
  final String employmentType;
  @override
  @JsonKey(name: 'employment_status')
  final String employmentStatus;
  @override
  @JsonKey(name: 'basic_salary')
  final double basicSalary;
  @override
  @JsonKey(name: 'hourly_rate')
  final double? hourlyRate;
  @override
  @JsonKey(name: 'working_hours_per_day')
  final double? workingHoursPerDay;
  @override
  @JsonKey(name: 'working_days_per_week')
  final int? workingDaysPerWeek;
  @override
  @JsonKey(name: 'manager_id')
  final int? managerId;
  @override
  @JsonKey(name: 'manager_name')
  final String? managerName;
  @override
  @JsonKey(name: 'emergency_contact_name')
  final String? emergencyContactName;
  @override
  @JsonKey(name: 'emergency_contact_phone')
  final String? emergencyContactPhone;
  @override
  @JsonKey(name: 'bank_account_number')
  final String? bankAccountNumber;
  @override
  @JsonKey(name: 'bank_name')
  final String? bankName;
  @override
  @JsonKey(name: 'national_id')
  final String? nationalId;
  @override
  @JsonKey(name: 'tax_id')
  final String? taxId;
  @override
  @JsonKey(name: 'profile_image')
  final String? profileImage;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'is_active', fromJson: employeeIsActiveFromJson)
  final bool? isActive;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'modified_by')
  final String? modifiedBy;
  @override
  final String? created;
  @override
  final String? modified;

  @override
  String toString() {
    return 'EmployeeModel(id: $id, employeeCode: $employeeCode, firstName: $firstName, lastName: $lastName, fullName: $fullName, email: $email, phone: $phone, address: $address, dateOfBirth: $dateOfBirth, hireDate: $hireDate, department: $department, position: $position, employmentType: $employmentType, employmentStatus: $employmentStatus, basicSalary: $basicSalary, hourlyRate: $hourlyRate, workingHoursPerDay: $workingHoursPerDay, workingDaysPerWeek: $workingDaysPerWeek, managerId: $managerId, managerName: $managerName, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone, bankAccountNumber: $bankAccountNumber, bankName: $bankName, nationalId: $nationalId, taxId: $taxId, profileImage: $profileImage, notes: $notes, isActive: $isActive, createdBy: $createdBy, modifiedBy: $modifiedBy, created: $created, modified: $modified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.hireDate, hireDate) ||
                other.hireDate == hireDate) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.employmentType, employmentType) ||
                other.employmentType == employmentType) &&
            (identical(other.employmentStatus, employmentStatus) ||
                other.employmentStatus == employmentStatus) &&
            (identical(other.basicSalary, basicSalary) ||
                other.basicSalary == basicSalary) &&
            (identical(other.hourlyRate, hourlyRate) ||
                other.hourlyRate == hourlyRate) &&
            (identical(other.workingHoursPerDay, workingHoursPerDay) ||
                other.workingHoursPerDay == workingHoursPerDay) &&
            (identical(other.workingDaysPerWeek, workingDaysPerWeek) ||
                other.workingDaysPerWeek == workingDaysPerWeek) &&
            (identical(other.managerId, managerId) ||
                other.managerId == managerId) &&
            (identical(other.managerName, managerName) ||
                other.managerName == managerName) &&
            (identical(other.emergencyContactName, emergencyContactName) ||
                other.emergencyContactName == emergencyContactName) &&
            (identical(other.emergencyContactPhone, emergencyContactPhone) ||
                other.emergencyContactPhone == emergencyContactPhone) &&
            (identical(other.bankAccountNumber, bankAccountNumber) ||
                other.bankAccountNumber == bankAccountNumber) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.nationalId, nationalId) ||
                other.nationalId == nationalId) &&
            (identical(other.taxId, taxId) || other.taxId == taxId) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.modified, modified) ||
                other.modified == modified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        employeeCode,
        firstName,
        lastName,
        fullName,
        email,
        phone,
        address,
        dateOfBirth,
        hireDate,
        department,
        position,
        employmentType,
        employmentStatus,
        basicSalary,
        hourlyRate,
        workingHoursPerDay,
        workingDaysPerWeek,
        managerId,
        managerName,
        emergencyContactName,
        emergencyContactPhone,
        bankAccountNumber,
        bankName,
        nationalId,
        taxId,
        profileImage,
        notes,
        isActive,
        createdBy,
        modifiedBy,
        created,
        modified
      ]);

  /// Create a copy of EmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeModelImplCopyWith<_$EmployeeModelImpl> get copyWith =>
      __$$EmployeeModelImplCopyWithImpl<_$EmployeeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeModelImplToJson(
      this,
    );
  }
}

abstract class _EmployeeModel implements EmployeeModel {
  const factory _EmployeeModel(
      {required final int id,
      @JsonKey(name: 'employee_code') required final String employeeCode,
      @JsonKey(name: 'first_name') required final String firstName,
      @JsonKey(name: 'last_name') required final String lastName,
      @JsonKey(name: 'full_name') required final String fullName,
      final String? email,
      final String? phone,
      final String? address,
      @JsonKey(name: 'date_of_birth') final String? dateOfBirth,
      @JsonKey(name: 'hire_date') required final String hireDate,
      required final String department,
      required final String position,
      @JsonKey(name: 'employment_type') required final String employmentType,
      @JsonKey(name: 'employment_status')
      required final String employmentStatus,
      @JsonKey(name: 'basic_salary') required final double basicSalary,
      @JsonKey(name: 'hourly_rate') final double? hourlyRate,
      @JsonKey(name: 'working_hours_per_day') final double? workingHoursPerDay,
      @JsonKey(name: 'working_days_per_week') final int? workingDaysPerWeek,
      @JsonKey(name: 'manager_id') final int? managerId,
      @JsonKey(name: 'manager_name') final String? managerName,
      @JsonKey(name: 'emergency_contact_name')
      final String? emergencyContactName,
      @JsonKey(name: 'emergency_contact_phone')
      final String? emergencyContactPhone,
      @JsonKey(name: 'bank_account_number') final String? bankAccountNumber,
      @JsonKey(name: 'bank_name') final String? bankName,
      @JsonKey(name: 'national_id') final String? nationalId,
      @JsonKey(name: 'tax_id') final String? taxId,
      @JsonKey(name: 'profile_image') final String? profileImage,
      final String? notes,
      @JsonKey(name: 'is_active', fromJson: employeeIsActiveFromJson)
      final bool? isActive,
      @JsonKey(name: 'created_by') final String? createdBy,
      @JsonKey(name: 'modified_by') final String? modifiedBy,
      final String? created,
      final String? modified}) = _$EmployeeModelImpl;

  factory _EmployeeModel.fromJson(Map<String, dynamic> json) =
      _$EmployeeModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'employee_code')
  String get employeeCode;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String? get email; // ✅ FIXED: Made nullable to handle null from API
  @override
  String? get phone;
  @override
  String? get address;
  @override
  @JsonKey(name: 'date_of_birth')
  String? get dateOfBirth;
  @override
  @JsonKey(name: 'hire_date')
  String get hireDate;
  @override
  String get department;
  @override
  String get position;
  @override
  @JsonKey(name: 'employment_type')
  String get employmentType;
  @override
  @JsonKey(name: 'employment_status')
  String get employmentStatus;
  @override
  @JsonKey(name: 'basic_salary')
  double get basicSalary;
  @override
  @JsonKey(name: 'hourly_rate')
  double? get hourlyRate;
  @override
  @JsonKey(name: 'working_hours_per_day')
  double? get workingHoursPerDay;
  @override
  @JsonKey(name: 'working_days_per_week')
  int? get workingDaysPerWeek;
  @override
  @JsonKey(name: 'manager_id')
  int? get managerId;
  @override
  @JsonKey(name: 'manager_name')
  String? get managerName;
  @override
  @JsonKey(name: 'emergency_contact_name')
  String? get emergencyContactName;
  @override
  @JsonKey(name: 'emergency_contact_phone')
  String? get emergencyContactPhone;
  @override
  @JsonKey(name: 'bank_account_number')
  String? get bankAccountNumber;
  @override
  @JsonKey(name: 'bank_name')
  String? get bankName;
  @override
  @JsonKey(name: 'national_id')
  String? get nationalId;
  @override
  @JsonKey(name: 'tax_id')
  String? get taxId;
  @override
  @JsonKey(name: 'profile_image')
  String? get profileImage;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'is_active', fromJson: employeeIsActiveFromJson)
  bool? get isActive;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'modified_by')
  String? get modifiedBy;
  @override
  String? get created;
  @override
  String? get modified;

  /// Create a copy of EmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeModelImplCopyWith<_$EmployeeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
