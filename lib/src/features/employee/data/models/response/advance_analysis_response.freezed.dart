// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advance_analysis_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdvanceAnalysisResponse _$AdvanceAnalysisResponseFromJson(
    Map<String, dynamic> json) {
  return _AdvanceAnalysisResponse.fromJson(json);
}

/// @nodoc
mixin _$AdvanceAnalysisResponse {
  @JsonKey(name: 'analysis_data')
  List<AdvanceAnalysisData> get analysisData =>
      throw _privateConstructorUsedError;
  AdvanceSummary get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_employees')
  List<TopEmployee> get topEmployees => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_departments')
  List<TopDepartment> get topDepartments => throw _privateConstructorUsedError;
  @JsonKey(name: 'filters_applied')
  FiltersApplied get filtersApplied => throw _privateConstructorUsedError;
  AdvanceMetadata get metadata => throw _privateConstructorUsedError;

  /// Serializes this AdvanceAnalysisResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdvanceAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdvanceAnalysisResponseCopyWith<AdvanceAnalysisResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdvanceAnalysisResponseCopyWith<$Res> {
  factory $AdvanceAnalysisResponseCopyWith(AdvanceAnalysisResponse value,
          $Res Function(AdvanceAnalysisResponse) then) =
      _$AdvanceAnalysisResponseCopyWithImpl<$Res, AdvanceAnalysisResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'analysis_data') List<AdvanceAnalysisData> analysisData,
      AdvanceSummary summary,
      @JsonKey(name: 'top_employees') List<TopEmployee> topEmployees,
      @JsonKey(name: 'top_departments') List<TopDepartment> topDepartments,
      @JsonKey(name: 'filters_applied') FiltersApplied filtersApplied,
      AdvanceMetadata metadata});

  $AdvanceSummaryCopyWith<$Res> get summary;
  $FiltersAppliedCopyWith<$Res> get filtersApplied;
  $AdvanceMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class _$AdvanceAnalysisResponseCopyWithImpl<$Res,
        $Val extends AdvanceAnalysisResponse>
    implements $AdvanceAnalysisResponseCopyWith<$Res> {
  _$AdvanceAnalysisResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdvanceAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? analysisData = null,
    Object? summary = null,
    Object? topEmployees = null,
    Object? topDepartments = null,
    Object? filtersApplied = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      analysisData: null == analysisData
          ? _value.analysisData
          : analysisData // ignore: cast_nullable_to_non_nullable
              as List<AdvanceAnalysisData>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as AdvanceSummary,
      topEmployees: null == topEmployees
          ? _value.topEmployees
          : topEmployees // ignore: cast_nullable_to_non_nullable
              as List<TopEmployee>,
      topDepartments: null == topDepartments
          ? _value.topDepartments
          : topDepartments // ignore: cast_nullable_to_non_nullable
              as List<TopDepartment>,
      filtersApplied: null == filtersApplied
          ? _value.filtersApplied
          : filtersApplied // ignore: cast_nullable_to_non_nullable
              as FiltersApplied,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as AdvanceMetadata,
    ) as $Val);
  }

  /// Create a copy of AdvanceAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AdvanceSummaryCopyWith<$Res> get summary {
    return $AdvanceSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }

  /// Create a copy of AdvanceAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FiltersAppliedCopyWith<$Res> get filtersApplied {
    return $FiltersAppliedCopyWith<$Res>(_value.filtersApplied, (value) {
      return _then(_value.copyWith(filtersApplied: value) as $Val);
    });
  }

  /// Create a copy of AdvanceAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AdvanceMetadataCopyWith<$Res> get metadata {
    return $AdvanceMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AdvanceAnalysisResponseImplCopyWith<$Res>
    implements $AdvanceAnalysisResponseCopyWith<$Res> {
  factory _$$AdvanceAnalysisResponseImplCopyWith(
          _$AdvanceAnalysisResponseImpl value,
          $Res Function(_$AdvanceAnalysisResponseImpl) then) =
      __$$AdvanceAnalysisResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'analysis_data') List<AdvanceAnalysisData> analysisData,
      AdvanceSummary summary,
      @JsonKey(name: 'top_employees') List<TopEmployee> topEmployees,
      @JsonKey(name: 'top_departments') List<TopDepartment> topDepartments,
      @JsonKey(name: 'filters_applied') FiltersApplied filtersApplied,
      AdvanceMetadata metadata});

  @override
  $AdvanceSummaryCopyWith<$Res> get summary;
  @override
  $FiltersAppliedCopyWith<$Res> get filtersApplied;
  @override
  $AdvanceMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$AdvanceAnalysisResponseImplCopyWithImpl<$Res>
    extends _$AdvanceAnalysisResponseCopyWithImpl<$Res,
        _$AdvanceAnalysisResponseImpl>
    implements _$$AdvanceAnalysisResponseImplCopyWith<$Res> {
  __$$AdvanceAnalysisResponseImplCopyWithImpl(
      _$AdvanceAnalysisResponseImpl _value,
      $Res Function(_$AdvanceAnalysisResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdvanceAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? analysisData = null,
    Object? summary = null,
    Object? topEmployees = null,
    Object? topDepartments = null,
    Object? filtersApplied = null,
    Object? metadata = null,
  }) {
    return _then(_$AdvanceAnalysisResponseImpl(
      analysisData: null == analysisData
          ? _value._analysisData
          : analysisData // ignore: cast_nullable_to_non_nullable
              as List<AdvanceAnalysisData>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as AdvanceSummary,
      topEmployees: null == topEmployees
          ? _value._topEmployees
          : topEmployees // ignore: cast_nullable_to_non_nullable
              as List<TopEmployee>,
      topDepartments: null == topDepartments
          ? _value._topDepartments
          : topDepartments // ignore: cast_nullable_to_non_nullable
              as List<TopDepartment>,
      filtersApplied: null == filtersApplied
          ? _value.filtersApplied
          : filtersApplied // ignore: cast_nullable_to_non_nullable
              as FiltersApplied,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as AdvanceMetadata,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdvanceAnalysisResponseImpl implements _AdvanceAnalysisResponse {
  const _$AdvanceAnalysisResponseImpl(
      {@JsonKey(name: 'analysis_data')
      required final List<AdvanceAnalysisData> analysisData,
      required this.summary,
      @JsonKey(name: 'top_employees')
      required final List<TopEmployee> topEmployees,
      @JsonKey(name: 'top_departments')
      required final List<TopDepartment> topDepartments,
      @JsonKey(name: 'filters_applied') required this.filtersApplied,
      required this.metadata})
      : _analysisData = analysisData,
        _topEmployees = topEmployees,
        _topDepartments = topDepartments;

  factory _$AdvanceAnalysisResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdvanceAnalysisResponseImplFromJson(json);

  final List<AdvanceAnalysisData> _analysisData;
  @override
  @JsonKey(name: 'analysis_data')
  List<AdvanceAnalysisData> get analysisData {
    if (_analysisData is EqualUnmodifiableListView) return _analysisData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_analysisData);
  }

  @override
  final AdvanceSummary summary;
  final List<TopEmployee> _topEmployees;
  @override
  @JsonKey(name: 'top_employees')
  List<TopEmployee> get topEmployees {
    if (_topEmployees is EqualUnmodifiableListView) return _topEmployees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topEmployees);
  }

  final List<TopDepartment> _topDepartments;
  @override
  @JsonKey(name: 'top_departments')
  List<TopDepartment> get topDepartments {
    if (_topDepartments is EqualUnmodifiableListView) return _topDepartments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topDepartments);
  }

  @override
  @JsonKey(name: 'filters_applied')
  final FiltersApplied filtersApplied;
  @override
  final AdvanceMetadata metadata;

  @override
  String toString() {
    return 'AdvanceAnalysisResponse(analysisData: $analysisData, summary: $summary, topEmployees: $topEmployees, topDepartments: $topDepartments, filtersApplied: $filtersApplied, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdvanceAnalysisResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._analysisData, _analysisData) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality()
                .equals(other._topEmployees, _topEmployees) &&
            const DeepCollectionEquality()
                .equals(other._topDepartments, _topDepartments) &&
            (identical(other.filtersApplied, filtersApplied) ||
                other.filtersApplied == filtersApplied) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_analysisData),
      summary,
      const DeepCollectionEquality().hash(_topEmployees),
      const DeepCollectionEquality().hash(_topDepartments),
      filtersApplied,
      metadata);

  /// Create a copy of AdvanceAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdvanceAnalysisResponseImplCopyWith<_$AdvanceAnalysisResponseImpl>
      get copyWith => __$$AdvanceAnalysisResponseImplCopyWithImpl<
          _$AdvanceAnalysisResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdvanceAnalysisResponseImplToJson(
      this,
    );
  }
}

abstract class _AdvanceAnalysisResponse implements AdvanceAnalysisResponse {
  const factory _AdvanceAnalysisResponse(
      {@JsonKey(name: 'analysis_data')
      required final List<AdvanceAnalysisData> analysisData,
      required final AdvanceSummary summary,
      @JsonKey(name: 'top_employees')
      required final List<TopEmployee> topEmployees,
      @JsonKey(name: 'top_departments')
      required final List<TopDepartment> topDepartments,
      @JsonKey(name: 'filters_applied')
      required final FiltersApplied filtersApplied,
      required final AdvanceMetadata metadata}) = _$AdvanceAnalysisResponseImpl;

  factory _AdvanceAnalysisResponse.fromJson(Map<String, dynamic> json) =
      _$AdvanceAnalysisResponseImpl.fromJson;

  @override
  @JsonKey(name: 'analysis_data')
  List<AdvanceAnalysisData> get analysisData;
  @override
  AdvanceSummary get summary;
  @override
  @JsonKey(name: 'top_employees')
  List<TopEmployee> get topEmployees;
  @override
  @JsonKey(name: 'top_departments')
  List<TopDepartment> get topDepartments;
  @override
  @JsonKey(name: 'filters_applied')
  FiltersApplied get filtersApplied;
  @override
  AdvanceMetadata get metadata;

  /// Create a copy of AdvanceAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdvanceAnalysisResponseImplCopyWith<_$AdvanceAnalysisResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AdvanceAnalysisData _$AdvanceAnalysisDataFromJson(Map<String, dynamic> json) {
  return _AdvanceAnalysisData.fromJson(json);
}

/// @nodoc
mixin _$AdvanceAnalysisData {
  @JsonKey(name: 'employee_id')
  int get employeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_code')
  String get employeeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_name')
  String get employeeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'party_id')
  String get partyId => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;
  @JsonKey(name: 'basic_salary')
  double get basicSalary => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_count')
  int get invoiceCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_quantity')
  int get totalQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_amount')
  double get averageAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_rate')
  double get averageRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_discount')
  double get totalDiscount => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_purchase_date')
  DateTime get firstPurchaseDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_purchase_date')
  DateTime get lastPurchaseDate => throw _privateConstructorUsedError;
  List<Invoice> get invoices => throw _privateConstructorUsedError;

  /// Serializes this AdvanceAnalysisData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdvanceAnalysisData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdvanceAnalysisDataCopyWith<AdvanceAnalysisData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdvanceAnalysisDataCopyWith<$Res> {
  factory $AdvanceAnalysisDataCopyWith(
          AdvanceAnalysisData value, $Res Function(AdvanceAnalysisData) then) =
      _$AdvanceAnalysisDataCopyWithImpl<$Res, AdvanceAnalysisData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'party_id') String partyId,
      String department,
      String position,
      @JsonKey(name: 'basic_salary') double basicSalary,
      @JsonKey(name: 'invoice_count') int invoiceCount,
      @JsonKey(name: 'total_quantity') int totalQuantity,
      @JsonKey(name: 'total_amount') double totalAmount,
      @JsonKey(name: 'average_amount') double averageAmount,
      @JsonKey(name: 'average_rate') double averageRate,
      @JsonKey(name: 'total_discount') double totalDiscount,
      @JsonKey(name: 'first_purchase_date') DateTime firstPurchaseDate,
      @JsonKey(name: 'last_purchase_date') DateTime lastPurchaseDate,
      List<Invoice> invoices});
}

/// @nodoc
class _$AdvanceAnalysisDataCopyWithImpl<$Res, $Val extends AdvanceAnalysisData>
    implements $AdvanceAnalysisDataCopyWith<$Res> {
  _$AdvanceAnalysisDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdvanceAnalysisData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? employeeCode = null,
    Object? employeeName = null,
    Object? partyId = null,
    Object? department = null,
    Object? position = null,
    Object? basicSalary = null,
    Object? invoiceCount = null,
    Object? totalQuantity = null,
    Object? totalAmount = null,
    Object? averageAmount = null,
    Object? averageRate = null,
    Object? totalDiscount = null,
    Object? firstPurchaseDate = null,
    Object? lastPurchaseDate = null,
    Object? invoices = null,
  }) {
    return _then(_value.copyWith(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      partyId: null == partyId
          ? _value.partyId
          : partyId // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      basicSalary: null == basicSalary
          ? _value.basicSalary
          : basicSalary // ignore: cast_nullable_to_non_nullable
              as double,
      invoiceCount: null == invoiceCount
          ? _value.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      averageAmount: null == averageAmount
          ? _value.averageAmount
          : averageAmount // ignore: cast_nullable_to_non_nullable
              as double,
      averageRate: null == averageRate
          ? _value.averageRate
          : averageRate // ignore: cast_nullable_to_non_nullable
              as double,
      totalDiscount: null == totalDiscount
          ? _value.totalDiscount
          : totalDiscount // ignore: cast_nullable_to_non_nullable
              as double,
      firstPurchaseDate: null == firstPurchaseDate
          ? _value.firstPurchaseDate
          : firstPurchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastPurchaseDate: null == lastPurchaseDate
          ? _value.lastPurchaseDate
          : lastPurchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      invoices: null == invoices
          ? _value.invoices
          : invoices // ignore: cast_nullable_to_non_nullable
              as List<Invoice>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdvanceAnalysisDataImplCopyWith<$Res>
    implements $AdvanceAnalysisDataCopyWith<$Res> {
  factory _$$AdvanceAnalysisDataImplCopyWith(_$AdvanceAnalysisDataImpl value,
          $Res Function(_$AdvanceAnalysisDataImpl) then) =
      __$$AdvanceAnalysisDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_id') int employeeId,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'party_id') String partyId,
      String department,
      String position,
      @JsonKey(name: 'basic_salary') double basicSalary,
      @JsonKey(name: 'invoice_count') int invoiceCount,
      @JsonKey(name: 'total_quantity') int totalQuantity,
      @JsonKey(name: 'total_amount') double totalAmount,
      @JsonKey(name: 'average_amount') double averageAmount,
      @JsonKey(name: 'average_rate') double averageRate,
      @JsonKey(name: 'total_discount') double totalDiscount,
      @JsonKey(name: 'first_purchase_date') DateTime firstPurchaseDate,
      @JsonKey(name: 'last_purchase_date') DateTime lastPurchaseDate,
      List<Invoice> invoices});
}

/// @nodoc
class __$$AdvanceAnalysisDataImplCopyWithImpl<$Res>
    extends _$AdvanceAnalysisDataCopyWithImpl<$Res, _$AdvanceAnalysisDataImpl>
    implements _$$AdvanceAnalysisDataImplCopyWith<$Res> {
  __$$AdvanceAnalysisDataImplCopyWithImpl(_$AdvanceAnalysisDataImpl _value,
      $Res Function(_$AdvanceAnalysisDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdvanceAnalysisData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = null,
    Object? employeeCode = null,
    Object? employeeName = null,
    Object? partyId = null,
    Object? department = null,
    Object? position = null,
    Object? basicSalary = null,
    Object? invoiceCount = null,
    Object? totalQuantity = null,
    Object? totalAmount = null,
    Object? averageAmount = null,
    Object? averageRate = null,
    Object? totalDiscount = null,
    Object? firstPurchaseDate = null,
    Object? lastPurchaseDate = null,
    Object? invoices = null,
  }) {
    return _then(_$AdvanceAnalysisDataImpl(
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      partyId: null == partyId
          ? _value.partyId
          : partyId // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      basicSalary: null == basicSalary
          ? _value.basicSalary
          : basicSalary // ignore: cast_nullable_to_non_nullable
              as double,
      invoiceCount: null == invoiceCount
          ? _value.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      averageAmount: null == averageAmount
          ? _value.averageAmount
          : averageAmount // ignore: cast_nullable_to_non_nullable
              as double,
      averageRate: null == averageRate
          ? _value.averageRate
          : averageRate // ignore: cast_nullable_to_non_nullable
              as double,
      totalDiscount: null == totalDiscount
          ? _value.totalDiscount
          : totalDiscount // ignore: cast_nullable_to_non_nullable
              as double,
      firstPurchaseDate: null == firstPurchaseDate
          ? _value.firstPurchaseDate
          : firstPurchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastPurchaseDate: null == lastPurchaseDate
          ? _value.lastPurchaseDate
          : lastPurchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      invoices: null == invoices
          ? _value._invoices
          : invoices // ignore: cast_nullable_to_non_nullable
              as List<Invoice>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdvanceAnalysisDataImpl implements _AdvanceAnalysisData {
  const _$AdvanceAnalysisDataImpl(
      {@JsonKey(name: 'employee_id') required this.employeeId,
      @JsonKey(name: 'employee_code') required this.employeeCode,
      @JsonKey(name: 'employee_name') required this.employeeName,
      @JsonKey(name: 'party_id') required this.partyId,
      required this.department,
      required this.position,
      @JsonKey(name: 'basic_salary') required this.basicSalary,
      @JsonKey(name: 'invoice_count') required this.invoiceCount,
      @JsonKey(name: 'total_quantity') required this.totalQuantity,
      @JsonKey(name: 'total_amount') required this.totalAmount,
      @JsonKey(name: 'average_amount') required this.averageAmount,
      @JsonKey(name: 'average_rate') required this.averageRate,
      @JsonKey(name: 'total_discount') required this.totalDiscount,
      @JsonKey(name: 'first_purchase_date') required this.firstPurchaseDate,
      @JsonKey(name: 'last_purchase_date') required this.lastPurchaseDate,
      required final List<Invoice> invoices})
      : _invoices = invoices;

  factory _$AdvanceAnalysisDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdvanceAnalysisDataImplFromJson(json);

  @override
  @JsonKey(name: 'employee_id')
  final int employeeId;
  @override
  @JsonKey(name: 'employee_code')
  final String employeeCode;
  @override
  @JsonKey(name: 'employee_name')
  final String employeeName;
  @override
  @JsonKey(name: 'party_id')
  final String partyId;
  @override
  final String department;
  @override
  final String position;
  @override
  @JsonKey(name: 'basic_salary')
  final double basicSalary;
  @override
  @JsonKey(name: 'invoice_count')
  final int invoiceCount;
  @override
  @JsonKey(name: 'total_quantity')
  final int totalQuantity;
  @override
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  @override
  @JsonKey(name: 'average_amount')
  final double averageAmount;
  @override
  @JsonKey(name: 'average_rate')
  final double averageRate;
  @override
  @JsonKey(name: 'total_discount')
  final double totalDiscount;
  @override
  @JsonKey(name: 'first_purchase_date')
  final DateTime firstPurchaseDate;
  @override
  @JsonKey(name: 'last_purchase_date')
  final DateTime lastPurchaseDate;
  final List<Invoice> _invoices;
  @override
  List<Invoice> get invoices {
    if (_invoices is EqualUnmodifiableListView) return _invoices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_invoices);
  }

  @override
  String toString() {
    return 'AdvanceAnalysisData(employeeId: $employeeId, employeeCode: $employeeCode, employeeName: $employeeName, partyId: $partyId, department: $department, position: $position, basicSalary: $basicSalary, invoiceCount: $invoiceCount, totalQuantity: $totalQuantity, totalAmount: $totalAmount, averageAmount: $averageAmount, averageRate: $averageRate, totalDiscount: $totalDiscount, firstPurchaseDate: $firstPurchaseDate, lastPurchaseDate: $lastPurchaseDate, invoices: $invoices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdvanceAnalysisDataImpl &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.partyId, partyId) || other.partyId == partyId) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.basicSalary, basicSalary) ||
                other.basicSalary == basicSalary) &&
            (identical(other.invoiceCount, invoiceCount) ||
                other.invoiceCount == invoiceCount) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.averageAmount, averageAmount) ||
                other.averageAmount == averageAmount) &&
            (identical(other.averageRate, averageRate) ||
                other.averageRate == averageRate) &&
            (identical(other.totalDiscount, totalDiscount) ||
                other.totalDiscount == totalDiscount) &&
            (identical(other.firstPurchaseDate, firstPurchaseDate) ||
                other.firstPurchaseDate == firstPurchaseDate) &&
            (identical(other.lastPurchaseDate, lastPurchaseDate) ||
                other.lastPurchaseDate == lastPurchaseDate) &&
            const DeepCollectionEquality().equals(other._invoices, _invoices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      employeeId,
      employeeCode,
      employeeName,
      partyId,
      department,
      position,
      basicSalary,
      invoiceCount,
      totalQuantity,
      totalAmount,
      averageAmount,
      averageRate,
      totalDiscount,
      firstPurchaseDate,
      lastPurchaseDate,
      const DeepCollectionEquality().hash(_invoices));

  /// Create a copy of AdvanceAnalysisData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdvanceAnalysisDataImplCopyWith<_$AdvanceAnalysisDataImpl> get copyWith =>
      __$$AdvanceAnalysisDataImplCopyWithImpl<_$AdvanceAnalysisDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdvanceAnalysisDataImplToJson(
      this,
    );
  }
}

abstract class _AdvanceAnalysisData implements AdvanceAnalysisData {
  const factory _AdvanceAnalysisData(
      {@JsonKey(name: 'employee_id') required final int employeeId,
      @JsonKey(name: 'employee_code') required final String employeeCode,
      @JsonKey(name: 'employee_name') required final String employeeName,
      @JsonKey(name: 'party_id') required final String partyId,
      required final String department,
      required final String position,
      @JsonKey(name: 'basic_salary') required final double basicSalary,
      @JsonKey(name: 'invoice_count') required final int invoiceCount,
      @JsonKey(name: 'total_quantity') required final int totalQuantity,
      @JsonKey(name: 'total_amount') required final double totalAmount,
      @JsonKey(name: 'average_amount') required final double averageAmount,
      @JsonKey(name: 'average_rate') required final double averageRate,
      @JsonKey(name: 'total_discount') required final double totalDiscount,
      @JsonKey(name: 'first_purchase_date')
      required final DateTime firstPurchaseDate,
      @JsonKey(name: 'last_purchase_date')
      required final DateTime lastPurchaseDate,
      required final List<Invoice> invoices}) = _$AdvanceAnalysisDataImpl;

  factory _AdvanceAnalysisData.fromJson(Map<String, dynamic> json) =
      _$AdvanceAnalysisDataImpl.fromJson;

  @override
  @JsonKey(name: 'employee_id')
  int get employeeId;
  @override
  @JsonKey(name: 'employee_code')
  String get employeeCode;
  @override
  @JsonKey(name: 'employee_name')
  String get employeeName;
  @override
  @JsonKey(name: 'party_id')
  String get partyId;
  @override
  String get department;
  @override
  String get position;
  @override
  @JsonKey(name: 'basic_salary')
  double get basicSalary;
  @override
  @JsonKey(name: 'invoice_count')
  int get invoiceCount;
  @override
  @JsonKey(name: 'total_quantity')
  int get totalQuantity;
  @override
  @JsonKey(name: 'total_amount')
  double get totalAmount;
  @override
  @JsonKey(name: 'average_amount')
  double get averageAmount;
  @override
  @JsonKey(name: 'average_rate')
  double get averageRate;
  @override
  @JsonKey(name: 'total_discount')
  double get totalDiscount;
  @override
  @JsonKey(name: 'first_purchase_date')
  DateTime get firstPurchaseDate;
  @override
  @JsonKey(name: 'last_purchase_date')
  DateTime get lastPurchaseDate;
  @override
  List<Invoice> get invoices;

  /// Create a copy of AdvanceAnalysisData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdvanceAnalysisDataImplCopyWith<_$AdvanceAnalysisDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return _Invoice.fromJson(json);
}

/// @nodoc
mixin _$Invoice {
  @JsonKey(name: 'invoice_name')
  String get invoiceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'number_series')
  String get numberSeries => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier_name')
  String get supplierName => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_name')
  String get employeeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_code')
  String get employeeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_date')
  DateTime get invoiceDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total')
  String get grandTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_total')
  String get netTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'base_grand_total')
  String get baseGrandTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount')
  String get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_percent')
  int get discountPercent => throw _privateConstructorUsedError;
  @JsonKey(name: 'outstanding_amount')
  String get outstandingAmount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'exchange_rate')
  int get exchangeRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_submitted')
  int get isSubmitted => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_date')
  DateTime get createdDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;

  /// Serializes this Invoice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceCopyWith<Invoice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceCopyWith<$Res> {
  factory $InvoiceCopyWith(Invoice value, $Res Function(Invoice) then) =
      _$InvoiceCopyWithImpl<$Res, Invoice>;
  @useResult
  $Res call(
      {@JsonKey(name: 'invoice_name') String invoiceName,
      @JsonKey(name: 'number_series') String numberSeries,
      @JsonKey(name: 'supplier_name') String supplierName,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'invoice_date') DateTime invoiceDate,
      @JsonKey(name: 'grand_total') String grandTotal,
      @JsonKey(name: 'net_total') String netTotal,
      @JsonKey(name: 'base_grand_total') String baseGrandTotal,
      @JsonKey(name: 'discount_amount') String discountAmount,
      @JsonKey(name: 'discount_percent') int discountPercent,
      @JsonKey(name: 'outstanding_amount') String outstandingAmount,
      String currency,
      @JsonKey(name: 'exchange_rate') int exchangeRate,
      @JsonKey(name: 'is_submitted') int isSubmitted,
      @JsonKey(name: 'created_date') DateTime createdDate,
      @JsonKey(name: 'created_by') String createdBy});
}

/// @nodoc
class _$InvoiceCopyWithImpl<$Res, $Val extends Invoice>
    implements $InvoiceCopyWith<$Res> {
  _$InvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceName = null,
    Object? numberSeries = null,
    Object? supplierName = null,
    Object? employeeName = null,
    Object? employeeCode = null,
    Object? invoiceDate = null,
    Object? grandTotal = null,
    Object? netTotal = null,
    Object? baseGrandTotal = null,
    Object? discountAmount = null,
    Object? discountPercent = null,
    Object? outstandingAmount = null,
    Object? currency = null,
    Object? exchangeRate = null,
    Object? isSubmitted = null,
    Object? createdDate = null,
    Object? createdBy = null,
  }) {
    return _then(_value.copyWith(
      invoiceName: null == invoiceName
          ? _value.invoiceName
          : invoiceName // ignore: cast_nullable_to_non_nullable
              as String,
      numberSeries: null == numberSeries
          ? _value.numberSeries
          : numberSeries // ignore: cast_nullable_to_non_nullable
              as String,
      supplierName: null == supplierName
          ? _value.supplierName
          : supplierName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceDate: null == invoiceDate
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      grandTotal: null == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as String,
      netTotal: null == netTotal
          ? _value.netTotal
          : netTotal // ignore: cast_nullable_to_non_nullable
              as String,
      baseGrandTotal: null == baseGrandTotal
          ? _value.baseGrandTotal
          : baseGrandTotal // ignore: cast_nullable_to_non_nullable
              as String,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as String,
      discountPercent: null == discountPercent
          ? _value.discountPercent
          : discountPercent // ignore: cast_nullable_to_non_nullable
              as int,
      outstandingAmount: null == outstandingAmount
          ? _value.outstandingAmount
          : outstandingAmount // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      exchangeRate: null == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as int,
      isSubmitted: null == isSubmitted
          ? _value.isSubmitted
          : isSubmitted // ignore: cast_nullable_to_non_nullable
              as int,
      createdDate: null == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceImplCopyWith<$Res> implements $InvoiceCopyWith<$Res> {
  factory _$$InvoiceImplCopyWith(
          _$InvoiceImpl value, $Res Function(_$InvoiceImpl) then) =
      __$$InvoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'invoice_name') String invoiceName,
      @JsonKey(name: 'number_series') String numberSeries,
      @JsonKey(name: 'supplier_name') String supplierName,
      @JsonKey(name: 'employee_name') String employeeName,
      @JsonKey(name: 'employee_code') String employeeCode,
      @JsonKey(name: 'invoice_date') DateTime invoiceDate,
      @JsonKey(name: 'grand_total') String grandTotal,
      @JsonKey(name: 'net_total') String netTotal,
      @JsonKey(name: 'base_grand_total') String baseGrandTotal,
      @JsonKey(name: 'discount_amount') String discountAmount,
      @JsonKey(name: 'discount_percent') int discountPercent,
      @JsonKey(name: 'outstanding_amount') String outstandingAmount,
      String currency,
      @JsonKey(name: 'exchange_rate') int exchangeRate,
      @JsonKey(name: 'is_submitted') int isSubmitted,
      @JsonKey(name: 'created_date') DateTime createdDate,
      @JsonKey(name: 'created_by') String createdBy});
}

/// @nodoc
class __$$InvoiceImplCopyWithImpl<$Res>
    extends _$InvoiceCopyWithImpl<$Res, _$InvoiceImpl>
    implements _$$InvoiceImplCopyWith<$Res> {
  __$$InvoiceImplCopyWithImpl(
      _$InvoiceImpl _value, $Res Function(_$InvoiceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceName = null,
    Object? numberSeries = null,
    Object? supplierName = null,
    Object? employeeName = null,
    Object? employeeCode = null,
    Object? invoiceDate = null,
    Object? grandTotal = null,
    Object? netTotal = null,
    Object? baseGrandTotal = null,
    Object? discountAmount = null,
    Object? discountPercent = null,
    Object? outstandingAmount = null,
    Object? currency = null,
    Object? exchangeRate = null,
    Object? isSubmitted = null,
    Object? createdDate = null,
    Object? createdBy = null,
  }) {
    return _then(_$InvoiceImpl(
      invoiceName: null == invoiceName
          ? _value.invoiceName
          : invoiceName // ignore: cast_nullable_to_non_nullable
              as String,
      numberSeries: null == numberSeries
          ? _value.numberSeries
          : numberSeries // ignore: cast_nullable_to_non_nullable
              as String,
      supplierName: null == supplierName
          ? _value.supplierName
          : supplierName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCode: null == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceDate: null == invoiceDate
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      grandTotal: null == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as String,
      netTotal: null == netTotal
          ? _value.netTotal
          : netTotal // ignore: cast_nullable_to_non_nullable
              as String,
      baseGrandTotal: null == baseGrandTotal
          ? _value.baseGrandTotal
          : baseGrandTotal // ignore: cast_nullable_to_non_nullable
              as String,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as String,
      discountPercent: null == discountPercent
          ? _value.discountPercent
          : discountPercent // ignore: cast_nullable_to_non_nullable
              as int,
      outstandingAmount: null == outstandingAmount
          ? _value.outstandingAmount
          : outstandingAmount // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      exchangeRate: null == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as int,
      isSubmitted: null == isSubmitted
          ? _value.isSubmitted
          : isSubmitted // ignore: cast_nullable_to_non_nullable
              as int,
      createdDate: null == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceImpl implements _Invoice {
  const _$InvoiceImpl(
      {@JsonKey(name: 'invoice_name') required this.invoiceName,
      @JsonKey(name: 'number_series') required this.numberSeries,
      @JsonKey(name: 'supplier_name') required this.supplierName,
      @JsonKey(name: 'employee_name') required this.employeeName,
      @JsonKey(name: 'employee_code') required this.employeeCode,
      @JsonKey(name: 'invoice_date') required this.invoiceDate,
      @JsonKey(name: 'grand_total') required this.grandTotal,
      @JsonKey(name: 'net_total') required this.netTotal,
      @JsonKey(name: 'base_grand_total') required this.baseGrandTotal,
      @JsonKey(name: 'discount_amount') required this.discountAmount,
      @JsonKey(name: 'discount_percent') required this.discountPercent,
      @JsonKey(name: 'outstanding_amount') required this.outstandingAmount,
      required this.currency,
      @JsonKey(name: 'exchange_rate') required this.exchangeRate,
      @JsonKey(name: 'is_submitted') required this.isSubmitted,
      @JsonKey(name: 'created_date') required this.createdDate,
      @JsonKey(name: 'created_by') required this.createdBy});

  factory _$InvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceImplFromJson(json);

  @override
  @JsonKey(name: 'invoice_name')
  final String invoiceName;
  @override
  @JsonKey(name: 'number_series')
  final String numberSeries;
  @override
  @JsonKey(name: 'supplier_name')
  final String supplierName;
  @override
  @JsonKey(name: 'employee_name')
  final String employeeName;
  @override
  @JsonKey(name: 'employee_code')
  final String employeeCode;
  @override
  @JsonKey(name: 'invoice_date')
  final DateTime invoiceDate;
  @override
  @JsonKey(name: 'grand_total')
  final String grandTotal;
  @override
  @JsonKey(name: 'net_total')
  final String netTotal;
  @override
  @JsonKey(name: 'base_grand_total')
  final String baseGrandTotal;
  @override
  @JsonKey(name: 'discount_amount')
  final String discountAmount;
  @override
  @JsonKey(name: 'discount_percent')
  final int discountPercent;
  @override
  @JsonKey(name: 'outstanding_amount')
  final String outstandingAmount;
  @override
  final String currency;
  @override
  @JsonKey(name: 'exchange_rate')
  final int exchangeRate;
  @override
  @JsonKey(name: 'is_submitted')
  final int isSubmitted;
  @override
  @JsonKey(name: 'created_date')
  final DateTime createdDate;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;

  @override
  String toString() {
    return 'Invoice(invoiceName: $invoiceName, numberSeries: $numberSeries, supplierName: $supplierName, employeeName: $employeeName, employeeCode: $employeeCode, invoiceDate: $invoiceDate, grandTotal: $grandTotal, netTotal: $netTotal, baseGrandTotal: $baseGrandTotal, discountAmount: $discountAmount, discountPercent: $discountPercent, outstandingAmount: $outstandingAmount, currency: $currency, exchangeRate: $exchangeRate, isSubmitted: $isSubmitted, createdDate: $createdDate, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceImpl &&
            (identical(other.invoiceName, invoiceName) ||
                other.invoiceName == invoiceName) &&
            (identical(other.numberSeries, numberSeries) ||
                other.numberSeries == numberSeries) &&
            (identical(other.supplierName, supplierName) ||
                other.supplierName == supplierName) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.invoiceDate, invoiceDate) ||
                other.invoiceDate == invoiceDate) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.netTotal, netTotal) ||
                other.netTotal == netTotal) &&
            (identical(other.baseGrandTotal, baseGrandTotal) ||
                other.baseGrandTotal == baseGrandTotal) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.discountPercent, discountPercent) ||
                other.discountPercent == discountPercent) &&
            (identical(other.outstandingAmount, outstandingAmount) ||
                other.outstandingAmount == outstandingAmount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.exchangeRate, exchangeRate) ||
                other.exchangeRate == exchangeRate) &&
            (identical(other.isSubmitted, isSubmitted) ||
                other.isSubmitted == isSubmitted) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      invoiceName,
      numberSeries,
      supplierName,
      employeeName,
      employeeCode,
      invoiceDate,
      grandTotal,
      netTotal,
      baseGrandTotal,
      discountAmount,
      discountPercent,
      outstandingAmount,
      currency,
      exchangeRate,
      isSubmitted,
      createdDate,
      createdBy);

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      __$$InvoiceImplCopyWithImpl<_$InvoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceImplToJson(
      this,
    );
  }
}

abstract class _Invoice implements Invoice {
  const factory _Invoice(
      {@JsonKey(name: 'invoice_name') required final String invoiceName,
      @JsonKey(name: 'number_series') required final String numberSeries,
      @JsonKey(name: 'supplier_name') required final String supplierName,
      @JsonKey(name: 'employee_name') required final String employeeName,
      @JsonKey(name: 'employee_code') required final String employeeCode,
      @JsonKey(name: 'invoice_date') required final DateTime invoiceDate,
      @JsonKey(name: 'grand_total') required final String grandTotal,
      @JsonKey(name: 'net_total') required final String netTotal,
      @JsonKey(name: 'base_grand_total') required final String baseGrandTotal,
      @JsonKey(name: 'discount_amount') required final String discountAmount,
      @JsonKey(name: 'discount_percent') required final int discountPercent,
      @JsonKey(name: 'outstanding_amount')
      required final String outstandingAmount,
      required final String currency,
      @JsonKey(name: 'exchange_rate') required final int exchangeRate,
      @JsonKey(name: 'is_submitted') required final int isSubmitted,
      @JsonKey(name: 'created_date') required final DateTime createdDate,
      @JsonKey(name: 'created_by')
      required final String createdBy}) = _$InvoiceImpl;

  factory _Invoice.fromJson(Map<String, dynamic> json) = _$InvoiceImpl.fromJson;

  @override
  @JsonKey(name: 'invoice_name')
  String get invoiceName;
  @override
  @JsonKey(name: 'number_series')
  String get numberSeries;
  @override
  @JsonKey(name: 'supplier_name')
  String get supplierName;
  @override
  @JsonKey(name: 'employee_name')
  String get employeeName;
  @override
  @JsonKey(name: 'employee_code')
  String get employeeCode;
  @override
  @JsonKey(name: 'invoice_date')
  DateTime get invoiceDate;
  @override
  @JsonKey(name: 'grand_total')
  String get grandTotal;
  @override
  @JsonKey(name: 'net_total')
  String get netTotal;
  @override
  @JsonKey(name: 'base_grand_total')
  String get baseGrandTotal;
  @override
  @JsonKey(name: 'discount_amount')
  String get discountAmount;
  @override
  @JsonKey(name: 'discount_percent')
  int get discountPercent;
  @override
  @JsonKey(name: 'outstanding_amount')
  String get outstandingAmount;
  @override
  String get currency;
  @override
  @JsonKey(name: 'exchange_rate')
  int get exchangeRate;
  @override
  @JsonKey(name: 'is_submitted')
  int get isSubmitted;
  @override
  @JsonKey(name: 'created_date')
  DateTime get createdDate;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdvanceSummary _$AdvanceSummaryFromJson(Map<String, dynamic> json) {
  return _AdvanceSummary.fromJson(json);
}

/// @nodoc
mixin _$AdvanceSummary {
  @JsonKey(name: 'total_invoices')
  int get totalInvoices => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_employees')
  int get totalEmployees => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_departments')
  int get totalDepartments => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_items')
  int get totalItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total_amount')
  double get grandTotalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total_quantity')
  int get grandTotalQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'overall_average_amount')
  double get overallAverageAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total_discount')
  double get grandTotalDiscount => throw _privateConstructorUsedError;
  @JsonKey(name: 'earliest_purchase')
  DateTime? get earliestPurchase => throw _privateConstructorUsedError;
  @JsonKey(name: 'latest_purchase')
  DateTime? get latestPurchase => throw _privateConstructorUsedError;

  /// Serializes this AdvanceSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdvanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdvanceSummaryCopyWith<AdvanceSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdvanceSummaryCopyWith<$Res> {
  factory $AdvanceSummaryCopyWith(
          AdvanceSummary value, $Res Function(AdvanceSummary) then) =
      _$AdvanceSummaryCopyWithImpl<$Res, AdvanceSummary>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_invoices') int totalInvoices,
      @JsonKey(name: 'total_employees') int totalEmployees,
      @JsonKey(name: 'total_departments') int totalDepartments,
      @JsonKey(name: 'total_items') int totalItems,
      @JsonKey(name: 'grand_total_amount') double grandTotalAmount,
      @JsonKey(name: 'grand_total_quantity') int grandTotalQuantity,
      @JsonKey(name: 'overall_average_amount') double overallAverageAmount,
      @JsonKey(name: 'grand_total_discount') double grandTotalDiscount,
      @JsonKey(name: 'earliest_purchase') DateTime? earliestPurchase,
      @JsonKey(name: 'latest_purchase') DateTime? latestPurchase});
}

/// @nodoc
class _$AdvanceSummaryCopyWithImpl<$Res, $Val extends AdvanceSummary>
    implements $AdvanceSummaryCopyWith<$Res> {
  _$AdvanceSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdvanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalInvoices = null,
    Object? totalEmployees = null,
    Object? totalDepartments = null,
    Object? totalItems = null,
    Object? grandTotalAmount = null,
    Object? grandTotalQuantity = null,
    Object? overallAverageAmount = null,
    Object? grandTotalDiscount = null,
    Object? earliestPurchase = freezed,
    Object? latestPurchase = freezed,
  }) {
    return _then(_value.copyWith(
      totalInvoices: null == totalInvoices
          ? _value.totalInvoices
          : totalInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      totalEmployees: null == totalEmployees
          ? _value.totalEmployees
          : totalEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      totalDepartments: null == totalDepartments
          ? _value.totalDepartments
          : totalDepartments // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      grandTotalAmount: null == grandTotalAmount
          ? _value.grandTotalAmount
          : grandTotalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      grandTotalQuantity: null == grandTotalQuantity
          ? _value.grandTotalQuantity
          : grandTotalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      overallAverageAmount: null == overallAverageAmount
          ? _value.overallAverageAmount
          : overallAverageAmount // ignore: cast_nullable_to_non_nullable
              as double,
      grandTotalDiscount: null == grandTotalDiscount
          ? _value.grandTotalDiscount
          : grandTotalDiscount // ignore: cast_nullable_to_non_nullable
              as double,
      earliestPurchase: freezed == earliestPurchase
          ? _value.earliestPurchase
          : earliestPurchase // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      latestPurchase: freezed == latestPurchase
          ? _value.latestPurchase
          : latestPurchase // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdvanceSummaryImplCopyWith<$Res>
    implements $AdvanceSummaryCopyWith<$Res> {
  factory _$$AdvanceSummaryImplCopyWith(_$AdvanceSummaryImpl value,
          $Res Function(_$AdvanceSummaryImpl) then) =
      __$$AdvanceSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_invoices') int totalInvoices,
      @JsonKey(name: 'total_employees') int totalEmployees,
      @JsonKey(name: 'total_departments') int totalDepartments,
      @JsonKey(name: 'total_items') int totalItems,
      @JsonKey(name: 'grand_total_amount') double grandTotalAmount,
      @JsonKey(name: 'grand_total_quantity') int grandTotalQuantity,
      @JsonKey(name: 'overall_average_amount') double overallAverageAmount,
      @JsonKey(name: 'grand_total_discount') double grandTotalDiscount,
      @JsonKey(name: 'earliest_purchase') DateTime? earliestPurchase,
      @JsonKey(name: 'latest_purchase') DateTime? latestPurchase});
}

/// @nodoc
class __$$AdvanceSummaryImplCopyWithImpl<$Res>
    extends _$AdvanceSummaryCopyWithImpl<$Res, _$AdvanceSummaryImpl>
    implements _$$AdvanceSummaryImplCopyWith<$Res> {
  __$$AdvanceSummaryImplCopyWithImpl(
      _$AdvanceSummaryImpl _value, $Res Function(_$AdvanceSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdvanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalInvoices = null,
    Object? totalEmployees = null,
    Object? totalDepartments = null,
    Object? totalItems = null,
    Object? grandTotalAmount = null,
    Object? grandTotalQuantity = null,
    Object? overallAverageAmount = null,
    Object? grandTotalDiscount = null,
    Object? earliestPurchase = freezed,
    Object? latestPurchase = freezed,
  }) {
    return _then(_$AdvanceSummaryImpl(
      totalInvoices: null == totalInvoices
          ? _value.totalInvoices
          : totalInvoices // ignore: cast_nullable_to_non_nullable
              as int,
      totalEmployees: null == totalEmployees
          ? _value.totalEmployees
          : totalEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      totalDepartments: null == totalDepartments
          ? _value.totalDepartments
          : totalDepartments // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      grandTotalAmount: null == grandTotalAmount
          ? _value.grandTotalAmount
          : grandTotalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      grandTotalQuantity: null == grandTotalQuantity
          ? _value.grandTotalQuantity
          : grandTotalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      overallAverageAmount: null == overallAverageAmount
          ? _value.overallAverageAmount
          : overallAverageAmount // ignore: cast_nullable_to_non_nullable
              as double,
      grandTotalDiscount: null == grandTotalDiscount
          ? _value.grandTotalDiscount
          : grandTotalDiscount // ignore: cast_nullable_to_non_nullable
              as double,
      earliestPurchase: freezed == earliestPurchase
          ? _value.earliestPurchase
          : earliestPurchase // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      latestPurchase: freezed == latestPurchase
          ? _value.latestPurchase
          : latestPurchase // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdvanceSummaryImpl implements _AdvanceSummary {
  const _$AdvanceSummaryImpl(
      {@JsonKey(name: 'total_invoices') required this.totalInvoices,
      @JsonKey(name: 'total_employees') required this.totalEmployees,
      @JsonKey(name: 'total_departments') required this.totalDepartments,
      @JsonKey(name: 'total_items') required this.totalItems,
      @JsonKey(name: 'grand_total_amount') required this.grandTotalAmount,
      @JsonKey(name: 'grand_total_quantity') required this.grandTotalQuantity,
      @JsonKey(name: 'overall_average_amount')
      required this.overallAverageAmount,
      @JsonKey(name: 'grand_total_discount') required this.grandTotalDiscount,
      @JsonKey(name: 'earliest_purchase') this.earliestPurchase,
      @JsonKey(name: 'latest_purchase') this.latestPurchase});

  factory _$AdvanceSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdvanceSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'total_invoices')
  final int totalInvoices;
  @override
  @JsonKey(name: 'total_employees')
  final int totalEmployees;
  @override
  @JsonKey(name: 'total_departments')
  final int totalDepartments;
  @override
  @JsonKey(name: 'total_items')
  final int totalItems;
  @override
  @JsonKey(name: 'grand_total_amount')
  final double grandTotalAmount;
  @override
  @JsonKey(name: 'grand_total_quantity')
  final int grandTotalQuantity;
  @override
  @JsonKey(name: 'overall_average_amount')
  final double overallAverageAmount;
  @override
  @JsonKey(name: 'grand_total_discount')
  final double grandTotalDiscount;
  @override
  @JsonKey(name: 'earliest_purchase')
  final DateTime? earliestPurchase;
  @override
  @JsonKey(name: 'latest_purchase')
  final DateTime? latestPurchase;

  @override
  String toString() {
    return 'AdvanceSummary(totalInvoices: $totalInvoices, totalEmployees: $totalEmployees, totalDepartments: $totalDepartments, totalItems: $totalItems, grandTotalAmount: $grandTotalAmount, grandTotalQuantity: $grandTotalQuantity, overallAverageAmount: $overallAverageAmount, grandTotalDiscount: $grandTotalDiscount, earliestPurchase: $earliestPurchase, latestPurchase: $latestPurchase)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdvanceSummaryImpl &&
            (identical(other.totalInvoices, totalInvoices) ||
                other.totalInvoices == totalInvoices) &&
            (identical(other.totalEmployees, totalEmployees) ||
                other.totalEmployees == totalEmployees) &&
            (identical(other.totalDepartments, totalDepartments) ||
                other.totalDepartments == totalDepartments) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.grandTotalAmount, grandTotalAmount) ||
                other.grandTotalAmount == grandTotalAmount) &&
            (identical(other.grandTotalQuantity, grandTotalQuantity) ||
                other.grandTotalQuantity == grandTotalQuantity) &&
            (identical(other.overallAverageAmount, overallAverageAmount) ||
                other.overallAverageAmount == overallAverageAmount) &&
            (identical(other.grandTotalDiscount, grandTotalDiscount) ||
                other.grandTotalDiscount == grandTotalDiscount) &&
            (identical(other.earliestPurchase, earliestPurchase) ||
                other.earliestPurchase == earliestPurchase) &&
            (identical(other.latestPurchase, latestPurchase) ||
                other.latestPurchase == latestPurchase));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalInvoices,
      totalEmployees,
      totalDepartments,
      totalItems,
      grandTotalAmount,
      grandTotalQuantity,
      overallAverageAmount,
      grandTotalDiscount,
      earliestPurchase,
      latestPurchase);

  /// Create a copy of AdvanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdvanceSummaryImplCopyWith<_$AdvanceSummaryImpl> get copyWith =>
      __$$AdvanceSummaryImplCopyWithImpl<_$AdvanceSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdvanceSummaryImplToJson(
      this,
    );
  }
}

abstract class _AdvanceSummary implements AdvanceSummary {
  const factory _AdvanceSummary(
      {@JsonKey(name: 'total_invoices') required final int totalInvoices,
      @JsonKey(name: 'total_employees') required final int totalEmployees,
      @JsonKey(name: 'total_departments') required final int totalDepartments,
      @JsonKey(name: 'total_items') required final int totalItems,
      @JsonKey(name: 'grand_total_amount')
      required final double grandTotalAmount,
      @JsonKey(name: 'grand_total_quantity')
      required final int grandTotalQuantity,
      @JsonKey(name: 'overall_average_amount')
      required final double overallAverageAmount,
      @JsonKey(name: 'grand_total_discount')
      required final double grandTotalDiscount,
      @JsonKey(name: 'earliest_purchase') final DateTime? earliestPurchase,
      @JsonKey(name: 'latest_purchase')
      final DateTime? latestPurchase}) = _$AdvanceSummaryImpl;

  factory _AdvanceSummary.fromJson(Map<String, dynamic> json) =
      _$AdvanceSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'total_invoices')
  int get totalInvoices;
  @override
  @JsonKey(name: 'total_employees')
  int get totalEmployees;
  @override
  @JsonKey(name: 'total_departments')
  int get totalDepartments;
  @override
  @JsonKey(name: 'total_items')
  int get totalItems;
  @override
  @JsonKey(name: 'grand_total_amount')
  double get grandTotalAmount;
  @override
  @JsonKey(name: 'grand_total_quantity')
  int get grandTotalQuantity;
  @override
  @JsonKey(name: 'overall_average_amount')
  double get overallAverageAmount;
  @override
  @JsonKey(name: 'grand_total_discount')
  double get grandTotalDiscount;
  @override
  @JsonKey(name: 'earliest_purchase')
  DateTime? get earliestPurchase;
  @override
  @JsonKey(name: 'latest_purchase')
  DateTime? get latestPurchase;

  /// Create a copy of AdvanceSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdvanceSummaryImplCopyWith<_$AdvanceSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopEmployee _$TopEmployeeFromJson(Map<String, dynamic> json) {
  return _TopEmployee.fromJson(json);
}

/// @nodoc
mixin _$TopEmployee {
  @JsonKey(name: 'employee_name')
  String? get employeeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_code')
  String? get employeeCode => throw _privateConstructorUsedError;
  String? get department => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double? get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_quantity')
  int? get totalQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_count')
  int? get invoiceCount => throw _privateConstructorUsedError;

  /// Serializes this TopEmployee to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopEmployee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopEmployeeCopyWith<TopEmployee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopEmployeeCopyWith<$Res> {
  factory $TopEmployeeCopyWith(
          TopEmployee value, $Res Function(TopEmployee) then) =
      _$TopEmployeeCopyWithImpl<$Res, TopEmployee>;
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_name') String? employeeName,
      @JsonKey(name: 'employee_code') String? employeeCode,
      String? department,
      @JsonKey(name: 'total_amount') double? totalAmount,
      @JsonKey(name: 'total_quantity') int? totalQuantity,
      @JsonKey(name: 'invoice_count') int? invoiceCount});
}

/// @nodoc
class _$TopEmployeeCopyWithImpl<$Res, $Val extends TopEmployee>
    implements $TopEmployeeCopyWith<$Res> {
  _$TopEmployeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopEmployee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeName = freezed,
    Object? employeeCode = freezed,
    Object? department = freezed,
    Object? totalAmount = freezed,
    Object? totalQuantity = freezed,
    Object? invoiceCount = freezed,
  }) {
    return _then(_value.copyWith(
      employeeName: freezed == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeCode: freezed == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String?,
      department: freezed == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      totalAmount: freezed == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      totalQuantity: freezed == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      invoiceCount: freezed == invoiceCount
          ? _value.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopEmployeeImplCopyWith<$Res>
    implements $TopEmployeeCopyWith<$Res> {
  factory _$$TopEmployeeImplCopyWith(
          _$TopEmployeeImpl value, $Res Function(_$TopEmployeeImpl) then) =
      __$$TopEmployeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'employee_name') String? employeeName,
      @JsonKey(name: 'employee_code') String? employeeCode,
      String? department,
      @JsonKey(name: 'total_amount') double? totalAmount,
      @JsonKey(name: 'total_quantity') int? totalQuantity,
      @JsonKey(name: 'invoice_count') int? invoiceCount});
}

/// @nodoc
class __$$TopEmployeeImplCopyWithImpl<$Res>
    extends _$TopEmployeeCopyWithImpl<$Res, _$TopEmployeeImpl>
    implements _$$TopEmployeeImplCopyWith<$Res> {
  __$$TopEmployeeImplCopyWithImpl(
      _$TopEmployeeImpl _value, $Res Function(_$TopEmployeeImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopEmployee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeName = freezed,
    Object? employeeCode = freezed,
    Object? department = freezed,
    Object? totalAmount = freezed,
    Object? totalQuantity = freezed,
    Object? invoiceCount = freezed,
  }) {
    return _then(_$TopEmployeeImpl(
      employeeName: freezed == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeCode: freezed == employeeCode
          ? _value.employeeCode
          : employeeCode // ignore: cast_nullable_to_non_nullable
              as String?,
      department: freezed == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      totalAmount: freezed == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      totalQuantity: freezed == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      invoiceCount: freezed == invoiceCount
          ? _value.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopEmployeeImpl implements _TopEmployee {
  const _$TopEmployeeImpl(
      {@JsonKey(name: 'employee_name') this.employeeName,
      @JsonKey(name: 'employee_code') this.employeeCode,
      this.department,
      @JsonKey(name: 'total_amount') this.totalAmount,
      @JsonKey(name: 'total_quantity') this.totalQuantity,
      @JsonKey(name: 'invoice_count') this.invoiceCount});

  factory _$TopEmployeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopEmployeeImplFromJson(json);

  @override
  @JsonKey(name: 'employee_name')
  final String? employeeName;
  @override
  @JsonKey(name: 'employee_code')
  final String? employeeCode;
  @override
  final String? department;
  @override
  @JsonKey(name: 'total_amount')
  final double? totalAmount;
  @override
  @JsonKey(name: 'total_quantity')
  final int? totalQuantity;
  @override
  @JsonKey(name: 'invoice_count')
  final int? invoiceCount;

  @override
  String toString() {
    return 'TopEmployee(employeeName: $employeeName, employeeCode: $employeeCode, department: $department, totalAmount: $totalAmount, totalQuantity: $totalQuantity, invoiceCount: $invoiceCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopEmployeeImpl &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
            (identical(other.invoiceCount, invoiceCount) ||
                other.invoiceCount == invoiceCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, employeeName, employeeCode,
      department, totalAmount, totalQuantity, invoiceCount);

  /// Create a copy of TopEmployee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopEmployeeImplCopyWith<_$TopEmployeeImpl> get copyWith =>
      __$$TopEmployeeImplCopyWithImpl<_$TopEmployeeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopEmployeeImplToJson(
      this,
    );
  }
}

abstract class _TopEmployee implements TopEmployee {
  const factory _TopEmployee(
          {@JsonKey(name: 'employee_name') final String? employeeName,
          @JsonKey(name: 'employee_code') final String? employeeCode,
          final String? department,
          @JsonKey(name: 'total_amount') final double? totalAmount,
          @JsonKey(name: 'total_quantity') final int? totalQuantity,
          @JsonKey(name: 'invoice_count') final int? invoiceCount}) =
      _$TopEmployeeImpl;

  factory _TopEmployee.fromJson(Map<String, dynamic> json) =
      _$TopEmployeeImpl.fromJson;

  @override
  @JsonKey(name: 'employee_name')
  String? get employeeName;
  @override
  @JsonKey(name: 'employee_code')
  String? get employeeCode;
  @override
  String? get department;
  @override
  @JsonKey(name: 'total_amount')
  double? get totalAmount;
  @override
  @JsonKey(name: 'total_quantity')
  int? get totalQuantity;
  @override
  @JsonKey(name: 'invoice_count')
  int? get invoiceCount;

  /// Create a copy of TopEmployee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopEmployeeImplCopyWith<_$TopEmployeeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopDepartment _$TopDepartmentFromJson(Map<String, dynamic> json) {
  return _TopDepartment.fromJson(json);
}

/// @nodoc
mixin _$TopDepartment {
  String get department => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_count')
  int get employeeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_quantity')
  int get totalQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_count')
  int get invoiceCount => throw _privateConstructorUsedError;

  /// Serializes this TopDepartment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopDepartment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopDepartmentCopyWith<TopDepartment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopDepartmentCopyWith<$Res> {
  factory $TopDepartmentCopyWith(
          TopDepartment value, $Res Function(TopDepartment) then) =
      _$TopDepartmentCopyWithImpl<$Res, TopDepartment>;
  @useResult
  $Res call(
      {String department,
      @JsonKey(name: 'employee_count') int employeeCount,
      @JsonKey(name: 'total_amount') double totalAmount,
      @JsonKey(name: 'total_quantity') int totalQuantity,
      @JsonKey(name: 'invoice_count') int invoiceCount});
}

/// @nodoc
class _$TopDepartmentCopyWithImpl<$Res, $Val extends TopDepartment>
    implements $TopDepartmentCopyWith<$Res> {
  _$TopDepartmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopDepartment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? department = null,
    Object? employeeCount = null,
    Object? totalAmount = null,
    Object? totalQuantity = null,
    Object? invoiceCount = null,
  }) {
    return _then(_value.copyWith(
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCount: null == employeeCount
          ? _value.employeeCount
          : employeeCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceCount: null == invoiceCount
          ? _value.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopDepartmentImplCopyWith<$Res>
    implements $TopDepartmentCopyWith<$Res> {
  factory _$$TopDepartmentImplCopyWith(
          _$TopDepartmentImpl value, $Res Function(_$TopDepartmentImpl) then) =
      __$$TopDepartmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String department,
      @JsonKey(name: 'employee_count') int employeeCount,
      @JsonKey(name: 'total_amount') double totalAmount,
      @JsonKey(name: 'total_quantity') int totalQuantity,
      @JsonKey(name: 'invoice_count') int invoiceCount});
}

/// @nodoc
class __$$TopDepartmentImplCopyWithImpl<$Res>
    extends _$TopDepartmentCopyWithImpl<$Res, _$TopDepartmentImpl>
    implements _$$TopDepartmentImplCopyWith<$Res> {
  __$$TopDepartmentImplCopyWithImpl(
      _$TopDepartmentImpl _value, $Res Function(_$TopDepartmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopDepartment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? department = null,
    Object? employeeCount = null,
    Object? totalAmount = null,
    Object? totalQuantity = null,
    Object? invoiceCount = null,
  }) {
    return _then(_$TopDepartmentImpl(
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCount: null == employeeCount
          ? _value.employeeCount
          : employeeCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceCount: null == invoiceCount
          ? _value.invoiceCount
          : invoiceCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopDepartmentImpl implements _TopDepartment {
  const _$TopDepartmentImpl(
      {required this.department,
      @JsonKey(name: 'employee_count') required this.employeeCount,
      @JsonKey(name: 'total_amount') required this.totalAmount,
      @JsonKey(name: 'total_quantity') required this.totalQuantity,
      @JsonKey(name: 'invoice_count') required this.invoiceCount});

  factory _$TopDepartmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopDepartmentImplFromJson(json);

  @override
  final String department;
  @override
  @JsonKey(name: 'employee_count')
  final int employeeCount;
  @override
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  @override
  @JsonKey(name: 'total_quantity')
  final int totalQuantity;
  @override
  @JsonKey(name: 'invoice_count')
  final int invoiceCount;

  @override
  String toString() {
    return 'TopDepartment(department: $department, employeeCount: $employeeCount, totalAmount: $totalAmount, totalQuantity: $totalQuantity, invoiceCount: $invoiceCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopDepartmentImpl &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.employeeCount, employeeCount) ||
                other.employeeCount == employeeCount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
            (identical(other.invoiceCount, invoiceCount) ||
                other.invoiceCount == invoiceCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, department, employeeCount,
      totalAmount, totalQuantity, invoiceCount);

  /// Create a copy of TopDepartment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopDepartmentImplCopyWith<_$TopDepartmentImpl> get copyWith =>
      __$$TopDepartmentImplCopyWithImpl<_$TopDepartmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopDepartmentImplToJson(
      this,
    );
  }
}

abstract class _TopDepartment implements TopDepartment {
  const factory _TopDepartment(
          {required final String department,
          @JsonKey(name: 'employee_count') required final int employeeCount,
          @JsonKey(name: 'total_amount') required final double totalAmount,
          @JsonKey(name: 'total_quantity') required final int totalQuantity,
          @JsonKey(name: 'invoice_count') required final int invoiceCount}) =
      _$TopDepartmentImpl;

  factory _TopDepartment.fromJson(Map<String, dynamic> json) =
      _$TopDepartmentImpl.fromJson;

  @override
  String get department;
  @override
  @JsonKey(name: 'employee_count')
  int get employeeCount;
  @override
  @JsonKey(name: 'total_amount')
  double get totalAmount;
  @override
  @JsonKey(name: 'total_quantity')
  int get totalQuantity;
  @override
  @JsonKey(name: 'invoice_count')
  int get invoiceCount;

  /// Create a copy of TopDepartment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopDepartmentImplCopyWith<_$TopDepartmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FiltersApplied _$FiltersAppliedFromJson(Map<String, dynamic> json) {
  return _FiltersApplied.fromJson(json);
}

/// @nodoc
mixin _$FiltersApplied {
  List<String>? get employees => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_id', fromJson: _filtersEmployeeIdFromJson)
  int? get employeeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_search')
  String? get itemSearch => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  String? get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  String? get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_by')
  String get groupBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_by')
  String get sortBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  String get sortOrder => throw _privateConstructorUsedError;
  int? get limit => throw _privateConstructorUsedError;

  /// Serializes this FiltersApplied to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FiltersApplied
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FiltersAppliedCopyWith<FiltersApplied> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FiltersAppliedCopyWith<$Res> {
  factory $FiltersAppliedCopyWith(
          FiltersApplied value, $Res Function(FiltersApplied) then) =
      _$FiltersAppliedCopyWithImpl<$Res, FiltersApplied>;
  @useResult
  $Res call(
      {List<String>? employees,
      @JsonKey(name: 'employee_id', fromJson: _filtersEmployeeIdFromJson)
      int? employeeId,
      @JsonKey(name: 'item_search') String? itemSearch,
      @JsonKey(name: 'start_date') String? startDate,
      @JsonKey(name: 'end_date') String? endDate,
      @JsonKey(name: 'group_by') String groupBy,
      @JsonKey(name: 'sort_by') String sortBy,
      @JsonKey(name: 'sort_order') String sortOrder,
      int? limit});
}

/// @nodoc
class _$FiltersAppliedCopyWithImpl<$Res, $Val extends FiltersApplied>
    implements $FiltersAppliedCopyWith<$Res> {
  _$FiltersAppliedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FiltersApplied
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employees = freezed,
    Object? employeeId = freezed,
    Object? itemSearch = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? groupBy = null,
    Object? sortBy = null,
    Object? sortOrder = null,
    Object? limit = freezed,
  }) {
    return _then(_value.copyWith(
      employees: freezed == employees
          ? _value.employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int?,
      itemSearch: freezed == itemSearch
          ? _value.itemSearch
          : itemSearch // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      groupBy: null == groupBy
          ? _value.groupBy
          : groupBy // ignore: cast_nullable_to_non_nullable
              as String,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as String,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FiltersAppliedImplCopyWith<$Res>
    implements $FiltersAppliedCopyWith<$Res> {
  factory _$$FiltersAppliedImplCopyWith(_$FiltersAppliedImpl value,
          $Res Function(_$FiltersAppliedImpl) then) =
      __$$FiltersAppliedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String>? employees,
      @JsonKey(name: 'employee_id', fromJson: _filtersEmployeeIdFromJson)
      int? employeeId,
      @JsonKey(name: 'item_search') String? itemSearch,
      @JsonKey(name: 'start_date') String? startDate,
      @JsonKey(name: 'end_date') String? endDate,
      @JsonKey(name: 'group_by') String groupBy,
      @JsonKey(name: 'sort_by') String sortBy,
      @JsonKey(name: 'sort_order') String sortOrder,
      int? limit});
}

/// @nodoc
class __$$FiltersAppliedImplCopyWithImpl<$Res>
    extends _$FiltersAppliedCopyWithImpl<$Res, _$FiltersAppliedImpl>
    implements _$$FiltersAppliedImplCopyWith<$Res> {
  __$$FiltersAppliedImplCopyWithImpl(
      _$FiltersAppliedImpl _value, $Res Function(_$FiltersAppliedImpl) _then)
      : super(_value, _then);

  /// Create a copy of FiltersApplied
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employees = freezed,
    Object? employeeId = freezed,
    Object? itemSearch = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? groupBy = null,
    Object? sortBy = null,
    Object? sortOrder = null,
    Object? limit = freezed,
  }) {
    return _then(_$FiltersAppliedImpl(
      employees: freezed == employees
          ? _value._employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int?,
      itemSearch: freezed == itemSearch
          ? _value.itemSearch
          : itemSearch // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      groupBy: null == groupBy
          ? _value.groupBy
          : groupBy // ignore: cast_nullable_to_non_nullable
              as String,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as String,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FiltersAppliedImpl implements _FiltersApplied {
  const _$FiltersAppliedImpl(
      {required final List<String>? employees,
      @JsonKey(name: 'employee_id', fromJson: _filtersEmployeeIdFromJson)
      required this.employeeId,
      @JsonKey(name: 'item_search') required this.itemSearch,
      @JsonKey(name: 'start_date') required this.startDate,
      @JsonKey(name: 'end_date') required this.endDate,
      @JsonKey(name: 'group_by') required this.groupBy,
      @JsonKey(name: 'sort_by') required this.sortBy,
      @JsonKey(name: 'sort_order') required this.sortOrder,
      required this.limit})
      : _employees = employees;

  factory _$FiltersAppliedImpl.fromJson(Map<String, dynamic> json) =>
      _$$FiltersAppliedImplFromJson(json);

  final List<String>? _employees;
  @override
  List<String>? get employees {
    final value = _employees;
    if (value == null) return null;
    if (_employees is EqualUnmodifiableListView) return _employees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'employee_id', fromJson: _filtersEmployeeIdFromJson)
  final int? employeeId;
  @override
  @JsonKey(name: 'item_search')
  final String? itemSearch;
  @override
  @JsonKey(name: 'start_date')
  final String? startDate;
  @override
  @JsonKey(name: 'end_date')
  final String? endDate;
  @override
  @JsonKey(name: 'group_by')
  final String groupBy;
  @override
  @JsonKey(name: 'sort_by')
  final String sortBy;
  @override
  @JsonKey(name: 'sort_order')
  final String sortOrder;
  @override
  final int? limit;

  @override
  String toString() {
    return 'FiltersApplied(employees: $employees, employeeId: $employeeId, itemSearch: $itemSearch, startDate: $startDate, endDate: $endDate, groupBy: $groupBy, sortBy: $sortBy, sortOrder: $sortOrder, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FiltersAppliedImpl &&
            const DeepCollectionEquality()
                .equals(other._employees, _employees) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.itemSearch, itemSearch) ||
                other.itemSearch == itemSearch) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.groupBy, groupBy) || other.groupBy == groupBy) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_employees),
      employeeId,
      itemSearch,
      startDate,
      endDate,
      groupBy,
      sortBy,
      sortOrder,
      limit);

  /// Create a copy of FiltersApplied
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FiltersAppliedImplCopyWith<_$FiltersAppliedImpl> get copyWith =>
      __$$FiltersAppliedImplCopyWithImpl<_$FiltersAppliedImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FiltersAppliedImplToJson(
      this,
    );
  }
}

abstract class _FiltersApplied implements FiltersApplied {
  const factory _FiltersApplied(
      {required final List<String>? employees,
      @JsonKey(name: 'employee_id', fromJson: _filtersEmployeeIdFromJson)
      required final int? employeeId,
      @JsonKey(name: 'item_search') required final String? itemSearch,
      @JsonKey(name: 'start_date') required final String? startDate,
      @JsonKey(name: 'end_date') required final String? endDate,
      @JsonKey(name: 'group_by') required final String groupBy,
      @JsonKey(name: 'sort_by') required final String sortBy,
      @JsonKey(name: 'sort_order') required final String sortOrder,
      required final int? limit}) = _$FiltersAppliedImpl;

  factory _FiltersApplied.fromJson(Map<String, dynamic> json) =
      _$FiltersAppliedImpl.fromJson;

  @override
  List<String>? get employees;
  @override
  @JsonKey(name: 'employee_id', fromJson: _filtersEmployeeIdFromJson)
  int? get employeeId;
  @override
  @JsonKey(name: 'item_search')
  String? get itemSearch;
  @override
  @JsonKey(name: 'start_date')
  String? get startDate;
  @override
  @JsonKey(name: 'end_date')
  String? get endDate;
  @override
  @JsonKey(name: 'group_by')
  String get groupBy;
  @override
  @JsonKey(name: 'sort_by')
  String get sortBy;
  @override
  @JsonKey(name: 'sort_order')
  String get sortOrder;
  @override
  int? get limit;

  /// Create a copy of FiltersApplied
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FiltersAppliedImplCopyWith<_$FiltersAppliedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdvanceMetadata _$AdvanceMetadataFromJson(Map<String, dynamic> json) {
  return _AdvanceMetadata.fromJson(json);
}

/// @nodoc
mixin _$AdvanceMetadata {
  @JsonKey(name: 'total_records')
  int get totalRecords => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_by')
  String get groupBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_limit')
  bool get hasLimit => throw _privateConstructorUsedError;

  /// Serializes this AdvanceMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdvanceMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdvanceMetadataCopyWith<AdvanceMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdvanceMetadataCopyWith<$Res> {
  factory $AdvanceMetadataCopyWith(
          AdvanceMetadata value, $Res Function(AdvanceMetadata) then) =
      _$AdvanceMetadataCopyWithImpl<$Res, AdvanceMetadata>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_records') int totalRecords,
      @JsonKey(name: 'group_by') String groupBy,
      @JsonKey(name: 'has_limit') bool hasLimit});
}

/// @nodoc
class _$AdvanceMetadataCopyWithImpl<$Res, $Val extends AdvanceMetadata>
    implements $AdvanceMetadataCopyWith<$Res> {
  _$AdvanceMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdvanceMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRecords = null,
    Object? groupBy = null,
    Object? hasLimit = null,
  }) {
    return _then(_value.copyWith(
      totalRecords: null == totalRecords
          ? _value.totalRecords
          : totalRecords // ignore: cast_nullable_to_non_nullable
              as int,
      groupBy: null == groupBy
          ? _value.groupBy
          : groupBy // ignore: cast_nullable_to_non_nullable
              as String,
      hasLimit: null == hasLimit
          ? _value.hasLimit
          : hasLimit // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdvanceMetadataImplCopyWith<$Res>
    implements $AdvanceMetadataCopyWith<$Res> {
  factory _$$AdvanceMetadataImplCopyWith(_$AdvanceMetadataImpl value,
          $Res Function(_$AdvanceMetadataImpl) then) =
      __$$AdvanceMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_records') int totalRecords,
      @JsonKey(name: 'group_by') String groupBy,
      @JsonKey(name: 'has_limit') bool hasLimit});
}

/// @nodoc
class __$$AdvanceMetadataImplCopyWithImpl<$Res>
    extends _$AdvanceMetadataCopyWithImpl<$Res, _$AdvanceMetadataImpl>
    implements _$$AdvanceMetadataImplCopyWith<$Res> {
  __$$AdvanceMetadataImplCopyWithImpl(
      _$AdvanceMetadataImpl _value, $Res Function(_$AdvanceMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdvanceMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRecords = null,
    Object? groupBy = null,
    Object? hasLimit = null,
  }) {
    return _then(_$AdvanceMetadataImpl(
      totalRecords: null == totalRecords
          ? _value.totalRecords
          : totalRecords // ignore: cast_nullable_to_non_nullable
              as int,
      groupBy: null == groupBy
          ? _value.groupBy
          : groupBy // ignore: cast_nullable_to_non_nullable
              as String,
      hasLimit: null == hasLimit
          ? _value.hasLimit
          : hasLimit // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdvanceMetadataImpl implements _AdvanceMetadata {
  const _$AdvanceMetadataImpl(
      {@JsonKey(name: 'total_records') required this.totalRecords,
      @JsonKey(name: 'group_by') required this.groupBy,
      @JsonKey(name: 'has_limit') required this.hasLimit});

  factory _$AdvanceMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdvanceMetadataImplFromJson(json);

  @override
  @JsonKey(name: 'total_records')
  final int totalRecords;
  @override
  @JsonKey(name: 'group_by')
  final String groupBy;
  @override
  @JsonKey(name: 'has_limit')
  final bool hasLimit;

  @override
  String toString() {
    return 'AdvanceMetadata(totalRecords: $totalRecords, groupBy: $groupBy, hasLimit: $hasLimit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdvanceMetadataImpl &&
            (identical(other.totalRecords, totalRecords) ||
                other.totalRecords == totalRecords) &&
            (identical(other.groupBy, groupBy) || other.groupBy == groupBy) &&
            (identical(other.hasLimit, hasLimit) ||
                other.hasLimit == hasLimit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalRecords, groupBy, hasLimit);

  /// Create a copy of AdvanceMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdvanceMetadataImplCopyWith<_$AdvanceMetadataImpl> get copyWith =>
      __$$AdvanceMetadataImplCopyWithImpl<_$AdvanceMetadataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdvanceMetadataImplToJson(
      this,
    );
  }
}

abstract class _AdvanceMetadata implements AdvanceMetadata {
  const factory _AdvanceMetadata(
          {@JsonKey(name: 'total_records') required final int totalRecords,
          @JsonKey(name: 'group_by') required final String groupBy,
          @JsonKey(name: 'has_limit') required final bool hasLimit}) =
      _$AdvanceMetadataImpl;

  factory _AdvanceMetadata.fromJson(Map<String, dynamic> json) =
      _$AdvanceMetadataImpl.fromJson;

  @override
  @JsonKey(name: 'total_records')
  int get totalRecords;
  @override
  @JsonKey(name: 'group_by')
  String get groupBy;
  @override
  @JsonKey(name: 'has_limit')
  bool get hasLimit;

  /// Create a copy of AdvanceMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdvanceMetadataImplCopyWith<_$AdvanceMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
