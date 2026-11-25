// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_application_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveApplicationModel _$LeaveApplicationModelFromJson(
    Map<String, dynamic> json) {
  return _LeaveApplicationModel.fromJson(json);
}

/// @nodoc
mixin _$LeaveApplicationModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'application_number')
  String get applicationNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_id')
  int get employeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_name')
  String get employeeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_code')
  String get employeeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'leave_type_id')
  int get leaveTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'leave_type_name')
  String get leaveTypeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_date')
  String get fromDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_date')
  String get toDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_days')
  double get totalDays => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  @JsonKey(name: 'emergency_contact')
  String? get emergencyContact => throw _privateConstructorUsedError;
  @JsonKey(name: 'handover_notes')
  String? get handoverNotes => throw _privateConstructorUsedError;
  @JsonKey(name: 'application_date')
  String get applicationDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'approved_by')
  String? get approvedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'approved_date')
  String? get approvedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'rejection_reason')
  String? get rejectionReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'manager_comments')
  String? get managerComments => throw _privateConstructorUsedError;
  @JsonKey(name: 'hr_comments')
  String? get hrComments => throw _privateConstructorUsedError;
  String? get attachment => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_emergency')
  bool get isEmergency => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_half_day')
  bool get isHalfDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'half_day_session')
  String? get halfDaySession => throw _privateConstructorUsedError;
  @JsonKey(name: 'substitute_employee_id')
  int? get substituteEmployeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'substitute_name')
  String? get substituteName => throw _privateConstructorUsedError;
  String? get created => throw _privateConstructorUsedError;
  String? get modified => throw _privateConstructorUsedError;

  /// Serializes this LeaveApplicationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveApplicationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveApplicationModelCopyWith<LeaveApplicationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveApplicationModelCopyWith<$Res> {
  factory $LeaveApplicationModelCopyWith(LeaveApplicationModel value,
          $Res Function(LeaveApplicationModel) then) =
      _$LeaveApplicationModelCopyWithImpl<$Res, LeaveApplicationModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'application_number') String applicationNumber,
      @JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'leave_type_id') int leaveTypeId,
      @JsonKey(name: 'leave_type_name') String leaveTypeName,
      @JsonKey(name: 'from_date') String fromDate,
      @JsonKey(name: 'to_date') String toDate,
      @JsonKey(name: 'total_days') double totalDays,
      String reason,
      @JsonKey(name: 'emergency_contact') String? emergencyContact,
      @JsonKey(name: 'handover_notes') String? handoverNotes,
      @JsonKey(name: 'application_date') String applicationDate,
      String status,
      @JsonKey(name: 'approved_by') String? approvedBy,
      @JsonKey(name: 'approved_date') String? approvedDate,
      @JsonKey(name: 'rejection_reason') String? rejectionReason,
      @JsonKey(name: 'manager_comments') String? managerComments,
      @JsonKey(name: 'hr_comments') String? hrComments,
      String? attachment,
      @JsonKey(name: 'is_emergency') bool isEmergency,
      @JsonKey(name: 'is_half_day') bool isHalfDay,
      @JsonKey(name: 'half_day_session') String? halfDaySession,
      @JsonKey(name: 'substitute_employee_id') int? substituteEmployeeId,
      @JsonKey(name: 'substitute_name') String? substituteName,
      String? created,
      String? modified});
}

/// @nodoc
class _$LeaveApplicationModelCopyWithImpl<$Res,
        $Val extends LeaveApplicationModel>
    implements $LeaveApplicationModelCopyWith<$Res> {
  _$LeaveApplicationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveApplicationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? applicationNumber = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? employeeCode = null,
    Object? leaveTypeId = null,
    Object? leaveTypeName = null,
    Object? fromDate = null,
    Object? toDate = null,
    Object? totalDays = null,
    Object? reason = null,
    Object? emergencyContact = freezed,
    Object? handoverNotes = freezed,
    Object? applicationDate = null,
    Object? status = null,
    Object? approvedBy = freezed,
    Object? approvedDate = freezed,
    Object? rejectionReason = freezed,
    Object? managerComments = freezed,
    Object? hrComments = freezed,
    Object? attachment = freezed,
    Object? isEmergency = null,
    Object? isHalfDay = null,
    Object? halfDaySession = freezed,
    Object? substituteEmployeeId = freezed,
    Object? substituteName = freezed,
    Object? created = freezed,
    Object? modified = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      applicationNumber: null == applicationNumber
          ? _value.applicationNumber
          : applicationNumber // ignore: cast_nullable_to_non_nullable
              as String,
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
      leaveTypeId: null == leaveTypeId
          ? _value.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as int,
      leaveTypeName: null == leaveTypeName
          ? _value.leaveTypeName
          : leaveTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
      totalDays: null == totalDays
          ? _value.totalDays
          : totalDays // ignore: cast_nullable_to_non_nullable
              as double,
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
      applicationDate: null == applicationDate
          ? _value.applicationDate
          : applicationDate // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedDate: freezed == approvedDate
          ? _value.approvedDate
          : approvedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      managerComments: freezed == managerComments
          ? _value.managerComments
          : managerComments // ignore: cast_nullable_to_non_nullable
              as String?,
      hrComments: freezed == hrComments
          ? _value.hrComments
          : hrComments // ignore: cast_nullable_to_non_nullable
              as String?,
      attachment: freezed == attachment
          ? _value.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as String?,
      isEmergency: null == isEmergency
          ? _value.isEmergency
          : isEmergency // ignore: cast_nullable_to_non_nullable
              as bool,
      isHalfDay: null == isHalfDay
          ? _value.isHalfDay
          : isHalfDay // ignore: cast_nullable_to_non_nullable
              as bool,
      halfDaySession: freezed == halfDaySession
          ? _value.halfDaySession
          : halfDaySession // ignore: cast_nullable_to_non_nullable
              as String?,
      substituteEmployeeId: freezed == substituteEmployeeId
          ? _value.substituteEmployeeId
          : substituteEmployeeId // ignore: cast_nullable_to_non_nullable
              as int?,
      substituteName: freezed == substituteName
          ? _value.substituteName
          : substituteName // ignore: cast_nullable_to_non_nullable
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
abstract class _$$LeaveApplicationModelImplCopyWith<$Res>
    implements $LeaveApplicationModelCopyWith<$Res> {
  factory _$$LeaveApplicationModelImplCopyWith(
          _$LeaveApplicationModelImpl value,
          $Res Function(_$LeaveApplicationModelImpl) then) =
      __$$LeaveApplicationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'application_number') String applicationNumber,
      @JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'leave_type_id') int leaveTypeId,
      @JsonKey(name: 'leave_type_name') String leaveTypeName,
      @JsonKey(name: 'from_date') String fromDate,
      @JsonKey(name: 'to_date') String toDate,
      @JsonKey(name: 'total_days') double totalDays,
      String reason,
      @JsonKey(name: 'emergency_contact') String? emergencyContact,
      @JsonKey(name: 'handover_notes') String? handoverNotes,
      @JsonKey(name: 'application_date') String applicationDate,
      String status,
      @JsonKey(name: 'approved_by') String? approvedBy,
      @JsonKey(name: 'approved_date') String? approvedDate,
      @JsonKey(name: 'rejection_reason') String? rejectionReason,
      @JsonKey(name: 'manager_comments') String? managerComments,
      @JsonKey(name: 'hr_comments') String? hrComments,
      String? attachment,
      @JsonKey(name: 'is_emergency') bool isEmergency,
      @JsonKey(name: 'is_half_day') bool isHalfDay,
      @JsonKey(name: 'half_day_session') String? halfDaySession,
      @JsonKey(name: 'substitute_employee_id') int? substituteEmployeeId,
      @JsonKey(name: 'substitute_name') String? substituteName,
      String? created,
      String? modified});
}

/// @nodoc
class __$$LeaveApplicationModelImplCopyWithImpl<$Res>
    extends _$LeaveApplicationModelCopyWithImpl<$Res,
        _$LeaveApplicationModelImpl>
    implements _$$LeaveApplicationModelImplCopyWith<$Res> {
  __$$LeaveApplicationModelImplCopyWithImpl(_$LeaveApplicationModelImpl _value,
      $Res Function(_$LeaveApplicationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaveApplicationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? applicationNumber = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? employeeCode = null,
    Object? leaveTypeId = null,
    Object? leaveTypeName = null,
    Object? fromDate = null,
    Object? toDate = null,
    Object? totalDays = null,
    Object? reason = null,
    Object? emergencyContact = freezed,
    Object? handoverNotes = freezed,
    Object? applicationDate = null,
    Object? status = null,
    Object? approvedBy = freezed,
    Object? approvedDate = freezed,
    Object? rejectionReason = freezed,
    Object? managerComments = freezed,
    Object? hrComments = freezed,
    Object? attachment = freezed,
    Object? isEmergency = null,
    Object? isHalfDay = null,
    Object? halfDaySession = freezed,
    Object? substituteEmployeeId = freezed,
    Object? substituteName = freezed,
    Object? created = freezed,
    Object? modified = freezed,
  }) {
    return _then(_$LeaveApplicationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      applicationNumber: null == applicationNumber
          ? _value.applicationNumber
          : applicationNumber // ignore: cast_nullable_to_non_nullable
              as String,
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
      leaveTypeId: null == leaveTypeId
          ? _value.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as int,
      leaveTypeName: null == leaveTypeName
          ? _value.leaveTypeName
          : leaveTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
      totalDays: null == totalDays
          ? _value.totalDays
          : totalDays // ignore: cast_nullable_to_non_nullable
              as double,
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
      applicationDate: null == applicationDate
          ? _value.applicationDate
          : applicationDate // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedDate: freezed == approvedDate
          ? _value.approvedDate
          : approvedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      managerComments: freezed == managerComments
          ? _value.managerComments
          : managerComments // ignore: cast_nullable_to_non_nullable
              as String?,
      hrComments: freezed == hrComments
          ? _value.hrComments
          : hrComments // ignore: cast_nullable_to_non_nullable
              as String?,
      attachment: freezed == attachment
          ? _value.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as String?,
      isEmergency: null == isEmergency
          ? _value.isEmergency
          : isEmergency // ignore: cast_nullable_to_non_nullable
              as bool,
      isHalfDay: null == isHalfDay
          ? _value.isHalfDay
          : isHalfDay // ignore: cast_nullable_to_non_nullable
              as bool,
      halfDaySession: freezed == halfDaySession
          ? _value.halfDaySession
          : halfDaySession // ignore: cast_nullable_to_non_nullable
              as String?,
      substituteEmployeeId: freezed == substituteEmployeeId
          ? _value.substituteEmployeeId
          : substituteEmployeeId // ignore: cast_nullable_to_non_nullable
              as int?,
      substituteName: freezed == substituteName
          ? _value.substituteName
          : substituteName // ignore: cast_nullable_to_non_nullable
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
class _$LeaveApplicationModelImpl implements _LeaveApplicationModel {
  const _$LeaveApplicationModelImpl(
      {required this.id,
      @JsonKey(name: 'application_number') required this.applicationNumber,
      @JsonKey(name: 'employee_id') required this.employeeId,
      @JsonKey(name: 'employee_name') required this.employeeName,
      @JsonKey(name: 'employee_code') required this.employeeCode,
      @JsonKey(name: 'leave_type_id') required this.leaveTypeId,
      @JsonKey(name: 'leave_type_name') required this.leaveTypeName,
      @JsonKey(name: 'from_date') required this.fromDate,
      @JsonKey(name: 'to_date') required this.toDate,
      @JsonKey(name: 'total_days') required this.totalDays,
      required this.reason,
      @JsonKey(name: 'emergency_contact') this.emergencyContact,
      @JsonKey(name: 'handover_notes') this.handoverNotes,
      @JsonKey(name: 'application_date') required this.applicationDate,
      required this.status,
      @JsonKey(name: 'approved_by') this.approvedBy,
      @JsonKey(name: 'approved_date') this.approvedDate,
      @JsonKey(name: 'rejection_reason') this.rejectionReason,
      @JsonKey(name: 'manager_comments') this.managerComments,
      @JsonKey(name: 'hr_comments') this.hrComments,
      this.attachment,
      @JsonKey(name: 'is_emergency') required this.isEmergency,
      @JsonKey(name: 'is_half_day') required this.isHalfDay,
      @JsonKey(name: 'half_day_session') this.halfDaySession,
      @JsonKey(name: 'substitute_employee_id') this.substituteEmployeeId,
      @JsonKey(name: 'substitute_name') this.substituteName,
      this.created,
      this.modified});

  factory _$LeaveApplicationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveApplicationModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'application_number')
  final String applicationNumber;
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
  @JsonKey(name: 'leave_type_id')
  final int leaveTypeId;
  @override
  @JsonKey(name: 'leave_type_name')
  final String leaveTypeName;
  @override
  @JsonKey(name: 'from_date')
  final String fromDate;
  @override
  @JsonKey(name: 'to_date')
  final String toDate;
  @override
  @JsonKey(name: 'total_days')
  final double totalDays;
  @override
  final String reason;
  @override
  @JsonKey(name: 'emergency_contact')
  final String? emergencyContact;
  @override
  @JsonKey(name: 'handover_notes')
  final String? handoverNotes;
  @override
  @JsonKey(name: 'application_date')
  final String applicationDate;
  @override
  final String status;
  @override
  @JsonKey(name: 'approved_by')
  final String? approvedBy;
  @override
  @JsonKey(name: 'approved_date')
  final String? approvedDate;
  @override
  @JsonKey(name: 'rejection_reason')
  final String? rejectionReason;
  @override
  @JsonKey(name: 'manager_comments')
  final String? managerComments;
  @override
  @JsonKey(name: 'hr_comments')
  final String? hrComments;
  @override
  final String? attachment;
  @override
  @JsonKey(name: 'is_emergency')
  final bool isEmergency;
  @override
  @JsonKey(name: 'is_half_day')
  final bool isHalfDay;
  @override
  @JsonKey(name: 'half_day_session')
  final String? halfDaySession;
  @override
  @JsonKey(name: 'substitute_employee_id')
  final int? substituteEmployeeId;
  @override
  @JsonKey(name: 'substitute_name')
  final String? substituteName;
  @override
  final String? created;
  @override
  final String? modified;

  @override
  String toString() {
    return 'LeaveApplicationModel(id: $id, applicationNumber: $applicationNumber, employeeId: $employeeId, employeeName: $employeeName, employeeCode: $employeeCode, leaveTypeId: $leaveTypeId, leaveTypeName: $leaveTypeName, fromDate: $fromDate, toDate: $toDate, totalDays: $totalDays, reason: $reason, emergencyContact: $emergencyContact, handoverNotes: $handoverNotes, applicationDate: $applicationDate, status: $status, approvedBy: $approvedBy, approvedDate: $approvedDate, rejectionReason: $rejectionReason, managerComments: $managerComments, hrComments: $hrComments, attachment: $attachment, isEmergency: $isEmergency, isHalfDay: $isHalfDay, halfDaySession: $halfDaySession, substituteEmployeeId: $substituteEmployeeId, substituteName: $substituteName, created: $created, modified: $modified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveApplicationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.applicationNumber, applicationNumber) ||
                other.applicationNumber == applicationNumber) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.leaveTypeId, leaveTypeId) ||
                other.leaveTypeId == leaveTypeId) &&
            (identical(other.leaveTypeName, leaveTypeName) ||
                other.leaveTypeName == leaveTypeName) &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.totalDays, totalDays) ||
                other.totalDays == totalDays) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact) &&
            (identical(other.handoverNotes, handoverNotes) ||
                other.handoverNotes == handoverNotes) &&
            (identical(other.applicationDate, applicationDate) ||
                other.applicationDate == applicationDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedDate, approvedDate) ||
                other.approvedDate == approvedDate) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.managerComments, managerComments) ||
                other.managerComments == managerComments) &&
            (identical(other.hrComments, hrComments) ||
                other.hrComments == hrComments) &&
            (identical(other.attachment, attachment) ||
                other.attachment == attachment) &&
            (identical(other.isEmergency, isEmergency) ||
                other.isEmergency == isEmergency) &&
            (identical(other.isHalfDay, isHalfDay) ||
                other.isHalfDay == isHalfDay) &&
            (identical(other.halfDaySession, halfDaySession) ||
                other.halfDaySession == halfDaySession) &&
            (identical(other.substituteEmployeeId, substituteEmployeeId) ||
                other.substituteEmployeeId == substituteEmployeeId) &&
            (identical(other.substituteName, substituteName) ||
                other.substituteName == substituteName) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.modified, modified) ||
                other.modified == modified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        applicationNumber,
        employeeId,
        employeeName,
        employeeCode,
        leaveTypeId,
        leaveTypeName,
        fromDate,
        toDate,
        totalDays,
        reason,
        emergencyContact,
        handoverNotes,
        applicationDate,
        status,
        approvedBy,
        approvedDate,
        rejectionReason,
        managerComments,
        hrComments,
        attachment,
        isEmergency,
        isHalfDay,
        halfDaySession,
        substituteEmployeeId,
        substituteName,
        created,
        modified
      ]);

  /// Create a copy of LeaveApplicationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveApplicationModelImplCopyWith<_$LeaveApplicationModelImpl>
      get copyWith => __$$LeaveApplicationModelImplCopyWithImpl<
          _$LeaveApplicationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveApplicationModelImplToJson(
      this,
    );
  }
}

abstract class _LeaveApplicationModel implements LeaveApplicationModel {
  const factory _LeaveApplicationModel(
      {required final int id,
      @JsonKey(name: 'application_number')
      required final String applicationNumber,
      @JsonKey(name: 'employee_id') required final int employeeId,
      @JsonKey(name: 'employee_name') required final String employeeName,
      @JsonKey(name: 'employee_code') required final String employeeCode,
      @JsonKey(name: 'leave_type_id') required final int leaveTypeId,
      @JsonKey(name: 'leave_type_name') required final String leaveTypeName,
      @JsonKey(name: 'from_date') required final String fromDate,
      @JsonKey(name: 'to_date') required final String toDate,
      @JsonKey(name: 'total_days') required final double totalDays,
      required final String reason,
      @JsonKey(name: 'emergency_contact') final String? emergencyContact,
      @JsonKey(name: 'handover_notes') final String? handoverNotes,
      @JsonKey(name: 'application_date') required final String applicationDate,
      required final String status,
      @JsonKey(name: 'approved_by') final String? approvedBy,
      @JsonKey(name: 'approved_date') final String? approvedDate,
      @JsonKey(name: 'rejection_reason') final String? rejectionReason,
      @JsonKey(name: 'manager_comments') final String? managerComments,
      @JsonKey(name: 'hr_comments') final String? hrComments,
      final String? attachment,
      @JsonKey(name: 'is_emergency') required final bool isEmergency,
      @JsonKey(name: 'is_half_day') required final bool isHalfDay,
      @JsonKey(name: 'half_day_session') final String? halfDaySession,
      @JsonKey(name: 'substitute_employee_id') final int? substituteEmployeeId,
      @JsonKey(name: 'substitute_name') final String? substituteName,
      final String? created,
      final String? modified}) = _$LeaveApplicationModelImpl;

  factory _LeaveApplicationModel.fromJson(Map<String, dynamic> json) =
      _$LeaveApplicationModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'application_number')
  String get applicationNumber;
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
  @JsonKey(name: 'leave_type_id')
  int get leaveTypeId;
  @override
  @JsonKey(name: 'leave_type_name')
  String get leaveTypeName;
  @override
  @JsonKey(name: 'from_date')
  String get fromDate;
  @override
  @JsonKey(name: 'to_date')
  String get toDate;
  @override
  @JsonKey(name: 'total_days')
  double get totalDays;
  @override
  String get reason;
  @override
  @JsonKey(name: 'emergency_contact')
  String? get emergencyContact;
  @override
  @JsonKey(name: 'handover_notes')
  String? get handoverNotes;
  @override
  @JsonKey(name: 'application_date')
  String get applicationDate;
  @override
  String get status;
  @override
  @JsonKey(name: 'approved_by')
  String? get approvedBy;
  @override
  @JsonKey(name: 'approved_date')
  String? get approvedDate;
  @override
  @JsonKey(name: 'rejection_reason')
  String? get rejectionReason;
  @override
  @JsonKey(name: 'manager_comments')
  String? get managerComments;
  @override
  @JsonKey(name: 'hr_comments')
  String? get hrComments;
  @override
  String? get attachment;
  @override
  @JsonKey(name: 'is_emergency')
  bool get isEmergency;
  @override
  @JsonKey(name: 'is_half_day')
  bool get isHalfDay;
  @override
  @JsonKey(name: 'half_day_session')
  String? get halfDaySession;
  @override
  @JsonKey(name: 'substitute_employee_id')
  int? get substituteEmployeeId;
  @override
  @JsonKey(name: 'substitute_name')
  String? get substituteName;
  @override
  String? get created;
  @override
  String? get modified;

  /// Create a copy of LeaveApplicationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveApplicationModelImplCopyWith<_$LeaveApplicationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
