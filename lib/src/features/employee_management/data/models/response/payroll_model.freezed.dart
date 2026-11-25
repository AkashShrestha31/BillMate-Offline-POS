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
  int get employeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_name')
  String get employeeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_code')
  String get employeeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'payroll_month')
  String get payrollMonth => throw _privateConstructorUsedError;
  @JsonKey(name: 'pay_period_start')
  String get payPeriodStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'pay_period_end')
  String get payPeriodEnd => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_working_days')
  int get totalWorkingDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'days_present')
  int get daysPresent => throw _privateConstructorUsedError;
  @JsonKey(name: 'days_absent')
  int get daysAbsent => throw _privateConstructorUsedError;
  @JsonKey(name: 'sick_days')
  int get sickDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'vacation_days')
  int get vacationDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_hours_worked')
  double get totalHoursWorked => throw _privateConstructorUsedError;
  @JsonKey(name: 'regular_hours')
  double get regularHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'overtime_hours')
  double get overtimeHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'basic_salary')
  double get basicSalary => throw _privateConstructorUsedError;
  @JsonKey(name: 'overtime_pay')
  double get overtimePay => throw _privateConstructorUsedError;
  double get allowances => throw _privateConstructorUsedError;
  double get bonus => throw _privateConstructorUsedError;
  @JsonKey(name: 'gross_pay')
  double get grossPay => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_deduction')
  double get taxDeduction => throw _privateConstructorUsedError;
  @JsonKey(name: 'insurance_deduction')
  double get insuranceDeduction => throw _privateConstructorUsedError;
  @JsonKey(name: 'provident_fund')
  double get providentFund => throw _privateConstructorUsedError;
  @JsonKey(name: 'other_deductions')
  double get otherDeductions => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_deductions')
  double get totalDeductions => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_pay')
  double get netPay => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_date')
  String? get paymentDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String? get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_status')
  String get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'bank_reference')
  String? get bankReference => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_approved')
  bool get isApproved => throw _privateConstructorUsedError;
  String? get created => throw _privateConstructorUsedError;
  String? get modified => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'payroll_month') String payrollMonth,
      @JsonKey(name: 'pay_period_start') String payPeriodStart,
      @JsonKey(name: 'pay_period_end') String payPeriodEnd,
      @JsonKey(name: 'total_working_days') int totalWorkingDays,
      @JsonKey(name: 'days_present') int daysPresent,
      @JsonKey(name: 'days_absent') int daysAbsent,
      @JsonKey(name: 'sick_days') int sickDays,
      @JsonKey(name: 'vacation_days') int vacationDays,
      @JsonKey(name: 'total_hours_worked') double totalHoursWorked,
      @JsonKey(name: 'regular_hours') double regularHours,
      @JsonKey(name: 'overtime_hours') double overtimeHours,
      @JsonKey(name: 'basic_salary') double basicSalary,
      @JsonKey(name: 'overtime_pay') double overtimePay,
      double allowances,
      double bonus,
      @JsonKey(name: 'gross_pay') double grossPay,
      @JsonKey(name: 'tax_deduction') double taxDeduction,
      @JsonKey(name: 'insurance_deduction') double insuranceDeduction,
      @JsonKey(name: 'provident_fund') double providentFund,
      @JsonKey(name: 'other_deductions') double otherDeductions,
      @JsonKey(name: 'total_deductions') double totalDeductions,
      @JsonKey(name: 'net_pay') double netPay,
      @JsonKey(name: 'payment_date') String? paymentDate,
      @JsonKey(name: 'payment_method') String? paymentMethod,
      @JsonKey(name: 'payment_status') String paymentStatus,
      @JsonKey(name: 'bank_reference') String? bankReference,
      String? notes,
      @JsonKey(name: 'is_approved') bool isApproved,
      String? created,
      String? modified});
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
    Object? employeeId = null,
    Object? employeeName = null,
    Object? employeeCode = null,
    Object? payrollMonth = null,
    Object? payPeriodStart = null,
    Object? payPeriodEnd = null,
    Object? totalWorkingDays = null,
    Object? daysPresent = null,
    Object? daysAbsent = null,
    Object? sickDays = null,
    Object? vacationDays = null,
    Object? totalHoursWorked = null,
    Object? regularHours = null,
    Object? overtimeHours = null,
    Object? basicSalary = null,
    Object? overtimePay = null,
    Object? allowances = null,
    Object? bonus = null,
    Object? grossPay = null,
    Object? taxDeduction = null,
    Object? insuranceDeduction = null,
    Object? providentFund = null,
    Object? otherDeductions = null,
    Object? totalDeductions = null,
    Object? netPay = null,
    Object? paymentDate = freezed,
    Object? paymentMethod = freezed,
    Object? paymentStatus = null,
    Object? bankReference = freezed,
    Object? notes = freezed,
    Object? isApproved = null,
    Object? created = freezed,
    Object? modified = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
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
      totalWorkingDays: null == totalWorkingDays
          ? _value.totalWorkingDays
          : totalWorkingDays // ignore: cast_nullable_to_non_nullable
              as int,
      daysPresent: null == daysPresent
          ? _value.daysPresent
          : daysPresent // ignore: cast_nullable_to_non_nullable
              as int,
      daysAbsent: null == daysAbsent
          ? _value.daysAbsent
          : daysAbsent // ignore: cast_nullable_to_non_nullable
              as int,
      sickDays: null == sickDays
          ? _value.sickDays
          : sickDays // ignore: cast_nullable_to_non_nullable
              as int,
      vacationDays: null == vacationDays
          ? _value.vacationDays
          : vacationDays // ignore: cast_nullable_to_non_nullable
              as int,
      totalHoursWorked: null == totalHoursWorked
          ? _value.totalHoursWorked
          : totalHoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      regularHours: null == regularHours
          ? _value.regularHours
          : regularHours // ignore: cast_nullable_to_non_nullable
              as double,
      overtimeHours: null == overtimeHours
          ? _value.overtimeHours
          : overtimeHours // ignore: cast_nullable_to_non_nullable
              as double,
      basicSalary: null == basicSalary
          ? _value.basicSalary
          : basicSalary // ignore: cast_nullable_to_non_nullable
              as double,
      overtimePay: null == overtimePay
          ? _value.overtimePay
          : overtimePay // ignore: cast_nullable_to_non_nullable
              as double,
      allowances: null == allowances
          ? _value.allowances
          : allowances // ignore: cast_nullable_to_non_nullable
              as double,
      bonus: null == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as double,
      grossPay: null == grossPay
          ? _value.grossPay
          : grossPay // ignore: cast_nullable_to_non_nullable
              as double,
      taxDeduction: null == taxDeduction
          ? _value.taxDeduction
          : taxDeduction // ignore: cast_nullable_to_non_nullable
              as double,
      insuranceDeduction: null == insuranceDeduction
          ? _value.insuranceDeduction
          : insuranceDeduction // ignore: cast_nullable_to_non_nullable
              as double,
      providentFund: null == providentFund
          ? _value.providentFund
          : providentFund // ignore: cast_nullable_to_non_nullable
              as double,
      otherDeductions: null == otherDeductions
          ? _value.otherDeductions
          : otherDeductions // ignore: cast_nullable_to_non_nullable
              as double,
      totalDeductions: null == totalDeductions
          ? _value.totalDeductions
          : totalDeductions // ignore: cast_nullable_to_non_nullable
              as double,
      netPay: null == netPay
          ? _value.netPay
          : netPay // ignore: cast_nullable_to_non_nullable
              as double,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isApproved: null == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$PayrollModelImplCopyWith<$Res>
    implements $PayrollModelCopyWith<$Res> {
  factory _$$PayrollModelImplCopyWith(
          _$PayrollModelImpl value, $Res Function(_$PayrollModelImpl) then) =
      __$$PayrollModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'payroll_month') String payrollMonth,
      @JsonKey(name: 'pay_period_start') String payPeriodStart,
      @JsonKey(name: 'pay_period_end') String payPeriodEnd,
      @JsonKey(name: 'total_working_days') int totalWorkingDays,
      @JsonKey(name: 'days_present') int daysPresent,
      @JsonKey(name: 'days_absent') int daysAbsent,
      @JsonKey(name: 'sick_days') int sickDays,
      @JsonKey(name: 'vacation_days') int vacationDays,
      @JsonKey(name: 'total_hours_worked') double totalHoursWorked,
      @JsonKey(name: 'regular_hours') double regularHours,
      @JsonKey(name: 'overtime_hours') double overtimeHours,
      @JsonKey(name: 'basic_salary') double basicSalary,
      @JsonKey(name: 'overtime_pay') double overtimePay,
      double allowances,
      double bonus,
      @JsonKey(name: 'gross_pay') double grossPay,
      @JsonKey(name: 'tax_deduction') double taxDeduction,
      @JsonKey(name: 'insurance_deduction') double insuranceDeduction,
      @JsonKey(name: 'provident_fund') double providentFund,
      @JsonKey(name: 'other_deductions') double otherDeductions,
      @JsonKey(name: 'total_deductions') double totalDeductions,
      @JsonKey(name: 'net_pay') double netPay,
      @JsonKey(name: 'payment_date') String? paymentDate,
      @JsonKey(name: 'payment_method') String? paymentMethod,
      @JsonKey(name: 'payment_status') String paymentStatus,
      @JsonKey(name: 'bank_reference') String? bankReference,
      String? notes,
      @JsonKey(name: 'is_approved') bool isApproved,
      String? created,
      String? modified});
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
    Object? employeeId = null,
    Object? employeeName = null,
    Object? employeeCode = null,
    Object? payrollMonth = null,
    Object? payPeriodStart = null,
    Object? payPeriodEnd = null,
    Object? totalWorkingDays = null,
    Object? daysPresent = null,
    Object? daysAbsent = null,
    Object? sickDays = null,
    Object? vacationDays = null,
    Object? totalHoursWorked = null,
    Object? regularHours = null,
    Object? overtimeHours = null,
    Object? basicSalary = null,
    Object? overtimePay = null,
    Object? allowances = null,
    Object? bonus = null,
    Object? grossPay = null,
    Object? taxDeduction = null,
    Object? insuranceDeduction = null,
    Object? providentFund = null,
    Object? otherDeductions = null,
    Object? totalDeductions = null,
    Object? netPay = null,
    Object? paymentDate = freezed,
    Object? paymentMethod = freezed,
    Object? paymentStatus = null,
    Object? bankReference = freezed,
    Object? notes = freezed,
    Object? isApproved = null,
    Object? created = freezed,
    Object? modified = freezed,
  }) {
    return _then(_$PayrollModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
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
      totalWorkingDays: null == totalWorkingDays
          ? _value.totalWorkingDays
          : totalWorkingDays // ignore: cast_nullable_to_non_nullable
              as int,
      daysPresent: null == daysPresent
          ? _value.daysPresent
          : daysPresent // ignore: cast_nullable_to_non_nullable
              as int,
      daysAbsent: null == daysAbsent
          ? _value.daysAbsent
          : daysAbsent // ignore: cast_nullable_to_non_nullable
              as int,
      sickDays: null == sickDays
          ? _value.sickDays
          : sickDays // ignore: cast_nullable_to_non_nullable
              as int,
      vacationDays: null == vacationDays
          ? _value.vacationDays
          : vacationDays // ignore: cast_nullable_to_non_nullable
              as int,
      totalHoursWorked: null == totalHoursWorked
          ? _value.totalHoursWorked
          : totalHoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      regularHours: null == regularHours
          ? _value.regularHours
          : regularHours // ignore: cast_nullable_to_non_nullable
              as double,
      overtimeHours: null == overtimeHours
          ? _value.overtimeHours
          : overtimeHours // ignore: cast_nullable_to_non_nullable
              as double,
      basicSalary: null == basicSalary
          ? _value.basicSalary
          : basicSalary // ignore: cast_nullable_to_non_nullable
              as double,
      overtimePay: null == overtimePay
          ? _value.overtimePay
          : overtimePay // ignore: cast_nullable_to_non_nullable
              as double,
      allowances: null == allowances
          ? _value.allowances
          : allowances // ignore: cast_nullable_to_non_nullable
              as double,
      bonus: null == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as double,
      grossPay: null == grossPay
          ? _value.grossPay
          : grossPay // ignore: cast_nullable_to_non_nullable
              as double,
      taxDeduction: null == taxDeduction
          ? _value.taxDeduction
          : taxDeduction // ignore: cast_nullable_to_non_nullable
              as double,
      insuranceDeduction: null == insuranceDeduction
          ? _value.insuranceDeduction
          : insuranceDeduction // ignore: cast_nullable_to_non_nullable
              as double,
      providentFund: null == providentFund
          ? _value.providentFund
          : providentFund // ignore: cast_nullable_to_non_nullable
              as double,
      otherDeductions: null == otherDeductions
          ? _value.otherDeductions
          : otherDeductions // ignore: cast_nullable_to_non_nullable
              as double,
      totalDeductions: null == totalDeductions
          ? _value.totalDeductions
          : totalDeductions // ignore: cast_nullable_to_non_nullable
              as double,
      netPay: null == netPay
          ? _value.netPay
          : netPay // ignore: cast_nullable_to_non_nullable
              as double,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isApproved: null == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$PayrollModelImpl implements _PayrollModel {
  const _$PayrollModelImpl(
      {required this.id,
      @JsonKey(name: 'employee_id') required this.employeeId,
      @JsonKey(name: 'employee_name') required this.employeeName,
      @JsonKey(name: 'employee_code') required this.employeeCode,
      @JsonKey(name: 'payroll_month') required this.payrollMonth,
      @JsonKey(name: 'pay_period_start') required this.payPeriodStart,
      @JsonKey(name: 'pay_period_end') required this.payPeriodEnd,
      @JsonKey(name: 'total_working_days') required this.totalWorkingDays,
      @JsonKey(name: 'days_present') required this.daysPresent,
      @JsonKey(name: 'days_absent') required this.daysAbsent,
      @JsonKey(name: 'sick_days') required this.sickDays,
      @JsonKey(name: 'vacation_days') required this.vacationDays,
      @JsonKey(name: 'total_hours_worked') required this.totalHoursWorked,
      @JsonKey(name: 'regular_hours') required this.regularHours,
      @JsonKey(name: 'overtime_hours') required this.overtimeHours,
      @JsonKey(name: 'basic_salary') required this.basicSalary,
      @JsonKey(name: 'overtime_pay') required this.overtimePay,
      required this.allowances,
      required this.bonus,
      @JsonKey(name: 'gross_pay') required this.grossPay,
      @JsonKey(name: 'tax_deduction') required this.taxDeduction,
      @JsonKey(name: 'insurance_deduction') required this.insuranceDeduction,
      @JsonKey(name: 'provident_fund') required this.providentFund,
      @JsonKey(name: 'other_deductions') required this.otherDeductions,
      @JsonKey(name: 'total_deductions') required this.totalDeductions,
      @JsonKey(name: 'net_pay') required this.netPay,
      @JsonKey(name: 'payment_date') this.paymentDate,
      @JsonKey(name: 'payment_method') this.paymentMethod,
      @JsonKey(name: 'payment_status') required this.paymentStatus,
      @JsonKey(name: 'bank_reference') this.bankReference,
      this.notes,
      @JsonKey(name: 'is_approved') required this.isApproved,
      this.created,
      this.modified});

  factory _$PayrollModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'employee_id')
  final int employeeId;
  @override
  @JsonKey(name: 'employee_name')
  final String employeeName;
  @override
  @JsonKey(name: 'employee_code')
  final String employeeCode;
  @override
  @JsonKey(name: 'payroll_month')
  final String payrollMonth;
  @override
  @JsonKey(name: 'pay_period_start')
  final String payPeriodStart;
  @override
  @JsonKey(name: 'pay_period_end')
  final String payPeriodEnd;
  @override
  @JsonKey(name: 'total_working_days')
  final int totalWorkingDays;
  @override
  @JsonKey(name: 'days_present')
  final int daysPresent;
  @override
  @JsonKey(name: 'days_absent')
  final int daysAbsent;
  @override
  @JsonKey(name: 'sick_days')
  final int sickDays;
  @override
  @JsonKey(name: 'vacation_days')
  final int vacationDays;
  @override
  @JsonKey(name: 'total_hours_worked')
  final double totalHoursWorked;
  @override
  @JsonKey(name: 'regular_hours')
  final double regularHours;
  @override
  @JsonKey(name: 'overtime_hours')
  final double overtimeHours;
  @override
  @JsonKey(name: 'basic_salary')
  final double basicSalary;
  @override
  @JsonKey(name: 'overtime_pay')
  final double overtimePay;
  @override
  final double allowances;
  @override
  final double bonus;
  @override
  @JsonKey(name: 'gross_pay')
  final double grossPay;
  @override
  @JsonKey(name: 'tax_deduction')
  final double taxDeduction;
  @override
  @JsonKey(name: 'insurance_deduction')
  final double insuranceDeduction;
  @override
  @JsonKey(name: 'provident_fund')
  final double providentFund;
  @override
  @JsonKey(name: 'other_deductions')
  final double otherDeductions;
  @override
  @JsonKey(name: 'total_deductions')
  final double totalDeductions;
  @override
  @JsonKey(name: 'net_pay')
  final double netPay;
  @override
  @JsonKey(name: 'payment_date')
  final String? paymentDate;
  @override
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @override
  @JsonKey(name: 'payment_status')
  final String paymentStatus;
  @override
  @JsonKey(name: 'bank_reference')
  final String? bankReference;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'is_approved')
  final bool isApproved;
  @override
  final String? created;
  @override
  final String? modified;

  @override
  String toString() {
    return 'PayrollModel(id: $id, employeeId: $employeeId, employeeName: $employeeName, employeeCode: $employeeCode, payrollMonth: $payrollMonth, payPeriodStart: $payPeriodStart, payPeriodEnd: $payPeriodEnd, totalWorkingDays: $totalWorkingDays, daysPresent: $daysPresent, daysAbsent: $daysAbsent, sickDays: $sickDays, vacationDays: $vacationDays, totalHoursWorked: $totalHoursWorked, regularHours: $regularHours, overtimeHours: $overtimeHours, basicSalary: $basicSalary, overtimePay: $overtimePay, allowances: $allowances, bonus: $bonus, grossPay: $grossPay, taxDeduction: $taxDeduction, insuranceDeduction: $insuranceDeduction, providentFund: $providentFund, otherDeductions: $otherDeductions, totalDeductions: $totalDeductions, netPay: $netPay, paymentDate: $paymentDate, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, bankReference: $bankReference, notes: $notes, isApproved: $isApproved, created: $created, modified: $modified)';
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
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.modified, modified) ||
                other.modified == modified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        employeeId,
        employeeName,
        employeeCode,
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
        isApproved,
        created,
        modified
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
      @JsonKey(name: 'employee_id') required final int employeeId,
      @JsonKey(name: 'employee_name') required final String employeeName,
      @JsonKey(name: 'employee_code') required final String employeeCode,
      @JsonKey(name: 'payroll_month') required final String payrollMonth,
      @JsonKey(name: 'pay_period_start') required final String payPeriodStart,
      @JsonKey(name: 'pay_period_end') required final String payPeriodEnd,
      @JsonKey(name: 'total_working_days') required final int totalWorkingDays,
      @JsonKey(name: 'days_present') required final int daysPresent,
      @JsonKey(name: 'days_absent') required final int daysAbsent,
      @JsonKey(name: 'sick_days') required final int sickDays,
      @JsonKey(name: 'vacation_days') required final int vacationDays,
      @JsonKey(name: 'total_hours_worked')
      required final double totalHoursWorked,
      @JsonKey(name: 'regular_hours') required final double regularHours,
      @JsonKey(name: 'overtime_hours') required final double overtimeHours,
      @JsonKey(name: 'basic_salary') required final double basicSalary,
      @JsonKey(name: 'overtime_pay') required final double overtimePay,
      required final double allowances,
      required final double bonus,
      @JsonKey(name: 'gross_pay') required final double grossPay,
      @JsonKey(name: 'tax_deduction') required final double taxDeduction,
      @JsonKey(name: 'insurance_deduction')
      required final double insuranceDeduction,
      @JsonKey(name: 'provident_fund') required final double providentFund,
      @JsonKey(name: 'other_deductions') required final double otherDeductions,
      @JsonKey(name: 'total_deductions') required final double totalDeductions,
      @JsonKey(name: 'net_pay') required final double netPay,
      @JsonKey(name: 'payment_date') final String? paymentDate,
      @JsonKey(name: 'payment_method') final String? paymentMethod,
      @JsonKey(name: 'payment_status') required final String paymentStatus,
      @JsonKey(name: 'bank_reference') final String? bankReference,
      final String? notes,
      @JsonKey(name: 'is_approved') required final bool isApproved,
      final String? created,
      final String? modified}) = _$PayrollModelImpl;

  factory _PayrollModel.fromJson(Map<String, dynamic> json) =
      _$PayrollModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'employee_id')
  int get employeeId;
  @override
  @JsonKey(name: 'employee_name')
  String get employeeName;
  @override
  @JsonKey(name: 'employee_code')
  String get employeeCode;
  @override
  @JsonKey(name: 'payroll_month')
  String get payrollMonth;
  @override
  @JsonKey(name: 'pay_period_start')
  String get payPeriodStart;
  @override
  @JsonKey(name: 'pay_period_end')
  String get payPeriodEnd;
  @override
  @JsonKey(name: 'total_working_days')
  int get totalWorkingDays;
  @override
  @JsonKey(name: 'days_present')
  int get daysPresent;
  @override
  @JsonKey(name: 'days_absent')
  int get daysAbsent;
  @override
  @JsonKey(name: 'sick_days')
  int get sickDays;
  @override
  @JsonKey(name: 'vacation_days')
  int get vacationDays;
  @override
  @JsonKey(name: 'total_hours_worked')
  double get totalHoursWorked;
  @override
  @JsonKey(name: 'regular_hours')
  double get regularHours;
  @override
  @JsonKey(name: 'overtime_hours')
  double get overtimeHours;
  @override
  @JsonKey(name: 'basic_salary')
  double get basicSalary;
  @override
  @JsonKey(name: 'overtime_pay')
  double get overtimePay;
  @override
  double get allowances;
  @override
  double get bonus;
  @override
  @JsonKey(name: 'gross_pay')
  double get grossPay;
  @override
  @JsonKey(name: 'tax_deduction')
  double get taxDeduction;
  @override
  @JsonKey(name: 'insurance_deduction')
  double get insuranceDeduction;
  @override
  @JsonKey(name: 'provident_fund')
  double get providentFund;
  @override
  @JsonKey(name: 'other_deductions')
  double get otherDeductions;
  @override
  @JsonKey(name: 'total_deductions')
  double get totalDeductions;
  @override
  @JsonKey(name: 'net_pay')
  double get netPay;
  @override
  @JsonKey(name: 'payment_date')
  String? get paymentDate;
  @override
  @JsonKey(name: 'payment_method')
  String? get paymentMethod;
  @override
  @JsonKey(name: 'payment_status')
  String get paymentStatus;
  @override
  @JsonKey(name: 'bank_reference')
  String? get bankReference;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'is_approved')
  bool get isApproved;
  @override
  String? get created;
  @override
  String? get modified;

  /// Create a copy of PayrollModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayrollModelImplCopyWith<_$PayrollModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
