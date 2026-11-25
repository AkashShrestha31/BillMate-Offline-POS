// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_order_item_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UpdateOrderItemRequest {
  double get quantity => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  String? get remarks => throw _privateConstructorUsedError;
  String? get modifiedBy => throw _privateConstructorUsedError;

  /// Create a copy of UpdateOrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateOrderItemRequestCopyWith<UpdateOrderItemRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateOrderItemRequestCopyWith<$Res> {
  factory $UpdateOrderItemRequestCopyWith(UpdateOrderItemRequest value,
          $Res Function(UpdateOrderItemRequest) then) =
      _$UpdateOrderItemRequestCopyWithImpl<$Res, UpdateOrderItemRequest>;
  @useResult
  $Res call(
      {double quantity,
      String? description,
      String? unit,
      String? remarks,
      String? modifiedBy});
}

/// @nodoc
class _$UpdateOrderItemRequestCopyWithImpl<$Res,
        $Val extends UpdateOrderItemRequest>
    implements $UpdateOrderItemRequestCopyWith<$Res> {
  _$UpdateOrderItemRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateOrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? description = freezed,
    Object? unit = freezed,
    Object? remarks = freezed,
    Object? modifiedBy = freezed,
  }) {
    return _then(_value.copyWith(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateOrderItemRequestImplCopyWith<$Res>
    implements $UpdateOrderItemRequestCopyWith<$Res> {
  factory _$$UpdateOrderItemRequestImplCopyWith(
          _$UpdateOrderItemRequestImpl value,
          $Res Function(_$UpdateOrderItemRequestImpl) then) =
      __$$UpdateOrderItemRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double quantity,
      String? description,
      String? unit,
      String? remarks,
      String? modifiedBy});
}

/// @nodoc
class __$$UpdateOrderItemRequestImplCopyWithImpl<$Res>
    extends _$UpdateOrderItemRequestCopyWithImpl<$Res,
        _$UpdateOrderItemRequestImpl>
    implements _$$UpdateOrderItemRequestImplCopyWith<$Res> {
  __$$UpdateOrderItemRequestImplCopyWithImpl(
      _$UpdateOrderItemRequestImpl _value,
      $Res Function(_$UpdateOrderItemRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateOrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? description = freezed,
    Object? unit = freezed,
    Object? remarks = freezed,
    Object? modifiedBy = freezed,
  }) {
    return _then(_$UpdateOrderItemRequestImpl(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UpdateOrderItemRequestImpl extends _UpdateOrderItemRequest {
  const _$UpdateOrderItemRequestImpl(
      {required this.quantity,
      this.description,
      this.unit,
      this.remarks,
      this.modifiedBy})
      : super._();

  @override
  final double quantity;
  @override
  final String? description;
  @override
  final String? unit;
  @override
  final String? remarks;
  @override
  final String? modifiedBy;

  @override
  String toString() {
    return 'UpdateOrderItemRequest(quantity: $quantity, description: $description, unit: $unit, remarks: $remarks, modifiedBy: $modifiedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateOrderItemRequestImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.remarks, remarks) || other.remarks == remarks) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, quantity, description, unit, remarks, modifiedBy);

  /// Create a copy of UpdateOrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateOrderItemRequestImplCopyWith<_$UpdateOrderItemRequestImpl>
      get copyWith => __$$UpdateOrderItemRequestImplCopyWithImpl<
          _$UpdateOrderItemRequestImpl>(this, _$identity);
}

abstract class _UpdateOrderItemRequest extends UpdateOrderItemRequest {
  const factory _UpdateOrderItemRequest(
      {required final double quantity,
      final String? description,
      final String? unit,
      final String? remarks,
      final String? modifiedBy}) = _$UpdateOrderItemRequestImpl;
  const _UpdateOrderItemRequest._() : super._();

  @override
  double get quantity;
  @override
  String? get description;
  @override
  String? get unit;
  @override
  String? get remarks;
  @override
  String? get modifiedBy;

  /// Create a copy of UpdateOrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateOrderItemRequestImplCopyWith<_$UpdateOrderItemRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
