// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payroll_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PayrollListResponse _$PayrollListResponseFromJson(Map<String, dynamic> json) {
  return _PayrollListResponse.fromJson(json);
}

/// @nodoc
mixin _$PayrollListResponse {
  bool get success => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  PayrollSummaryModel get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'filters_applied')
  FiltersAppliedModel get filtersApplied => throw _privateConstructorUsedError;
  @JsonKey(name: 'payroll_records')
  List<PayrollModel> get payrollRecords => throw _privateConstructorUsedError;

  /// Serializes this PayrollListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayrollListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayrollListResponseCopyWith<PayrollListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayrollListResponseCopyWith<$Res> {
  factory $PayrollListResponseCopyWith(
          PayrollListResponse value, $Res Function(PayrollListResponse) then) =
      _$PayrollListResponseCopyWithImpl<$Res, PayrollListResponse>;
  @useResult
  $Res call(
      {bool success,
      int count,
      PayrollSummaryModel summary,
      @JsonKey(name: 'filters_applied') FiltersAppliedModel filtersApplied,
      @JsonKey(name: 'payroll_records') List<PayrollModel> payrollRecords});

  $PayrollSummaryModelCopyWith<$Res> get summary;
  $FiltersAppliedModelCopyWith<$Res> get filtersApplied;
}

/// @nodoc
class _$PayrollListResponseCopyWithImpl<$Res, $Val extends PayrollListResponse>
    implements $PayrollListResponseCopyWith<$Res> {
  _$PayrollListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayrollListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? summary = null,
    Object? filtersApplied = null,
    Object? payrollRecords = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as PayrollSummaryModel,
      filtersApplied: null == filtersApplied
          ? _value.filtersApplied
          : filtersApplied // ignore: cast_nullable_to_non_nullable
              as FiltersAppliedModel,
      payrollRecords: null == payrollRecords
          ? _value.payrollRecords
          : payrollRecords // ignore: cast_nullable_to_non_nullable
              as List<PayrollModel>,
    ) as $Val);
  }

  /// Create a copy of PayrollListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PayrollSummaryModelCopyWith<$Res> get summary {
    return $PayrollSummaryModelCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }

  /// Create a copy of PayrollListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FiltersAppliedModelCopyWith<$Res> get filtersApplied {
    return $FiltersAppliedModelCopyWith<$Res>(_value.filtersApplied, (value) {
      return _then(_value.copyWith(filtersApplied: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PayrollListResponseImplCopyWith<$Res>
    implements $PayrollListResponseCopyWith<$Res> {
  factory _$$PayrollListResponseImplCopyWith(_$PayrollListResponseImpl value,
          $Res Function(_$PayrollListResponseImpl) then) =
      __$$PayrollListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      int count,
      PayrollSummaryModel summary,
      @JsonKey(name: 'filters_applied') FiltersAppliedModel filtersApplied,
      @JsonKey(name: 'payroll_records') List<PayrollModel> payrollRecords});

  @override
  $PayrollSummaryModelCopyWith<$Res> get summary;
  @override
  $FiltersAppliedModelCopyWith<$Res> get filtersApplied;
}

/// @nodoc
class __$$PayrollListResponseImplCopyWithImpl<$Res>
    extends _$PayrollListResponseCopyWithImpl<$Res, _$PayrollListResponseImpl>
    implements _$$PayrollListResponseImplCopyWith<$Res> {
  __$$PayrollListResponseImplCopyWithImpl(_$PayrollListResponseImpl _value,
      $Res Function(_$PayrollListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayrollListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? summary = null,
    Object? filtersApplied = null,
    Object? payrollRecords = null,
  }) {
    return _then(_$PayrollListResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as PayrollSummaryModel,
      filtersApplied: null == filtersApplied
          ? _value.filtersApplied
          : filtersApplied // ignore: cast_nullable_to_non_nullable
              as FiltersAppliedModel,
      payrollRecords: null == payrollRecords
          ? _value._payrollRecords
          : payrollRecords // ignore: cast_nullable_to_non_nullable
              as List<PayrollModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayrollListResponseImpl implements _PayrollListResponse {
  const _$PayrollListResponseImpl(
      {required this.success,
      required this.count,
      required this.summary,
      @JsonKey(name: 'filters_applied') required this.filtersApplied,
      @JsonKey(name: 'payroll_records')
      required final List<PayrollModel> payrollRecords})
      : _payrollRecords = payrollRecords;

  factory _$PayrollListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollListResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final int count;
  @override
  final PayrollSummaryModel summary;
  @override
  @JsonKey(name: 'filters_applied')
  final FiltersAppliedModel filtersApplied;
  final List<PayrollModel> _payrollRecords;
  @override
  @JsonKey(name: 'payroll_records')
  List<PayrollModel> get payrollRecords {
    if (_payrollRecords is EqualUnmodifiableListView) return _payrollRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payrollRecords);
  }

  @override
  String toString() {
    return 'PayrollListResponse(success: $success, count: $count, summary: $summary, filtersApplied: $filtersApplied, payrollRecords: $payrollRecords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayrollListResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.filtersApplied, filtersApplied) ||
                other.filtersApplied == filtersApplied) &&
            const DeepCollectionEquality()
                .equals(other._payrollRecords, _payrollRecords));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, count, summary,
      filtersApplied, const DeepCollectionEquality().hash(_payrollRecords));

  /// Create a copy of PayrollListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayrollListResponseImplCopyWith<_$PayrollListResponseImpl> get copyWith =>
      __$$PayrollListResponseImplCopyWithImpl<_$PayrollListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayrollListResponseImplToJson(
      this,
    );
  }
}

abstract class _PayrollListResponse implements PayrollListResponse {
  const factory _PayrollListResponse(
          {required final bool success,
          required final int count,
          required final PayrollSummaryModel summary,
          @JsonKey(name: 'filters_applied')
          required final FiltersAppliedModel filtersApplied,
          @JsonKey(name: 'payroll_records')
          required final List<PayrollModel> payrollRecords}) =
      _$PayrollListResponseImpl;

  factory _PayrollListResponse.fromJson(Map<String, dynamic> json) =
      _$PayrollListResponseImpl.fromJson;

  @override
  bool get success;
  @override
  int get count;
  @override
  PayrollSummaryModel get summary;
  @override
  @JsonKey(name: 'filters_applied')
  FiltersAppliedModel get filtersApplied;
  @override
  @JsonKey(name: 'payroll_records')
  List<PayrollModel> get payrollRecords;

  /// Create a copy of PayrollListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayrollListResponseImplCopyWith<_$PayrollListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
