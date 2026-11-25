// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_register_query_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CashRegisterQueryParams _$CashRegisterQueryParamsFromJson(
    Map<String, dynamic> json) {
  return _CashRegisterQueryParams.fromJson(json);
}

/// @nodoc
mixin _$CashRegisterQueryParams {
  @JsonKey(name: 'register_id')
  int? get registerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'register_name')
  String? get registerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'shift_date')
  String? get shiftDate => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_from')
  String? get dateFrom => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_to')
  String? get dateTo => throw _privateConstructorUsedError;

  /// Serializes this CashRegisterQueryParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CashRegisterQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashRegisterQueryParamsCopyWith<CashRegisterQueryParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashRegisterQueryParamsCopyWith<$Res> {
  factory $CashRegisterQueryParamsCopyWith(CashRegisterQueryParams value,
          $Res Function(CashRegisterQueryParams) then) =
      _$CashRegisterQueryParamsCopyWithImpl<$Res, CashRegisterQueryParams>;
  @useResult
  $Res call(
      {@JsonKey(name: 'register_id') int? registerId,
      @JsonKey(name: 'register_name') String? registerName,
      @JsonKey(name: 'shift_date') String? shiftDate,
      String? status,
      @JsonKey(name: 'date_from') String? dateFrom,
      @JsonKey(name: 'date_to') String? dateTo});
}

/// @nodoc
class _$CashRegisterQueryParamsCopyWithImpl<$Res,
        $Val extends CashRegisterQueryParams>
    implements $CashRegisterQueryParamsCopyWith<$Res> {
  _$CashRegisterQueryParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashRegisterQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registerId = freezed,
    Object? registerName = freezed,
    Object? shiftDate = freezed,
    Object? status = freezed,
    Object? dateFrom = freezed,
    Object? dateTo = freezed,
  }) {
    return _then(_value.copyWith(
      registerId: freezed == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as int?,
      registerName: freezed == registerName
          ? _value.registerName
          : registerName // ignore: cast_nullable_to_non_nullable
              as String?,
      shiftDate: freezed == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      dateFrom: freezed == dateFrom
          ? _value.dateFrom
          : dateFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTo: freezed == dateTo
          ? _value.dateTo
          : dateTo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CashRegisterQueryParamsImplCopyWith<$Res>
    implements $CashRegisterQueryParamsCopyWith<$Res> {
  factory _$$CashRegisterQueryParamsImplCopyWith(
          _$CashRegisterQueryParamsImpl value,
          $Res Function(_$CashRegisterQueryParamsImpl) then) =
      __$$CashRegisterQueryParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'register_id') int? registerId,
      @JsonKey(name: 'register_name') String? registerName,
      @JsonKey(name: 'shift_date') String? shiftDate,
      String? status,
      @JsonKey(name: 'date_from') String? dateFrom,
      @JsonKey(name: 'date_to') String? dateTo});
}

/// @nodoc
class __$$CashRegisterQueryParamsImplCopyWithImpl<$Res>
    extends _$CashRegisterQueryParamsCopyWithImpl<$Res,
        _$CashRegisterQueryParamsImpl>
    implements _$$CashRegisterQueryParamsImplCopyWith<$Res> {
  __$$CashRegisterQueryParamsImplCopyWithImpl(
      _$CashRegisterQueryParamsImpl _value,
      $Res Function(_$CashRegisterQueryParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of CashRegisterQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registerId = freezed,
    Object? registerName = freezed,
    Object? shiftDate = freezed,
    Object? status = freezed,
    Object? dateFrom = freezed,
    Object? dateTo = freezed,
  }) {
    return _then(_$CashRegisterQueryParamsImpl(
      registerId: freezed == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as int?,
      registerName: freezed == registerName
          ? _value.registerName
          : registerName // ignore: cast_nullable_to_non_nullable
              as String?,
      shiftDate: freezed == shiftDate
          ? _value.shiftDate
          : shiftDate // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      dateFrom: freezed == dateFrom
          ? _value.dateFrom
          : dateFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTo: freezed == dateTo
          ? _value.dateTo
          : dateTo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CashRegisterQueryParamsImpl implements _CashRegisterQueryParams {
  const _$CashRegisterQueryParamsImpl(
      {@JsonKey(name: 'register_id') this.registerId,
      @JsonKey(name: 'register_name') this.registerName,
      @JsonKey(name: 'shift_date') this.shiftDate,
      this.status,
      @JsonKey(name: 'date_from') this.dateFrom,
      @JsonKey(name: 'date_to') this.dateTo});

  factory _$CashRegisterQueryParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashRegisterQueryParamsImplFromJson(json);

  @override
  @JsonKey(name: 'register_id')
  final int? registerId;
  @override
  @JsonKey(name: 'register_name')
  final String? registerName;
  @override
  @JsonKey(name: 'shift_date')
  final String? shiftDate;
  @override
  final String? status;
  @override
  @JsonKey(name: 'date_from')
  final String? dateFrom;
  @override
  @JsonKey(name: 'date_to')
  final String? dateTo;

  @override
  String toString() {
    return 'CashRegisterQueryParams(registerId: $registerId, registerName: $registerName, shiftDate: $shiftDate, status: $status, dateFrom: $dateFrom, dateTo: $dateTo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashRegisterQueryParamsImpl &&
            (identical(other.registerId, registerId) ||
                other.registerId == registerId) &&
            (identical(other.registerName, registerName) ||
                other.registerName == registerName) &&
            (identical(other.shiftDate, shiftDate) ||
                other.shiftDate == shiftDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.dateFrom, dateFrom) ||
                other.dateFrom == dateFrom) &&
            (identical(other.dateTo, dateTo) || other.dateTo == dateTo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, registerId, registerName,
      shiftDate, status, dateFrom, dateTo);

  /// Create a copy of CashRegisterQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashRegisterQueryParamsImplCopyWith<_$CashRegisterQueryParamsImpl>
      get copyWith => __$$CashRegisterQueryParamsImplCopyWithImpl<
          _$CashRegisterQueryParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashRegisterQueryParamsImplToJson(
      this,
    );
  }
}

abstract class _CashRegisterQueryParams implements CashRegisterQueryParams {
  const factory _CashRegisterQueryParams(
          {@JsonKey(name: 'register_id') final int? registerId,
          @JsonKey(name: 'register_name') final String? registerName,
          @JsonKey(name: 'shift_date') final String? shiftDate,
          final String? status,
          @JsonKey(name: 'date_from') final String? dateFrom,
          @JsonKey(name: 'date_to') final String? dateTo}) =
      _$CashRegisterQueryParamsImpl;

  factory _CashRegisterQueryParams.fromJson(Map<String, dynamic> json) =
      _$CashRegisterQueryParamsImpl.fromJson;

  @override
  @JsonKey(name: 'register_id')
  int? get registerId;
  @override
  @JsonKey(name: 'register_name')
  String? get registerName;
  @override
  @JsonKey(name: 'shift_date')
  String? get shiftDate;
  @override
  String? get status;
  @override
  @JsonKey(name: 'date_from')
  String? get dateFrom;
  @override
  @JsonKey(name: 'date_to')
  String? get dateTo;

  /// Create a copy of CashRegisterQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashRegisterQueryParamsImplCopyWith<_$CashRegisterQueryParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
