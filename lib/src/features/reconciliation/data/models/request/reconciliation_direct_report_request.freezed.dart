// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reconciliation_direct_report_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReconciliationDirectReportRequest _$ReconciliationDirectReportRequestFromJson(
    Map<String, dynamic> json) {
  return _ReconciliationDirectReportRequest.fromJson(json);
}

/// @nodoc
mixin _$ReconciliationDirectReportRequest {
  @JsonKey(name: 'previous_stock')
  List<StockItem> get previousStock => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_stock')
  List<StockItem> get currentStock => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  String get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  String get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'include_transaction_details')
  bool get includeTransactionDetails => throw _privateConstructorUsedError;
  @JsonKey(name: 'save_report')
  bool get saveReport => throw _privateConstructorUsedError;
  @JsonKey(name: 'report_name')
  String get reportName => throw _privateConstructorUsedError;

  /// Serializes this ReconciliationDirectReportRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReconciliationDirectReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReconciliationDirectReportRequestCopyWith<ReconciliationDirectReportRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReconciliationDirectReportRequestCopyWith<$Res> {
  factory $ReconciliationDirectReportRequestCopyWith(
          ReconciliationDirectReportRequest value,
          $Res Function(ReconciliationDirectReportRequest) then) =
      _$ReconciliationDirectReportRequestCopyWithImpl<$Res,
          ReconciliationDirectReportRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'previous_stock') List<StockItem> previousStock,
      @JsonKey(name: 'current_stock') List<StockItem> currentStock,
      @JsonKey(name: 'start_date') String startDate,
      @JsonKey(name: 'end_date') String endDate,
      @JsonKey(name: 'include_transaction_details')
      bool includeTransactionDetails,
      @JsonKey(name: 'save_report') bool saveReport,
      @JsonKey(name: 'report_name') String reportName});
}

/// @nodoc
class _$ReconciliationDirectReportRequestCopyWithImpl<$Res,
        $Val extends ReconciliationDirectReportRequest>
    implements $ReconciliationDirectReportRequestCopyWith<$Res> {
  _$ReconciliationDirectReportRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReconciliationDirectReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousStock = null,
    Object? currentStock = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? includeTransactionDetails = null,
    Object? saveReport = null,
    Object? reportName = null,
  }) {
    return _then(_value.copyWith(
      previousStock: null == previousStock
          ? _value.previousStock
          : previousStock // ignore: cast_nullable_to_non_nullable
              as List<StockItem>,
      currentStock: null == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as List<StockItem>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      includeTransactionDetails: null == includeTransactionDetails
          ? _value.includeTransactionDetails
          : includeTransactionDetails // ignore: cast_nullable_to_non_nullable
              as bool,
      saveReport: null == saveReport
          ? _value.saveReport
          : saveReport // ignore: cast_nullable_to_non_nullable
              as bool,
      reportName: null == reportName
          ? _value.reportName
          : reportName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReconciliationDirectReportRequestImplCopyWith<$Res>
    implements $ReconciliationDirectReportRequestCopyWith<$Res> {
  factory _$$ReconciliationDirectReportRequestImplCopyWith(
          _$ReconciliationDirectReportRequestImpl value,
          $Res Function(_$ReconciliationDirectReportRequestImpl) then) =
      __$$ReconciliationDirectReportRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'previous_stock') List<StockItem> previousStock,
      @JsonKey(name: 'current_stock') List<StockItem> currentStock,
      @JsonKey(name: 'start_date') String startDate,
      @JsonKey(name: 'end_date') String endDate,
      @JsonKey(name: 'include_transaction_details')
      bool includeTransactionDetails,
      @JsonKey(name: 'save_report') bool saveReport,
      @JsonKey(name: 'report_name') String reportName});
}

/// @nodoc
class __$$ReconciliationDirectReportRequestImplCopyWithImpl<$Res>
    extends _$ReconciliationDirectReportRequestCopyWithImpl<$Res,
        _$ReconciliationDirectReportRequestImpl>
    implements _$$ReconciliationDirectReportRequestImplCopyWith<$Res> {
  __$$ReconciliationDirectReportRequestImplCopyWithImpl(
      _$ReconciliationDirectReportRequestImpl _value,
      $Res Function(_$ReconciliationDirectReportRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReconciliationDirectReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousStock = null,
    Object? currentStock = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? includeTransactionDetails = null,
    Object? saveReport = null,
    Object? reportName = null,
  }) {
    return _then(_$ReconciliationDirectReportRequestImpl(
      previousStock: null == previousStock
          ? _value._previousStock
          : previousStock // ignore: cast_nullable_to_non_nullable
              as List<StockItem>,
      currentStock: null == currentStock
          ? _value._currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as List<StockItem>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      includeTransactionDetails: null == includeTransactionDetails
          ? _value.includeTransactionDetails
          : includeTransactionDetails // ignore: cast_nullable_to_non_nullable
              as bool,
      saveReport: null == saveReport
          ? _value.saveReport
          : saveReport // ignore: cast_nullable_to_non_nullable
              as bool,
      reportName: null == reportName
          ? _value.reportName
          : reportName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReconciliationDirectReportRequestImpl
    implements _ReconciliationDirectReportRequest {
  const _$ReconciliationDirectReportRequestImpl(
      {@JsonKey(name: 'previous_stock')
      required final List<StockItem> previousStock,
      @JsonKey(name: 'current_stock')
      required final List<StockItem> currentStock,
      @JsonKey(name: 'start_date') required this.startDate,
      @JsonKey(name: 'end_date') required this.endDate,
      @JsonKey(name: 'include_transaction_details')
      required this.includeTransactionDetails,
      @JsonKey(name: 'save_report') required this.saveReport,
      @JsonKey(name: 'report_name') required this.reportName})
      : _previousStock = previousStock,
        _currentStock = currentStock;

  factory _$ReconciliationDirectReportRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReconciliationDirectReportRequestImplFromJson(json);

  final List<StockItem> _previousStock;
  @override
  @JsonKey(name: 'previous_stock')
  List<StockItem> get previousStock {
    if (_previousStock is EqualUnmodifiableListView) return _previousStock;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previousStock);
  }

  final List<StockItem> _currentStock;
  @override
  @JsonKey(name: 'current_stock')
  List<StockItem> get currentStock {
    if (_currentStock is EqualUnmodifiableListView) return _currentStock;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentStock);
  }

  @override
  @JsonKey(name: 'start_date')
  final String startDate;
  @override
  @JsonKey(name: 'end_date')
  final String endDate;
  @override
  @JsonKey(name: 'include_transaction_details')
  final bool includeTransactionDetails;
  @override
  @JsonKey(name: 'save_report')
  final bool saveReport;
  @override
  @JsonKey(name: 'report_name')
  final String reportName;

  @override
  String toString() {
    return 'ReconciliationDirectReportRequest(previousStock: $previousStock, currentStock: $currentStock, startDate: $startDate, endDate: $endDate, includeTransactionDetails: $includeTransactionDetails, saveReport: $saveReport, reportName: $reportName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReconciliationDirectReportRequestImpl &&
            const DeepCollectionEquality()
                .equals(other._previousStock, _previousStock) &&
            const DeepCollectionEquality()
                .equals(other._currentStock, _currentStock) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.includeTransactionDetails,
                    includeTransactionDetails) ||
                other.includeTransactionDetails == includeTransactionDetails) &&
            (identical(other.saveReport, saveReport) ||
                other.saveReport == saveReport) &&
            (identical(other.reportName, reportName) ||
                other.reportName == reportName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_previousStock),
      const DeepCollectionEquality().hash(_currentStock),
      startDate,
      endDate,
      includeTransactionDetails,
      saveReport,
      reportName);

  /// Create a copy of ReconciliationDirectReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReconciliationDirectReportRequestImplCopyWith<
          _$ReconciliationDirectReportRequestImpl>
      get copyWith => __$$ReconciliationDirectReportRequestImplCopyWithImpl<
          _$ReconciliationDirectReportRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReconciliationDirectReportRequestImplToJson(
      this,
    );
  }
}

abstract class _ReconciliationDirectReportRequest
    implements ReconciliationDirectReportRequest {
  const factory _ReconciliationDirectReportRequest(
          {@JsonKey(name: 'previous_stock')
          required final List<StockItem> previousStock,
          @JsonKey(name: 'current_stock')
          required final List<StockItem> currentStock,
          @JsonKey(name: 'start_date') required final String startDate,
          @JsonKey(name: 'end_date') required final String endDate,
          @JsonKey(name: 'include_transaction_details')
          required final bool includeTransactionDetails,
          @JsonKey(name: 'save_report') required final bool saveReport,
          @JsonKey(name: 'report_name') required final String reportName}) =
      _$ReconciliationDirectReportRequestImpl;

  factory _ReconciliationDirectReportRequest.fromJson(
          Map<String, dynamic> json) =
      _$ReconciliationDirectReportRequestImpl.fromJson;

  @override
  @JsonKey(name: 'previous_stock')
  List<StockItem> get previousStock;
  @override
  @JsonKey(name: 'current_stock')
  List<StockItem> get currentStock;
  @override
  @JsonKey(name: 'start_date')
  String get startDate;
  @override
  @JsonKey(name: 'end_date')
  String get endDate;
  @override
  @JsonKey(name: 'include_transaction_details')
  bool get includeTransactionDetails;
  @override
  @JsonKey(name: 'save_report')
  bool get saveReport;
  @override
  @JsonKey(name: 'report_name')
  String get reportName;

  /// Create a copy of ReconciliationDirectReportRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReconciliationDirectReportRequestImplCopyWith<
          _$ReconciliationDirectReportRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

StockItem _$StockItemFromJson(Map<String, dynamic> json) {
  return _StockItem.fromJson(json);
}

/// @nodoc
mixin _$StockItem {
  String get item => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numberToDouble)
  double get quantity => throw _privateConstructorUsedError;

  /// Serializes this StockItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockItemCopyWith<StockItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockItemCopyWith<$Res> {
  factory $StockItemCopyWith(StockItem value, $Res Function(StockItem) then) =
      _$StockItemCopyWithImpl<$Res, StockItem>;
  @useResult
  $Res call(
      {String item,
      String location,
      @JsonKey(fromJson: _numberToDouble) double quantity});
}

/// @nodoc
class _$StockItemCopyWithImpl<$Res, $Val extends StockItem>
    implements $StockItemCopyWith<$Res> {
  _$StockItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? location = null,
    Object? quantity = null,
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
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockItemImplCopyWith<$Res>
    implements $StockItemCopyWith<$Res> {
  factory _$$StockItemImplCopyWith(
          _$StockItemImpl value, $Res Function(_$StockItemImpl) then) =
      __$$StockItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String item,
      String location,
      @JsonKey(fromJson: _numberToDouble) double quantity});
}

/// @nodoc
class __$$StockItemImplCopyWithImpl<$Res>
    extends _$StockItemCopyWithImpl<$Res, _$StockItemImpl>
    implements _$$StockItemImplCopyWith<$Res> {
  __$$StockItemImplCopyWithImpl(
      _$StockItemImpl _value, $Res Function(_$StockItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of StockItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? location = null,
    Object? quantity = null,
  }) {
    return _then(_$StockItemImpl(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockItemImpl implements _StockItem {
  const _$StockItemImpl(
      {required this.item,
      required this.location,
      @JsonKey(fromJson: _numberToDouble) required this.quantity});

  factory _$StockItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockItemImplFromJson(json);

  @override
  final String item;
  @override
  final String location;
  @override
  @JsonKey(fromJson: _numberToDouble)
  final double quantity;

  @override
  String toString() {
    return 'StockItem(item: $item, location: $location, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockItemImpl &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, item, location, quantity);

  /// Create a copy of StockItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockItemImplCopyWith<_$StockItemImpl> get copyWith =>
      __$$StockItemImplCopyWithImpl<_$StockItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockItemImplToJson(
      this,
    );
  }
}

abstract class _StockItem implements StockItem {
  const factory _StockItem(
          {required final String item,
          required final String location,
          @JsonKey(fromJson: _numberToDouble) required final double quantity}) =
      _$StockItemImpl;

  factory _StockItem.fromJson(Map<String, dynamic> json) =
      _$StockItemImpl.fromJson;

  @override
  String get item;
  @override
  String get location;
  @override
  @JsonKey(fromJson: _numberToDouble)
  double get quantity;

  /// Create a copy of StockItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockItemImplCopyWith<_$StockItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
