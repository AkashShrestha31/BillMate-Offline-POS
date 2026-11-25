// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profit_loss_report_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfitLossReportResponse {
  Map<String, dynamic> get summary => throw _privateConstructorUsedError;
  Map<String, dynamic> get trend => throw _privateConstructorUsedError;
  Map<String, dynamic> get statement => throw _privateConstructorUsedError;
  Map<String, dynamic> get expense => throw _privateConstructorUsedError;
  Map<String, dynamic> get revenue => throw _privateConstructorUsedError;

  /// Create a copy of ProfitLossReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfitLossReportResponseCopyWith<ProfitLossReportResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfitLossReportResponseCopyWith<$Res> {
  factory $ProfitLossReportResponseCopyWith(ProfitLossReportResponse value,
          $Res Function(ProfitLossReportResponse) then) =
      _$ProfitLossReportResponseCopyWithImpl<$Res, ProfitLossReportResponse>;
  @useResult
  $Res call(
      {Map<String, dynamic> summary,
      Map<String, dynamic> trend,
      Map<String, dynamic> statement,
      Map<String, dynamic> expense,
      Map<String, dynamic> revenue});
}

/// @nodoc
class _$ProfitLossReportResponseCopyWithImpl<$Res,
        $Val extends ProfitLossReportResponse>
    implements $ProfitLossReportResponseCopyWith<$Res> {
  _$ProfitLossReportResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfitLossReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = null,
    Object? trend = null,
    Object? statement = null,
    Object? expense = null,
    Object? revenue = null,
  }) {
    return _then(_value.copyWith(
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      statement: null == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      expense: null == expense
          ? _value.expense
          : expense // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfitLossReportResponseImplCopyWith<$Res>
    implements $ProfitLossReportResponseCopyWith<$Res> {
  factory _$$ProfitLossReportResponseImplCopyWith(
          _$ProfitLossReportResponseImpl value,
          $Res Function(_$ProfitLossReportResponseImpl) then) =
      __$$ProfitLossReportResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, dynamic> summary,
      Map<String, dynamic> trend,
      Map<String, dynamic> statement,
      Map<String, dynamic> expense,
      Map<String, dynamic> revenue});
}

/// @nodoc
class __$$ProfitLossReportResponseImplCopyWithImpl<$Res>
    extends _$ProfitLossReportResponseCopyWithImpl<$Res,
        _$ProfitLossReportResponseImpl>
    implements _$$ProfitLossReportResponseImplCopyWith<$Res> {
  __$$ProfitLossReportResponseImplCopyWithImpl(
      _$ProfitLossReportResponseImpl _value,
      $Res Function(_$ProfitLossReportResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfitLossReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = null,
    Object? trend = null,
    Object? statement = null,
    Object? expense = null,
    Object? revenue = null,
  }) {
    return _then(_$ProfitLossReportResponseImpl(
      summary: null == summary
          ? _value._summary
          : summary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      trend: null == trend
          ? _value._trend
          : trend // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      statement: null == statement
          ? _value._statement
          : statement // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      expense: null == expense
          ? _value._expense
          : expense // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      revenue: null == revenue
          ? _value._revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$ProfitLossReportResponseImpl implements _ProfitLossReportResponse {
  const _$ProfitLossReportResponseImpl(
      {required final Map<String, dynamic> summary,
      required final Map<String, dynamic> trend,
      required final Map<String, dynamic> statement,
      required final Map<String, dynamic> expense,
      required final Map<String, dynamic> revenue})
      : _summary = summary,
        _trend = trend,
        _statement = statement,
        _expense = expense,
        _revenue = revenue;

  final Map<String, dynamic> _summary;
  @override
  Map<String, dynamic> get summary {
    if (_summary is EqualUnmodifiableMapView) return _summary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_summary);
  }

  final Map<String, dynamic> _trend;
  @override
  Map<String, dynamic> get trend {
    if (_trend is EqualUnmodifiableMapView) return _trend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_trend);
  }

  final Map<String, dynamic> _statement;
  @override
  Map<String, dynamic> get statement {
    if (_statement is EqualUnmodifiableMapView) return _statement;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statement);
  }

  final Map<String, dynamic> _expense;
  @override
  Map<String, dynamic> get expense {
    if (_expense is EqualUnmodifiableMapView) return _expense;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_expense);
  }

  final Map<String, dynamic> _revenue;
  @override
  Map<String, dynamic> get revenue {
    if (_revenue is EqualUnmodifiableMapView) return _revenue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_revenue);
  }

  @override
  String toString() {
    return 'ProfitLossReportResponse(summary: $summary, trend: $trend, statement: $statement, expense: $expense, revenue: $revenue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfitLossReportResponseImpl &&
            const DeepCollectionEquality().equals(other._summary, _summary) &&
            const DeepCollectionEquality().equals(other._trend, _trend) &&
            const DeepCollectionEquality()
                .equals(other._statement, _statement) &&
            const DeepCollectionEquality().equals(other._expense, _expense) &&
            const DeepCollectionEquality().equals(other._revenue, _revenue));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_summary),
      const DeepCollectionEquality().hash(_trend),
      const DeepCollectionEquality().hash(_statement),
      const DeepCollectionEquality().hash(_expense),
      const DeepCollectionEquality().hash(_revenue));

  /// Create a copy of ProfitLossReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfitLossReportResponseImplCopyWith<_$ProfitLossReportResponseImpl>
      get copyWith => __$$ProfitLossReportResponseImplCopyWithImpl<
          _$ProfitLossReportResponseImpl>(this, _$identity);
}

abstract class _ProfitLossReportResponse implements ProfitLossReportResponse {
  const factory _ProfitLossReportResponse(
          {required final Map<String, dynamic> summary,
          required final Map<String, dynamic> trend,
          required final Map<String, dynamic> statement,
          required final Map<String, dynamic> expense,
          required final Map<String, dynamic> revenue}) =
      _$ProfitLossReportResponseImpl;

  @override
  Map<String, dynamic> get summary;
  @override
  Map<String, dynamic> get trend;
  @override
  Map<String, dynamic> get statement;
  @override
  Map<String, dynamic> get expense;
  @override
  Map<String, dynamic> get revenue;

  /// Create a copy of ProfitLossReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfitLossReportResponseImplCopyWith<_$ProfitLossReportResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
