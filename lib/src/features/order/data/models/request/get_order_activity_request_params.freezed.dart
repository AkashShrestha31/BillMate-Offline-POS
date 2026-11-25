// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_order_activity_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GetOrderActivityRequestParams {
  String get orderName => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get perPage => throw _privateConstructorUsedError;

  /// Create a copy of GetOrderActivityRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetOrderActivityRequestParamsCopyWith<GetOrderActivityRequestParams>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetOrderActivityRequestParamsCopyWith<$Res> {
  factory $GetOrderActivityRequestParamsCopyWith(
          GetOrderActivityRequestParams value,
          $Res Function(GetOrderActivityRequestParams) then) =
      _$GetOrderActivityRequestParamsCopyWithImpl<$Res,
          GetOrderActivityRequestParams>;
  @useResult
  $Res call({String orderName, int page, int perPage});
}

/// @nodoc
class _$GetOrderActivityRequestParamsCopyWithImpl<$Res,
        $Val extends GetOrderActivityRequestParams>
    implements $GetOrderActivityRequestParamsCopyWith<$Res> {
  _$GetOrderActivityRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetOrderActivityRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderName = null,
    Object? page = null,
    Object? perPage = null,
  }) {
    return _then(_value.copyWith(
      orderName: null == orderName
          ? _value.orderName
          : orderName // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetOrderActivityRequestParamsImplCopyWith<$Res>
    implements $GetOrderActivityRequestParamsCopyWith<$Res> {
  factory _$$GetOrderActivityRequestParamsImplCopyWith(
          _$GetOrderActivityRequestParamsImpl value,
          $Res Function(_$GetOrderActivityRequestParamsImpl) then) =
      __$$GetOrderActivityRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String orderName, int page, int perPage});
}

/// @nodoc
class __$$GetOrderActivityRequestParamsImplCopyWithImpl<$Res>
    extends _$GetOrderActivityRequestParamsCopyWithImpl<$Res,
        _$GetOrderActivityRequestParamsImpl>
    implements _$$GetOrderActivityRequestParamsImplCopyWith<$Res> {
  __$$GetOrderActivityRequestParamsImplCopyWithImpl(
      _$GetOrderActivityRequestParamsImpl _value,
      $Res Function(_$GetOrderActivityRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetOrderActivityRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderName = null,
    Object? page = null,
    Object? perPage = null,
  }) {
    return _then(_$GetOrderActivityRequestParamsImpl(
      orderName: null == orderName
          ? _value.orderName
          : orderName // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GetOrderActivityRequestParamsImpl
    implements _GetOrderActivityRequestParams {
  const _$GetOrderActivityRequestParamsImpl(
      {required this.orderName, this.page = 1, this.perPage = 50});

  @override
  final String orderName;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int perPage;

  @override
  String toString() {
    return 'GetOrderActivityRequestParams(orderName: $orderName, page: $page, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetOrderActivityRequestParamsImpl &&
            (identical(other.orderName, orderName) ||
                other.orderName == orderName) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderName, page, perPage);

  /// Create a copy of GetOrderActivityRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetOrderActivityRequestParamsImplCopyWith<
          _$GetOrderActivityRequestParamsImpl>
      get copyWith => __$$GetOrderActivityRequestParamsImplCopyWithImpl<
          _$GetOrderActivityRequestParamsImpl>(this, _$identity);
}

abstract class _GetOrderActivityRequestParams
    implements GetOrderActivityRequestParams {
  const factory _GetOrderActivityRequestParams(
      {required final String orderName,
      final int page,
      final int perPage}) = _$GetOrderActivityRequestParamsImpl;

  @override
  String get orderName;
  @override
  int get page;
  @override
  int get perPage;

  /// Create a copy of GetOrderActivityRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetOrderActivityRequestParamsImplCopyWith<
          _$GetOrderActivityRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
