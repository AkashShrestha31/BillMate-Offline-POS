// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_orders_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GetOrdersRequestParams {
  OrderQueryParams? get query => throw _privateConstructorUsedError;

  /// Create a copy of GetOrdersRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetOrdersRequestParamsCopyWith<GetOrdersRequestParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetOrdersRequestParamsCopyWith<$Res> {
  factory $GetOrdersRequestParamsCopyWith(GetOrdersRequestParams value,
          $Res Function(GetOrdersRequestParams) then) =
      _$GetOrdersRequestParamsCopyWithImpl<$Res, GetOrdersRequestParams>;
  @useResult
  $Res call({OrderQueryParams? query});
}

/// @nodoc
class _$GetOrdersRequestParamsCopyWithImpl<$Res,
        $Val extends GetOrdersRequestParams>
    implements $GetOrdersRequestParamsCopyWith<$Res> {
  _$GetOrdersRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetOrdersRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = freezed,
  }) {
    return _then(_value.copyWith(
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as OrderQueryParams?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetOrdersRequestParamsImplCopyWith<$Res>
    implements $GetOrdersRequestParamsCopyWith<$Res> {
  factory _$$GetOrdersRequestParamsImplCopyWith(
          _$GetOrdersRequestParamsImpl value,
          $Res Function(_$GetOrdersRequestParamsImpl) then) =
      __$$GetOrdersRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({OrderQueryParams? query});
}

/// @nodoc
class __$$GetOrdersRequestParamsImplCopyWithImpl<$Res>
    extends _$GetOrdersRequestParamsCopyWithImpl<$Res,
        _$GetOrdersRequestParamsImpl>
    implements _$$GetOrdersRequestParamsImplCopyWith<$Res> {
  __$$GetOrdersRequestParamsImplCopyWithImpl(
      _$GetOrdersRequestParamsImpl _value,
      $Res Function(_$GetOrdersRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetOrdersRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = freezed,
  }) {
    return _then(_$GetOrdersRequestParamsImpl(
      query: freezed == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as OrderQueryParams?,
    ));
  }
}

/// @nodoc

class _$GetOrdersRequestParamsImpl implements _GetOrdersRequestParams {
  const _$GetOrdersRequestParamsImpl({this.query});

  @override
  final OrderQueryParams? query;

  @override
  String toString() {
    return 'GetOrdersRequestParams(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetOrdersRequestParamsImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of GetOrdersRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetOrdersRequestParamsImplCopyWith<_$GetOrdersRequestParamsImpl>
      get copyWith => __$$GetOrdersRequestParamsImplCopyWithImpl<
          _$GetOrdersRequestParamsImpl>(this, _$identity);
}

abstract class _GetOrdersRequestParams implements GetOrdersRequestParams {
  const factory _GetOrdersRequestParams({final OrderQueryParams? query}) =
      _$GetOrdersRequestParamsImpl;

  @override
  OrderQueryParams? get query;

  /// Create a copy of GetOrdersRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetOrdersRequestParamsImplCopyWith<_$GetOrdersRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
