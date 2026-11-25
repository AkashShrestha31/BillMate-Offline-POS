// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profit_loss_report_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfitLossReportRequest {
  String get mode => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  int get monthFrom => throw _privateConstructorUsedError;
  int get monthTo => throw _privateConstructorUsedError;
  DateTime get customStart => throw _privateConstructorUsedError;
  DateTime get customEnd => throw _privateConstructorUsedError;

  /// Create a copy of ProfitLossReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfitLossReportRequestCopyWith<ProfitLossReportRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfitLossReportRequestCopyWith<$Res> {
  factory $ProfitLossReportRequestCopyWith(ProfitLossReportRequest value,
          $Res Function(ProfitLossReportRequest) then) =
      _$ProfitLossReportRequestCopyWithImpl<$Res, ProfitLossReportRequest>;
  @useResult
  $Res call(
      {String mode,
      int year,
      int month,
      int monthFrom,
      int monthTo,
      DateTime customStart,
      DateTime customEnd});
}

/// @nodoc
class _$ProfitLossReportRequestCopyWithImpl<$Res,
        $Val extends ProfitLossReportRequest>
    implements $ProfitLossReportRequestCopyWith<$Res> {
  _$ProfitLossReportRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfitLossReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? year = null,
    Object? month = null,
    Object? monthFrom = null,
    Object? monthTo = null,
    Object? customStart = null,
    Object? customEnd = null,
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
      customStart: null == customStart
          ? _value.customStart
          : customStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      customEnd: null == customEnd
          ? _value.customEnd
          : customEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfitLossReportRequestImplCopyWith<$Res>
    implements $ProfitLossReportRequestCopyWith<$Res> {
  factory _$$ProfitLossReportRequestImplCopyWith(
          _$ProfitLossReportRequestImpl value,
          $Res Function(_$ProfitLossReportRequestImpl) then) =
      __$$ProfitLossReportRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String mode,
      int year,
      int month,
      int monthFrom,
      int monthTo,
      DateTime customStart,
      DateTime customEnd});
}

/// @nodoc
class __$$ProfitLossReportRequestImplCopyWithImpl<$Res>
    extends _$ProfitLossReportRequestCopyWithImpl<$Res,
        _$ProfitLossReportRequestImpl>
    implements _$$ProfitLossReportRequestImplCopyWith<$Res> {
  __$$ProfitLossReportRequestImplCopyWithImpl(
      _$ProfitLossReportRequestImpl _value,
      $Res Function(_$ProfitLossReportRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfitLossReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? year = null,
    Object? month = null,
    Object? monthFrom = null,
    Object? monthTo = null,
    Object? customStart = null,
    Object? customEnd = null,
  }) {
    return _then(_$ProfitLossReportRequestImpl(
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
      customStart: null == customStart
          ? _value.customStart
          : customStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      customEnd: null == customEnd
          ? _value.customEnd
          : customEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$ProfitLossReportRequestImpl implements _ProfitLossReportRequest {
  const _$ProfitLossReportRequestImpl(
      {required this.mode,
      required this.year,
      required this.month,
      required this.monthFrom,
      required this.monthTo,
      required this.customStart,
      required this.customEnd});

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
  final DateTime customStart;
  @override
  final DateTime customEnd;

  @override
  String toString() {
    return 'ProfitLossReportRequest(mode: $mode, year: $year, month: $month, monthFrom: $monthFrom, monthTo: $monthTo, customStart: $customStart, customEnd: $customEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfitLossReportRequestImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.monthFrom, monthFrom) ||
                other.monthFrom == monthFrom) &&
            (identical(other.monthTo, monthTo) || other.monthTo == monthTo) &&
            (identical(other.customStart, customStart) ||
                other.customStart == customStart) &&
            (identical(other.customEnd, customEnd) ||
                other.customEnd == customEnd));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mode, year, month, monthFrom,
      monthTo, customStart, customEnd);

  /// Create a copy of ProfitLossReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfitLossReportRequestImplCopyWith<_$ProfitLossReportRequestImpl>
      get copyWith => __$$ProfitLossReportRequestImplCopyWithImpl<
          _$ProfitLossReportRequestImpl>(this, _$identity);
}

abstract class _ProfitLossReportRequest implements ProfitLossReportRequest {
  const factory _ProfitLossReportRequest(
      {required final String mode,
      required final int year,
      required final int month,
      required final int monthFrom,
      required final int monthTo,
      required final DateTime customStart,
      required final DateTime customEnd}) = _$ProfitLossReportRequestImpl;

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
  DateTime get customStart;
  @override
  DateTime get customEnd;

  /// Create a copy of ProfitLossReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfitLossReportRequestImplCopyWith<_$ProfitLossReportRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
