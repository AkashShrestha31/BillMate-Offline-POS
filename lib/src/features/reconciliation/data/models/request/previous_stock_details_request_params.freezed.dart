// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'previous_stock_details_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PreviousStockDetailsRequestParams _$PreviousStockDetailsRequestParamsFromJson(
    Map<String, dynamic> json) {
  return _PreviousStockDetailsRequestParams.fromJson(json);
}

/// @nodoc
mixin _$PreviousStockDetailsRequestParams {
  @JsonKey(name: 'reporting_date')
  String get reportingDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'batch_number')
  String? get batchNumber => throw _privateConstructorUsedError;
  String? get item => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;

  /// Serializes this PreviousStockDetailsRequestParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PreviousStockDetailsRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PreviousStockDetailsRequestParamsCopyWith<PreviousStockDetailsRequestParams>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreviousStockDetailsRequestParamsCopyWith<$Res> {
  factory $PreviousStockDetailsRequestParamsCopyWith(
          PreviousStockDetailsRequestParams value,
          $Res Function(PreviousStockDetailsRequestParams) then) =
      _$PreviousStockDetailsRequestParamsCopyWithImpl<$Res,
          PreviousStockDetailsRequestParams>;
  @useResult
  $Res call(
      {@JsonKey(name: 'reporting_date') String reportingDate,
      @JsonKey(name: 'batch_number') String? batchNumber,
      String? item,
      String? location});
}

/// @nodoc
class _$PreviousStockDetailsRequestParamsCopyWithImpl<$Res,
        $Val extends PreviousStockDetailsRequestParams>
    implements $PreviousStockDetailsRequestParamsCopyWith<$Res> {
  _$PreviousStockDetailsRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PreviousStockDetailsRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportingDate = null,
    Object? batchNumber = freezed,
    Object? item = freezed,
    Object? location = freezed,
  }) {
    return _then(_value.copyWith(
      reportingDate: null == reportingDate
          ? _value.reportingDate
          : reportingDate // ignore: cast_nullable_to_non_nullable
              as String,
      batchNumber: freezed == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      item: freezed == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreviousStockDetailsRequestParamsImplCopyWith<$Res>
    implements $PreviousStockDetailsRequestParamsCopyWith<$Res> {
  factory _$$PreviousStockDetailsRequestParamsImplCopyWith(
          _$PreviousStockDetailsRequestParamsImpl value,
          $Res Function(_$PreviousStockDetailsRequestParamsImpl) then) =
      __$$PreviousStockDetailsRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'reporting_date') String reportingDate,
      @JsonKey(name: 'batch_number') String? batchNumber,
      String? item,
      String? location});
}

/// @nodoc
class __$$PreviousStockDetailsRequestParamsImplCopyWithImpl<$Res>
    extends _$PreviousStockDetailsRequestParamsCopyWithImpl<$Res,
        _$PreviousStockDetailsRequestParamsImpl>
    implements _$$PreviousStockDetailsRequestParamsImplCopyWith<$Res> {
  __$$PreviousStockDetailsRequestParamsImplCopyWithImpl(
      _$PreviousStockDetailsRequestParamsImpl _value,
      $Res Function(_$PreviousStockDetailsRequestParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PreviousStockDetailsRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportingDate = null,
    Object? batchNumber = freezed,
    Object? item = freezed,
    Object? location = freezed,
  }) {
    return _then(_$PreviousStockDetailsRequestParamsImpl(
      reportingDate: null == reportingDate
          ? _value.reportingDate
          : reportingDate // ignore: cast_nullable_to_non_nullable
              as String,
      batchNumber: freezed == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      item: freezed == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreviousStockDetailsRequestParamsImpl
    implements _PreviousStockDetailsRequestParams {
  const _$PreviousStockDetailsRequestParamsImpl(
      {@JsonKey(name: 'reporting_date') required this.reportingDate,
      @JsonKey(name: 'batch_number') this.batchNumber,
      this.item,
      this.location});

  factory _$PreviousStockDetailsRequestParamsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PreviousStockDetailsRequestParamsImplFromJson(json);

  @override
  @JsonKey(name: 'reporting_date')
  final String reportingDate;
  @override
  @JsonKey(name: 'batch_number')
  final String? batchNumber;
  @override
  final String? item;
  @override
  final String? location;

  @override
  String toString() {
    return 'PreviousStockDetailsRequestParams(reportingDate: $reportingDate, batchNumber: $batchNumber, item: $item, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreviousStockDetailsRequestParamsImpl &&
            (identical(other.reportingDate, reportingDate) ||
                other.reportingDate == reportingDate) &&
            (identical(other.batchNumber, batchNumber) ||
                other.batchNumber == batchNumber) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, reportingDate, batchNumber, item, location);

  /// Create a copy of PreviousStockDetailsRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PreviousStockDetailsRequestParamsImplCopyWith<
          _$PreviousStockDetailsRequestParamsImpl>
      get copyWith => __$$PreviousStockDetailsRequestParamsImplCopyWithImpl<
          _$PreviousStockDetailsRequestParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreviousStockDetailsRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _PreviousStockDetailsRequestParams
    implements PreviousStockDetailsRequestParams {
  const factory _PreviousStockDetailsRequestParams(
      {@JsonKey(name: 'reporting_date') required final String reportingDate,
      @JsonKey(name: 'batch_number') final String? batchNumber,
      final String? item,
      final String? location}) = _$PreviousStockDetailsRequestParamsImpl;

  factory _PreviousStockDetailsRequestParams.fromJson(
          Map<String, dynamic> json) =
      _$PreviousStockDetailsRequestParamsImpl.fromJson;

  @override
  @JsonKey(name: 'reporting_date')
  String get reportingDate;
  @override
  @JsonKey(name: 'batch_number')
  String? get batchNumber;
  @override
  String? get item;
  @override
  String? get location;

  /// Create a copy of PreviousStockDetailsRequestParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PreviousStockDetailsRequestParamsImplCopyWith<
          _$PreviousStockDetailsRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
