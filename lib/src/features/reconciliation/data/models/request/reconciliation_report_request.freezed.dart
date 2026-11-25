// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reconciliation_report_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReconciliationReportRequest _$ReconciliationReportRequestFromJson(
    Map<String, dynamic> json) {
  return _ReconciliationReportRequest.fromJson(json);
}

/// @nodoc
mixin _$ReconciliationReportRequest {
  @JsonKey(name: 'from_date')
  String get fromDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_date')
  String get toDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_stock_date')
  String get currentStockDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'previous_stock_date')
  String get previousStockDate => throw _privateConstructorUsedError;
  List<String> get items => throw _privateConstructorUsedError;
  List<String> get locations => throw _privateConstructorUsedError;
  @JsonKey(name: 'save_report')
  bool get saveReport => throw _privateConstructorUsedError;

  /// Serializes this ReconciliationReportRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReconciliationReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReconciliationReportRequestCopyWith<ReconciliationReportRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReconciliationReportRequestCopyWith<$Res> {
  factory $ReconciliationReportRequestCopyWith(
          ReconciliationReportRequest value,
          $Res Function(ReconciliationReportRequest) then) =
      _$ReconciliationReportRequestCopyWithImpl<$Res,
          ReconciliationReportRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'from_date') String fromDate,
      @JsonKey(name: 'to_date') String toDate,
      @JsonKey(name: 'current_stock_date') String currentStockDate,
      @JsonKey(name: 'previous_stock_date') String previousStockDate,
      List<String> items,
      List<String> locations,
      @JsonKey(name: 'save_report') bool saveReport});
}

/// @nodoc
class _$ReconciliationReportRequestCopyWithImpl<$Res,
        $Val extends ReconciliationReportRequest>
    implements $ReconciliationReportRequestCopyWith<$Res> {
  _$ReconciliationReportRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReconciliationReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromDate = null,
    Object? toDate = null,
    Object? currentStockDate = null,
    Object? previousStockDate = null,
    Object? items = null,
    Object? locations = null,
    Object? saveReport = null,
  }) {
    return _then(_value.copyWith(
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
      currentStockDate: null == currentStockDate
          ? _value.currentStockDate
          : currentStockDate // ignore: cast_nullable_to_non_nullable
              as String,
      previousStockDate: null == previousStockDate
          ? _value.previousStockDate
          : previousStockDate // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<String>,
      locations: null == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      saveReport: null == saveReport
          ? _value.saveReport
          : saveReport // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReconciliationReportRequestImplCopyWith<$Res>
    implements $ReconciliationReportRequestCopyWith<$Res> {
  factory _$$ReconciliationReportRequestImplCopyWith(
          _$ReconciliationReportRequestImpl value,
          $Res Function(_$ReconciliationReportRequestImpl) then) =
      __$$ReconciliationReportRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'from_date') String fromDate,
      @JsonKey(name: 'to_date') String toDate,
      @JsonKey(name: 'current_stock_date') String currentStockDate,
      @JsonKey(name: 'previous_stock_date') String previousStockDate,
      List<String> items,
      List<String> locations,
      @JsonKey(name: 'save_report') bool saveReport});
}

/// @nodoc
class __$$ReconciliationReportRequestImplCopyWithImpl<$Res>
    extends _$ReconciliationReportRequestCopyWithImpl<$Res,
        _$ReconciliationReportRequestImpl>
    implements _$$ReconciliationReportRequestImplCopyWith<$Res> {
  __$$ReconciliationReportRequestImplCopyWithImpl(
      _$ReconciliationReportRequestImpl _value,
      $Res Function(_$ReconciliationReportRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReconciliationReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromDate = null,
    Object? toDate = null,
    Object? currentStockDate = null,
    Object? previousStockDate = null,
    Object? items = null,
    Object? locations = null,
    Object? saveReport = null,
  }) {
    return _then(_$ReconciliationReportRequestImpl(
      fromDate: null == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as String,
      toDate: null == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as String,
      currentStockDate: null == currentStockDate
          ? _value.currentStockDate
          : currentStockDate // ignore: cast_nullable_to_non_nullable
              as String,
      previousStockDate: null == previousStockDate
          ? _value.previousStockDate
          : previousStockDate // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<String>,
      locations: null == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      saveReport: null == saveReport
          ? _value.saveReport
          : saveReport // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReconciliationReportRequestImpl
    implements _ReconciliationReportRequest {
  const _$ReconciliationReportRequestImpl(
      {@JsonKey(name: 'from_date') required this.fromDate,
      @JsonKey(name: 'to_date') required this.toDate,
      @JsonKey(name: 'current_stock_date') required this.currentStockDate,
      @JsonKey(name: 'previous_stock_date') required this.previousStockDate,
      required final List<String> items,
      required final List<String> locations,
      @JsonKey(name: 'save_report') required this.saveReport})
      : _items = items,
        _locations = locations;

  factory _$ReconciliationReportRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReconciliationReportRequestImplFromJson(json);

  @override
  @JsonKey(name: 'from_date')
  final String fromDate;
  @override
  @JsonKey(name: 'to_date')
  final String toDate;
  @override
  @JsonKey(name: 'current_stock_date')
  final String currentStockDate;
  @override
  @JsonKey(name: 'previous_stock_date')
  final String previousStockDate;
  final List<String> _items;
  @override
  List<String> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<String> _locations;
  @override
  List<String> get locations {
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locations);
  }

  @override
  @JsonKey(name: 'save_report')
  final bool saveReport;

  @override
  String toString() {
    return 'ReconciliationReportRequest(fromDate: $fromDate, toDate: $toDate, currentStockDate: $currentStockDate, previousStockDate: $previousStockDate, items: $items, locations: $locations, saveReport: $saveReport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReconciliationReportRequestImpl &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.currentStockDate, currentStockDate) ||
                other.currentStockDate == currentStockDate) &&
            (identical(other.previousStockDate, previousStockDate) ||
                other.previousStockDate == previousStockDate) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations) &&
            (identical(other.saveReport, saveReport) ||
                other.saveReport == saveReport));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      fromDate,
      toDate,
      currentStockDate,
      previousStockDate,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_locations),
      saveReport);

  /// Create a copy of ReconciliationReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReconciliationReportRequestImplCopyWith<_$ReconciliationReportRequestImpl>
      get copyWith => __$$ReconciliationReportRequestImplCopyWithImpl<
          _$ReconciliationReportRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReconciliationReportRequestImplToJson(
      this,
    );
  }
}

abstract class _ReconciliationReportRequest
    implements ReconciliationReportRequest {
  const factory _ReconciliationReportRequest(
          {@JsonKey(name: 'from_date') required final String fromDate,
          @JsonKey(name: 'to_date') required final String toDate,
          @JsonKey(name: 'current_stock_date')
          required final String currentStockDate,
          @JsonKey(name: 'previous_stock_date')
          required final String previousStockDate,
          required final List<String> items,
          required final List<String> locations,
          @JsonKey(name: 'save_report') required final bool saveReport}) =
      _$ReconciliationReportRequestImpl;

  factory _ReconciliationReportRequest.fromJson(Map<String, dynamic> json) =
      _$ReconciliationReportRequestImpl.fromJson;

  @override
  @JsonKey(name: 'from_date')
  String get fromDate;
  @override
  @JsonKey(name: 'to_date')
  String get toDate;
  @override
  @JsonKey(name: 'current_stock_date')
  String get currentStockDate;
  @override
  @JsonKey(name: 'previous_stock_date')
  String get previousStockDate;
  @override
  List<String> get items;
  @override
  List<String> get locations;
  @override
  @JsonKey(name: 'save_report')
  bool get saveReport;

  /// Create a copy of ReconciliationReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReconciliationReportRequestImplCopyWith<_$ReconciliationReportRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
