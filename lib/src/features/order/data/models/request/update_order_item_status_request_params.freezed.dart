// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_order_item_status_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UpdateOrderItemStatusRequestParams {
  String get orderName => throw _privateConstructorUsedError;
  String get itemLineName => throw _privateConstructorUsedError;
  String get itemStatus => throw _privateConstructorUsedError;

  /// Create a copy of UpdateOrderItemStatusRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateOrderItemStatusRequestParamsCopyWith<
          UpdateOrderItemStatusRequestParams>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateOrderItemStatusRequestParamsCopyWith<$Res> {
  factory $UpdateOrderItemStatusRequestParamsCopyWith(
          UpdateOrderItemStatusRequestParams value,
          $Res Function(UpdateOrderItemStatusRequestParams) then) =
      _$UpdateOrderItemStatusRequestParamsCopyWithImpl<$Res,
          UpdateOrderItemStatusRequestParams>;
  @useResult
  $Res call({String orderName, String itemLineName, String itemStatus});
}

/// @nodoc
class _$UpdateOrderItemStatusRequestParamsCopyWithImpl<$Res,
        $Val extends UpdateOrderItemStatusRequestParams>
    implements $UpdateOrderItemStatusRequestParamsCopyWith<$Res> {
  _$UpdateOrderItemStatusRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateOrderItemStatusRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderName = null,
    Object? itemLineName = null,
    Object? itemStatus = null,
  }) {
    return _then(_value.copyWith(
      orderName: null == orderName
          ? _value.orderName
          : orderName // ignore: cast_nullable_to_non_nullable
              as String,
      itemLineName: null == itemLineName
          ? _value.itemLineName
          : itemLineName // ignore: cast_nullable_to_non_nullable
              as String,
      itemStatus: null == itemStatus
          ? _value.itemStatus
          : itemStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateOrderItemStatusRequestParamsImplCopyWith<$Res>
    implements $UpdateOrderItemStatusRequestParamsCopyWith<$Res> {
  factory _$$UpdateOrderItemStatusRequestParamsImplCopyWith(
          _$UpdateOrderItemStatusRequestParamsImpl value,
          $Res Function(_$UpdateOrderItemStatusRequestParamsImpl) then) =
      __$$UpdateOrderItemStatusRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String orderName, String itemLineName, String itemStatus});
}

/// @nodoc
class __$$UpdateOrderItemStatusRequestParamsImplCopyWithImpl<$Res>
    extends _$UpdateOrderItemStatusRequestParamsCopyWithImpl<$Res,
        _$UpdateOrderItemStatusRequestParamsImpl>
    implements _$$UpdateOrderItemStatusRequestParamsImplCopyWith<$Res> {
  __$$UpdateOrderItemStatusRequestParamsImplCopyWithImpl(
      _$UpdateOrderItemStatusRequestParamsImpl _value,
      $Res Function(_$UpdateOrderItemStatusRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateOrderItemStatusRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderName = null,
    Object? itemLineName = null,
    Object? itemStatus = null,
  }) {
    return _then(_$UpdateOrderItemStatusRequestParamsImpl(
      orderName: null == orderName
          ? _value.orderName
          : orderName // ignore: cast_nullable_to_non_nullable
              as String,
      itemLineName: null == itemLineName
          ? _value.itemLineName
          : itemLineName // ignore: cast_nullable_to_non_nullable
              as String,
      itemStatus: null == itemStatus
          ? _value.itemStatus
          : itemStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateOrderItemStatusRequestParamsImpl
    implements _UpdateOrderItemStatusRequestParams {
  const _$UpdateOrderItemStatusRequestParamsImpl(
      {required this.orderName,
      required this.itemLineName,
      required this.itemStatus});

  @override
  final String orderName;
  @override
  final String itemLineName;
  @override
  final String itemStatus;

  @override
  String toString() {
    return 'UpdateOrderItemStatusRequestParams(orderName: $orderName, itemLineName: $itemLineName, itemStatus: $itemStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateOrderItemStatusRequestParamsImpl &&
            (identical(other.orderName, orderName) ||
                other.orderName == orderName) &&
            (identical(other.itemLineName, itemLineName) ||
                other.itemLineName == itemLineName) &&
            (identical(other.itemStatus, itemStatus) ||
                other.itemStatus == itemStatus));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, orderName, itemLineName, itemStatus);

  /// Create a copy of UpdateOrderItemStatusRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateOrderItemStatusRequestParamsImplCopyWith<
          _$UpdateOrderItemStatusRequestParamsImpl>
      get copyWith => __$$UpdateOrderItemStatusRequestParamsImplCopyWithImpl<
          _$UpdateOrderItemStatusRequestParamsImpl>(this, _$identity);
}

abstract class _UpdateOrderItemStatusRequestParams
    implements UpdateOrderItemStatusRequestParams {
  const factory _UpdateOrderItemStatusRequestParams(
          {required final String orderName,
          required final String itemLineName,
          required final String itemStatus}) =
      _$UpdateOrderItemStatusRequestParamsImpl;

  @override
  String get orderName;
  @override
  String get itemLineName;
  @override
  String get itemStatus;

  /// Create a copy of UpdateOrderItemStatusRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateOrderItemStatusRequestParamsImplCopyWith<
          _$UpdateOrderItemStatusRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
