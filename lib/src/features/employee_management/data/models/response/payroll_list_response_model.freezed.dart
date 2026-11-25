// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payroll_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PayrollListResponseModel _$PayrollListResponseModelFromJson(
    Map<String, dynamic> json) {
  return _PayrollListResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PayrollListResponseModel {
  bool get success => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  Map<String, dynamic>? get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'filters_applied')
  Map<String, dynamic>? get filtersApplied =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'payroll_records')
  List<PayrollModel> get payrollRecords => throw _privateConstructorUsedError;

  /// Serializes this PayrollListResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayrollListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayrollListResponseModelCopyWith<PayrollListResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayrollListResponseModelCopyWith<$Res> {
  factory $PayrollListResponseModelCopyWith(PayrollListResponseModel value,
          $Res Function(PayrollListResponseModel) then) =
      _$PayrollListResponseModelCopyWithImpl<$Res, PayrollListResponseModel>;
  @useResult
  $Res call(
      {bool success,
      int count,
      Map<String, dynamic>? summary,
      @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
      @JsonKey(name: 'payroll_records') List<PayrollModel> payrollRecords});
}

/// @nodoc
class _$PayrollListResponseModelCopyWithImpl<$Res,
        $Val extends PayrollListResponseModel>
    implements $PayrollListResponseModelCopyWith<$Res> {
  _$PayrollListResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayrollListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? summary = freezed,
    Object? filtersApplied = freezed,
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
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      filtersApplied: freezed == filtersApplied
          ? _value.filtersApplied
          : filtersApplied // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      payrollRecords: null == payrollRecords
          ? _value.payrollRecords
          : payrollRecords // ignore: cast_nullable_to_non_nullable
              as List<PayrollModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayrollListResponseModelImplCopyWith<$Res>
    implements $PayrollListResponseModelCopyWith<$Res> {
  factory _$$PayrollListResponseModelImplCopyWith(
          _$PayrollListResponseModelImpl value,
          $Res Function(_$PayrollListResponseModelImpl) then) =
      __$$PayrollListResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      int count,
      Map<String, dynamic>? summary,
      @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
      @JsonKey(name: 'payroll_records') List<PayrollModel> payrollRecords});
}

/// @nodoc
class __$$PayrollListResponseModelImplCopyWithImpl<$Res>
    extends _$PayrollListResponseModelCopyWithImpl<$Res,
        _$PayrollListResponseModelImpl>
    implements _$$PayrollListResponseModelImplCopyWith<$Res> {
  __$$PayrollListResponseModelImplCopyWithImpl(
      _$PayrollListResponseModelImpl _value,
      $Res Function(_$PayrollListResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayrollListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? summary = freezed,
    Object? filtersApplied = freezed,
    Object? payrollRecords = null,
  }) {
    return _then(_$PayrollListResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      summary: freezed == summary
          ? _value._summary
          : summary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      filtersApplied: freezed == filtersApplied
          ? _value._filtersApplied
          : filtersApplied // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      payrollRecords: null == payrollRecords
          ? _value._payrollRecords
          : payrollRecords // ignore: cast_nullable_to_non_nullable
              as List<PayrollModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayrollListResponseModelImpl implements _PayrollListResponseModel {
  const _$PayrollListResponseModelImpl(
      {required this.success,
      required this.count,
      final Map<String, dynamic>? summary,
      @JsonKey(name: 'filters_applied')
      final Map<String, dynamic>? filtersApplied,
      @JsonKey(name: 'payroll_records')
      required final List<PayrollModel> payrollRecords})
      : _summary = summary,
        _filtersApplied = filtersApplied,
        _payrollRecords = payrollRecords;

  factory _$PayrollListResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollListResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  final int count;
  final Map<String, dynamic>? _summary;
  @override
  Map<String, dynamic>? get summary {
    final value = _summary;
    if (value == null) return null;
    if (_summary is EqualUnmodifiableMapView) return _summary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _filtersApplied;
  @override
  @JsonKey(name: 'filters_applied')
  Map<String, dynamic>? get filtersApplied {
    final value = _filtersApplied;
    if (value == null) return null;
    if (_filtersApplied is EqualUnmodifiableMapView) return _filtersApplied;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

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
    return 'PayrollListResponseModel(success: $success, count: $count, summary: $summary, filtersApplied: $filtersApplied, payrollRecords: $payrollRecords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayrollListResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality().equals(other._summary, _summary) &&
            const DeepCollectionEquality()
                .equals(other._filtersApplied, _filtersApplied) &&
            const DeepCollectionEquality()
                .equals(other._payrollRecords, _payrollRecords));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      count,
      const DeepCollectionEquality().hash(_summary),
      const DeepCollectionEquality().hash(_filtersApplied),
      const DeepCollectionEquality().hash(_payrollRecords));

  /// Create a copy of PayrollListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayrollListResponseModelImplCopyWith<_$PayrollListResponseModelImpl>
      get copyWith => __$$PayrollListResponseModelImplCopyWithImpl<
          _$PayrollListResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayrollListResponseModelImplToJson(
      this,
    );
  }
}

abstract class _PayrollListResponseModel implements PayrollListResponseModel {
  const factory _PayrollListResponseModel(
          {required final bool success,
          required final int count,
          final Map<String, dynamic>? summary,
          @JsonKey(name: 'filters_applied')
          final Map<String, dynamic>? filtersApplied,
          @JsonKey(name: 'payroll_records')
          required final List<PayrollModel> payrollRecords}) =
      _$PayrollListResponseModelImpl;

  factory _PayrollListResponseModel.fromJson(Map<String, dynamic> json) =
      _$PayrollListResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  int get count;
  @override
  Map<String, dynamic>? get summary;
  @override
  @JsonKey(name: 'filters_applied')
  Map<String, dynamic>? get filtersApplied;
  @override
  @JsonKey(name: 'payroll_records')
  List<PayrollModel> get payrollRecords;

  /// Create a copy of PayrollListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayrollListResponseModelImplCopyWith<_$PayrollListResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
