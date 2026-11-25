// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payroll_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PayrollModel _$PayrollModelFromJson(Map<String, dynamic> json) {
  return _PayrollModel.fromJson(json);
}

/// @nodoc
mixin _$PayrollModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_id')
  int? get employeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_name')
  String get employeeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_code')
  String get employeeCode => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;
  @JsonKey(name: 'payroll_month')
  String get payrollMonth => throw _privateConstructorUsedError;
  @JsonKey(name: 'pay_period_start')
  String get payPeriodStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'pay_period_end')
  String get payPeriodEnd =>
      throw _privateConstructorUsedError; // Attendance fields - from attendance_summary
  @JsonKey(name: 'total_working_days')
  int? get totalWorkingDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'days_present')
  int? get daysPresent => throw _privateConstructorUsedError;
  @JsonKey(name: 'days_absent')
  int? get daysAbsent => throw _privateConstructorUsedError;
  @JsonKey(name: 'sick_days')
  int? get sickDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'vacation_days')
  int? get vacationDays =>
      throw _privateConstructorUsedError; // Hours fields - from hours_summary
  @JsonKey(name: 'total_hours_worked')
  double? get totalHoursWorked => throw _privateConstructorUsedError;
  @JsonKey(name: 'regular_hours')
  double? get regularHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'overtime_hours')
  double? get overtimeHours =>
      throw _privateConstructorUsedError; // Earnings fields - from earnings
  @JsonKey(name: 'basic_salary')
  double? get basicSalary => throw _privateConstructorUsedError;
  @JsonKey(name: 'overtime_pay')
  double? get overtimePay => throw _privateConstructorUsedError;
  double? get allowances => throw _privateConstructorUsedError;
  double? get bonus => throw _privateConstructorUsedError;
  @JsonKey(name: 'gross_pay')
  double? get grossPay =>
      throw _privateConstructorUsedError; // Deductions fields - from deductions
  @JsonKey(name: 'tax_deduction')
  double? get taxDeduction => throw _privateConstructorUsedError;
  @JsonKey(name: 'insurance_deduction')
  double? get insuranceDeduction => throw _privateConstructorUsedError;
  @JsonKey(name: 'provident_fund')
  double? get providentFund => throw _privateConstructorUsedError;
  @JsonKey(name: 'other_deductions')
  double? get otherDeductions => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_deductions')
  double? get totalDeductions => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_pay')
  double? get netPay =>
      throw _privateConstructorUsedError; // Payment info fields
  @JsonKey(name: 'payment_date')
  String? get paymentDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_status')
  String get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'bank_reference')
  String? get bankReference => throw _privateConstructorUsedError; // Metadata
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'generated_by')
  String? get generatedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'approved_by')
  String? get approvedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_by')
  String? get paidBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_approved')
  bool get isApproved => throw _privateConstructorUsedError;
  String get created => throw _privateConstructorUsedError;
  String get modified =>
      throw _privateConstructorUsedError; // Additional fields from API response
  @JsonKey(name: 'attendance_summary')
  Map<String, dynamic>? get attendanceSummary =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'hours_summary')
  Map<String, dynamic>? get hoursSummary => throw _privateConstructorUsedError;
  Map<String, dynamic>? get earnings => throw _privateConstructorUsedError;
  Map<String, dynamic>? get deductions => throw _privateConstructorUsedError;

  /// Serializes this PayrollModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayrollModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayrollModelCopyWith<PayrollModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayrollModelCopyWith<$Res> {
  factory $PayrollModelCopyWith(
          PayrollModel value, $Res Function(PayrollModel) then) =
      _$PayrollModelCopyWithImpl<$Res, PayrollModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'employee_id') int? employeeId,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'employee_code') String employeeCode,
      String department,
      String position,
      @JsonKey(name: 'payroll_month') String payrollMonth,
      @JsonKey(name: 'pay_period_start') String payPeriodStart,
      @JsonKey(name: 'pay_period_end') String payPeriodEnd,
      @JsonKey(name: 'total_working_days') int? totalWorkingDays,
      @JsonKey(name: 'days_present') int? daysPresent,
      @JsonKey(name: 'days_absent') int? daysAbsent,
      @JsonKey(name: 'sick_days') int? sickDays,
      @JsonKey(name: 'vacation_days') int? vacationDays,
      @JsonKey(name: 'total_hours_worked') double? totalHoursWorked,
      @JsonKey(name: 'regular_hours') double? regularHours,
      @JsonKey(name: 'overtime_hours') double? overtimeHours,
      @JsonKey(name: 'basic_salary') double? basicSalary,
      @JsonKey(name: 'overtime_pay') double? overtimePay,
      double? allowances,
      double? bonus,
      @JsonKey(name: 'gross_pay') double? grossPay,
      @JsonKey(name: 'tax_deduction') double? taxDeduction,
      @JsonKey(name: 'insurance_deduction') double? insuranceDeduction,
      @JsonKey(name: 'provident_fund') double? providentFund,
      @JsonKey(name: 'other_deductions') double? otherDeductions,
      @JsonKey(name: 'total_deductions') double? totalDeductions,
      @JsonKey(name: 'net_pay') double? netPay,
      @JsonKey(name: 'payment_date') String? paymentDate,
      @JsonKey(name: 'payment_method') String paymentMethod,
      @JsonKey(name: 'payment_status') String paymentStatus,
      @JsonKey(name: 'bank_reference') String? bankReference,
      String? notes,
      @JsonKey(name: 'generated_by') String? generatedBy,
      @JsonKey(name: 'approved_by') String? approvedBy,
      @JsonKey(name: 'paid_by') String? paidBy,
      @JsonKey(name: 'is_approved') bool isApproved,
      String created,
      String modified,
      @JsonKey(name: 'attendance_summary')
      Map<String, dynamic>? attendanceSummary,
      @JsonKey(name: 'hours_summary') Map<String, dynamic>? hoursSummary,
      Map<String, dynamic>? earnings,
      Map<String, dynamic>? deductions});
}

/// @nodoc
class _$PayrollModelCopyWithImpl<$Res, $Val extends PayrollModel>
    implements $PayrollModelCopyWith<$Res> {
  _$PayrollModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayrollModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = freezed,
    Object? employeeName = null,
    Object? employeeCode = null,
    Object? department = null,
    Object? position = null,
    Object? payrollMonth = null,
    Object? payPeriodStart = null,
    Object? payPeriodEnd = null,
    Object? totalWorkingDays = freezed,
    Object? daysPresent = freezed,
    Object? daysAbsent = freezed,
    Object? sickDays = freezed,
    Object? vacationDays = freezed,
    Object? totalHoursWorked = freezed,
    Object? regularHours = freezed,
    Object? overtimeHours = freezed,
    Object? basicSalary = freezed,
    Object? overtimePay = freezed,
    Object? allowances = freezed,
    Object? bonus = freezed,
    Object? grossPay = freezed,
    Object? taxDeduction = freezed,
    Object? insuranceDeduction = freezed,
    Object? providentFund = freezed,
    Object? otherDeductions = freezed,
    Object? totalDeductions = freezed,
    Object? netPay = freezed,
    Object? paymentDate = freezed,
    Object? paymentMethod = null,
    Object? paymentStatus = null,
    Object? bankReference = freezed,
    Object? notes = freezed,
    Object? generatedBy = freezed,
    Object? approvedBy = freezed,
    Object? paidBy = freezed,
    Object? isApproved = null,
    Object? created = null,
    Object? modified = null,
    Object? attendanceSummary = freezed,
    Object? hoursSummary = freezed,
    Object? earnings = freezed,
    Object? deductions = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int?,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      payrollMonth: null == payrollMonth
          ? _value.payrollMonth
          : payrollMonth // ignore: cast_nullable_to_non_nullable
              as String,
      payPeriodStart: null == payPeriodStart
          ? _value.payPeriodStart
          : payPeriodStart // ignore: cast_nullable_to_non_nullable
              as String,
      payPeriodEnd: null == payPeriodEnd
          ? _value.payPeriodEnd
          : payPeriodEnd // ignore: cast_nullable_to_non_nullable
              as String,
      totalWorkingDays: freezed == totalWorkingDays
          ? _value.totalWorkingDays
          : totalWorkingDays // ignore: cast_nullable_to_non_nullable
              as int?,
      daysPresent: freezed == daysPresent
          ? _value.daysPresent
          : daysPresent // ignore: cast_nullable_to_non_nullable
              as int?,
      daysAbsent: freezed == daysAbsent
          ? _value.daysAbsent
          : daysAbsent // ignore: cast_nullable_to_non_nullable
              as int?,
      sickDays: freezed == sickDays
          ? _value.sickDays
          : sickDays // ignore: cast_nullable_to_non_nullable
              as int?,
      vacationDays: freezed == vacationDays
          ? _value.vacationDays
          : vacationDays // ignore: cast_nullable_to_non_nullable
              as int?,
      totalHoursWorked: freezed == totalHoursWorked
          ? _value.totalHoursWorked
          : totalHoursWorked // ignore: cast_nullable_to_non_nullable
              as double?,
      regularHours: freezed == regularHours
          ? _value.regularHours
          : regularHours // ignore: cast_nullable_to_non_nullable
              as double?,
      overtimeHours: freezed == overtimeHours
          ? _value.overtimeHours
          : overtimeHours // ignore: cast_nullable_to_non_nullable
              as double?,
      basicSalary: freezed == basicSalary
          ? _value.basicSalary
          : basicSalary // ignore: cast_nullable_to_non_nullable
              as double?,
      overtimePay: freezed == overtimePay
          ? _value.overtimePay
          : overtimePay // ignore: cast_nullable_to_non_nullable
              as double?,
      allowances: freezed == allowances
          ? _value.allowances
          : allowances // ignore: cast_nullable_to_non_nullable
              as double?,
      bonus: freezed == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as double?,
      grossPay: freezed == grossPay
          ? _value.grossPay
          : grossPay // ignore: cast_nullable_to_non_nullable
              as double?,
      taxDeduction: freezed == taxDeduction
          ? _value.taxDeduction
          : taxDeduction // ignore: cast_nullable_to_non_nullable
              as double?,
      insuranceDeduction: freezed == insuranceDeduction
          ? _value.insuranceDeduction
          : insuranceDeduction // ignore: cast_nullable_to_non_nullable
              as double?,
      providentFund: freezed == providentFund
          ? _value.providentFund
          : providentFund // ignore: cast_nullable_to_non_nullable
              as double?,
      otherDeductions: freezed == otherDeductions
          ? _value.otherDeductions
          : otherDeductions // ignore: cast_nullable_to_non_nullable
              as double?,
      totalDeductions: freezed == totalDeductions
          ? _value.totalDeductions
          : totalDeductions // ignore: cast_nullable_to_non_nullable
              as double?,
      netPay: freezed == netPay
          ? _value.netPay
          : netPay // ignore: cast_nullable_to_non_nullable
              as double?,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      bankReference: freezed == bankReference
          ? _value.bankReference
          : bankReference // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      generatedBy: freezed == generatedBy
          ? _value.generatedBy
          : generatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      paidBy: freezed == paidBy
          ? _value.paidBy
          : paidBy // ignore: cast_nullable_to_non_nullable
              as String?,
      isApproved: null == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String,
      attendanceSummary: freezed == attendanceSummary
          ? _value.attendanceSummary
          : attendanceSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      hoursSummary: freezed == hoursSummary
          ? _value.hoursSummary
          : hoursSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      earnings: freezed == earnings
          ? _value.earnings
          : earnings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      deductions: freezed == deductions
          ? _value.deductions
          : deductions // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayrollModelImplCopyWith<$Res>
    implements $PayrollModelCopyWith<$Res> {
  factory _$$PayrollModelImplCopyWith(
          _$PayrollModelImpl value, $Res Function(_$PayrollModelImpl) then) =
      __$$PayrollModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'employee_id') int? employeeId,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'employee_code') String employeeCode,
      String department,
      String position,
      @JsonKey(name: 'payroll_month') String payrollMonth,
      @JsonKey(name: 'pay_period_start') String payPeriodStart,
      @JsonKey(name: 'pay_period_end') String payPeriodEnd,
      @JsonKey(name: 'total_working_days') int? totalWorkingDays,
      @JsonKey(name: 'days_present') int? daysPresent,
      @JsonKey(name: 'days_absent') int? daysAbsent,
      @JsonKey(name: 'sick_days') int? sickDays,
      @JsonKey(name: 'vacation_days') int? vacationDays,
      @JsonKey(name: 'total_hours_worked') double? totalHoursWorked,
      @JsonKey(name: 'regular_hours') double? regularHours,
      @JsonKey(name: 'overtime_hours') double? overtimeHours,
      @JsonKey(name: 'basic_salary') double? basicSalary,
      @JsonKey(name: 'overtime_pay') double? overtimePay,
      double? allowances,
      double? bonus,
      @JsonKey(name: 'gross_pay') double? grossPay,
      @JsonKey(name: 'tax_deduction') double? taxDeduction,
      @JsonKey(name: 'insurance_deduction') double? insuranceDeduction,
      @JsonKey(name: 'provident_fund') double? providentFund,
      @JsonKey(name: 'other_deductions') double? otherDeductions,
      @JsonKey(name: 'total_deductions') double? totalDeductions,
      @JsonKey(name: 'net_pay') double? netPay,
      @JsonKey(name: 'payment_date') String? paymentDate,
      @JsonKey(name: 'payment_method') String paymentMethod,
      @JsonKey(name: 'payment_status') String paymentStatus,
      @JsonKey(name: 'bank_reference') String? bankReference,
      String? notes,
      @JsonKey(name: 'generated_by') String? generatedBy,
      @JsonKey(name: 'approved_by') String? approvedBy,
      @JsonKey(name: 'paid_by') String? paidBy,
      @JsonKey(name: 'is_approved') bool isApproved,
      String created,
      String modified,
      @JsonKey(name: 'attendance_summary')
      Map<String, dynamic>? attendanceSummary,
      @JsonKey(name: 'hours_summary') Map<String, dynamic>? hoursSummary,
      Map<String, dynamic>? earnings,
      Map<String, dynamic>? deductions});
}

/// @nodoc
class __$$PayrollModelImplCopyWithImpl<$Res>
    extends _$PayrollModelCopyWithImpl<$Res, _$PayrollModelImpl>
    implements _$$PayrollModelImplCopyWith<$Res> {
  __$$PayrollModelImplCopyWithImpl(
      _$PayrollModelImpl _value, $Res Function(_$PayrollModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayrollModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = freezed,
    Object? employeeName = null,
    Object? employeeCode = null,
    Object? department = null,
    Object? position = null,
    Object? payrollMonth = null,
    Object? payPeriodStart = null,
    Object? payPeriodEnd = null,
    Object? totalWorkingDays = freezed,
    Object? daysPresent = freezed,
    Object? daysAbsent = freezed,
    Object? sickDays = freezed,
    Object? vacationDays = freezed,
    Object? totalHoursWorked = freezed,
    Object? regularHours = freezed,
    Object? overtimeHours = freezed,
    Object? basicSalary = freezed,
    Object? overtimePay = freezed,
    Object? allowances = freezed,
    Object? bonus = freezed,
    Object? grossPay = freezed,
    Object? taxDeduction = freezed,
    Object? insuranceDeduction = freezed,
    Object? providentFund = freezed,
    Object? otherDeductions = freezed,
    Object? totalDeductions = freezed,
    Object? netPay = freezed,
    Object? paymentDate = freezed,
    Object? paymentMethod = null,
    Object? paymentStatus = null,
    Object? bankReference = freezed,
    Object? notes = freezed,
    Object? generatedBy = freezed,
    Object? approvedBy = freezed,
    Object? paidBy = freezed,
    Object? isApproved = null,
    Object? created = null,
    Object? modified = null,
    Object? attendanceSummary = freezed,
    Object? hoursSummary = freezed,
    Object? earnings = freezed,
    Object? deductions = freezed,
  }) {
    return _then(_$PayrollModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int?,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      payrollMonth: null == payrollMonth
          ? _value.payrollMonth
          : payrollMonth // ignore: cast_nullable_to_non_nullable
              as String,
      payPeriodStart: null == payPeriodStart
          ? _value.payPeriodStart
          : payPeriodStart // ignore: cast_nullable_to_non_nullable
              as String,
      payPeriodEnd: null == payPeriodEnd
          ? _value.payPeriodEnd
          : payPeriodEnd // ignore: cast_nullable_to_non_nullable
              as String,
      totalWorkingDays: freezed == totalWorkingDays
          ? _value.totalWorkingDays
          : totalWorkingDays // ignore: cast_nullable_to_non_nullable
              as int?,
      daysPresent: freezed == daysPresent
          ? _value.daysPresent
          : daysPresent // ignore: cast_nullable_to_non_nullable
              as int?,
      daysAbsent: freezed == daysAbsent
          ? _value.daysAbsent
          : daysAbsent // ignore: cast_nullable_to_non_nullable
              as int?,
      sickDays: freezed == sickDays
          ? _value.sickDays
          : sickDays // ignore: cast_nullable_to_non_nullable
              as int?,
      vacationDays: freezed == vacationDays
          ? _value.vacationDays
          : vacationDays // ignore: cast_nullable_to_non_nullable
              as int?,
      totalHoursWorked: freezed == totalHoursWorked
          ? _value.totalHoursWorked
          : totalHoursWorked // ignore: cast_nullable_to_non_nullable
              as double?,
      regularHours: freezed == regularHours
          ? _value.regularHours
          : regularHours // ignore: cast_nullable_to_non_nullable
              as double?,
      overtimeHours: freezed == overtimeHours
          ? _value.overtimeHours
          : overtimeHours // ignore: cast_nullable_to_non_nullable
              as double?,
      basicSalary: freezed == basicSalary
          ? _value.basicSalary
          : basicSalary // ignore: cast_nullable_to_non_nullable
              as double?,
      overtimePay: freezed == overtimePay
          ? _value.overtimePay
          : overtimePay // ignore: cast_nullable_to_non_nullable
              as double?,
      allowances: freezed == allowances
          ? _value.allowances
          : allowances // ignore: cast_nullable_to_non_nullable
              as double?,
      bonus: freezed == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as double?,
      grossPay: freezed == grossPay
          ? _value.grossPay
          : grossPay // ignore: cast_nullable_to_non_nullable
              as double?,
      taxDeduction: freezed == taxDeduction
          ? _value.taxDeduction
          : taxDeduction // ignore: cast_nullable_to_non_nullable
              as double?,
      insuranceDeduction: freezed == insuranceDeduction
          ? _value.insuranceDeduction
          : insuranceDeduction // ignore: cast_nullable_to_non_nullable
              as double?,
      providentFund: freezed == providentFund
          ? _value.providentFund
          : providentFund // ignore: cast_nullable_to_non_nullable
              as double?,
      otherDeductions: freezed == otherDeductions
          ? _value.otherDeductions
          : otherDeductions // ignore: cast_nullable_to_non_nullable
              as double?,
      totalDeductions: freezed == totalDeductions
          ? _value.totalDeductions
          : totalDeductions // ignore: cast_nullable_to_non_nullable
              as double?,
      netPay: freezed == netPay
          ? _value.netPay
          : netPay // ignore: cast_nullable_to_non_nullable
              as double?,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      bankReference: freezed == bankReference
          ? _value.bankReference
          : bankReference // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      generatedBy: freezed == generatedBy
          ? _value.generatedBy
          : generatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      paidBy: freezed == paidBy
          ? _value.paidBy
          : paidBy // ignore: cast_nullable_to_non_nullable
              as String?,
      isApproved: null == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String,
      attendanceSummary: freezed == attendanceSummary
          ? _value._attendanceSummary
          : attendanceSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      hoursSummary: freezed == hoursSummary
          ? _value._hoursSummary
          : hoursSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      earnings: freezed == earnings
          ? _value._earnings
          : earnings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      deductions: freezed == deductions
          ? _value._deductions
          : deductions // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayrollModelImpl implements _PayrollModel {
  const _$PayrollModelImpl(
      {required this.id,
      @JsonKey(name: 'employee_id') this.employeeId,
      @JsonKey(name: 'employee_name') required this.employeeName,
      @JsonKey(name: 'employee_code') this.employeeCode = '',
      this.department = '',
      this.position = '',
      @JsonKey(name: 'payroll_month') required this.payrollMonth,
      @JsonKey(name: 'pay_period_start') this.payPeriodStart = '',
      @JsonKey(name: 'pay_period_end') this.payPeriodEnd = '',
      @JsonKey(name: 'total_working_days') this.totalWorkingDays,
      @JsonKey(name: 'days_present') this.daysPresent,
      @JsonKey(name: 'days_absent') this.daysAbsent,
      @JsonKey(name: 'sick_days') this.sickDays,
      @JsonKey(name: 'vacation_days') this.vacationDays,
      @JsonKey(name: 'total_hours_worked') this.totalHoursWorked,
      @JsonKey(name: 'regular_hours') this.regularHours,
      @JsonKey(name: 'overtime_hours') this.overtimeHours,
      @JsonKey(name: 'basic_salary') this.basicSalary,
      @JsonKey(name: 'overtime_pay') this.overtimePay,
      this.allowances,
      this.bonus,
      @JsonKey(name: 'gross_pay') this.grossPay,
      @JsonKey(name: 'tax_deduction') this.taxDeduction,
      @JsonKey(name: 'insurance_deduction') this.insuranceDeduction,
      @JsonKey(name: 'provident_fund') this.providentFund,
      @JsonKey(name: 'other_deductions') this.otherDeductions,
      @JsonKey(name: 'total_deductions') this.totalDeductions,
      @JsonKey(name: 'net_pay') this.netPay,
      @JsonKey(name: 'payment_date') this.paymentDate,
      @JsonKey(name: 'payment_method') this.paymentMethod = '',
      @JsonKey(name: 'payment_status') this.paymentStatus = '',
      @JsonKey(name: 'bank_reference') this.bankReference,
      this.notes,
      @JsonKey(name: 'generated_by') this.generatedBy,
      @JsonKey(name: 'approved_by') this.approvedBy,
      @JsonKey(name: 'paid_by') this.paidBy,
      @JsonKey(name: 'is_approved') this.isApproved = false,
      this.created = '',
      this.modified = '',
      @JsonKey(name: 'attendance_summary')
      final Map<String, dynamic>? attendanceSummary,
      @JsonKey(name: 'hours_summary') final Map<String, dynamic>? hoursSummary,
      final Map<String, dynamic>? earnings,
      final Map<String, dynamic>? deductions})
      : _attendanceSummary = attendanceSummary,
        _hoursSummary = hoursSummary,
        _earnings = earnings,
        _deductions = deductions;

  factory _$PayrollModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'employee_id')
  final int? employeeId;
  @override
  @JsonKey(name: 'employee_name')
  final String employeeName;
  @override
  @JsonKey(name: 'employee_code')
  final String employeeCode;
  @override
  @JsonKey()
  final String department;
  @override
  @JsonKey()
  final String position;
  @override
  @JsonKey(name: 'payroll_month')
  final String payrollMonth;
  @override
  @JsonKey(name: 'pay_period_start')
  final String payPeriodStart;
  @override
  @JsonKey(name: 'pay_period_end')
  final String payPeriodEnd;
// Attendance fields - from attendance_summary
  @override
  @JsonKey(name: 'total_working_days')
  final int? totalWorkingDays;
  @override
  @JsonKey(name: 'days_present')
  final int? daysPresent;
  @override
  @JsonKey(name: 'days_absent')
  final int? daysAbsent;
  @override
  @JsonKey(name: 'sick_days')
  final int? sickDays;
  @override
  @JsonKey(name: 'vacation_days')
  final int? vacationDays;
// Hours fields - from hours_summary
  @override
  @JsonKey(name: 'total_hours_worked')
  final double? totalHoursWorked;
  @override
  @JsonKey(name: 'regular_hours')
  final double? regularHours;
  @override
  @JsonKey(name: 'overtime_hours')
  final double? overtimeHours;
// Earnings fields - from earnings
  @override
  @JsonKey(name: 'basic_salary')
  final double? basicSalary;
  @override
  @JsonKey(name: 'overtime_pay')
  final double? overtimePay;
  @override
  final double? allowances;
  @override
  final double? bonus;
  @override
  @JsonKey(name: 'gross_pay')
  final double? grossPay;
// Deductions fields - from deductions
  @override
  @JsonKey(name: 'tax_deduction')
  final double? taxDeduction;
  @override
  @JsonKey(name: 'insurance_deduction')
  final double? insuranceDeduction;
  @override
  @JsonKey(name: 'provident_fund')
  final double? providentFund;
  @override
  @JsonKey(name: 'other_deductions')
  final double? otherDeductions;
  @override
  @JsonKey(name: 'total_deductions')
  final double? totalDeductions;
  @override
  @JsonKey(name: 'net_pay')
  final double? netPay;
// Payment info fields
  @override
  @JsonKey(name: 'payment_date')
  final String? paymentDate;
  @override
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  @override
  @JsonKey(name: 'payment_status')
  final String paymentStatus;
  @override
  @JsonKey(name: 'bank_reference')
  final String? bankReference;
// Metadata
  @override
  final String? notes;
  @override
  @JsonKey(name: 'generated_by')
  final String? generatedBy;
  @override
  @JsonKey(name: 'approved_by')
  final String? approvedBy;
  @override
  @JsonKey(name: 'paid_by')
  final String? paidBy;
  @override
  @JsonKey(name: 'is_approved')
  final bool isApproved;
  @override
  @JsonKey()
  final String created;
  @override
  @JsonKey()
  final String modified;
// Additional fields from API response
  final Map<String, dynamic>? _attendanceSummary;
// Additional fields from API response
  @override
  @JsonKey(name: 'attendance_summary')
  Map<String, dynamic>? get attendanceSummary {
    final value = _attendanceSummary;
    if (value == null) return null;
    if (_attendanceSummary is EqualUnmodifiableMapView)
      return _attendanceSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _hoursSummary;
  @override
  @JsonKey(name: 'hours_summary')
  Map<String, dynamic>? get hoursSummary {
    final value = _hoursSummary;
    if (value == null) return null;
    if (_hoursSummary is EqualUnmodifiableMapView) return _hoursSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _earnings;
  @override
  Map<String, dynamic>? get earnings {
    final value = _earnings;
    if (value == null) return null;
    if (_earnings is EqualUnmodifiableMapView) return _earnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _deductions;
  @override
  Map<String, dynamic>? get deductions {
    final value = _deductions;
    if (value == null) return null;
    if (_deductions is EqualUnmodifiableMapView) return _deductions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'PayrollModel(id: $id, employeeId: $employeeId, employeeName: $employeeName, employeeCode: $employeeCode, department: $department, position: $position, payrollMonth: $payrollMonth, payPeriodStart: $payPeriodStart, payPeriodEnd: $payPeriodEnd, totalWorkingDays: $totalWorkingDays, daysPresent: $daysPresent, daysAbsent: $daysAbsent, sickDays: $sickDays, vacationDays: $vacationDays, totalHoursWorked: $totalHoursWorked, regularHours: $regularHours, overtimeHours: $overtimeHours, basicSalary: $basicSalary, overtimePay: $overtimePay, allowances: $allowances, bonus: $bonus, grossPay: $grossPay, taxDeduction: $taxDeduction, insuranceDeduction: $insuranceDeduction, providentFund: $providentFund, otherDeductions: $otherDeductions, totalDeductions: $totalDeductions, netPay: $netPay, paymentDate: $paymentDate, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, bankReference: $bankReference, notes: $notes, generatedBy: $generatedBy, approvedBy: $approvedBy, paidBy: $paidBy, isApproved: $isApproved, created: $created, modified: $modified, attendanceSummary: $attendanceSummary, hoursSummary: $hoursSummary, earnings: $earnings, deductions: $deductions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayrollModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.payrollMonth, payrollMonth) ||
                other.payrollMonth == payrollMonth) &&
            (identical(other.payPeriodStart, payPeriodStart) ||
                other.payPeriodStart == payPeriodStart) &&
            (identical(other.payPeriodEnd, payPeriodEnd) ||
                other.payPeriodEnd == payPeriodEnd) &&
            (identical(other.totalWorkingDays, totalWorkingDays) ||
                other.totalWorkingDays == totalWorkingDays) &&
            (identical(other.daysPresent, daysPresent) ||
                other.daysPresent == daysPresent) &&
            (identical(other.daysAbsent, daysAbsent) ||
                other.daysAbsent == daysAbsent) &&
            (identical(other.sickDays, sickDays) ||
                other.sickDays == sickDays) &&
            (identical(other.vacationDays, vacationDays) ||
                other.vacationDays == vacationDays) &&
            (identical(other.totalHoursWorked, totalHoursWorked) ||
                other.totalHoursWorked == totalHoursWorked) &&
            (identical(other.regularHours, regularHours) ||
                other.regularHours == regularHours) &&
            (identical(other.overtimeHours, overtimeHours) ||
                other.overtimeHours == overtimeHours) &&
            (identical(other.basicSalary, basicSalary) ||
                other.basicSalary == basicSalary) &&
            (identical(other.overtimePay, overtimePay) ||
                other.overtimePay == overtimePay) &&
            (identical(other.allowances, allowances) ||
                other.allowances == allowances) &&
            (identical(other.bonus, bonus) || other.bonus == bonus) &&
            (identical(other.grossPay, grossPay) ||
                other.grossPay == grossPay) &&
            (identical(other.taxDeduction, taxDeduction) ||
                other.taxDeduction == taxDeduction) &&
            (identical(other.insuranceDeduction, insuranceDeduction) ||
                other.insuranceDeduction == insuranceDeduction) &&
            (identical(other.providentFund, providentFund) ||
                other.providentFund == providentFund) &&
            (identical(other.otherDeductions, otherDeductions) ||
                other.otherDeductions == otherDeductions) &&
            (identical(other.totalDeductions, totalDeductions) ||
                other.totalDeductions == totalDeductions) &&
            (identical(other.netPay, netPay) || other.netPay == netPay) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.bankReference, bankReference) ||
                other.bankReference == bankReference) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.generatedBy, generatedBy) ||
                other.generatedBy == generatedBy) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.paidBy, paidBy) || other.paidBy == paidBy) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.modified, modified) ||
                other.modified == modified) &&
            const DeepCollectionEquality()
                .equals(other._attendanceSummary, _attendanceSummary) &&
            const DeepCollectionEquality()
                .equals(other._hoursSummary, _hoursSummary) &&
            const DeepCollectionEquality().equals(other._earnings, _earnings) &&
            const DeepCollectionEquality()
                .equals(other._deductions, _deductions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        employeeId,
        employeeName,
        employeeCode,
        department,
        position,
        payrollMonth,
        payPeriodStart,
        payPeriodEnd,
        totalWorkingDays,
        daysPresent,
        daysAbsent,
        sickDays,
        vacationDays,
        totalHoursWorked,
        regularHours,
        overtimeHours,
        basicSalary,
        overtimePay,
        allowances,
        bonus,
        grossPay,
        taxDeduction,
        insuranceDeduction,
        providentFund,
        otherDeductions,
        totalDeductions,
        netPay,
        paymentDate,
        paymentMethod,
        paymentStatus,
        bankReference,
        notes,
        generatedBy,
        approvedBy,
        paidBy,
        isApproved,
        created,
        modified,
        const DeepCollectionEquality().hash(_attendanceSummary),
        const DeepCollectionEquality().hash(_hoursSummary),
        const DeepCollectionEquality().hash(_earnings),
        const DeepCollectionEquality().hash(_deductions)
      ]);

  /// Create a copy of PayrollModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayrollModelImplCopyWith<_$PayrollModelImpl> get copyWith =>
      __$$PayrollModelImplCopyWithImpl<_$PayrollModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayrollModelImplToJson(
      this,
    );
  }
}

abstract class _PayrollModel implements PayrollModel {
  const factory _PayrollModel(
      {required final int id,
      @JsonKey(name: 'employee_id') final int? employeeId,
      @JsonKey(name: 'employee_name') required final String employeeName,
      @JsonKey(name: 'employee_code') final String employeeCode,
      final String department,
      final String position,
      @JsonKey(name: 'payroll_month') required final String payrollMonth,
      @JsonKey(name: 'pay_period_start') final String payPeriodStart,
      @JsonKey(name: 'pay_period_end') final String payPeriodEnd,
      @JsonKey(name: 'total_working_days') final int? totalWorkingDays,
      @JsonKey(name: 'days_present') final int? daysPresent,
      @JsonKey(name: 'days_absent') final int? daysAbsent,
      @JsonKey(name: 'sick_days') final int? sickDays,
      @JsonKey(name: 'vacation_days') final int? vacationDays,
      @JsonKey(name: 'total_hours_worked') final double? totalHoursWorked,
      @JsonKey(name: 'regular_hours') final double? regularHours,
      @JsonKey(name: 'overtime_hours') final double? overtimeHours,
      @JsonKey(name: 'basic_salary') final double? basicSalary,
      @JsonKey(name: 'overtime_pay') final double? overtimePay,
      final double? allowances,
      final double? bonus,
      @JsonKey(name: 'gross_pay') final double? grossPay,
      @JsonKey(name: 'tax_deduction') final double? taxDeduction,
      @JsonKey(name: 'insurance_deduction') final double? insuranceDeduction,
      @JsonKey(name: 'provident_fund') final double? providentFund,
      @JsonKey(name: 'other_deductions') final double? otherDeductions,
      @JsonKey(name: 'total_deductions') final double? totalDeductions,
      @JsonKey(name: 'net_pay') final double? netPay,
      @JsonKey(name: 'payment_date') final String? paymentDate,
      @JsonKey(name: 'payment_method') final String paymentMethod,
      @JsonKey(name: 'payment_status') final String paymentStatus,
      @JsonKey(name: 'bank_reference') final String? bankReference,
      final String? notes,
      @JsonKey(name: 'generated_by') final String? generatedBy,
      @JsonKey(name: 'approved_by') final String? approvedBy,
      @JsonKey(name: 'paid_by') final String? paidBy,
      @JsonKey(name: 'is_approved') final bool isApproved,
      final String created,
      final String modified,
      @JsonKey(name: 'attendance_summary')
      final Map<String, dynamic>? attendanceSummary,
      @JsonKey(name: 'hours_summary') final Map<String, dynamic>? hoursSummary,
      final Map<String, dynamic>? earnings,
      final Map<String, dynamic>? deductions}) = _$PayrollModelImpl;

  factory _PayrollModel.fromJson(Map<String, dynamic> json) =
      _$PayrollModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'employee_id')
  int? get employeeId;
  @override
  @JsonKey(name: 'employee_name')
  String get employeeName;
  @override
  @JsonKey(name: 'employee_code')
  String get employeeCode;
  @override
  String get department;
  @override
  String get position;
  @override
  @JsonKey(name: 'payroll_month')
  String get payrollMonth;
  @override
  @JsonKey(name: 'pay_period_start')
  String get payPeriodStart;
  @override
  @JsonKey(name: 'pay_period_end')
  String get payPeriodEnd; // Attendance fields - from attendance_summary
  @override
  @JsonKey(name: 'total_working_days')
  int? get totalWorkingDays;
  @override
  @JsonKey(name: 'days_present')
  int? get daysPresent;
  @override
  @JsonKey(name: 'days_absent')
  int? get daysAbsent;
  @override
  @JsonKey(name: 'sick_days')
  int? get sickDays;
  @override
  @JsonKey(name: 'vacation_days')
  int? get vacationDays; // Hours fields - from hours_summary
  @override
  @JsonKey(name: 'total_hours_worked')
  double? get totalHoursWorked;
  @override
  @JsonKey(name: 'regular_hours')
  double? get regularHours;
  @override
  @JsonKey(name: 'overtime_hours')
  double? get overtimeHours; // Earnings fields - from earnings
  @override
  @JsonKey(name: 'basic_salary')
  double? get basicSalary;
  @override
  @JsonKey(name: 'overtime_pay')
  double? get overtimePay;
  @override
  double? get allowances;
  @override
  double? get bonus;
  @override
  @JsonKey(name: 'gross_pay')
  double? get grossPay; // Deductions fields - from deductions
  @override
  @JsonKey(name: 'tax_deduction')
  double? get taxDeduction;
  @override
  @JsonKey(name: 'insurance_deduction')
  double? get insuranceDeduction;
  @override
  @JsonKey(name: 'provident_fund')
  double? get providentFund;
  @override
  @JsonKey(name: 'other_deductions')
  double? get otherDeductions;
  @override
  @JsonKey(name: 'total_deductions')
  double? get totalDeductions;
  @override
  @JsonKey(name: 'net_pay')
  double? get netPay; // Payment info fields
  @override
  @JsonKey(name: 'payment_date')
  String? get paymentDate;
  @override
  @JsonKey(name: 'payment_method')
  String get paymentMethod;
  @override
  @JsonKey(name: 'payment_status')
  String get paymentStatus;
  @override
  @JsonKey(name: 'bank_reference')
  String? get bankReference; // Metadata
  @override
  String? get notes;
  @override
  @JsonKey(name: 'generated_by')
  String? get generatedBy;
  @override
  @JsonKey(name: 'approved_by')
  String? get approvedBy;
  @override
  @JsonKey(name: 'paid_by')
  String? get paidBy;
  @override
  @JsonKey(name: 'is_approved')
  bool get isApproved;
  @override
  String get created;
  @override
  String get modified; // Additional fields from API response
  @override
  @JsonKey(name: 'attendance_summary')
  Map<String, dynamic>? get attendanceSummary;
  @override
  @JsonKey(name: 'hours_summary')
  Map<String, dynamic>? get hoursSummary;
  @override
  Map<String, dynamic>? get earnings;
  @override
  Map<String, dynamic>? get deductions;

  /// Create a copy of PayrollModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayrollModelImplCopyWith<_$PayrollModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
