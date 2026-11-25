// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendanceListResponseModel _$AttendanceListResponseModelFromJson(
    Map<String, dynamic> json) {
  return _AttendanceListResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceListResponseModel {
  bool get success => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  Map<String, dynamic>? get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'filters_applied')
  Map<String, dynamic>? get filtersApplied =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'attendance_records')
  List<AttendanceModel> get attendanceRecords =>
      throw _privateConstructorUsedError;

  /// Serializes this AttendanceListResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceListResponseModelCopyWith<AttendanceListResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceListResponseModelCopyWith<$Res> {
  factory $AttendanceListResponseModelCopyWith(
          AttendanceListResponseModel value,
          $Res Function(AttendanceListResponseModel) then) =
      _$AttendanceListResponseModelCopyWithImpl<$Res,
          AttendanceListResponseModel>;
  @useResult
  $Res call(
      {bool success,
      int count,
      Map<String, dynamic>? summary,
      @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
      @JsonKey(name: 'attendance_records')
      List<AttendanceModel> attendanceRecords});
}

/// @nodoc
class _$AttendanceListResponseModelCopyWithImpl<$Res,
        $Val extends AttendanceListResponseModel>
    implements $AttendanceListResponseModelCopyWith<$Res> {
  _$AttendanceListResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? summary = freezed,
    Object? filtersApplied = freezed,
    Object? attendanceRecords = null,
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
      attendanceRecords: null == attendanceRecords
          ? _value.attendanceRecords
          : attendanceRecords // ignore: cast_nullable_to_non_nullable
              as List<AttendanceModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceListResponseModelImplCopyWith<$Res>
    implements $AttendanceListResponseModelCopyWith<$Res> {
  factory _$$AttendanceListResponseModelImplCopyWith(
          _$AttendanceListResponseModelImpl value,
          $Res Function(_$AttendanceListResponseModelImpl) then) =
      __$$AttendanceListResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      int count,
      Map<String, dynamic>? summary,
      @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
      @JsonKey(name: 'attendance_records')
      List<AttendanceModel> attendanceRecords});
}

/// @nodoc
class __$$AttendanceListResponseModelImplCopyWithImpl<$Res>
    extends _$AttendanceListResponseModelCopyWithImpl<$Res,
        _$AttendanceListResponseModelImpl>
    implements _$$AttendanceListResponseModelImplCopyWith<$Res> {
  __$$AttendanceListResponseModelImplCopyWithImpl(
      _$AttendanceListResponseModelImpl _value,
      $Res Function(_$AttendanceListResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendanceListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? summary = freezed,
    Object? filtersApplied = freezed,
    Object? attendanceRecords = null,
  }) {
    return _then(_$AttendanceListResponseModelImpl(
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
      attendanceRecords: null == attendanceRecords
          ? _value._attendanceRecords
          : attendanceRecords // ignore: cast_nullable_to_non_nullable
              as List<AttendanceModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceListResponseModelImpl
    implements _AttendanceListResponseModel {
  const _$AttendanceListResponseModelImpl(
      {required this.success,
      required this.count,
      final Map<String, dynamic>? summary,
      @JsonKey(name: 'filters_applied')
      final Map<String, dynamic>? filtersApplied,
      @JsonKey(name: 'attendance_records')
      required final List<AttendanceModel> attendanceRecords})
      : _summary = summary,
        _filtersApplied = filtersApplied,
        _attendanceRecords = attendanceRecords;

  factory _$AttendanceListResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AttendanceListResponseModelImplFromJson(json);

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

  final List<AttendanceModel> _attendanceRecords;
  @override
  @JsonKey(name: 'attendance_records')
  List<AttendanceModel> get attendanceRecords {
    if (_attendanceRecords is EqualUnmodifiableListView)
      return _attendanceRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attendanceRecords);
  }

  @override
  String toString() {
    return 'AttendanceListResponseModel(success: $success, count: $count, summary: $summary, filtersApplied: $filtersApplied, attendanceRecords: $attendanceRecords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceListResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality().equals(other._summary, _summary) &&
            const DeepCollectionEquality()
                .equals(other._filtersApplied, _filtersApplied) &&
            const DeepCollectionEquality()
                .equals(other._attendanceRecords, _attendanceRecords));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      count,
      const DeepCollectionEquality().hash(_summary),
      const DeepCollectionEquality().hash(_filtersApplied),
      const DeepCollectionEquality().hash(_attendanceRecords));

  /// Create a copy of AttendanceListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceListResponseModelImplCopyWith<_$AttendanceListResponseModelImpl>
      get copyWith => __$$AttendanceListResponseModelImplCopyWithImpl<
          _$AttendanceListResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceListResponseModelImplToJson(
      this,
    );
  }
}

abstract class _AttendanceListResponseModel
    implements AttendanceListResponseModel {
  const factory _AttendanceListResponseModel(
          {required final bool success,
          required final int count,
          final Map<String, dynamic>? summary,
          @JsonKey(name: 'filters_applied')
          final Map<String, dynamic>? filtersApplied,
          @JsonKey(name: 'attendance_records')
          required final List<AttendanceModel> attendanceRecords}) =
      _$AttendanceListResponseModelImpl;

  factory _AttendanceListResponseModel.fromJson(Map<String, dynamic> json) =
      _$AttendanceListResponseModelImpl.fromJson;

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
  @JsonKey(name: 'attendance_records')
  List<AttendanceModel> get attendanceRecords;

  /// Create a copy of AttendanceListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceListResponseModelImplCopyWith<_$AttendanceListResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
