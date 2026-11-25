// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_report_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AnalyticsReportResponse {
  Map<String, dynamic> get dashboard => throw _privateConstructorUsedError;
  Map<String, dynamic> get summary => throw _privateConstructorUsedError;
  Map<String, dynamic> get trend => throw _privateConstructorUsedError;
  Map<String, dynamic> get items => throw _privateConstructorUsedError;
  Map<String, dynamic> get categories => throw _privateConstructorUsedError;
  Map<String, dynamic> get parties => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsReportResponseCopyWith<AnalyticsReportResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsReportResponseCopyWith<$Res> {
  factory $AnalyticsReportResponseCopyWith(AnalyticsReportResponse value,
          $Res Function(AnalyticsReportResponse) then) =
      _$AnalyticsReportResponseCopyWithImpl<$Res, AnalyticsReportResponse>;
  @useResult
  $Res call(
      {Map<String, dynamic> dashboard,
      Map<String, dynamic> summary,
      Map<String, dynamic> trend,
      Map<String, dynamic> items,
      Map<String, dynamic> categories,
      Map<String, dynamic> parties});
}

/// @nodoc
class _$AnalyticsReportResponseCopyWithImpl<$Res,
        $Val extends AnalyticsReportResponse>
    implements $AnalyticsReportResponseCopyWith<$Res> {
  _$AnalyticsReportResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dashboard = null,
    Object? summary = null,
    Object? trend = null,
    Object? items = null,
    Object? categories = null,
    Object? parties = null,
  }) {
    return _then(_value.copyWith(
      dashboard: null == dashboard
          ? _value.dashboard
          : dashboard // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      parties: null == parties
          ? _value.parties
          : parties // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnalyticsReportResponseImplCopyWith<$Res>
    implements $AnalyticsReportResponseCopyWith<$Res> {
  factory _$$AnalyticsReportResponseImplCopyWith(
          _$AnalyticsReportResponseImpl value,
          $Res Function(_$AnalyticsReportResponseImpl) then) =
      __$$AnalyticsReportResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, dynamic> dashboard,
      Map<String, dynamic> summary,
      Map<String, dynamic> trend,
      Map<String, dynamic> items,
      Map<String, dynamic> categories,
      Map<String, dynamic> parties});
}

/// @nodoc
class __$$AnalyticsReportResponseImplCopyWithImpl<$Res>
    extends _$AnalyticsReportResponseCopyWithImpl<$Res,
        _$AnalyticsReportResponseImpl>
    implements _$$AnalyticsReportResponseImplCopyWith<$Res> {
  __$$AnalyticsReportResponseImplCopyWithImpl(
      _$AnalyticsReportResponseImpl _value,
      $Res Function(_$AnalyticsReportResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnalyticsReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dashboard = null,
    Object? summary = null,
    Object? trend = null,
    Object? items = null,
    Object? categories = null,
    Object? parties = null,
  }) {
    return _then(_$AnalyticsReportResponseImpl(
      dashboard: null == dashboard
          ? _value._dashboard
          : dashboard // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      summary: null == summary
          ? _value._summary
          : summary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      trend: null == trend
          ? _value._trend
          : trend // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      parties: null == parties
          ? _value._parties
          : parties // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$AnalyticsReportResponseImpl implements _AnalyticsReportResponse {
  const _$AnalyticsReportResponseImpl(
      {required final Map<String, dynamic> dashboard,
      required final Map<String, dynamic> summary,
      required final Map<String, dynamic> trend,
      required final Map<String, dynamic> items,
      required final Map<String, dynamic> categories,
      required final Map<String, dynamic> parties})
      : _dashboard = dashboard,
        _summary = summary,
        _trend = trend,
        _items = items,
        _categories = categories,
        _parties = parties;

  final Map<String, dynamic> _dashboard;
  @override
  Map<String, dynamic> get dashboard {
    if (_dashboard is EqualUnmodifiableMapView) return _dashboard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dashboard);
  }

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

  final Map<String, dynamic> _items;
  @override
  Map<String, dynamic> get items {
    if (_items is EqualUnmodifiableMapView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_items);
  }

  final Map<String, dynamic> _categories;
  @override
  Map<String, dynamic> get categories {
    if (_categories is EqualUnmodifiableMapView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categories);
  }

  final Map<String, dynamic> _parties;
  @override
  Map<String, dynamic> get parties {
    if (_parties is EqualUnmodifiableMapView) return _parties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parties);
  }

  @override
  String toString() {
    return 'AnalyticsReportResponse(dashboard: $dashboard, summary: $summary, trend: $trend, items: $items, categories: $categories, parties: $parties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsReportResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._dashboard, _dashboard) &&
            const DeepCollectionEquality().equals(other._summary, _summary) &&
            const DeepCollectionEquality().equals(other._trend, _trend) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._parties, _parties));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_dashboard),
      const DeepCollectionEquality().hash(_summary),
      const DeepCollectionEquality().hash(_trend),
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_parties));

  /// Create a copy of AnalyticsReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsReportResponseImplCopyWith<_$AnalyticsReportResponseImpl>
      get copyWith => __$$AnalyticsReportResponseImplCopyWithImpl<
          _$AnalyticsReportResponseImpl>(this, _$identity);
}

abstract class _AnalyticsReportResponse implements AnalyticsReportResponse {
  const factory _AnalyticsReportResponse(
          {required final Map<String, dynamic> dashboard,
          required final Map<String, dynamic> summary,
          required final Map<String, dynamic> trend,
          required final Map<String, dynamic> items,
          required final Map<String, dynamic> categories,
          required final Map<String, dynamic> parties}) =
      _$AnalyticsReportResponseImpl;

  @override
  Map<String, dynamic> get dashboard;
  @override
  Map<String, dynamic> get summary;
  @override
  Map<String, dynamic> get trend;
  @override
  Map<String, dynamic> get items;
  @override
  Map<String, dynamic> get categories;
  @override
  Map<String, dynamic> get parties;

  /// Create a copy of AnalyticsReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsReportResponseImplCopyWith<_$AnalyticsReportResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
