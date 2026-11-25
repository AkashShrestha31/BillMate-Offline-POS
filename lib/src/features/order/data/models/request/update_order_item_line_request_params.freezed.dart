// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_order_item_line_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UpdateOrderItemLineRequestParams {
  String get orderName => throw _privateConstructorUsedError;
  String get itemLineName => throw _privateConstructorUsedError;
  UpdateOrderItemRequest get body => throw _privateConstructorUsedError;

  /// Create a copy of UpdateOrderItemLineRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateOrderItemLineRequestParamsCopyWith<UpdateOrderItemLineRequestParams>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateOrderItemLineRequestParamsCopyWith<$Res> {
  factory $UpdateOrderItemLineRequestParamsCopyWith(
          UpdateOrderItemLineRequestParams value,
          $Res Function(UpdateOrderItemLineRequestParams) then) =
      _$UpdateOrderItemLineRequestParamsCopyWithImpl<$Res,
          UpdateOrderItemLineRequestParams>;
  @useResult
  $Res call(
      {String orderName, String itemLineName, UpdateOrderItemRequest body});

  $UpdateOrderItemRequestCopyWith<$Res> get body;
}

/// @nodoc
class _$UpdateOrderItemLineRequestParamsCopyWithImpl<$Res,
        $Val extends UpdateOrderItemLineRequestParams>
    implements $UpdateOrderItemLineRequestParamsCopyWith<$Res> {
  _$UpdateOrderItemLineRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateOrderItemLineRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderName = null,
    Object? itemLineName = null,
    Object? body = null,
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
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as UpdateOrderItemRequest,
    ) as $Val);
  }

  /// Create a copy of UpdateOrderItemLineRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UpdateOrderItemRequestCopyWith<$Res> get body {
    return $UpdateOrderItemRequestCopyWith<$Res>(_value.body, (value) {
      return _then(_value.copyWith(body: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UpdateOrderItemLineRequestParamsImplCopyWith<$Res>
    implements $UpdateOrderItemLineRequestParamsCopyWith<$Res> {
  factory _$$UpdateOrderItemLineRequestParamsImplCopyWith(
          _$UpdateOrderItemLineRequestParamsImpl value,
          $Res Function(_$UpdateOrderItemLineRequestParamsImpl) then) =
      __$$UpdateOrderItemLineRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String orderName, String itemLineName, UpdateOrderItemRequest body});

  @override
  $UpdateOrderItemRequestCopyWith<$Res> get body;
}

/// @nodoc
class __$$UpdateOrderItemLineRequestParamsImplCopyWithImpl<$Res>
    extends _$UpdateOrderItemLineRequestParamsCopyWithImpl<$Res,
        _$UpdateOrderItemLineRequestParamsImpl>
    implements _$$UpdateOrderItemLineRequestParamsImplCopyWith<$Res> {
  __$$UpdateOrderItemLineRequestParamsImplCopyWithImpl(
      _$UpdateOrderItemLineRequestParamsImpl _value,
      $Res Function(_$UpdateOrderItemLineRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateOrderItemLineRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderName = null,
    Object? itemLineName = null,
    Object? body = null,
  }) {
    return _then(_$UpdateOrderItemLineRequestParamsImpl(
      orderName: null == orderName
          ? _value.orderName
          : orderName // ignore: cast_nullable_to_non_nullable
              as String,
      itemLineName: null == itemLineName
          ? _value.itemLineName
          : itemLineName // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as UpdateOrderItemRequest,
    ));
  }
}

/// @nodoc

class _$UpdateOrderItemLineRequestParamsImpl
    implements _UpdateOrderItemLineRequestParams {
  const _$UpdateOrderItemLineRequestParamsImpl(
      {required this.orderName,
      required this.itemLineName,
      required this.body});

  @override
  final String orderName;
  @override
  final String itemLineName;
  @override
  final UpdateOrderItemRequest body;

  @override
  String toString() {
    return 'UpdateOrderItemLineRequestParams(orderName: $orderName, itemLineName: $itemLineName, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateOrderItemLineRequestParamsImpl &&
            (identical(other.orderName, orderName) ||
                other.orderName == orderName) &&
            (identical(other.itemLineName, itemLineName) ||
                other.itemLineName == itemLineName) &&
            (identical(other.body, body) || other.body == body));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderName, itemLineName, body);

  /// Create a copy of UpdateOrderItemLineRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateOrderItemLineRequestParamsImplCopyWith<
          _$UpdateOrderItemLineRequestParamsImpl>
      get copyWith => __$$UpdateOrderItemLineRequestParamsImplCopyWithImpl<
          _$UpdateOrderItemLineRequestParamsImpl>(this, _$identity);
}

abstract class _UpdateOrderItemLineRequestParams
    implements UpdateOrderItemLineRequestParams {
  const factory _UpdateOrderItemLineRequestParams(
          {required final String orderName,
          required final String itemLineName,
          required final UpdateOrderItemRequest body}) =
      _$UpdateOrderItemLineRequestParamsImpl;

  @override
  String get orderName;
  @override
  String get itemLineName;
  @override
  UpdateOrderItemRequest get body;

  /// Create a copy of UpdateOrderItemLineRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateOrderItemLineRequestParamsImplCopyWith<
          _$UpdateOrderItemLineRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
