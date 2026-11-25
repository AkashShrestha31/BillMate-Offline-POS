// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_application_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveApplicationRequestParams _$LeaveApplicationRequestParamsFromJson(
    Map<String, dynamic> json) {
  return _LeaveApplicationRequestParams.fromJson(json);
}

/// @nodoc
mixin _$LeaveApplicationRequestParams {
  @JsonKey(name: 'employee_id')
  int get employeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'leave_type_id')
  int get leaveTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_date')
  String get fromDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_date')
  String get toDate => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  @JsonKey(name: 'emergency_contact')
  String? get emergencyContact => throw _privateConstructorUsedError;
  @JsonKey(name: 'handover_notes')
  String? get handoverNotes => throw _privateConstructorUsedError;
  @JsonKey(name: 'substitute_employee_id')
  int? get substituteEmployeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_emergency')
  bool? get isEmergency => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_half_day')
  bool? get isHalfDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'half_day_session')
  String? get halfDaySession => throw _privateConstructorUsedError;

  /// Serializes this LeaveApplicationRequestParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveApplicationRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveApplicationRequestParamsCopyWith<LeaveApplicationRequestParams>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveApplicationRequestParamsCopyWith<$Res> {
  factory $LeaveApplicationRequestParamsCopyWith(
          LeaveApplicationRequestParams value,
          $Res Function(LeaveApplicationRequestParams) then) =
      _$LeaveApplicationRequestParamsCopyWithImpl<$Res,
          LeaveApplicationRequestParams>;
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'leave_type_id') int leaveTypeId,
      @JsonKey(name: 'from_date') String fromDate,
      @JsonKey(name: 'to_date') String toDate,
      String reason,
      @JsonKey(name: 'emergency_contact') String? emergencyContact,
      @JsonKey(name: 'handover_notes') String? handoverNotes,
      @JsonKey(name: 'substitute_employee_id') int? substituteEmployeeId,
      @JsonKey(name: 'is_emergency') bool? isEmergency,
      @JsonKey(name: 'is_half_day') bool? isHalfDay,
      @JsonKey(name: 'half_day_session') String? halfDaySession});
}

/// @nodoc
class _$LeaveApplicationRequestParamsCopyWithImpl<$Res,
        $Val extends LeaveApplicationRequestParams>
    implements $LeaveApplicationRequestParamsCopyWith<$Res> {
  _$LeaveApplicationRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveApplicationRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? leaveTypeId = null,
    Object? fromDate = null,
    Object? toDate = null,
    Object? reason = null,
    Object? emergencyContact = freezed,
    Object? handoverNotes = freezed,
    Object? substituteEmployeeId = freezed,
    Object? isEmergency = freezed,
    Object? isHalfDay = freezed,
    Object? halfDaySession = freezed,
  }) {
    return _then(_value.copyWith(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      leaveTypeId: null == leaveTypeId
          ? _value.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as int,
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      handoverNotes: freezed == handoverNotes
          ? _value.handoverNotes
          : handoverNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      substituteEmployeeId: freezed == substituteEmployeeId
          ? _value.substituteEmployeeId
          : substituteEmployeeId // ignore: cast_nullable_to_non_nullable
              as int?,
      isEmergency: freezed == isEmergency
          ? _value.isEmergency
          : isEmergency // ignore: cast_nullable_to_non_nullable
              as bool?,
      isHalfDay: freezed == isHalfDay
          ? _value.isHalfDay
          : isHalfDay // ignore: cast_nullable_to_non_nullable
              as bool?,
      halfDaySession: freezed == halfDaySession
          ? _value.halfDaySession
          : halfDaySession // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveApplicationRequestParamsImplCopyWith<$Res>
    implements $LeaveApplicationRequestParamsCopyWith<$Res> {
  factory _$$LeaveApplicationRequestParamsImplCopyWith(
          _$LeaveApplicationRequestParamsImpl value,
          $Res Function(_$LeaveApplicationRequestParamsImpl) then) =
      __$$LeaveApplicationRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'leave_type_id') int leaveTypeId,
      @JsonKey(name: 'from_date') String fromDate,
      @JsonKey(name: 'to_date') String toDate,
      String reason,
      @JsonKey(name: 'emergency_contact') String? emergencyContact,
      @JsonKey(name: 'handover_notes') String? handoverNotes,
      @JsonKey(name: 'substitute_employee_id') int? substituteEmployeeId,
      @JsonKey(name: 'is_emergency') bool? isEmergency,
      @JsonKey(name: 'is_half_day') bool? isHalfDay,
      @JsonKey(name: 'half_day_session') String? halfDaySession});
}

/// @nodoc
class __$$LeaveApplicationRequestParamsImplCopyWithImpl<$Res>
    extends _$LeaveApplicationRequestParamsCopyWithImpl<$Res,
        _$LeaveApplicationRequestParamsImpl>
    implements _$$LeaveApplicationRequestParamsImplCopyWith<$Res> {
  __$$LeaveApplicationRequestParamsImplCopyWithImpl(
      _$LeaveApplicationRequestParamsImpl _value,
      $Res Function(_$LeaveApplicationRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaveApplicationRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? leaveTypeId = null,
    Object? fromDate = null,
    Object? toDate = null,
    Object? reason = null,
    Object? emergencyContact = freezed,
    Object? handoverNotes = freezed,
    Object? substituteEmployeeId = freezed,
    Object? isEmergency = freezed,
    Object? isHalfDay = freezed,
    Object? halfDaySession = freezed,
  }) {
    return _then(_$LeaveApplicationRequestParamsImpl(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      leaveTypeId: null == leaveTypeId
          ? _value.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as int,
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      handoverNotes: freezed == handoverNotes
          ? _value.handoverNotes
          : handoverNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      substituteEmployeeId: freezed == substituteEmployeeId
          ? _value.substituteEmployeeId
          : substituteEmployeeId // ignore: cast_nullable_to_non_nullable
              as int?,
      isEmergency: freezed == isEmergency
          ? _value.isEmergency
          : isEmergency // ignore: cast_nullable_to_non_nullable
              as bool?,
      isHalfDay: freezed == isHalfDay
          ? _value.isHalfDay
          : isHalfDay // ignore: cast_nullable_to_non_nullable
              as bool?,
      halfDaySession: freezed == halfDaySession
          ? _value.halfDaySession
          : halfDaySession // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveApplicationRequestParamsImpl
    implements _LeaveApplicationRequestParams {
  const _$LeaveApplicationRequestParamsImpl(
      {@JsonKey(name: 'employee_id') required this.employeeId,
      @JsonKey(name: 'leave_type_id') required this.leaveTypeId,
      @JsonKey(name: 'from_date') required this.fromDate,
      @JsonKey(name: 'to_date') required this.toDate,
      required this.reason,
      @JsonKey(name: 'emergency_contact') this.emergencyContact,
      @JsonKey(name: 'handover_notes') this.handoverNotes,
      @JsonKey(name: 'substitute_employee_id') this.substituteEmployeeId,
      @JsonKey(name: 'is_emergency') this.isEmergency,
      @JsonKey(name: 'is_half_day') this.isHalfDay,
      @JsonKey(name: 'half_day_session') this.halfDaySession});

  factory _$LeaveApplicationRequestParamsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$LeaveApplicationRequestParamsImplFromJson(json);

  @override
  @JsonKey(name: 'employee_id')
  final int employeeId;
  @override
  @JsonKey(name: 'leave_type_id')
  final int leaveTypeId;
  @override
  @JsonKey(name: 'from_date')
  final String fromDate;
  @override
  @JsonKey(name: 'to_date')
  final String toDate;
  @override
  final String reason;
  @override
  @JsonKey(name: 'emergency_contact')
  final String? emergencyContact;
  @override
  @JsonKey(name: 'handover_notes')
  final String? handoverNotes;
  @override
  @JsonKey(name: 'substitute_employee_id')
  final int? substituteEmployeeId;
  @override
  @JsonKey(name: 'is_emergency')
  final bool? isEmergency;
  @override
  @JsonKey(name: 'is_half_day')
  final bool? isHalfDay;
  @override
  @JsonKey(name: 'half_day_session')
  final String? halfDaySession;

  @override
  String toString() {
    return 'LeaveApplicationRequestParams(employeeId: $employeeId, leaveTypeId: $leaveTypeId, fromDate: $fromDate, toDate: $toDate, reason: $reason, emergencyContact: $emergencyContact, handoverNotes: $handoverNotes, substituteEmployeeId: $substituteEmployeeId, isEmergency: $isEmergency, isHalfDay: $isHalfDay, halfDaySession: $halfDaySession)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveApplicationRequestParamsImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.leaveTypeId, leaveTypeId) ||
                other.leaveTypeId == leaveTypeId) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact) &&
            (identical(other.handoverNotes, handoverNotes) ||
                other.handoverNotes == handoverNotes) &&
            (identical(other.substituteEmployeeId, substituteEmployeeId) ||
                other.substituteEmployeeId == substituteEmployeeId) &&
            (identical(other.isEmergency, isEmergency) ||
                other.isEmergency == isEmergency) &&
            (identical(other.isHalfDay, isHalfDay) ||
                other.isHalfDay == isHalfDay) &&
            (identical(other.halfDaySession, halfDaySession) ||
                other.halfDaySession == halfDaySession));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      employeeId,
      leaveTypeId,
      fromDate,
      toDate,
      reason,
      emergencyContact,
      handoverNotes,
      substituteEmployeeId,
      isEmergency,
      isHalfDay,
      halfDaySession);

  /// Create a copy of LeaveApplicationRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveApplicationRequestParamsImplCopyWith<
          _$LeaveApplicationRequestParamsImpl>
      get copyWith => __$$LeaveApplicationRequestParamsImplCopyWithImpl<
          _$LeaveApplicationRequestParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveApplicationRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _LeaveApplicationRequestParams
    implements LeaveApplicationRequestParams {
  const factory _LeaveApplicationRequestParams(
      {@JsonKey(name: 'employee_id') required final int employeeId,
      @JsonKey(name: 'leave_type_id') required final int leaveTypeId,
      @JsonKey(name: 'from_date') required final String fromDate,
      @JsonKey(name: 'to_date') required final String toDate,
      required final String reason,
      @JsonKey(name: 'emergency_contact') final String? emergencyContact,
      @JsonKey(name: 'handover_notes') final String? handoverNotes,
      @JsonKey(name: 'substitute_employee_id') final int? substituteEmployeeId,
      @JsonKey(name: 'is_emergency') final bool? isEmergency,
      @JsonKey(name: 'is_half_day') final bool? isHalfDay,
      @JsonKey(name: 'half_day_session')
      final String? halfDaySession}) = _$LeaveApplicationRequestParamsImpl;

  factory _LeaveApplicationRequestParams.fromJson(Map<String, dynamic> json) =
      _$LeaveApplicationRequestParamsImpl.fromJson;

  @override
  @JsonKey(name: 'employee_id')
  int get employeeId;
  @override
  @JsonKey(name: 'leave_type_id')
  int get leaveTypeId;
  @override
  @JsonKey(name: 'from_date')
  String get fromDate;
  @override
  @JsonKey(name: 'to_date')
  String get toDate;
  @override
  String get reason;
  @override
  @JsonKey(name: 'emergency_contact')
  String? get emergencyContact;
  @override
  @JsonKey(name: 'handover_notes')
  String? get handoverNotes;
  @override
  @JsonKey(name: 'substitute_employee_id')
  int? get substituteEmployeeId;
  @override
  @JsonKey(name: 'is_emergency')
  bool? get isEmergency;
  @override
  @JsonKey(name: 'is_half_day')
  bool? get isHalfDay;
  @override
  @JsonKey(name: 'half_day_session')
  String? get halfDaySession;

  /// Create a copy of LeaveApplicationRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveApplicationRequestParamsImplCopyWith<
          _$LeaveApplicationRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
