// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_report_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AnalyticsReportRequest {
  int get tabIndex => throw _privateConstructorUsedError;
  String get mode => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  DateTime get day => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsReportRequestCopyWith<AnalyticsReportRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsReportRequestCopyWith<$Res> {
  factory $AnalyticsReportRequestCopyWith(AnalyticsReportRequest value,
          $Res Function(AnalyticsReportRequest) then) =
      _$AnalyticsReportRequestCopyWithImpl<$Res, AnalyticsReportRequest>;
  @useResult
  $Res call({int tabIndex, String mode, int year, int month, DateTime day});
}

/// @nodoc
class _$AnalyticsReportRequestCopyWithImpl<$Res,
        $Val extends AnalyticsReportRequest>
    implements $AnalyticsReportRequestCopyWith<$Res> {
  _$AnalyticsReportRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabIndex = null,
    Object? mode = null,
    Object? year = null,
    Object? month = null,
    Object? day = null,
  }) {
    return _then(_value.copyWith(
      tabIndex: null == tabIndex
          ? _value.tabIndex
          : tabIndex // ignore: cast_nullable_to_non_nullable
              as int,
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
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnalyticsReportRequestImplCopyWith<$Res>
    implements $AnalyticsReportRequestCopyWith<$Res> {
  factory _$$AnalyticsReportRequestImplCopyWith(
          _$AnalyticsReportRequestImpl value,
          $Res Function(_$AnalyticsReportRequestImpl) then) =
      __$$AnalyticsReportRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int tabIndex, String mode, int year, int month, DateTime day});
}

/// @nodoc
class __$$AnalyticsReportRequestImplCopyWithImpl<$Res>
    extends _$AnalyticsReportRequestCopyWithImpl<$Res,
        _$AnalyticsReportRequestImpl>
    implements _$$AnalyticsReportRequestImplCopyWith<$Res> {
  __$$AnalyticsReportRequestImplCopyWithImpl(
      _$AnalyticsReportRequestImpl _value,
      $Res Function(_$AnalyticsReportRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnalyticsReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabIndex = null,
    Object? mode = null,
    Object? year = null,
    Object? month = null,
    Object? day = null,
  }) {
    return _then(_$AnalyticsReportRequestImpl(
      tabIndex: null == tabIndex
          ? _value.tabIndex
          : tabIndex // ignore: cast_nullable_to_non_nullable
              as int,
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
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$AnalyticsReportRequestImpl implements _AnalyticsReportRequest {
  const _$AnalyticsReportRequestImpl(
      {required this.tabIndex,
      required this.mode,
      required this.year,
      required this.month,
      required this.day});

  @override
  final int tabIndex;
  @override
  final String mode;
  @override
  final int year;
  @override
  final int month;
  @override
  final DateTime day;

  @override
  String toString() {
    return 'AnalyticsReportRequest(tabIndex: $tabIndex, mode: $mode, year: $year, month: $month, day: $day)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsReportRequestImpl &&
            (identical(other.tabIndex, tabIndex) ||
                other.tabIndex == tabIndex) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.day, day) || other.day == day));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, tabIndex, mode, year, month, day);

  /// Create a copy of AnalyticsReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsReportRequestImplCopyWith<_$AnalyticsReportRequestImpl>
      get copyWith => __$$AnalyticsReportRequestImplCopyWithImpl<
          _$AnalyticsReportRequestImpl>(this, _$identity);
}

abstract class _AnalyticsReportRequest implements AnalyticsReportRequest {
  const factory _AnalyticsReportRequest(
      {required final int tabIndex,
      required final String mode,
      required final int year,
      required final int month,
      required final DateTime day}) = _$AnalyticsReportRequestImpl;

  @override
  int get tabIndex;
  @override
  String get mode;
  @override
  int get year;
  @override
  int get month;
  @override
  DateTime get day;

  /// Create a copy of AnalyticsReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsReportRequestImplCopyWith<_$AnalyticsReportRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
