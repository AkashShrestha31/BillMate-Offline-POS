// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_movement_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CashMovementRequest _$CashMovementRequestFromJson(Map<String, dynamic> json) {
  return _CashMovementRequest.fromJson(json);
}

/// @nodoc
mixin _$CashMovementRequest {
  @JsonKey(name: 'register_id')
  int get registerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'movement_type')
  String get movementType => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference_id')
  String? get referenceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;

  /// Serializes this CashMovementRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CashMovementRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashMovementRequestCopyWith<CashMovementRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashMovementRequestCopyWith<$Res> {
  factory $CashMovementRequestCopyWith(
          CashMovementRequest value, $Res Function(CashMovementRequest) then) =
      _$CashMovementRequestCopyWithImpl<$Res, CashMovementRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'register_id') int registerId,
      @JsonKey(name: 'movement_type') String movementType,
      double amount,
      String? reason,
      @JsonKey(name: 'reference_id') String? referenceId,
      @JsonKey(name: 'created_by') String createdBy});
}

/// @nodoc
class _$CashMovementRequestCopyWithImpl<$Res, $Val extends CashMovementRequest>
    implements $CashMovementRequestCopyWith<$Res> {
  _$CashMovementRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashMovementRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registerId = null,
    Object? movementType = null,
    Object? amount = null,
    Object? reason = freezed,
    Object? referenceId = freezed,
    Object? createdBy = null,
  }) {
    return _then(_value.copyWith(
      registerId: null == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as int,
      movementType: null == movementType
          ? _value.movementType
          : movementType // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CashMovementRequestImplCopyWith<$Res>
    implements $CashMovementRequestCopyWith<$Res> {
  factory _$$CashMovementRequestImplCopyWith(_$CashMovementRequestImpl value,
          $Res Function(_$CashMovementRequestImpl) then) =
      __$$CashMovementRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'register_id') int registerId,
      @JsonKey(name: 'movement_type') String movementType,
      double amount,
      String? reason,
      @JsonKey(name: 'reference_id') String? referenceId,
      @JsonKey(name: 'created_by') String createdBy});
}

/// @nodoc
class __$$CashMovementRequestImplCopyWithImpl<$Res>
    extends _$CashMovementRequestCopyWithImpl<$Res, _$CashMovementRequestImpl>
    implements _$$CashMovementRequestImplCopyWith<$Res> {
  __$$CashMovementRequestImplCopyWithImpl(_$CashMovementRequestImpl _value,
      $Res Function(_$CashMovementRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CashMovementRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registerId = null,
    Object? movementType = null,
    Object? amount = null,
    Object? reason = freezed,
    Object? referenceId = freezed,
    Object? createdBy = null,
  }) {
    return _then(_$CashMovementRequestImpl(
      registerId: null == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as int,
      movementType: null == movementType
          ? _value.movementType
          : movementType // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CashMovementRequestImpl implements _CashMovementRequest {
  const _$CashMovementRequestImpl(
      {@JsonKey(name: 'register_id') required this.registerId,
      @JsonKey(name: 'movement_type') required this.movementType,
      required this.amount,
      this.reason,
      @JsonKey(name: 'reference_id') this.referenceId,
      @JsonKey(name: 'created_by') required this.createdBy});

  factory _$CashMovementRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashMovementRequestImplFromJson(json);

  @override
  @JsonKey(name: 'register_id')
  final int registerId;
  @override
  @JsonKey(name: 'movement_type')
  final String movementType;
  @override
  final double amount;
  @override
  final String? reason;
  @override
  @JsonKey(name: 'reference_id')
  final String? referenceId;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;

  @override
  String toString() {
    return 'CashMovementRequest(registerId: $registerId, movementType: $movementType, amount: $amount, reason: $reason, referenceId: $referenceId, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashMovementRequestImpl &&
            (identical(other.registerId, registerId) ||
                other.registerId == registerId) &&
            (identical(other.movementType, movementType) ||
                other.movementType == movementType) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, registerId, movementType, amount,
      reason, referenceId, createdBy);

  /// Create a copy of CashMovementRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashMovementRequestImplCopyWith<_$CashMovementRequestImpl> get copyWith =>
      __$$CashMovementRequestImplCopyWithImpl<_$CashMovementRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashMovementRequestImplToJson(
      this,
    );
  }
}

abstract class _CashMovementRequest implements CashMovementRequest {
  const factory _CashMovementRequest(
          {@JsonKey(name: 'register_id') required final int registerId,
          @JsonKey(name: 'movement_type') required final String movementType,
          required final double amount,
          final String? reason,
          @JsonKey(name: 'reference_id') final String? referenceId,
          @JsonKey(name: 'created_by') required final String createdBy}) =
      _$CashMovementRequestImpl;

  factory _CashMovementRequest.fromJson(Map<String, dynamic> json) =
      _$CashMovementRequestImpl.fromJson;

  @override
  @JsonKey(name: 'register_id')
  int get registerId;
  @override
  @JsonKey(name: 'movement_type')
  String get movementType;
  @override
  double get amount;
  @override
  String? get reason;
  @override
  @JsonKey(name: 'reference_id')
  String? get referenceId;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;

  /// Create a copy of CashMovementRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashMovementRequestImplCopyWith<_$CashMovementRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
