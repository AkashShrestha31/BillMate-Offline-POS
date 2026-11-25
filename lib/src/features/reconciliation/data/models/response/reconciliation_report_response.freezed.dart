// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reconciliation_report_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReconciliationReportResponse _$ReconciliationReportResponseFromJson(
    Map<String, dynamic> json) {
  return _ReconciliationReportResponse.fromJson(json);
}

/// @nodoc
mixin _$ReconciliationReportResponse {
  bool get success => throw _privateConstructorUsedError;
  @JsonKey(name: 'report_date')
  String get reportDate => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  @JsonKey(name: 'starting_stock_date')
  String get startingStockDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_stock_date')
  String get currentStockDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'reconciliation_method')
  String get reconciliationMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'calculation_explanation')
  String get calculationExplanation => throw _privateConstructorUsedError;
  ReconciliationReportSummary get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'reconciliation_details')
  List<ReconciliationReportDetail> get reconciliationDetails =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'saved_to_database')
  bool get savedToDatabase => throw _privateConstructorUsedError;

  /// Serializes this ReconciliationReportResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReconciliationReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReconciliationReportResponseCopyWith<ReconciliationReportResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReconciliationReportResponseCopyWith<$Res> {
  factory $ReconciliationReportResponseCopyWith(
          ReconciliationReportResponse value,
          $Res Function(ReconciliationReportResponse) then) =
      _$ReconciliationReportResponseCopyWithImpl<$Res,
          ReconciliationReportResponse>;
  @useResult
  $Res call(
      {bool success,
      @JsonKey(name: 'report_date') String reportDate,
      String period,
      @JsonKey(name: 'starting_stock_date') String startingStockDate,
      @JsonKey(name: 'current_stock_date') String currentStockDate,
      @JsonKey(name: 'reconciliation_method') String reconciliationMethod,
      @JsonKey(name: 'calculation_explanation') String calculationExplanation,
      ReconciliationReportSummary summary,
      @JsonKey(name: 'reconciliation_details')
      List<ReconciliationReportDetail> reconciliationDetails,
      @JsonKey(name: 'saved_to_database') bool savedToDatabase});

  $ReconciliationReportSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$ReconciliationReportResponseCopyWithImpl<$Res,
        $Val extends ReconciliationReportResponse>
    implements $ReconciliationReportResponseCopyWith<$Res> {
  _$ReconciliationReportResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReconciliationReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? reportDate = null,
    Object? period = null,
    Object? startingStockDate = null,
    Object? currentStockDate = null,
    Object? reconciliationMethod = null,
    Object? calculationExplanation = null,
    Object? summary = null,
    Object? reconciliationDetails = null,
    Object? savedToDatabase = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      reportDate: null == reportDate
          ? _value.reportDate
          : reportDate // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      startingStockDate: null == startingStockDate
          ? _value.startingStockDate
          : startingStockDate // ignore: cast_nullable_to_non_nullable
              as String,
      currentStockDate: null == currentStockDate
          ? _value.currentStockDate
          : currentStockDate // ignore: cast_nullable_to_non_nullable
              as String,
      reconciliationMethod: null == reconciliationMethod
          ? _value.reconciliationMethod
          : reconciliationMethod // ignore: cast_nullable_to_non_nullable
              as String,
      calculationExplanation: null == calculationExplanation
          ? _value.calculationExplanation
          : calculationExplanation // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ReconciliationReportSummary,
      reconciliationDetails: null == reconciliationDetails
          ? _value.reconciliationDetails
          : reconciliationDetails // ignore: cast_nullable_to_non_nullable
              as List<ReconciliationReportDetail>,
      savedToDatabase: null == savedToDatabase
          ? _value.savedToDatabase
          : savedToDatabase // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of ReconciliationReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReconciliationReportSummaryCopyWith<$Res> get summary {
    return $ReconciliationReportSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReconciliationReportResponseImplCopyWith<$Res>
    implements $ReconciliationReportResponseCopyWith<$Res> {
  factory _$$ReconciliationReportResponseImplCopyWith(
          _$ReconciliationReportResponseImpl value,
          $Res Function(_$ReconciliationReportResponseImpl) then) =
      __$$ReconciliationReportResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      @JsonKey(name: 'report_date') String reportDate,
      String period,
      @JsonKey(name: 'starting_stock_date') String startingStockDate,
      @JsonKey(name: 'current_stock_date') String currentStockDate,
      @JsonKey(name: 'reconciliation_method') String reconciliationMethod,
      @JsonKey(name: 'calculation_explanation') String calculationExplanation,
      ReconciliationReportSummary summary,
      @JsonKey(name: 'reconciliation_details')
      List<ReconciliationReportDetail> reconciliationDetails,
      @JsonKey(name: 'saved_to_database') bool savedToDatabase});

  @override
  $ReconciliationReportSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$ReconciliationReportResponseImplCopyWithImpl<$Res>
    extends _$ReconciliationReportResponseCopyWithImpl<$Res,
        _$ReconciliationReportResponseImpl>
    implements _$$ReconciliationReportResponseImplCopyWith<$Res> {
  __$$ReconciliationReportResponseImplCopyWithImpl(
      _$ReconciliationReportResponseImpl _value,
      $Res Function(_$ReconciliationReportResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReconciliationReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? reportDate = null,
    Object? period = null,
    Object? startingStockDate = null,
    Object? currentStockDate = null,
    Object? reconciliationMethod = null,
    Object? calculationExplanation = null,
    Object? summary = null,
    Object? reconciliationDetails = null,
    Object? savedToDatabase = null,
  }) {
    return _then(_$ReconciliationReportResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      reportDate: null == reportDate
          ? _value.reportDate
          : reportDate // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      startingStockDate: null == startingStockDate
          ? _value.startingStockDate
          : startingStockDate // ignore: cast_nullable_to_non_nullable
              as String,
      currentStockDate: null == currentStockDate
          ? _value.currentStockDate
          : currentStockDate // ignore: cast_nullable_to_non_nullable
              as String,
      reconciliationMethod: null == reconciliationMethod
          ? _value.reconciliationMethod
          : reconciliationMethod // ignore: cast_nullable_to_non_nullable
              as String,
      calculationExplanation: null == calculationExplanation
          ? _value.calculationExplanation
          : calculationExplanation // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as ReconciliationReportSummary,
      reconciliationDetails: null == reconciliationDetails
          ? _value._reconciliationDetails
          : reconciliationDetails // ignore: cast_nullable_to_non_nullable
              as List<ReconciliationReportDetail>,
      savedToDatabase: null == savedToDatabase
          ? _value.savedToDatabase
          : savedToDatabase // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReconciliationReportResponseImpl
    implements _ReconciliationReportResponse {
  const _$ReconciliationReportResponseImpl(
      {required this.success,
      @JsonKey(name: 'report_date') required this.reportDate,
      required this.period,
      @JsonKey(name: 'starting_stock_date') required this.startingStockDate,
      @JsonKey(name: 'current_stock_date') required this.currentStockDate,
      @JsonKey(name: 'reconciliation_method')
      required this.reconciliationMethod,
      @JsonKey(name: 'calculation_explanation')
      required this.calculationExplanation,
      required this.summary,
      @JsonKey(name: 'reconciliation_details')
      required final List<ReconciliationReportDetail> reconciliationDetails,
      @JsonKey(name: 'saved_to_database') required this.savedToDatabase})
      : _reconciliationDetails = reconciliationDetails;

  factory _$ReconciliationReportResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReconciliationReportResponseImplFromJson(json);

  @override
  final bool success;
  @override
  @JsonKey(name: 'report_date')
  final String reportDate;
  @override
  final String period;
  @override
  @JsonKey(name: 'starting_stock_date')
  final String startingStockDate;
  @override
  @JsonKey(name: 'current_stock_date')
  final String currentStockDate;
  @override
  @JsonKey(name: 'reconciliation_method')
  final String reconciliationMethod;
  @override
  @JsonKey(name: 'calculation_explanation')
  final String calculationExplanation;
  @override
  final ReconciliationReportSummary summary;
  final List<ReconciliationReportDetail> _reconciliationDetails;
  @override
  @JsonKey(name: 'reconciliation_details')
  List<ReconciliationReportDetail> get reconciliationDetails {
    if (_reconciliationDetails is EqualUnmodifiableListView)
      return _reconciliationDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reconciliationDetails);
  }

  @override
  @JsonKey(name: 'saved_to_database')
  final bool savedToDatabase;

  @override
  String toString() {
    return 'ReconciliationReportResponse(success: $success, reportDate: $reportDate, period: $period, startingStockDate: $startingStockDate, currentStockDate: $currentStockDate, reconciliationMethod: $reconciliationMethod, calculationExplanation: $calculationExplanation, summary: $summary, reconciliationDetails: $reconciliationDetails, savedToDatabase: $savedToDatabase)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReconciliationReportResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.reportDate, reportDate) ||
                other.reportDate == reportDate) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.startingStockDate, startingStockDate) ||
                other.startingStockDate == startingStockDate) &&
            (identical(other.currentStockDate, currentStockDate) ||
                other.currentStockDate == currentStockDate) &&
            (identical(other.reconciliationMethod, reconciliationMethod) ||
                other.reconciliationMethod == reconciliationMethod) &&
            (identical(other.calculationExplanation, calculationExplanation) ||
                other.calculationExplanation == calculationExplanation) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality()
                .equals(other._reconciliationDetails, _reconciliationDetails) &&
            (identical(other.savedToDatabase, savedToDatabase) ||
                other.savedToDatabase == savedToDatabase));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      reportDate,
      period,
      startingStockDate,
      currentStockDate,
      reconciliationMethod,
      calculationExplanation,
      summary,
      const DeepCollectionEquality().hash(_reconciliationDetails),
      savedToDatabase);

  /// Create a copy of ReconciliationReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReconciliationReportResponseImplCopyWith<
          _$ReconciliationReportResponseImpl>
      get copyWith => __$$ReconciliationReportResponseImplCopyWithImpl<
          _$ReconciliationReportResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReconciliationReportResponseImplToJson(
      this,
    );
  }
}

abstract class _ReconciliationReportResponse
    implements ReconciliationReportResponse {
  const factory _ReconciliationReportResponse(
          {required final bool success,
          @JsonKey(name: 'report_date') required final String reportDate,
          required final String period,
          @JsonKey(name: 'starting_stock_date')
          required final String startingStockDate,
          @JsonKey(name: 'current_stock_date')
          required final String currentStockDate,
          @JsonKey(name: 'reconciliation_method')
          required final String reconciliationMethod,
          @JsonKey(name: 'calculation_explanation')
          required final String calculationExplanation,
          required final ReconciliationReportSummary summary,
          @JsonKey(name: 'reconciliation_details')
          required final List<ReconciliationReportDetail> reconciliationDetails,
          @JsonKey(name: 'saved_to_database')
          required final bool savedToDatabase}) =
      _$ReconciliationReportResponseImpl;

  factory _ReconciliationReportResponse.fromJson(Map<String, dynamic> json) =
      _$ReconciliationReportResponseImpl.fromJson;

  @override
  bool get success;
  @override
  @JsonKey(name: 'report_date')
  String get reportDate;
  @override
  String get period;
  @override
  @JsonKey(name: 'starting_stock_date')
  String get startingStockDate;
  @override
  @JsonKey(name: 'current_stock_date')
  String get currentStockDate;
  @override
  @JsonKey(name: 'reconciliation_method')
  String get reconciliationMethod;
  @override
  @JsonKey(name: 'calculation_explanation')
  String get calculationExplanation;
  @override
  ReconciliationReportSummary get summary;
  @override
  @JsonKey(name: 'reconciliation_details')
  List<ReconciliationReportDetail> get reconciliationDetails;
  @override
  @JsonKey(name: 'saved_to_database')
  bool get savedToDatabase;

  /// Create a copy of ReconciliationReportResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReconciliationReportResponseImplCopyWith<
          _$ReconciliationReportResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ReconciliationReportSummary _$ReconciliationReportSummaryFromJson(
    Map<String, dynamic> json) {
  return _ReconciliationReportSummary.fromJson(json);
}

/// @nodoc
mixin _$ReconciliationReportSummary {
  @JsonKey(name: 'total_items')
  int get totalItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'over_stock_items')
  int get overStockItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'short_stock_items')
  int get shortStockItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'matching_items')
  int get matchingItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_variance_value', fromJson: _stringToDouble)
  double get totalVarianceValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_over_value', fromJson: _stringToDouble)
  double get totalOverValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_short_value', fromJson: _stringToDouble)
  double get totalShortValue => throw _privateConstructorUsedError;

  /// Serializes this ReconciliationReportSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReconciliationReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReconciliationReportSummaryCopyWith<ReconciliationReportSummary>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReconciliationReportSummaryCopyWith<$Res> {
  factory $ReconciliationReportSummaryCopyWith(
          ReconciliationReportSummary value,
          $Res Function(ReconciliationReportSummary) then) =
      _$ReconciliationReportSummaryCopyWithImpl<$Res,
          ReconciliationReportSummary>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_items') int totalItems,
      @JsonKey(name: 'over_stock_items') int overStockItems,
      @JsonKey(name: 'short_stock_items') int shortStockItems,
      @JsonKey(name: 'matching_items') int matchingItems,
      @JsonKey(name: 'total_variance_value', fromJson: _stringToDouble)
      double totalVarianceValue,
      @JsonKey(name: 'total_over_value', fromJson: _stringToDouble)
      double totalOverValue,
      @JsonKey(name: 'total_short_value', fromJson: _stringToDouble)
      double totalShortValue});
}

/// @nodoc
class _$ReconciliationReportSummaryCopyWithImpl<$Res,
        $Val extends ReconciliationReportSummary>
    implements $ReconciliationReportSummaryCopyWith<$Res> {
  _$ReconciliationReportSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReconciliationReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalItems = null,
    Object? overStockItems = null,
    Object? shortStockItems = null,
    Object? matchingItems = null,
    Object? totalVarianceValue = null,
    Object? totalOverValue = null,
    Object? totalShortValue = null,
  }) {
    return _then(_value.copyWith(
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      overStockItems: null == overStockItems
          ? _value.overStockItems
          : overStockItems // ignore: cast_nullable_to_non_nullable
              as int,
      shortStockItems: null == shortStockItems
          ? _value.shortStockItems
          : shortStockItems // ignore: cast_nullable_to_non_nullable
              as int,
      matchingItems: null == matchingItems
          ? _value.matchingItems
          : matchingItems // ignore: cast_nullable_to_non_nullable
              as int,
      totalVarianceValue: null == totalVarianceValue
          ? _value.totalVarianceValue
          : totalVarianceValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalOverValue: null == totalOverValue
          ? _value.totalOverValue
          : totalOverValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalShortValue: null == totalShortValue
          ? _value.totalShortValue
          : totalShortValue // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReconciliationReportSummaryImplCopyWith<$Res>
    implements $ReconciliationReportSummaryCopyWith<$Res> {
  factory _$$ReconciliationReportSummaryImplCopyWith(
          _$ReconciliationReportSummaryImpl value,
          $Res Function(_$ReconciliationReportSummaryImpl) then) =
      __$$ReconciliationReportSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_items') int totalItems,
      @JsonKey(name: 'over_stock_items') int overStockItems,
      @JsonKey(name: 'short_stock_items') int shortStockItems,
      @JsonKey(name: 'matching_items') int matchingItems,
      @JsonKey(name: 'total_variance_value', fromJson: _stringToDouble)
      double totalVarianceValue,
      @JsonKey(name: 'total_over_value', fromJson: _stringToDouble)
      double totalOverValue,
      @JsonKey(name: 'total_short_value', fromJson: _stringToDouble)
      double totalShortValue});
}

/// @nodoc
class __$$ReconciliationReportSummaryImplCopyWithImpl<$Res>
    extends _$ReconciliationReportSummaryCopyWithImpl<$Res,
        _$ReconciliationReportSummaryImpl>
    implements _$$ReconciliationReportSummaryImplCopyWith<$Res> {
  __$$ReconciliationReportSummaryImplCopyWithImpl(
      _$ReconciliationReportSummaryImpl _value,
      $Res Function(_$ReconciliationReportSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReconciliationReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalItems = null,
    Object? overStockItems = null,
    Object? shortStockItems = null,
    Object? matchingItems = null,
    Object? totalVarianceValue = null,
    Object? totalOverValue = null,
    Object? totalShortValue = null,
  }) {
    return _then(_$ReconciliationReportSummaryImpl(
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      overStockItems: null == overStockItems
          ? _value.overStockItems
          : overStockItems // ignore: cast_nullable_to_non_nullable
              as int,
      shortStockItems: null == shortStockItems
          ? _value.shortStockItems
          : shortStockItems // ignore: cast_nullable_to_non_nullable
              as int,
      matchingItems: null == matchingItems
          ? _value.matchingItems
          : matchingItems // ignore: cast_nullable_to_non_nullable
              as int,
      totalVarianceValue: null == totalVarianceValue
          ? _value.totalVarianceValue
          : totalVarianceValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalOverValue: null == totalOverValue
          ? _value.totalOverValue
          : totalOverValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalShortValue: null == totalShortValue
          ? _value.totalShortValue
          : totalShortValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReconciliationReportSummaryImpl
    implements _ReconciliationReportSummary {
  const _$ReconciliationReportSummaryImpl(
      {@JsonKey(name: 'total_items') required this.totalItems,
      @JsonKey(name: 'over_stock_items') required this.overStockItems,
      @JsonKey(name: 'short_stock_items') required this.shortStockItems,
      @JsonKey(name: 'matching_items') required this.matchingItems,
      @JsonKey(name: 'total_variance_value', fromJson: _stringToDouble)
      required this.totalVarianceValue,
      @JsonKey(name: 'total_over_value', fromJson: _stringToDouble)
      required this.totalOverValue,
      @JsonKey(name: 'total_short_value', fromJson: _stringToDouble)
      required this.totalShortValue});

  factory _$ReconciliationReportSummaryImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReconciliationReportSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'total_items')
  final int totalItems;
  @override
  @JsonKey(name: 'over_stock_items')
  final int overStockItems;
  @override
  @JsonKey(name: 'short_stock_items')
  final int shortStockItems;
  @override
  @JsonKey(name: 'matching_items')
  final int matchingItems;
  @override
  @JsonKey(name: 'total_variance_value', fromJson: _stringToDouble)
  final double totalVarianceValue;
  @override
  @JsonKey(name: 'total_over_value', fromJson: _stringToDouble)
  final double totalOverValue;
  @override
  @JsonKey(name: 'total_short_value', fromJson: _stringToDouble)
  final double totalShortValue;

  @override
  String toString() {
    return 'ReconciliationReportSummary(totalItems: $totalItems, overStockItems: $overStockItems, shortStockItems: $shortStockItems, matchingItems: $matchingItems, totalVarianceValue: $totalVarianceValue, totalOverValue: $totalOverValue, totalShortValue: $totalShortValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReconciliationReportSummaryImpl &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.overStockItems, overStockItems) ||
                other.overStockItems == overStockItems) &&
            (identical(other.shortStockItems, shortStockItems) ||
                other.shortStockItems == shortStockItems) &&
            (identical(other.matchingItems, matchingItems) ||
                other.matchingItems == matchingItems) &&
            (identical(other.totalVarianceValue, totalVarianceValue) ||
                other.totalVarianceValue == totalVarianceValue) &&
            (identical(other.totalOverValue, totalOverValue) ||
                other.totalOverValue == totalOverValue) &&
            (identical(other.totalShortValue, totalShortValue) ||
                other.totalShortValue == totalShortValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalItems,
      overStockItems,
      shortStockItems,
      matchingItems,
      totalVarianceValue,
      totalOverValue,
      totalShortValue);

  /// Create a copy of ReconciliationReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReconciliationReportSummaryImplCopyWith<_$ReconciliationReportSummaryImpl>
      get copyWith => __$$ReconciliationReportSummaryImplCopyWithImpl<
          _$ReconciliationReportSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReconciliationReportSummaryImplToJson(
      this,
    );
  }
}

abstract class _ReconciliationReportSummary
    implements ReconciliationReportSummary {
  const factory _ReconciliationReportSummary(
      {@JsonKey(name: 'total_items') required final int totalItems,
      @JsonKey(name: 'over_stock_items') required final int overStockItems,
      @JsonKey(name: 'short_stock_items') required final int shortStockItems,
      @JsonKey(name: 'matching_items') required final int matchingItems,
      @JsonKey(name: 'total_variance_value', fromJson: _stringToDouble)
      required final double totalVarianceValue,
      @JsonKey(name: 'total_over_value', fromJson: _stringToDouble)
      required final double totalOverValue,
      @JsonKey(name: 'total_short_value', fromJson: _stringToDouble)
      required final double
          totalShortValue}) = _$ReconciliationReportSummaryImpl;

  factory _ReconciliationReportSummary.fromJson(Map<String, dynamic> json) =
      _$ReconciliationReportSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'total_items')
  int get totalItems;
  @override
  @JsonKey(name: 'over_stock_items')
  int get overStockItems;
  @override
  @JsonKey(name: 'short_stock_items')
  int get shortStockItems;
  @override
  @JsonKey(name: 'matching_items')
  int get matchingItems;
  @override
  @JsonKey(name: 'total_variance_value', fromJson: _stringToDouble)
  double get totalVarianceValue;
  @override
  @JsonKey(name: 'total_over_value', fromJson: _stringToDouble)
  double get totalOverValue;
  @override
  @JsonKey(name: 'total_short_value', fromJson: _stringToDouble)
  double get totalShortValue;

  /// Create a copy of ReconciliationReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReconciliationReportSummaryImplCopyWith<_$ReconciliationReportSummaryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ReconciliationReportDetail _$ReconciliationReportDetailFromJson(
    Map<String, dynamic> json) {
  return _ReconciliationReportDetail.fromJson(json);
}

/// @nodoc
mixin _$ReconciliationReportDetail {
  String get item => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'starting_stock')
  int get startingStock => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_purchases')
  int get totalPurchases => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales')
  int get totalSales => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_stock_in')
  int get totalStockIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_stock_out')
  int get totalStockOut => throw _privateConstructorUsedError;
  @JsonKey(name: 'expected_stock')
  int get expectedStock => throw _privateConstructorUsedError;
  @JsonKey(name: 'actual_stock')
  int get actualStock => throw _privateConstructorUsedError;
  int get variance => throw _privateConstructorUsedError;
  @JsonKey(name: 'variance_value', fromJson: _stringToDouble)
  double get varianceValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_rate', fromJson: _stringToDouble)
  double get itemRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'precious_stock')
  List<StockRecord>? get preciousStock => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_stock')
  List<StockRecord>? get currentStock => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'calculation_formula')
  String get calculationFormula => throw _privateConstructorUsedError;

  /// Serializes this ReconciliationReportDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReconciliationReportDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReconciliationReportDetailCopyWith<ReconciliationReportDetail>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReconciliationReportDetailCopyWith<$Res> {
  factory $ReconciliationReportDetailCopyWith(ReconciliationReportDetail value,
          $Res Function(ReconciliationReportDetail) then) =
      _$ReconciliationReportDetailCopyWithImpl<$Res,
          ReconciliationReportDetail>;
  @useResult
  $Res call(
      {String item,
      String location,
      @JsonKey(name: 'starting_stock') int startingStock,
      @JsonKey(name: 'total_purchases') int totalPurchases,
      @JsonKey(name: 'total_sales') int totalSales,
      @JsonKey(name: 'total_stock_in') int totalStockIn,
      @JsonKey(name: 'total_stock_out') int totalStockOut,
      @JsonKey(name: 'expected_stock') int expectedStock,
      @JsonKey(name: 'actual_stock') int actualStock,
      int variance,
      @JsonKey(name: 'variance_value', fromJson: _stringToDouble)
      double varianceValue,
      @JsonKey(name: 'item_rate', fromJson: _stringToDouble) double itemRate,
      @JsonKey(name: 'precious_stock') List<StockRecord>? preciousStock,
      @JsonKey(name: 'current_stock') List<StockRecord>? currentStock,
      String status,
      @JsonKey(name: 'calculation_formula') String calculationFormula});
}

/// @nodoc
class _$ReconciliationReportDetailCopyWithImpl<$Res,
        $Val extends ReconciliationReportDetail>
    implements $ReconciliationReportDetailCopyWith<$Res> {
  _$ReconciliationReportDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReconciliationReportDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? location = null,
    Object? startingStock = null,
    Object? totalPurchases = null,
    Object? totalSales = null,
    Object? totalStockIn = null,
    Object? totalStockOut = null,
    Object? expectedStock = null,
    Object? actualStock = null,
    Object? variance = null,
    Object? varianceValue = null,
    Object? itemRate = null,
    Object? preciousStock = freezed,
    Object? currentStock = freezed,
    Object? status = null,
    Object? calculationFormula = null,
  }) {
    return _then(_value.copyWith(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      startingStock: null == startingStock
          ? _value.startingStock
          : startingStock // ignore: cast_nullable_to_non_nullable
              as int,
      totalPurchases: null == totalPurchases
          ? _value.totalPurchases
          : totalPurchases // ignore: cast_nullable_to_non_nullable
              as int,
      totalSales: null == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as int,
      totalStockIn: null == totalStockIn
          ? _value.totalStockIn
          : totalStockIn // ignore: cast_nullable_to_non_nullable
              as int,
      totalStockOut: null == totalStockOut
          ? _value.totalStockOut
          : totalStockOut // ignore: cast_nullable_to_non_nullable
              as int,
      expectedStock: null == expectedStock
          ? _value.expectedStock
          : expectedStock // ignore: cast_nullable_to_non_nullable
              as int,
      actualStock: null == actualStock
          ? _value.actualStock
          : actualStock // ignore: cast_nullable_to_non_nullable
              as int,
      variance: null == variance
          ? _value.variance
          : variance // ignore: cast_nullable_to_non_nullable
              as int,
      varianceValue: null == varianceValue
          ? _value.varianceValue
          : varianceValue // ignore: cast_nullable_to_non_nullable
              as double,
      itemRate: null == itemRate
          ? _value.itemRate
          : itemRate // ignore: cast_nullable_to_non_nullable
              as double,
      preciousStock: freezed == preciousStock
          ? _value.preciousStock
          : preciousStock // ignore: cast_nullable_to_non_nullable
              as List<StockRecord>?,
      currentStock: freezed == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as List<StockRecord>?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      calculationFormula: null == calculationFormula
          ? _value.calculationFormula
          : calculationFormula // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReconciliationReportDetailImplCopyWith<$Res>
    implements $ReconciliationReportDetailCopyWith<$Res> {
  factory _$$ReconciliationReportDetailImplCopyWith(
          _$ReconciliationReportDetailImpl value,
          $Res Function(_$ReconciliationReportDetailImpl) then) =
      __$$ReconciliationReportDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String item,
      String location,
      @JsonKey(name: 'starting_stock') int startingStock,
      @JsonKey(name: 'total_purchases') int totalPurchases,
      @JsonKey(name: 'total_sales') int totalSales,
      @JsonKey(name: 'total_stock_in') int totalStockIn,
      @JsonKey(name: 'total_stock_out') int totalStockOut,
      @JsonKey(name: 'expected_stock') int expectedStock,
      @JsonKey(name: 'actual_stock') int actualStock,
      int variance,
      @JsonKey(name: 'variance_value', fromJson: _stringToDouble)
      double varianceValue,
      @JsonKey(name: 'item_rate', fromJson: _stringToDouble) double itemRate,
      @JsonKey(name: 'precious_stock') List<StockRecord>? preciousStock,
      @JsonKey(name: 'current_stock') List<StockRecord>? currentStock,
      String status,
      @JsonKey(name: 'calculation_formula') String calculationFormula});
}

/// @nodoc
class __$$ReconciliationReportDetailImplCopyWithImpl<$Res>
    extends _$ReconciliationReportDetailCopyWithImpl<$Res,
        _$ReconciliationReportDetailImpl>
    implements _$$ReconciliationReportDetailImplCopyWith<$Res> {
  __$$ReconciliationReportDetailImplCopyWithImpl(
      _$ReconciliationReportDetailImpl _value,
      $Res Function(_$ReconciliationReportDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReconciliationReportDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? location = null,
    Object? startingStock = null,
    Object? totalPurchases = null,
    Object? totalSales = null,
    Object? totalStockIn = null,
    Object? totalStockOut = null,
    Object? expectedStock = null,
    Object? actualStock = null,
    Object? variance = null,
    Object? varianceValue = null,
    Object? itemRate = null,
    Object? preciousStock = freezed,
    Object? currentStock = freezed,
    Object? status = null,
    Object? calculationFormula = null,
  }) {
    return _then(_$ReconciliationReportDetailImpl(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      startingStock: null == startingStock
          ? _value.startingStock
          : startingStock // ignore: cast_nullable_to_non_nullable
              as int,
      totalPurchases: null == totalPurchases
          ? _value.totalPurchases
          : totalPurchases // ignore: cast_nullable_to_non_nullable
              as int,
      totalSales: null == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as int,
      totalStockIn: null == totalStockIn
          ? _value.totalStockIn
          : totalStockIn // ignore: cast_nullable_to_non_nullable
              as int,
      totalStockOut: null == totalStockOut
          ? _value.totalStockOut
          : totalStockOut // ignore: cast_nullable_to_non_nullable
              as int,
      expectedStock: null == expectedStock
          ? _value.expectedStock
          : expectedStock // ignore: cast_nullable_to_non_nullable
              as int,
      actualStock: null == actualStock
          ? _value.actualStock
          : actualStock // ignore: cast_nullable_to_non_nullable
              as int,
      variance: null == variance
          ? _value.variance
          : variance // ignore: cast_nullable_to_non_nullable
              as int,
      varianceValue: null == varianceValue
          ? _value.varianceValue
          : varianceValue // ignore: cast_nullable_to_non_nullable
              as double,
      itemRate: null == itemRate
          ? _value.itemRate
          : itemRate // ignore: cast_nullable_to_non_nullable
              as double,
      preciousStock: freezed == preciousStock
          ? _value._preciousStock
          : preciousStock // ignore: cast_nullable_to_non_nullable
              as List<StockRecord>?,
      currentStock: freezed == currentStock
          ? _value._currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as List<StockRecord>?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      calculationFormula: null == calculationFormula
          ? _value.calculationFormula
          : calculationFormula // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReconciliationReportDetailImpl implements _ReconciliationReportDetail {
  const _$ReconciliationReportDetailImpl(
      {required this.item,
      required this.location,
      @JsonKey(name: 'starting_stock') required this.startingStock,
      @JsonKey(name: 'total_purchases') required this.totalPurchases,
      @JsonKey(name: 'total_sales') required this.totalSales,
      @JsonKey(name: 'total_stock_in') required this.totalStockIn,
      @JsonKey(name: 'total_stock_out') required this.totalStockOut,
      @JsonKey(name: 'expected_stock') required this.expectedStock,
      @JsonKey(name: 'actual_stock') required this.actualStock,
      required this.variance,
      @JsonKey(name: 'variance_value', fromJson: _stringToDouble)
      required this.varianceValue,
      @JsonKey(name: 'item_rate', fromJson: _stringToDouble)
      required this.itemRate,
      @JsonKey(name: 'precious_stock') final List<StockRecord>? preciousStock,
      @JsonKey(name: 'current_stock') final List<StockRecord>? currentStock,
      required this.status,
      @JsonKey(name: 'calculation_formula') required this.calculationFormula})
      : _preciousStock = preciousStock,
        _currentStock = currentStock;

  factory _$ReconciliationReportDetailImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReconciliationReportDetailImplFromJson(json);

  @override
  final String item;
  @override
  final String location;
  @override
  @JsonKey(name: 'starting_stock')
  final int startingStock;
  @override
  @JsonKey(name: 'total_purchases')
  final int totalPurchases;
  @override
  @JsonKey(name: 'total_sales')
  final int totalSales;
  @override
  @JsonKey(name: 'total_stock_in')
  final int totalStockIn;
  @override
  @JsonKey(name: 'total_stock_out')
  final int totalStockOut;
  @override
  @JsonKey(name: 'expected_stock')
  final int expectedStock;
  @override
  @JsonKey(name: 'actual_stock')
  final int actualStock;
  @override
  final int variance;
  @override
  @JsonKey(name: 'variance_value', fromJson: _stringToDouble)
  final double varianceValue;
  @override
  @JsonKey(name: 'item_rate', fromJson: _stringToDouble)
  final double itemRate;
  final List<StockRecord>? _preciousStock;
  @override
  @JsonKey(name: 'precious_stock')
  List<StockRecord>? get preciousStock {
    final value = _preciousStock;
    if (value == null) return null;
    if (_preciousStock is EqualUnmodifiableListView) return _preciousStock;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<StockRecord>? _currentStock;
  @override
  @JsonKey(name: 'current_stock')
  List<StockRecord>? get currentStock {
    final value = _currentStock;
    if (value == null) return null;
    if (_currentStock is EqualUnmodifiableListView) return _currentStock;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String status;
  @override
  @JsonKey(name: 'calculation_formula')
  final String calculationFormula;

  @override
  String toString() {
    return 'ReconciliationReportDetail(item: $item, location: $location, startingStock: $startingStock, totalPurchases: $totalPurchases, totalSales: $totalSales, totalStockIn: $totalStockIn, totalStockOut: $totalStockOut, expectedStock: $expectedStock, actualStock: $actualStock, variance: $variance, varianceValue: $varianceValue, itemRate: $itemRate, preciousStock: $preciousStock, currentStock: $currentStock, status: $status, calculationFormula: $calculationFormula)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReconciliationReportDetailImpl &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.startingStock, startingStock) ||
                other.startingStock == startingStock) &&
            (identical(other.totalPurchases, totalPurchases) ||
                other.totalPurchases == totalPurchases) &&
            (identical(other.totalSales, totalSales) ||
                other.totalSales == totalSales) &&
            (identical(other.totalStockIn, totalStockIn) ||
                other.totalStockIn == totalStockIn) &&
            (identical(other.totalStockOut, totalStockOut) ||
                other.totalStockOut == totalStockOut) &&
            (identical(other.expectedStock, expectedStock) ||
                other.expectedStock == expectedStock) &&
            (identical(other.actualStock, actualStock) ||
                other.actualStock == actualStock) &&
            (identical(other.variance, variance) ||
                other.variance == variance) &&
            (identical(other.varianceValue, varianceValue) ||
                other.varianceValue == varianceValue) &&
            (identical(other.itemRate, itemRate) ||
                other.itemRate == itemRate) &&
            const DeepCollectionEquality()
                .equals(other._preciousStock, _preciousStock) &&
            const DeepCollectionEquality()
                .equals(other._currentStock, _currentStock) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.calculationFormula, calculationFormula) ||
                other.calculationFormula == calculationFormula));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      item,
      location,
      startingStock,
      totalPurchases,
      totalSales,
      totalStockIn,
      totalStockOut,
      expectedStock,
      actualStock,
      variance,
      varianceValue,
      itemRate,
      const DeepCollectionEquality().hash(_preciousStock),
      const DeepCollectionEquality().hash(_currentStock),
      status,
      calculationFormula);

  /// Create a copy of ReconciliationReportDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReconciliationReportDetailImplCopyWith<_$ReconciliationReportDetailImpl>
      get copyWith => __$$ReconciliationReportDetailImplCopyWithImpl<
          _$ReconciliationReportDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReconciliationReportDetailImplToJson(
      this,
    );
  }
}

abstract class _ReconciliationReportDetail
    implements ReconciliationReportDetail {
  const factory _ReconciliationReportDetail(
      {required final String item,
      required final String location,
      @JsonKey(name: 'starting_stock') required final int startingStock,
      @JsonKey(name: 'total_purchases') required final int totalPurchases,
      @JsonKey(name: 'total_sales') required final int totalSales,
      @JsonKey(name: 'total_stock_in') required final int totalStockIn,
      @JsonKey(name: 'total_stock_out') required final int totalStockOut,
      @JsonKey(name: 'expected_stock') required final int expectedStock,
      @JsonKey(name: 'actual_stock') required final int actualStock,
      required final int variance,
      @JsonKey(name: 'variance_value', fromJson: _stringToDouble)
      required final double varianceValue,
      @JsonKey(name: 'item_rate', fromJson: _stringToDouble)
      required final double itemRate,
      @JsonKey(name: 'precious_stock') final List<StockRecord>? preciousStock,
      @JsonKey(name: 'current_stock') final List<StockRecord>? currentStock,
      required final String status,
      @JsonKey(name: 'calculation_formula')
      required final String
          calculationFormula}) = _$ReconciliationReportDetailImpl;

  factory _ReconciliationReportDetail.fromJson(Map<String, dynamic> json) =
      _$ReconciliationReportDetailImpl.fromJson;

  @override
  String get item;
  @override
  String get location;
  @override
  @JsonKey(name: 'starting_stock')
  int get startingStock;
  @override
  @JsonKey(name: 'total_purchases')
  int get totalPurchases;
  @override
  @JsonKey(name: 'total_sales')
  int get totalSales;
  @override
  @JsonKey(name: 'total_stock_in')
  int get totalStockIn;
  @override
  @JsonKey(name: 'total_stock_out')
  int get totalStockOut;
  @override
  @JsonKey(name: 'expected_stock')
  int get expectedStock;
  @override
  @JsonKey(name: 'actual_stock')
  int get actualStock;
  @override
  int get variance;
  @override
  @JsonKey(name: 'variance_value', fromJson: _stringToDouble)
  double get varianceValue;
  @override
  @JsonKey(name: 'item_rate', fromJson: _stringToDouble)
  double get itemRate;
  @override
  @JsonKey(name: 'precious_stock')
  List<StockRecord>? get preciousStock;
  @override
  @JsonKey(name: 'current_stock')
  List<StockRecord>? get currentStock;
  @override
  String get status;
  @override
  @JsonKey(name: 'calculation_formula')
  String get calculationFormula;

  /// Create a copy of ReconciliationReportDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReconciliationReportDetailImplCopyWith<_$ReconciliationReportDetailImpl>
      get copyWith => throw _privateConstructorUsedError;
}

StockRecord _$StockRecordFromJson(Map<String, dynamic> json) {
  return _StockRecord.fromJson(json);
}

/// @nodoc
mixin _$StockRecord {
  String get name => throw _privateConstructorUsedError;
  String get item => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'previousQuantity')
  int get previousQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'reportingDate')
  String get reportingDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'uploadDate')
  String get uploadDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'uploadedBy')
  String get uploadedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchNumber')
  String get batchNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'expiryDate')
  String get expiryDate => throw _privateConstructorUsedError;
  int get rate => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'isActive')
  int get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdBy')
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'modifiedBy')
  String get modifiedBy => throw _privateConstructorUsedError;
  String get created => throw _privateConstructorUsedError;
  String get modified => throw _privateConstructorUsedError;

  /// Serializes this StockRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockRecordCopyWith<StockRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockRecordCopyWith<$Res> {
  factory $StockRecordCopyWith(
          StockRecord value, $Res Function(StockRecord) then) =
      _$StockRecordCopyWithImpl<$Res, StockRecord>;
  @useResult
  $Res call(
      {String name,
      String item,
      String location,
      @JsonKey(name: 'previousQuantity') int previousQuantity,
      @JsonKey(name: 'reportingDate') String reportingDate,
      @JsonKey(name: 'uploadDate') String uploadDate,
      @JsonKey(name: 'uploadedBy') String uploadedBy,
      @JsonKey(name: 'batchNumber') String batchNumber,
      @JsonKey(name: 'expiryDate') String expiryDate,
      int rate,
      int value,
      String notes,
      @JsonKey(name: 'isActive') int isActive,
      @JsonKey(name: 'createdBy') String createdBy,
      @JsonKey(name: 'modifiedBy') String modifiedBy,
      String created,
      String modified});
}

/// @nodoc
class _$StockRecordCopyWithImpl<$Res, $Val extends StockRecord>
    implements $StockRecordCopyWith<$Res> {
  _$StockRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? item = null,
    Object? location = null,
    Object? previousQuantity = null,
    Object? reportingDate = null,
    Object? uploadDate = null,
    Object? uploadedBy = null,
    Object? batchNumber = null,
    Object? expiryDate = null,
    Object? rate = null,
    Object? value = null,
    Object? notes = null,
    Object? isActive = null,
    Object? createdBy = null,
    Object? modifiedBy = null,
    Object? created = null,
    Object? modified = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      previousQuantity: null == previousQuantity
          ? _value.previousQuantity
          : previousQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      reportingDate: null == reportingDate
          ? _value.reportingDate
          : reportingDate // ignore: cast_nullable_to_non_nullable
              as String,
      uploadDate: null == uploadDate
          ? _value.uploadDate
          : uploadDate // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedBy: null == uploadedBy
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as String,
      batchNumber: null == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as int,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as int,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      modifiedBy: null == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockRecordImplCopyWith<$Res>
    implements $StockRecordCopyWith<$Res> {
  factory _$$StockRecordImplCopyWith(
          _$StockRecordImpl value, $Res Function(_$StockRecordImpl) then) =
      __$$StockRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String item,
      String location,
      @JsonKey(name: 'previousQuantity') int previousQuantity,
      @JsonKey(name: 'reportingDate') String reportingDate,
      @JsonKey(name: 'uploadDate') String uploadDate,
      @JsonKey(name: 'uploadedBy') String uploadedBy,
      @JsonKey(name: 'batchNumber') String batchNumber,
      @JsonKey(name: 'expiryDate') String expiryDate,
      int rate,
      int value,
      String notes,
      @JsonKey(name: 'isActive') int isActive,
      @JsonKey(name: 'createdBy') String createdBy,
      @JsonKey(name: 'modifiedBy') String modifiedBy,
      String created,
      String modified});
}

/// @nodoc
class __$$StockRecordImplCopyWithImpl<$Res>
    extends _$StockRecordCopyWithImpl<$Res, _$StockRecordImpl>
    implements _$$StockRecordImplCopyWith<$Res> {
  __$$StockRecordImplCopyWithImpl(
      _$StockRecordImpl _value, $Res Function(_$StockRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of StockRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? item = null,
    Object? location = null,
    Object? previousQuantity = null,
    Object? reportingDate = null,
    Object? uploadDate = null,
    Object? uploadedBy = null,
    Object? batchNumber = null,
    Object? expiryDate = null,
    Object? rate = null,
    Object? value = null,
    Object? notes = null,
    Object? isActive = null,
    Object? createdBy = null,
    Object? modifiedBy = null,
    Object? created = null,
    Object? modified = null,
  }) {
    return _then(_$StockRecordImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      previousQuantity: null == previousQuantity
          ? _value.previousQuantity
          : previousQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      reportingDate: null == reportingDate
          ? _value.reportingDate
          : reportingDate // ignore: cast_nullable_to_non_nullable
              as String,
      uploadDate: null == uploadDate
          ? _value.uploadDate
          : uploadDate // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedBy: null == uploadedBy
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as String,
      batchNumber: null == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: null == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as int,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as int,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      modifiedBy: null == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockRecordImpl implements _StockRecord {
  const _$StockRecordImpl(
      {required this.name,
      required this.item,
      required this.location,
      @JsonKey(name: 'previousQuantity') required this.previousQuantity,
      @JsonKey(name: 'reportingDate') required this.reportingDate,
      @JsonKey(name: 'uploadDate') required this.uploadDate,
      @JsonKey(name: 'uploadedBy') required this.uploadedBy,
      @JsonKey(name: 'batchNumber') required this.batchNumber,
      @JsonKey(name: 'expiryDate') required this.expiryDate,
      required this.rate,
      required this.value,
      required this.notes,
      @JsonKey(name: 'isActive') required this.isActive,
      @JsonKey(name: 'createdBy') required this.createdBy,
      @JsonKey(name: 'modifiedBy') required this.modifiedBy,
      required this.created,
      required this.modified});

  factory _$StockRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockRecordImplFromJson(json);

  @override
  final String name;
  @override
  final String item;
  @override
  final String location;
  @override
  @JsonKey(name: 'previousQuantity')
  final int previousQuantity;
  @override
  @JsonKey(name: 'reportingDate')
  final String reportingDate;
  @override
  @JsonKey(name: 'uploadDate')
  final String uploadDate;
  @override
  @JsonKey(name: 'uploadedBy')
  final String uploadedBy;
  @override
  @JsonKey(name: 'batchNumber')
  final String batchNumber;
  @override
  @JsonKey(name: 'expiryDate')
  final String expiryDate;
  @override
  final int rate;
  @override
  final int value;
  @override
  final String notes;
  @override
  @JsonKey(name: 'isActive')
  final int isActive;
  @override
  @JsonKey(name: 'createdBy')
  final String createdBy;
  @override
  @JsonKey(name: 'modifiedBy')
  final String modifiedBy;
  @override
  final String created;
  @override
  final String modified;

  @override
  String toString() {
    return 'StockRecord(name: $name, item: $item, location: $location, previousQuantity: $previousQuantity, reportingDate: $reportingDate, uploadDate: $uploadDate, uploadedBy: $uploadedBy, batchNumber: $batchNumber, expiryDate: $expiryDate, rate: $rate, value: $value, notes: $notes, isActive: $isActive, createdBy: $createdBy, modifiedBy: $modifiedBy, created: $created, modified: $modified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockRecordImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.previousQuantity, previousQuantity) ||
                other.previousQuantity == previousQuantity) &&
            (identical(other.reportingDate, reportingDate) ||
                other.reportingDate == reportingDate) &&
            (identical(other.uploadDate, uploadDate) ||
                other.uploadDate == uploadDate) &&
            (identical(other.uploadedBy, uploadedBy) ||
                other.uploadedBy == uploadedBy) &&
            (identical(other.batchNumber, batchNumber) ||
                other.batchNumber == batchNumber) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.modified, modified) ||
                other.modified == modified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      item,
      location,
      previousQuantity,
      reportingDate,
      uploadDate,
      uploadedBy,
      batchNumber,
      expiryDate,
      rate,
      value,
      notes,
      isActive,
      createdBy,
      modifiedBy,
      created,
      modified);

  /// Create a copy of StockRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockRecordImplCopyWith<_$StockRecordImpl> get copyWith =>
      __$$StockRecordImplCopyWithImpl<_$StockRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockRecordImplToJson(
      this,
    );
  }
}

abstract class _StockRecord implements StockRecord {
  const factory _StockRecord(
      {required final String name,
      required final String item,
      required final String location,
      @JsonKey(name: 'previousQuantity') required final int previousQuantity,
      @JsonKey(name: 'reportingDate') required final String reportingDate,
      @JsonKey(name: 'uploadDate') required final String uploadDate,
      @JsonKey(name: 'uploadedBy') required final String uploadedBy,
      @JsonKey(name: 'batchNumber') required final String batchNumber,
      @JsonKey(name: 'expiryDate') required final String expiryDate,
      required final int rate,
      required final int value,
      required final String notes,
      @JsonKey(name: 'isActive') required final int isActive,
      @JsonKey(name: 'createdBy') required final String createdBy,
      @JsonKey(name: 'modifiedBy') required final String modifiedBy,
      required final String created,
      required final String modified}) = _$StockRecordImpl;

  factory _StockRecord.fromJson(Map<String, dynamic> json) =
      _$StockRecordImpl.fromJson;

  @override
  String get name;
  @override
  String get item;
  @override
  String get location;
  @override
  @JsonKey(name: 'previousQuantity')
  int get previousQuantity;
  @override
  @JsonKey(name: 'reportingDate')
  String get reportingDate;
  @override
  @JsonKey(name: 'uploadDate')
  String get uploadDate;
  @override
  @JsonKey(name: 'uploadedBy')
  String get uploadedBy;
  @override
  @JsonKey(name: 'batchNumber')
  String get batchNumber;
  @override
  @JsonKey(name: 'expiryDate')
  String get expiryDate;
  @override
  int get rate;
  @override
  int get value;
  @override
  String get notes;
  @override
  @JsonKey(name: 'isActive')
  int get isActive;
  @override
  @JsonKey(name: 'createdBy')
  String get createdBy;
  @override
  @JsonKey(name: 'modifiedBy')
  String get modifiedBy;
  @override
  String get created;
  @override
  String get modified;

  /// Create a copy of StockRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockRecordImplCopyWith<_$StockRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
