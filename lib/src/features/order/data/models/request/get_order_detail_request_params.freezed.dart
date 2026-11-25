// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_order_detail_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GetOrderDetailRequestParams {
  String get orderName => throw _privateConstructorUsedError;

  /// Create a copy of GetOrderDetailRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetOrderDetailRequestParamsCopyWith<GetOrderDetailRequestParams>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetOrderDetailRequestParamsCopyWith<$Res> {
  factory $GetOrderDetailRequestParamsCopyWith(
          GetOrderDetailRequestParams value,
          $Res Function(GetOrderDetailRequestParams) then) =
      _$GetOrderDetailRequestParamsCopyWithImpl<$Res,
          GetOrderDetailRequestParams>;
  @useResult
  $Res call({String orderName});
}

/// @nodoc
class _$GetOrderDetailRequestParamsCopyWithImpl<$Res,
        $Val extends GetOrderDetailRequestParams>
    implements $GetOrderDetailRequestParamsCopyWith<$Res> {
  _$GetOrderDetailRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetOrderDetailRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderName = null,
  }) {
    return _then(_value.copyWith(
      orderName: null == orderName
          ? _value.orderName
          : orderName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetOrderDetailRequestParamsImplCopyWith<$Res>
    implements $GetOrderDetailRequestParamsCopyWith<$Res> {
  factory _$$GetOrderDetailRequestParamsImplCopyWith(
          _$GetOrderDetailRequestParamsImpl value,
          $Res Function(_$GetOrderDetailRequestParamsImpl) then) =
      __$$GetOrderDetailRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String orderName});
}

/// @nodoc
class __$$GetOrderDetailRequestParamsImplCopyWithImpl<$Res>
    extends _$GetOrderDetailRequestParamsCopyWithImpl<$Res,
        _$GetOrderDetailRequestParamsImpl>
    implements _$$GetOrderDetailRequestParamsImplCopyWith<$Res> {
  __$$GetOrderDetailRequestParamsImplCopyWithImpl(
      _$GetOrderDetailRequestParamsImpl _value,
      $Res Function(_$GetOrderDetailRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetOrderDetailRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderName = null,
  }) {
    return _then(_$GetOrderDetailRequestParamsImpl(
      orderName: null == orderName
          ? _value.orderName
          : orderName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetOrderDetailRequestParamsImpl
    implements _GetOrderDetailRequestParams {
  const _$GetOrderDetailRequestParamsImpl({required this.orderName});

  @override
  final String orderName;

  @override
  String toString() {
    return 'GetOrderDetailRequestParams(orderName: $orderName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetOrderDetailRequestParamsImpl &&
            (identical(other.orderName, orderName) ||
                other.orderName == orderName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderName);

  /// Create a copy of GetOrderDetailRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetOrderDetailRequestParamsImplCopyWith<_$GetOrderDetailRequestParamsImpl>
      get copyWith => __$$GetOrderDetailRequestParamsImplCopyWithImpl<
          _$GetOrderDetailRequestParamsImpl>(this, _$identity);
}

abstract class _GetOrderDetailRequestParams
    implements GetOrderDetailRequestParams {
  const factory _GetOrderDetailRequestParams(
      {required final String orderName}) = _$GetOrderDetailRequestParamsImpl;

  @override
  String get orderName;

  /// Create a copy of GetOrderDetailRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetOrderDetailRequestParamsImplCopyWith<_$GetOrderDetailRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
