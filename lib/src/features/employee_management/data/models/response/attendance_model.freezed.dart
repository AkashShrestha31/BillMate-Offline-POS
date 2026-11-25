// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) {
  return _AttendanceModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_id')
  int get employeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_name')
  String get employeeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_code')
  String get employeeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendance_date')
  String get attendanceDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'check_in_time')
  String? get checkInTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'check_out_time')
  String? get checkOutTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'break_start_time')
  String? get breakStartTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'break_end_time')
  String? get breakEndTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_hours_worked')
  double get totalHoursWorked => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_break_hours')
  double? get totalBreakHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'overtime_hours')
  double get overtimeHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendance_status')
  String get attendanceStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'late_arrival_minutes')
  int? get lateArrivalMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'early_departure_minutes')
  int? get earlyDepartureMinutes => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'approved_by')
  String? get approvedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_approved')
  bool get isApproved => throw _privateConstructorUsedError;
  String? get created => throw _privateConstructorUsedError;
  String? get modified => throw _privateConstructorUsedError;

  /// Serializes this AttendanceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceModelCopyWith<AttendanceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceModelCopyWith<$Res> {
  factory $AttendanceModelCopyWith(
          AttendanceModel value, $Res Function(AttendanceModel) then) =
      _$AttendanceModelCopyWithImpl<$Res, AttendanceModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'attendance_date') String attendanceDate,
      @JsonKey(name: 'check_in_time') String? checkInTime,
      @JsonKey(name: 'check_out_time') String? checkOutTime,
      @JsonKey(name: 'break_start_time') String? breakStartTime,
      @JsonKey(name: 'break_end_time') String? breakEndTime,
      @JsonKey(name: 'total_hours_worked') double totalHoursWorked,
      @JsonKey(name: 'total_break_hours') double? totalBreakHours,
      @JsonKey(name: 'overtime_hours') double overtimeHours,
      @JsonKey(name: 'attendance_status') String attendanceStatus,
      @JsonKey(name: 'late_arrival_minutes') int? lateArrivalMinutes,
      @JsonKey(name: 'early_departure_minutes') int? earlyDepartureMinutes,
      String? location,
      String? notes,
      @JsonKey(name: 'approved_by') String? approvedBy,
      @JsonKey(name: 'is_approved') bool isApproved,
      String? created,
      String? modified});
}

/// @nodoc
class _$AttendanceModelCopyWithImpl<$Res, $Val extends AttendanceModel>
    implements $AttendanceModelCopyWith<$Res> {
  _$AttendanceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? employeeCode = null,
    Object? attendanceDate = null,
    Object? checkInTime = freezed,
    Object? checkOutTime = freezed,
    Object? breakStartTime = freezed,
    Object? breakEndTime = freezed,
    Object? totalHoursWorked = null,
    Object? totalBreakHours = freezed,
    Object? overtimeHours = null,
    Object? attendanceStatus = null,
    Object? lateArrivalMinutes = freezed,
    Object? earlyDepartureMinutes = freezed,
    Object? location = freezed,
    Object? notes = freezed,
    Object? approvedBy = freezed,
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
      attendanceDate: null == attendanceDate
          ? _value.attendanceDate
          : attendanceDate // ignore: cast_nullable_to_non_nullable
              as String,
      checkInTime: freezed == checkInTime
          ? _value.checkInTime
          : checkInTime // ignore: cast_nullable_to_non_nullable
              as String?,
      checkOutTime: freezed == checkOutTime
          ? _value.checkOutTime
          : checkOutTime // ignore: cast_nullable_to_non_nullable
              as String?,
      breakStartTime: freezed == breakStartTime
          ? _value.breakStartTime
          : breakStartTime // ignore: cast_nullable_to_non_nullable
              as String?,
      breakEndTime: freezed == breakEndTime
          ? _value.breakEndTime
          : breakEndTime // ignore: cast_nullable_to_non_nullable
              as String?,
      totalHoursWorked: null == totalHoursWorked
          ? _value.totalHoursWorked
          : totalHoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      totalBreakHours: freezed == totalBreakHours
          ? _value.totalBreakHours
          : totalBreakHours // ignore: cast_nullable_to_non_nullable
              as double?,
      overtimeHours: null == overtimeHours
          ? _value.overtimeHours
          : overtimeHours // ignore: cast_nullable_to_non_nullable
              as double,
      attendanceStatus: null == attendanceStatus
          ? _value.attendanceStatus
          : attendanceStatus // ignore: cast_nullable_to_non_nullable
              as String,
      lateArrivalMinutes: freezed == lateArrivalMinutes
          ? _value.lateArrivalMinutes
          : lateArrivalMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      earlyDepartureMinutes: freezed == earlyDepartureMinutes
          ? _value.earlyDepartureMinutes
          : earlyDepartureMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
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
abstract class _$$AttendanceModelImplCopyWith<$Res>
    implements $AttendanceModelCopyWith<$Res> {
  factory _$$AttendanceModelImplCopyWith(_$AttendanceModelImpl value,
          $Res Function(_$AttendanceModelImpl) then) =
      __$$AttendanceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'attendance_date') String attendanceDate,
      @JsonKey(name: 'check_in_time') String? checkInTime,
      @JsonKey(name: 'check_out_time') String? checkOutTime,
      @JsonKey(name: 'break_start_time') String? breakStartTime,
      @JsonKey(name: 'break_end_time') String? breakEndTime,
      @JsonKey(name: 'total_hours_worked') double totalHoursWorked,
      @JsonKey(name: 'total_break_hours') double? totalBreakHours,
      @JsonKey(name: 'overtime_hours') double overtimeHours,
      @JsonKey(name: 'attendance_status') String attendanceStatus,
      @JsonKey(name: 'late_arrival_minutes') int? lateArrivalMinutes,
      @JsonKey(name: 'early_departure_minutes') int? earlyDepartureMinutes,
      String? location,
      String? notes,
      @JsonKey(name: 'approved_by') String? approvedBy,
      @JsonKey(name: 'is_approved') bool isApproved,
      String? created,
      String? modified});
}

/// @nodoc
class __$$AttendanceModelImplCopyWithImpl<$Res>
    extends _$AttendanceModelCopyWithImpl<$Res, _$AttendanceModelImpl>
    implements _$$AttendanceModelImplCopyWith<$Res> {
  __$$AttendanceModelImplCopyWithImpl(
      _$AttendanceModelImpl _value, $Res Function(_$AttendanceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? employeeCode = null,
    Object? attendanceDate = null,
    Object? checkInTime = freezed,
    Object? checkOutTime = freezed,
    Object? breakStartTime = freezed,
    Object? breakEndTime = freezed,
    Object? totalHoursWorked = null,
    Object? totalBreakHours = freezed,
    Object? overtimeHours = null,
    Object? attendanceStatus = null,
    Object? lateArrivalMinutes = freezed,
    Object? earlyDepartureMinutes = freezed,
    Object? location = freezed,
    Object? notes = freezed,
    Object? approvedBy = freezed,
    Object? isApproved = null,
    Object? created = freezed,
    Object? modified = freezed,
  }) {
    return _then(_$AttendanceModelImpl(
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
      attendanceDate: null == attendanceDate
          ? _value.attendanceDate
          : attendanceDate // ignore: cast_nullable_to_non_nullable
              as String,
      checkInTime: freezed == checkInTime
          ? _value.checkInTime
          : checkInTime // ignore: cast_nullable_to_non_nullable
              as String?,
      checkOutTime: freezed == checkOutTime
          ? _value.checkOutTime
          : checkOutTime // ignore: cast_nullable_to_non_nullable
              as String?,
      breakStartTime: freezed == breakStartTime
          ? _value.breakStartTime
          : breakStartTime // ignore: cast_nullable_to_non_nullable
              as String?,
      breakEndTime: freezed == breakEndTime
          ? _value.breakEndTime
          : breakEndTime // ignore: cast_nullable_to_non_nullable
              as String?,
      totalHoursWorked: null == totalHoursWorked
          ? _value.totalHoursWorked
          : totalHoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      totalBreakHours: freezed == totalBreakHours
          ? _value.totalBreakHours
          : totalBreakHours // ignore: cast_nullable_to_non_nullable
              as double?,
      overtimeHours: null == overtimeHours
          ? _value.overtimeHours
          : overtimeHours // ignore: cast_nullable_to_non_nullable
              as double,
      attendanceStatus: null == attendanceStatus
          ? _value.attendanceStatus
          : attendanceStatus // ignore: cast_nullable_to_non_nullable
              as String,
      lateArrivalMinutes: freezed == lateArrivalMinutes
          ? _value.lateArrivalMinutes
          : lateArrivalMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      earlyDepartureMinutes: freezed == earlyDepartureMinutes
          ? _value.earlyDepartureMinutes
          : earlyDepartureMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
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
class _$AttendanceModelImpl implements _AttendanceModel {
  const _$AttendanceModelImpl(
      {required this.id,
      @JsonKey(name: 'employee_id') required this.employeeId,
      @JsonKey(name: 'employee_name') required this.employeeName,
      @JsonKey(name: 'employee_code') required this.employeeCode,
      @JsonKey(name: 'attendance_date') required this.attendanceDate,
      @JsonKey(name: 'check_in_time') this.checkInTime,
      @JsonKey(name: 'check_out_time') this.checkOutTime,
      @JsonKey(name: 'break_start_time') this.breakStartTime,
      @JsonKey(name: 'break_end_time') this.breakEndTime,
      @JsonKey(name: 'total_hours_worked') required this.totalHoursWorked,
      @JsonKey(name: 'total_break_hours') this.totalBreakHours,
      @JsonKey(name: 'overtime_hours') required this.overtimeHours,
      @JsonKey(name: 'attendance_status') required this.attendanceStatus,
      @JsonKey(name: 'late_arrival_minutes') this.lateArrivalMinutes,
      @JsonKey(name: 'early_departure_minutes') this.earlyDepartureMinutes,
      this.location,
      this.notes,
      @JsonKey(name: 'approved_by') this.approvedBy,
      @JsonKey(name: 'is_approved') required this.isApproved,
      this.created,
      this.modified});

  factory _$AttendanceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceModelImplFromJson(json);

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
  @JsonKey(name: 'attendance_date')
  final String attendanceDate;
  @override
  @JsonKey(name: 'check_in_time')
  final String? checkInTime;
  @override
  @JsonKey(name: 'check_out_time')
  final String? checkOutTime;
  @override
  @JsonKey(name: 'break_start_time')
  final String? breakStartTime;
  @override
  @JsonKey(name: 'break_end_time')
  final String? breakEndTime;
  @override
  @JsonKey(name: 'total_hours_worked')
  final double totalHoursWorked;
  @override
  @JsonKey(name: 'total_break_hours')
  final double? totalBreakHours;
  @override
  @JsonKey(name: 'overtime_hours')
  final double overtimeHours;
  @override
  @JsonKey(name: 'attendance_status')
  final String attendanceStatus;
  @override
  @JsonKey(name: 'late_arrival_minutes')
  final int? lateArrivalMinutes;
  @override
  @JsonKey(name: 'early_departure_minutes')
  final int? earlyDepartureMinutes;
  @override
  final String? location;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'approved_by')
  final String? approvedBy;
  @override
  @JsonKey(name: 'is_approved')
  final bool isApproved;
  @override
  final String? created;
  @override
  final String? modified;

  @override
  String toString() {
    return 'AttendanceModel(id: $id, employeeId: $employeeId, employeeName: $employeeName, employeeCode: $employeeCode, attendanceDate: $attendanceDate, checkInTime: $checkInTime, checkOutTime: $checkOutTime, breakStartTime: $breakStartTime, breakEndTime: $breakEndTime, totalHoursWorked: $totalHoursWorked, totalBreakHours: $totalBreakHours, overtimeHours: $overtimeHours, attendanceStatus: $attendanceStatus, lateArrivalMinutes: $lateArrivalMinutes, earlyDepartureMinutes: $earlyDepartureMinutes, location: $location, notes: $notes, approvedBy: $approvedBy, isApproved: $isApproved, created: $created, modified: $modified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.attendanceDate, attendanceDate) ||
                other.attendanceDate == attendanceDate) &&
            (identical(other.checkInTime, checkInTime) ||
                other.checkInTime == checkInTime) &&
            (identical(other.checkOutTime, checkOutTime) ||
                other.checkOutTime == checkOutTime) &&
            (identical(other.breakStartTime, breakStartTime) ||
                other.breakStartTime == breakStartTime) &&
            (identical(other.breakEndTime, breakEndTime) ||
                other.breakEndTime == breakEndTime) &&
            (identical(other.totalHoursWorked, totalHoursWorked) ||
                other.totalHoursWorked == totalHoursWorked) &&
            (identical(other.totalBreakHours, totalBreakHours) ||
                other.totalBreakHours == totalBreakHours) &&
            (identical(other.overtimeHours, overtimeHours) ||
                other.overtimeHours == overtimeHours) &&
            (identical(other.attendanceStatus, attendanceStatus) ||
                other.attendanceStatus == attendanceStatus) &&
            (identical(other.lateArrivalMinutes, lateArrivalMinutes) ||
                other.lateArrivalMinutes == lateArrivalMinutes) &&
            (identical(other.earlyDepartureMinutes, earlyDepartureMinutes) ||
                other.earlyDepartureMinutes == earlyDepartureMinutes) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
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
        attendanceDate,
        checkInTime,
        checkOutTime,
        breakStartTime,
        breakEndTime,
        totalHoursWorked,
        totalBreakHours,
        overtimeHours,
        attendanceStatus,
        lateArrivalMinutes,
        earlyDepartureMinutes,
        location,
        notes,
        approvedBy,
        isApproved,
        created,
        modified
      ]);

  /// Create a copy of AttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceModelImplCopyWith<_$AttendanceModelImpl> get copyWith =>
      __$$AttendanceModelImplCopyWithImpl<_$AttendanceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceModelImplToJson(
      this,
    );
  }
}

abstract class _AttendanceModel implements AttendanceModel {
  const factory _AttendanceModel(
      {required final int id,
      @JsonKey(name: 'employee_id') required final int employeeId,
      @JsonKey(name: 'employee_name') required final String employeeName,
      @JsonKey(name: 'employee_code') required final String employeeCode,
      @JsonKey(name: 'attendance_date') required final String attendanceDate,
      @JsonKey(name: 'check_in_time') final String? checkInTime,
      @JsonKey(name: 'check_out_time') final String? checkOutTime,
      @JsonKey(name: 'break_start_time') final String? breakStartTime,
      @JsonKey(name: 'break_end_time') final String? breakEndTime,
      @JsonKey(name: 'total_hours_worked')
      required final double totalHoursWorked,
      @JsonKey(name: 'total_break_hours') final double? totalBreakHours,
      @JsonKey(name: 'overtime_hours') required final double overtimeHours,
      @JsonKey(name: 'attendance_status')
      required final String attendanceStatus,
      @JsonKey(name: 'late_arrival_minutes') final int? lateArrivalMinutes,
      @JsonKey(name: 'early_departure_minutes')
      final int? earlyDepartureMinutes,
      final String? location,
      final String? notes,
      @JsonKey(name: 'approved_by') final String? approvedBy,
      @JsonKey(name: 'is_approved') required final bool isApproved,
      final String? created,
      final String? modified}) = _$AttendanceModelImpl;

  factory _AttendanceModel.fromJson(Map<String, dynamic> json) =
      _$AttendanceModelImpl.fromJson;

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
  @JsonKey(name: 'attendance_date')
  String get attendanceDate;
  @override
  @JsonKey(name: 'check_in_time')
  String? get checkInTime;
  @override
  @JsonKey(name: 'check_out_time')
  String? get checkOutTime;
  @override
  @JsonKey(name: 'break_start_time')
  String? get breakStartTime;
  @override
  @JsonKey(name: 'break_end_time')
  String? get breakEndTime;
  @override
  @JsonKey(name: 'total_hours_worked')
  double get totalHoursWorked;
  @override
  @JsonKey(name: 'total_break_hours')
  double? get totalBreakHours;
  @override
  @JsonKey(name: 'overtime_hours')
  double get overtimeHours;
  @override
  @JsonKey(name: 'attendance_status')
  String get attendanceStatus;
  @override
  @JsonKey(name: 'late_arrival_minutes')
  int? get lateArrivalMinutes;
  @override
  @JsonKey(name: 'early_departure_minutes')
  int? get earlyDepartureMinutes;
  @override
  String? get location;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'approved_by')
  String? get approvedBy;
  @override
  @JsonKey(name: 'is_approved')
  bool get isApproved;
  @override
  String? get created;
  @override
  String? get modified;

  /// Create a copy of AttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceModelImplCopyWith<_$AttendanceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
