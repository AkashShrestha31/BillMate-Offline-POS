// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hotel_sales_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HotelSalesRequestParams _$HotelSalesRequestParamsFromJson(
    Map<String, dynamic> json) {
  return _HotelSalesRequestParams.fromJson(json);
}

/// @nodoc
mixin _$HotelSalesRequestParams {
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;

  /// Serializes this HotelSalesRequestParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HotelSalesRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HotelSalesRequestParamsCopyWith<HotelSalesRequestParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HotelSalesRequestParamsCopyWith<$Res> {
  factory $HotelSalesRequestParamsCopyWith(HotelSalesRequestParams value,
          $Res Function(HotelSalesRequestParams) then) =
      _$HotelSalesRequestParamsCopyWithImpl<$Res, HotelSalesRequestParams>;
  @useResult
  $Res call({DateTime? startDate, DateTime? endDate, int? page, int? pageSize});
}

/// @nodoc
class _$HotelSalesRequestParamsCopyWithImpl<$Res,
        $Val extends HotelSalesRequestParams>
    implements $HotelSalesRequestParamsCopyWith<$Res> {
  _$HotelSalesRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HotelSalesRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_value.copyWith(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HotelSalesRequestParamsImplCopyWith<$Res>
    implements $HotelSalesRequestParamsCopyWith<$Res> {
  factory _$$HotelSalesRequestParamsImplCopyWith(
          _$HotelSalesRequestParamsImpl value,
          $Res Function(_$HotelSalesRequestParamsImpl) then) =
      __$$HotelSalesRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? startDate, DateTime? endDate, int? page, int? pageSize});
}

/// @nodoc
class __$$HotelSalesRequestParamsImplCopyWithImpl<$Res>
    extends _$HotelSalesRequestParamsCopyWithImpl<$Res,
        _$HotelSalesRequestParamsImpl>
    implements _$$HotelSalesRequestParamsImplCopyWith<$Res> {
  __$$HotelSalesRequestParamsImplCopyWithImpl(
      _$HotelSalesRequestParamsImpl _value,
      $Res Function(_$HotelSalesRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of HotelSalesRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_$HotelSalesRequestParamsImpl(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HotelSalesRequestParamsImpl implements _HotelSalesRequestParams {
  const _$HotelSalesRequestParamsImpl(
      {this.startDate, this.endDate, this.page, this.pageSize});

  factory _$HotelSalesRequestParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$HotelSalesRequestParamsImplFromJson(json);

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final int? page;
  @override
  final int? pageSize;

  @override
  String toString() {
    return 'HotelSalesRequestParams(startDate: $startDate, endDate: $endDate, page: $page, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotelSalesRequestParamsImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, startDate, endDate, page, pageSize);

  /// Create a copy of HotelSalesRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HotelSalesRequestParamsImplCopyWith<_$HotelSalesRequestParamsImpl>
      get copyWith => __$$HotelSalesRequestParamsImplCopyWithImpl<
          _$HotelSalesRequestParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HotelSalesRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _HotelSalesRequestParams implements HotelSalesRequestParams {
  const factory _HotelSalesRequestParams(
      {final DateTime? startDate,
      final DateTime? endDate,
      final int? page,
      final int? pageSize}) = _$HotelSalesRequestParamsImpl;

  factory _HotelSalesRequestParams.fromJson(Map<String, dynamic> json) =
      _$HotelSalesRequestParamsImpl.fromJson;

  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  int? get page;
  @override
  int? get pageSize;

  /// Create a copy of HotelSalesRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HotelSalesRequestParamsImplCopyWith<_$HotelSalesRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
