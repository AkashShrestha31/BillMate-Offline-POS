// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_movement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CashMovementModel _$CashMovementModelFromJson(Map<String, dynamic> json) {
  return _CashMovementModel.fromJson(json);
}

/// @nodoc
mixin _$CashMovementModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'register_id')
  int get registerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'movement_type')
  String get movementType => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference_id')
  String? get referenceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  String? get created => throw _privateConstructorUsedError;

  /// Serializes this CashMovementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CashMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashMovementModelCopyWith<CashMovementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashMovementModelCopyWith<$Res> {
  factory $CashMovementModelCopyWith(
          CashMovementModel value, $Res Function(CashMovementModel) then) =
      _$CashMovementModelCopyWithImpl<$Res, CashMovementModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'register_id') int registerId,
      @JsonKey(name: 'movement_type') String movementType,
      double amount,
      String? reason,
      @JsonKey(name: 'reference_id') String? referenceId,
      @JsonKey(name: 'created_by') String? createdBy,
      String? created});
}

/// @nodoc
class _$CashMovementModelCopyWithImpl<$Res, $Val extends CashMovementModel>
    implements $CashMovementModelCopyWith<$Res> {
  _$CashMovementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? registerId = null,
    Object? movementType = null,
    Object? amount = null,
    Object? reason = freezed,
    Object? referenceId = freezed,
    Object? createdBy = freezed,
    Object? created = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CashMovementModelImplCopyWith<$Res>
    implements $CashMovementModelCopyWith<$Res> {
  factory _$$CashMovementModelImplCopyWith(_$CashMovementModelImpl value,
          $Res Function(_$CashMovementModelImpl) then) =
      __$$CashMovementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'register_id') int registerId,
      @JsonKey(name: 'movement_type') String movementType,
      double amount,
      String? reason,
      @JsonKey(name: 'reference_id') String? referenceId,
      @JsonKey(name: 'created_by') String? createdBy,
      String? created});
}

/// @nodoc
class __$$CashMovementModelImplCopyWithImpl<$Res>
    extends _$CashMovementModelCopyWithImpl<$Res, _$CashMovementModelImpl>
    implements _$$CashMovementModelImplCopyWith<$Res> {
  __$$CashMovementModelImplCopyWithImpl(_$CashMovementModelImpl _value,
      $Res Function(_$CashMovementModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CashMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? registerId = null,
    Object? movementType = null,
    Object? amount = null,
    Object? reason = freezed,
    Object? referenceId = freezed,
    Object? createdBy = freezed,
    Object? created = freezed,
  }) {
    return _then(_$CashMovementModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CashMovementModelImpl implements _CashMovementModel {
  const _$CashMovementModelImpl(
      {required this.id,
      @JsonKey(name: 'register_id') required this.registerId,
      @JsonKey(name: 'movement_type') required this.movementType,
      required this.amount,
      this.reason,
      @JsonKey(name: 'reference_id') this.referenceId,
      @JsonKey(name: 'created_by') this.createdBy,
      this.created});

  factory _$CashMovementModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashMovementModelImplFromJson(json);

  @override
  final int id;
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
  final String? createdBy;
  @override
  final String? created;

  @override
  String toString() {
    return 'CashMovementModel(id: $id, registerId: $registerId, movementType: $movementType, amount: $amount, reason: $reason, referenceId: $referenceId, createdBy: $createdBy, created: $created)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashMovementModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.registerId, registerId) ||
                other.registerId == registerId) &&
            (identical(other.movementType, movementType) ||
                other.movementType == movementType) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.created, created) || other.created == created));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, registerId, movementType,
      amount, reason, referenceId, createdBy, created);

  /// Create a copy of CashMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashMovementModelImplCopyWith<_$CashMovementModelImpl> get copyWith =>
      __$$CashMovementModelImplCopyWithImpl<_$CashMovementModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashMovementModelImplToJson(
      this,
    );
  }
}

abstract class _CashMovementModel implements CashMovementModel {
  const factory _CashMovementModel(
      {required final int id,
      @JsonKey(name: 'register_id') required final int registerId,
      @JsonKey(name: 'movement_type') required final String movementType,
      required final double amount,
      final String? reason,
      @JsonKey(name: 'reference_id') final String? referenceId,
      @JsonKey(name: 'created_by') final String? createdBy,
      final String? created}) = _$CashMovementModelImpl;

  factory _CashMovementModel.fromJson(Map<String, dynamic> json) =
      _$CashMovementModelImpl.fromJson;

  @override
  int get id;
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
  String? get createdBy;
  @override
  String? get created;

  /// Create a copy of CashMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashMovementModelImplCopyWith<_$CashMovementModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
