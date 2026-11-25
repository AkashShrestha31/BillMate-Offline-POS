// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statement_report_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StatementReportRequest {
  String get mode => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  int get monthFrom => throw _privateConstructorUsedError;
  int get monthTo => throw _privateConstructorUsedError;
  DateTime get day => throw _privateConstructorUsedError;

  /// Create a copy of StatementReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatementReportRequestCopyWith<StatementReportRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatementReportRequestCopyWith<$Res> {
  factory $StatementReportRequestCopyWith(StatementReportRequest value,
          $Res Function(StatementReportRequest) then) =
      _$StatementReportRequestCopyWithImpl<$Res, StatementReportRequest>;
  @useResult
  $Res call(
      {String mode,
      int year,
      int month,
      int monthFrom,
      int monthTo,
      DateTime day});
}

/// @nodoc
class _$StatementReportRequestCopyWithImpl<$Res,
        $Val extends StatementReportRequest>
    implements $StatementReportRequestCopyWith<$Res> {
  _$StatementReportRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatementReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? year = null,
    Object? month = null,
    Object? monthFrom = null,
    Object? monthTo = null,
    Object? day = null,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      monthFrom: null == monthFrom
          ? _value.monthFrom
          : monthFrom // ignore: cast_nullable_to_non_nullable
              as int,
      monthTo: null == monthTo
          ? _value.monthTo
          : monthTo // ignore: cast_nullable_to_non_nullable
              as int,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatementReportRequestImplCopyWith<$Res>
    implements $StatementReportRequestCopyWith<$Res> {
  factory _$$StatementReportRequestImplCopyWith(
          _$StatementReportRequestImpl value,
          $Res Function(_$StatementReportRequestImpl) then) =
      __$$StatementReportRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String mode,
      int year,
      int month,
      int monthFrom,
      int monthTo,
      DateTime day});
}

/// @nodoc
class __$$StatementReportRequestImplCopyWithImpl<$Res>
    extends _$StatementReportRequestCopyWithImpl<$Res,
        _$StatementReportRequestImpl>
    implements _$$StatementReportRequestImplCopyWith<$Res> {
  __$$StatementReportRequestImplCopyWithImpl(
      _$StatementReportRequestImpl _value,
      $Res Function(_$StatementReportRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatementReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? year = null,
    Object? month = null,
    Object? monthFrom = null,
    Object? monthTo = null,
    Object? day = null,
  }) {
    return _then(_$StatementReportRequestImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      monthFrom: null == monthFrom
          ? _value.monthFrom
          : monthFrom // ignore: cast_nullable_to_non_nullable
              as int,
      monthTo: null == monthTo
          ? _value.monthTo
          : monthTo // ignore: cast_nullable_to_non_nullable
              as int,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$StatementReportRequestImpl implements _StatementReportRequest {
  const _$StatementReportRequestImpl(
      {required this.mode,
      required this.year,
      required this.month,
      required this.monthFrom,
      required this.monthTo,
      required this.day});

  @override
  final String mode;
  @override
  final int year;
  @override
  final int month;
  @override
  final int monthFrom;
  @override
  final int monthTo;
  @override
  final DateTime day;

  @override
  String toString() {
    return 'StatementReportRequest(mode: $mode, year: $year, month: $month, monthFrom: $monthFrom, monthTo: $monthTo, day: $day)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatementReportRequestImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.monthFrom, monthFrom) ||
                other.monthFrom == monthFrom) &&
            (identical(other.monthTo, monthTo) || other.monthTo == monthTo) &&
            (identical(other.day, day) || other.day == day));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, mode, year, month, monthFrom, monthTo, day);

  /// Create a copy of StatementReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatementReportRequestImplCopyWith<_$StatementReportRequestImpl>
      get copyWith => __$$StatementReportRequestImplCopyWithImpl<
          _$StatementReportRequestImpl>(this, _$identity);
}

abstract class _StatementReportRequest implements StatementReportRequest {
  const factory _StatementReportRequest(
      {required final String mode,
      required final int year,
      required final int month,
      required final int monthFrom,
      required final int monthTo,
      required final DateTime day}) = _$StatementReportRequestImpl;

  @override
  String get mode;
  @override
  int get year;
  @override
  int get month;
  @override
  int get monthFrom;
  @override
  int get monthTo;
  @override
  DateTime get day;

  /// Create a copy of StatementReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatementReportRequestImplCopyWith<_$StatementReportRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
