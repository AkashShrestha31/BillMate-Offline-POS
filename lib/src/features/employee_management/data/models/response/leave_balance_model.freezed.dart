// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_balance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveBalanceModel _$LeaveBalanceModelFromJson(Map<String, dynamic> json) {
  return _LeaveBalanceModel.fromJson(json);
}

/// @nodoc
mixin _$LeaveBalanceModel {
  int get id => throw _privateConstructorUsedError;
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
  int get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_allocated')
  int get totalAllocated => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_used')
  int get totalUsed => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pending')
  int get totalPending => throw _privateConstructorUsedError;
  @JsonKey(name: 'balance_remaining')
  int get balanceRemaining => throw _privateConstructorUsedError;
  @JsonKey(name: 'carry_forward_from_previous')
  int? get carryForwardFromPrevious => throw _privateConstructorUsedError;
  @JsonKey(name: 'utilization_percentage')
  double? get utilizationPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_updated')
  String? get lastUpdated => throw _privateConstructorUsedError;
  String? get created => throw _privateConstructorUsedError;
  String? get modified => throw _privateConstructorUsedError;

  /// Serializes this LeaveBalanceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveBalanceModelCopyWith<LeaveBalanceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveBalanceModelCopyWith<$Res> {
  factory $LeaveBalanceModelCopyWith(
          LeaveBalanceModel value, $Res Function(LeaveBalanceModel) then) =
      _$LeaveBalanceModelCopyWithImpl<$Res, LeaveBalanceModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'leave_type_id') int leaveTypeId,
      @JsonKey(name: 'leave_type_name') String leaveTypeName,
      int year,
      @JsonKey(name: 'total_allocated') int totalAllocated,
      @JsonKey(name: 'total_used') int totalUsed,
      @JsonKey(name: 'total_pending') int totalPending,
      @JsonKey(name: 'balance_remaining') int balanceRemaining,
      @JsonKey(name: 'carry_forward_from_previous')
      int? carryForwardFromPrevious,
      @JsonKey(name: 'utilization_percentage') double? utilizationPercentage,
      @JsonKey(name: 'last_updated') String? lastUpdated,
      String? created,
      String? modified});
}

/// @nodoc
class _$LeaveBalanceModelCopyWithImpl<$Res, $Val extends LeaveBalanceModel>
    implements $LeaveBalanceModelCopyWith<$Res> {
  _$LeaveBalanceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? employeeCode = null,
    Object? leaveTypeId = null,
    Object? leaveTypeName = null,
    Object? year = null,
    Object? totalAllocated = null,
    Object? totalUsed = null,
    Object? totalPending = null,
    Object? balanceRemaining = null,
    Object? carryForwardFromPrevious = freezed,
    Object? utilizationPercentage = freezed,
    Object? lastUpdated = freezed,
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
      leaveTypeId: null == leaveTypeId
          ? _value.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as int,
      leaveTypeName: null == leaveTypeName
          ? _value.leaveTypeName
          : leaveTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      totalAllocated: null == totalAllocated
          ? _value.totalAllocated
          : totalAllocated // ignore: cast_nullable_to_non_nullable
              as int,
      totalUsed: null == totalUsed
          ? _value.totalUsed
          : totalUsed // ignore: cast_nullable_to_non_nullable
              as int,
      totalPending: null == totalPending
          ? _value.totalPending
          : totalPending // ignore: cast_nullable_to_non_nullable
              as int,
      balanceRemaining: null == balanceRemaining
          ? _value.balanceRemaining
          : balanceRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      carryForwardFromPrevious: freezed == carryForwardFromPrevious
          ? _value.carryForwardFromPrevious
          : carryForwardFromPrevious // ignore: cast_nullable_to_non_nullable
              as int?,
      utilizationPercentage: freezed == utilizationPercentage
          ? _value.utilizationPercentage
          : utilizationPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
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
abstract class _$$LeaveBalanceModelImplCopyWith<$Res>
    implements $LeaveBalanceModelCopyWith<$Res> {
  factory _$$LeaveBalanceModelImplCopyWith(_$LeaveBalanceModelImpl value,
          $Res Function(_$LeaveBalanceModelImpl) then) =
      __$$LeaveBalanceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'leave_type_id') int leaveTypeId,
      @JsonKey(name: 'leave_type_name') String leaveTypeName,
      int year,
      @JsonKey(name: 'total_allocated') int totalAllocated,
      @JsonKey(name: 'total_used') int totalUsed,
      @JsonKey(name: 'total_pending') int totalPending,
      @JsonKey(name: 'balance_remaining') int balanceRemaining,
      @JsonKey(name: 'carry_forward_from_previous')
      int? carryForwardFromPrevious,
      @JsonKey(name: 'utilization_percentage') double? utilizationPercentage,
      @JsonKey(name: 'last_updated') String? lastUpdated,
      String? created,
      String? modified});
}

/// @nodoc
class __$$LeaveBalanceModelImplCopyWithImpl<$Res>
    extends _$LeaveBalanceModelCopyWithImpl<$Res, _$LeaveBalanceModelImpl>
    implements _$$LeaveBalanceModelImplCopyWith<$Res> {
  __$$LeaveBalanceModelImplCopyWithImpl(_$LeaveBalanceModelImpl _value,
      $Res Function(_$LeaveBalanceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? employeeCode = null,
    Object? leaveTypeId = null,
    Object? leaveTypeName = null,
    Object? year = null,
    Object? totalAllocated = null,
    Object? totalUsed = null,
    Object? totalPending = null,
    Object? balanceRemaining = null,
    Object? carryForwardFromPrevious = freezed,
    Object? utilizationPercentage = freezed,
    Object? lastUpdated = freezed,
    Object? created = freezed,
    Object? modified = freezed,
  }) {
    return _then(_$LeaveBalanceModelImpl(
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
      leaveTypeId: null == leaveTypeId
          ? _value.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as int,
      leaveTypeName: null == leaveTypeName
          ? _value.leaveTypeName
          : leaveTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      totalAllocated: null == totalAllocated
          ? _value.totalAllocated
          : totalAllocated // ignore: cast_nullable_to_non_nullable
              as int,
      totalUsed: null == totalUsed
          ? _value.totalUsed
          : totalUsed // ignore: cast_nullable_to_non_nullable
              as int,
      totalPending: null == totalPending
          ? _value.totalPending
          : totalPending // ignore: cast_nullable_to_non_nullable
              as int,
      balanceRemaining: null == balanceRemaining
          ? _value.balanceRemaining
          : balanceRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      carryForwardFromPrevious: freezed == carryForwardFromPrevious
          ? _value.carryForwardFromPrevious
          : carryForwardFromPrevious // ignore: cast_nullable_to_non_nullable
              as int?,
      utilizationPercentage: freezed == utilizationPercentage
          ? _value.utilizationPercentage
          : utilizationPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
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
class _$LeaveBalanceModelImpl implements _LeaveBalanceModel {
  const _$LeaveBalanceModelImpl(
      {required this.id,
      @JsonKey(name: 'employee_id') required this.employeeId,
      @JsonKey(name: 'employee_name') required this.employeeName,
      @JsonKey(name: 'employee_code') required this.employeeCode,
      @JsonKey(name: 'leave_type_id') required this.leaveTypeId,
      @JsonKey(name: 'leave_type_name') required this.leaveTypeName,
      required this.year,
      @JsonKey(name: 'total_allocated') required this.totalAllocated,
      @JsonKey(name: 'total_used') required this.totalUsed,
      @JsonKey(name: 'total_pending') required this.totalPending,
      @JsonKey(name: 'balance_remaining') required this.balanceRemaining,
      @JsonKey(name: 'carry_forward_from_previous')
      this.carryForwardFromPrevious,
      @JsonKey(name: 'utilization_percentage') this.utilizationPercentage,
      @JsonKey(name: 'last_updated') this.lastUpdated,
      this.created,
      this.modified});

  factory _$LeaveBalanceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveBalanceModelImplFromJson(json);

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
  @JsonKey(name: 'leave_type_id')
  final int leaveTypeId;
  @override
  @JsonKey(name: 'leave_type_name')
  final String leaveTypeName;
  @override
  final int year;
  @override
  @JsonKey(name: 'total_allocated')
  final int totalAllocated;
  @override
  @JsonKey(name: 'total_used')
  final int totalUsed;
  @override
  @JsonKey(name: 'total_pending')
  final int totalPending;
  @override
  @JsonKey(name: 'balance_remaining')
  final int balanceRemaining;
  @override
  @JsonKey(name: 'carry_forward_from_previous')
  final int? carryForwardFromPrevious;
  @override
  @JsonKey(name: 'utilization_percentage')
  final double? utilizationPercentage;
  @override
  @JsonKey(name: 'last_updated')
  final String? lastUpdated;
  @override
  final String? created;
  @override
  final String? modified;

  @override
  String toString() {
    return 'LeaveBalanceModel(id: $id, employeeId: $employeeId, employeeName: $employeeName, employeeCode: $employeeCode, leaveTypeId: $leaveTypeId, leaveTypeName: $leaveTypeName, year: $year, totalAllocated: $totalAllocated, totalUsed: $totalUsed, totalPending: $totalPending, balanceRemaining: $balanceRemaining, carryForwardFromPrevious: $carryForwardFromPrevious, utilizationPercentage: $utilizationPercentage, lastUpdated: $lastUpdated, created: $created, modified: $modified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveBalanceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
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
            (identical(other.year, year) || other.year == year) &&
            (identical(other.totalAllocated, totalAllocated) ||
                other.totalAllocated == totalAllocated) &&
            (identical(other.totalUsed, totalUsed) ||
                other.totalUsed == totalUsed) &&
            (identical(other.totalPending, totalPending) ||
                other.totalPending == totalPending) &&
            (identical(other.balanceRemaining, balanceRemaining) ||
                other.balanceRemaining == balanceRemaining) &&
            (identical(
                    other.carryForwardFromPrevious, carryForwardFromPrevious) ||
                other.carryForwardFromPrevious == carryForwardFromPrevious) &&
            (identical(other.utilizationPercentage, utilizationPercentage) ||
                other.utilizationPercentage == utilizationPercentage) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.modified, modified) ||
                other.modified == modified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      employeeId,
      employeeName,
      employeeCode,
      leaveTypeId,
      leaveTypeName,
      year,
      totalAllocated,
      totalUsed,
      totalPending,
      balanceRemaining,
      carryForwardFromPrevious,
      utilizationPercentage,
      lastUpdated,
      created,
      modified);

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveBalanceModelImplCopyWith<_$LeaveBalanceModelImpl> get copyWith =>
      __$$LeaveBalanceModelImplCopyWithImpl<_$LeaveBalanceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveBalanceModelImplToJson(
      this,
    );
  }
}

abstract class _LeaveBalanceModel implements LeaveBalanceModel {
  const factory _LeaveBalanceModel(
      {required final int id,
      @JsonKey(name: 'employee_id') required final int employeeId,
      @JsonKey(name: 'employee_name') required final String employeeName,
      @JsonKey(name: 'employee_code') required final String employeeCode,
      @JsonKey(name: 'leave_type_id') required final int leaveTypeId,
      @JsonKey(name: 'leave_type_name') required final String leaveTypeName,
      required final int year,
      @JsonKey(name: 'total_allocated') required final int totalAllocated,
      @JsonKey(name: 'total_used') required final int totalUsed,
      @JsonKey(name: 'total_pending') required final int totalPending,
      @JsonKey(name: 'balance_remaining') required final int balanceRemaining,
      @JsonKey(name: 'carry_forward_from_previous')
      final int? carryForwardFromPrevious,
      @JsonKey(name: 'utilization_percentage')
      final double? utilizationPercentage,
      @JsonKey(name: 'last_updated') final String? lastUpdated,
      final String? created,
      final String? modified}) = _$LeaveBalanceModelImpl;

  factory _LeaveBalanceModel.fromJson(Map<String, dynamic> json) =
      _$LeaveBalanceModelImpl.fromJson;

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
  @JsonKey(name: 'leave_type_id')
  int get leaveTypeId;
  @override
  @JsonKey(name: 'leave_type_name')
  String get leaveTypeName;
  @override
  int get year;
  @override
  @JsonKey(name: 'total_allocated')
  int get totalAllocated;
  @override
  @JsonKey(name: 'total_used')
  int get totalUsed;
  @override
  @JsonKey(name: 'total_pending')
  int get totalPending;
  @override
  @JsonKey(name: 'balance_remaining')
  int get balanceRemaining;
  @override
  @JsonKey(name: 'carry_forward_from_previous')
  int? get carryForwardFromPrevious;
  @override
  @JsonKey(name: 'utilization_percentage')
  double? get utilizationPercentage;
  @override
  @JsonKey(name: 'last_updated')
  String? get lastUpdated;
  @override
  String? get created;
  @override
  String? get modified;

  /// Create a copy of LeaveBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveBalanceModelImplCopyWith<_$LeaveBalanceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
