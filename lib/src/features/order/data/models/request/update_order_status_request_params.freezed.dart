// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_order_status_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UpdateOrderStatusRequestParams {
  String get orderName => throw _privateConstructorUsedError;
  String get orderStatus => throw _privateConstructorUsedError;

  /// Create a copy of UpdateOrderStatusRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateOrderStatusRequestParamsCopyWith<UpdateOrderStatusRequestParams>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateOrderStatusRequestParamsCopyWith<$Res> {
  factory $UpdateOrderStatusRequestParamsCopyWith(
          UpdateOrderStatusRequestParams value,
          $Res Function(UpdateOrderStatusRequestParams) then) =
      _$UpdateOrderStatusRequestParamsCopyWithImpl<$Res,
          UpdateOrderStatusRequestParams>;
  @useResult
  $Res call({String orderName, String orderStatus});
}

/// @nodoc
class _$UpdateOrderStatusRequestParamsCopyWithImpl<$Res,
        $Val extends UpdateOrderStatusRequestParams>
    implements $UpdateOrderStatusRequestParamsCopyWith<$Res> {
  _$UpdateOrderStatusRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateOrderStatusRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderName = null,
    Object? orderStatus = null,
  }) {
    return _then(_value.copyWith(
      orderName: null == orderName
          ? _value.orderName
          : orderName // ignore: cast_nullable_to_non_nullable
              as String,
      orderStatus: null == orderStatus
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateOrderStatusRequestParamsImplCopyWith<$Res>
    implements $UpdateOrderStatusRequestParamsCopyWith<$Res> {
  factory _$$UpdateOrderStatusRequestParamsImplCopyWith(
          _$UpdateOrderStatusRequestParamsImpl value,
          $Res Function(_$UpdateOrderStatusRequestParamsImpl) then) =
      __$$UpdateOrderStatusRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String orderName, String orderStatus});
}

/// @nodoc
class __$$UpdateOrderStatusRequestParamsImplCopyWithImpl<$Res>
    extends _$UpdateOrderStatusRequestParamsCopyWithImpl<$Res,
        _$UpdateOrderStatusRequestParamsImpl>
    implements _$$UpdateOrderStatusRequestParamsImplCopyWith<$Res> {
  __$$UpdateOrderStatusRequestParamsImplCopyWithImpl(
      _$UpdateOrderStatusRequestParamsImpl _value,
      $Res Function(_$UpdateOrderStatusRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateOrderStatusRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderName = null,
    Object? orderStatus = null,
  }) {
    return _then(_$UpdateOrderStatusRequestParamsImpl(
      orderName: null == orderName
          ? _value.orderName
          : orderName // ignore: cast_nullable_to_non_nullable
              as String,
      orderStatus: null == orderStatus
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateOrderStatusRequestParamsImpl
    implements _UpdateOrderStatusRequestParams {
  const _$UpdateOrderStatusRequestParamsImpl(
      {required this.orderName, required this.orderStatus});

  @override
  final String orderName;
  @override
  final String orderStatus;

  @override
  String toString() {
    return 'UpdateOrderStatusRequestParams(orderName: $orderName, orderStatus: $orderStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateOrderStatusRequestParamsImpl &&
            (identical(other.orderName, orderName) ||
                other.orderName == orderName) &&
            (identical(other.orderStatus, orderStatus) ||
                other.orderStatus == orderStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderName, orderStatus);

  /// Create a copy of UpdateOrderStatusRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateOrderStatusRequestParamsImplCopyWith<
          _$UpdateOrderStatusRequestParamsImpl>
      get copyWith => __$$UpdateOrderStatusRequestParamsImplCopyWithImpl<
          _$UpdateOrderStatusRequestParamsImpl>(this, _$identity);
}

abstract class _UpdateOrderStatusRequestParams
    implements UpdateOrderStatusRequestParams {
  const factory _UpdateOrderStatusRequestParams(
          {required final String orderName,
          required final String orderStatus}) =
      _$UpdateOrderStatusRequestParamsImpl;

  @override
  String get orderName;
  @override
  String get orderStatus;

  /// Create a copy of UpdateOrderStatusRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateOrderStatusRequestParamsImplCopyWith<
          _$UpdateOrderStatusRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
