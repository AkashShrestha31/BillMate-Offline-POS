// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendanceRequestParams _$AttendanceRequestParamsFromJson(
    Map<String, dynamic> json) {
  return _AttendanceRequestParams.fromJson(json);
}

/// @nodoc
mixin _$AttendanceRequestParams {
  @JsonKey(name: 'employee_id')
  int get employeeId => throw _privateConstructorUsedError;

  /// Single date: use [attendanceDate]. Range: use [startDate] and [endDate] instead.
  @JsonKey(name: 'attendance_date')
  String? get attendanceDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  String? get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  String? get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'check_in_time')
  String? get checkInTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'check_out_time')
  String? get checkOutTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'break_start_time')
  String? get breakStartTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'break_end_time')
  String? get breakEndTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendance_status')
  String get attendanceStatus => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this AttendanceRequestParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceRequestParamsCopyWith<AttendanceRequestParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceRequestParamsCopyWith<$Res> {
  factory $AttendanceRequestParamsCopyWith(AttendanceRequestParams value,
          $Res Function(AttendanceRequestParams) then) =
      _$AttendanceRequestParamsCopyWithImpl<$Res, AttendanceRequestParams>;
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'attendance_date') String? attendanceDate,
      @JsonKey(name: 'start_date') String? startDate,
      @JsonKey(name: 'end_date') String? endDate,
      @JsonKey(name: 'check_in_time') String? checkInTime,
      @JsonKey(name: 'check_out_time') String? checkOutTime,
      @JsonKey(name: 'break_start_time') String? breakStartTime,
      @JsonKey(name: 'break_end_time') String? breakEndTime,
      @JsonKey(name: 'attendance_status') String attendanceStatus,
      String? location,
      String? notes});
}

/// @nodoc
class _$AttendanceRequestParamsCopyWithImpl<$Res,
        $Val extends AttendanceRequestParams>
    implements $AttendanceRequestParamsCopyWith<$Res> {
  _$AttendanceRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? attendanceDate = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? checkInTime = freezed,
    Object? checkOutTime = freezed,
    Object? breakStartTime = freezed,
    Object? breakEndTime = freezed,
    Object? attendanceStatus = null,
    Object? location = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      attendanceDate: freezed == attendanceDate
          ? _value.attendanceDate
          : attendanceDate // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
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
      attendanceStatus: null == attendanceStatus
          ? _value.attendanceStatus
          : attendanceStatus // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceRequestParamsImplCopyWith<$Res>
    implements $AttendanceRequestParamsCopyWith<$Res> {
  factory _$$AttendanceRequestParamsImplCopyWith(
          _$AttendanceRequestParamsImpl value,
          $Res Function(_$AttendanceRequestParamsImpl) then) =
      __$$AttendanceRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'attendance_date') String? attendanceDate,
      @JsonKey(name: 'start_date') String? startDate,
      @JsonKey(name: 'end_date') String? endDate,
      @JsonKey(name: 'check_in_time') String? checkInTime,
      @JsonKey(name: 'check_out_time') String? checkOutTime,
      @JsonKey(name: 'break_start_time') String? breakStartTime,
      @JsonKey(name: 'break_end_time') String? breakEndTime,
      @JsonKey(name: 'attendance_status') String attendanceStatus,
      String? location,
      String? notes});
}

/// @nodoc
class __$$AttendanceRequestParamsImplCopyWithImpl<$Res>
    extends _$AttendanceRequestParamsCopyWithImpl<$Res,
        _$AttendanceRequestParamsImpl>
    implements _$$AttendanceRequestParamsImplCopyWith<$Res> {
  __$$AttendanceRequestParamsImplCopyWithImpl(
      _$AttendanceRequestParamsImpl _value,
      $Res Function(_$AttendanceRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendanceRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? attendanceDate = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? checkInTime = freezed,
    Object? checkOutTime = freezed,
    Object? breakStartTime = freezed,
    Object? breakEndTime = freezed,
    Object? attendanceStatus = null,
    Object? location = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$AttendanceRequestParamsImpl(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      attendanceDate: freezed == attendanceDate
          ? _value.attendanceDate
          : attendanceDate // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
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
      attendanceStatus: null == attendanceStatus
          ? _value.attendanceStatus
          : attendanceStatus // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceRequestParamsImpl implements _AttendanceRequestParams {
  const _$AttendanceRequestParamsImpl(
      {@JsonKey(name: 'employee_id') required this.employeeId,
      @JsonKey(name: 'attendance_date') this.attendanceDate,
      @JsonKey(name: 'start_date') this.startDate,
      @JsonKey(name: 'end_date') this.endDate,
      @JsonKey(name: 'check_in_time') this.checkInTime,
      @JsonKey(name: 'check_out_time') this.checkOutTime,
      @JsonKey(name: 'break_start_time') this.breakStartTime,
      @JsonKey(name: 'break_end_time') this.breakEndTime,
      @JsonKey(name: 'attendance_status') required this.attendanceStatus,
      this.location,
      this.notes});

  factory _$AttendanceRequestParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceRequestParamsImplFromJson(json);

  @override
  @JsonKey(name: 'employee_id')
  final int employeeId;

  /// Single date: use [attendanceDate]. Range: use [startDate] and [endDate] instead.
  @override
  @JsonKey(name: 'attendance_date')
  final String? attendanceDate;
  @override
  @JsonKey(name: 'start_date')
  final String? startDate;
  @override
  @JsonKey(name: 'end_date')
  final String? endDate;
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
  @JsonKey(name: 'attendance_status')
  final String attendanceStatus;
  @override
  final String? location;
  @override
  final String? notes;

  @override
  String toString() {
    return 'AttendanceRequestParams(employeeId: $employeeId, attendanceDate: $attendanceDate, startDate: $startDate, endDate: $endDate, checkInTime: $checkInTime, checkOutTime: $checkOutTime, breakStartTime: $breakStartTime, breakEndTime: $breakEndTime, attendanceStatus: $attendanceStatus, location: $location, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceRequestParamsImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.attendanceDate, attendanceDate) ||
                other.attendanceDate == attendanceDate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.checkInTime, checkInTime) ||
                other.checkInTime == checkInTime) &&
            (identical(other.checkOutTime, checkOutTime) ||
                other.checkOutTime == checkOutTime) &&
            (identical(other.breakStartTime, breakStartTime) ||
                other.breakStartTime == breakStartTime) &&
            (identical(other.breakEndTime, breakEndTime) ||
                other.breakEndTime == breakEndTime) &&
            (identical(other.attendanceStatus, attendanceStatus) ||
                other.attendanceStatus == attendanceStatus) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      employeeId,
      attendanceDate,
      startDate,
      endDate,
      checkInTime,
      checkOutTime,
      breakStartTime,
      breakEndTime,
      attendanceStatus,
      location,
      notes);

  /// Create a copy of AttendanceRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceRequestParamsImplCopyWith<_$AttendanceRequestParamsImpl>
      get copyWith => __$$AttendanceRequestParamsImplCopyWithImpl<
          _$AttendanceRequestParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _AttendanceRequestParams implements AttendanceRequestParams {
  const factory _AttendanceRequestParams(
      {@JsonKey(name: 'employee_id') required final int employeeId,
      @JsonKey(name: 'attendance_date') final String? attendanceDate,
      @JsonKey(name: 'start_date') final String? startDate,
      @JsonKey(name: 'end_date') final String? endDate,
      @JsonKey(name: 'check_in_time') final String? checkInTime,
      @JsonKey(name: 'check_out_time') final String? checkOutTime,
      @JsonKey(name: 'break_start_time') final String? breakStartTime,
      @JsonKey(name: 'break_end_time') final String? breakEndTime,
      @JsonKey(name: 'attendance_status')
      required final String attendanceStatus,
      final String? location,
      final String? notes}) = _$AttendanceRequestParamsImpl;

  factory _AttendanceRequestParams.fromJson(Map<String, dynamic> json) =
      _$AttendanceRequestParamsImpl.fromJson;

  @override
  @JsonKey(name: 'employee_id')
  int get employeeId;

  /// Single date: use [attendanceDate]. Range: use [startDate] and [endDate] instead.
  @override
  @JsonKey(name: 'attendance_date')
  String? get attendanceDate;
  @override
  @JsonKey(name: 'start_date')
  String? get startDate;
  @override
  @JsonKey(name: 'end_date')
  String? get endDate;
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
  @JsonKey(name: 'attendance_status')
  String get attendanceStatus;
  @override
  String? get location;
  @override
  String? get notes;

  /// Create a copy of AttendanceRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceRequestParamsImplCopyWith<_$AttendanceRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
