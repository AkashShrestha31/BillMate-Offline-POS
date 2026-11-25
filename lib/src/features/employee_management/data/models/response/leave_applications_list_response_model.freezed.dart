// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_applications_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveApplicationsListResponseModel _$LeaveApplicationsListResponseModelFromJson(
    Map<String, dynamic> json) {
  return _LeaveApplicationsListResponseModel.fromJson(json);
}

/// @nodoc
mixin _$LeaveApplicationsListResponseModel {
  bool get success => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  Map<String, dynamic>? get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'filters_applied')
  Map<String, dynamic>? get filtersApplied =>
      throw _privateConstructorUsedError;
  List<LeaveApplicationModel> get applications =>
      throw _privateConstructorUsedError;

  /// Serializes this LeaveApplicationsListResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveApplicationsListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveApplicationsListResponseModelCopyWith<
          LeaveApplicationsListResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveApplicationsListResponseModelCopyWith<$Res> {
  factory $LeaveApplicationsListResponseModelCopyWith(
          LeaveApplicationsListResponseModel value,
          $Res Function(LeaveApplicationsListResponseModel) then) =
      _$LeaveApplicationsListResponseModelCopyWithImpl<$Res,
          LeaveApplicationsListResponseModel>;
  @useResult
  $Res call(
      {bool success,
      int count,
      Map<String, dynamic>? summary,
      @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
      List<LeaveApplicationModel> applications});
}

/// @nodoc
class _$LeaveApplicationsListResponseModelCopyWithImpl<$Res,
        $Val extends LeaveApplicationsListResponseModel>
    implements $LeaveApplicationsListResponseModelCopyWith<$Res> {
  _$LeaveApplicationsListResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveApplicationsListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? summary = freezed,
    Object? filtersApplied = freezed,
    Object? applications = null,
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
      applications: null == applications
          ? _value.applications
          : applications // ignore: cast_nullable_to_non_nullable
              as List<LeaveApplicationModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveApplicationsListResponseModelImplCopyWith<$Res>
    implements $LeaveApplicationsListResponseModelCopyWith<$Res> {
  factory _$$LeaveApplicationsListResponseModelImplCopyWith(
          _$LeaveApplicationsListResponseModelImpl value,
          $Res Function(_$LeaveApplicationsListResponseModelImpl) then) =
      __$$LeaveApplicationsListResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      int count,
      Map<String, dynamic>? summary,
      @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
      List<LeaveApplicationModel> applications});
}

/// @nodoc
class __$$LeaveApplicationsListResponseModelImplCopyWithImpl<$Res>
    extends _$LeaveApplicationsListResponseModelCopyWithImpl<$Res,
        _$LeaveApplicationsListResponseModelImpl>
    implements _$$LeaveApplicationsListResponseModelImplCopyWith<$Res> {
  __$$LeaveApplicationsListResponseModelImplCopyWithImpl(
      _$LeaveApplicationsListResponseModelImpl _value,
      $Res Function(_$LeaveApplicationsListResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaveApplicationsListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? summary = freezed,
    Object? filtersApplied = freezed,
    Object? applications = null,
  }) {
    return _then(_$LeaveApplicationsListResponseModelImpl(
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
      applications: null == applications
          ? _value._applications
          : applications // ignore: cast_nullable_to_non_nullable
              as List<LeaveApplicationModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveApplicationsListResponseModelImpl
    implements _LeaveApplicationsListResponseModel {
  const _$LeaveApplicationsListResponseModelImpl(
      {required this.success,
      required this.count,
      final Map<String, dynamic>? summary,
      @JsonKey(name: 'filters_applied')
      final Map<String, dynamic>? filtersApplied,
      required final List<LeaveApplicationModel> applications})
      : _summary = summary,
        _filtersApplied = filtersApplied,
        _applications = applications;

  factory _$LeaveApplicationsListResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$LeaveApplicationsListResponseModelImplFromJson(json);

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

  final List<LeaveApplicationModel> _applications;
  @override
  List<LeaveApplicationModel> get applications {
    if (_applications is EqualUnmodifiableListView) return _applications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_applications);
  }

  @override
  String toString() {
    return 'LeaveApplicationsListResponseModel(success: $success, count: $count, summary: $summary, filtersApplied: $filtersApplied, applications: $applications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveApplicationsListResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality().equals(other._summary, _summary) &&
            const DeepCollectionEquality()
                .equals(other._filtersApplied, _filtersApplied) &&
            const DeepCollectionEquality()
                .equals(other._applications, _applications));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      count,
      const DeepCollectionEquality().hash(_summary),
      const DeepCollectionEquality().hash(_filtersApplied),
      const DeepCollectionEquality().hash(_applications));

  /// Create a copy of LeaveApplicationsListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveApplicationsListResponseModelImplCopyWith<
          _$LeaveApplicationsListResponseModelImpl>
      get copyWith => __$$LeaveApplicationsListResponseModelImplCopyWithImpl<
          _$LeaveApplicationsListResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveApplicationsListResponseModelImplToJson(
      this,
    );
  }
}

abstract class _LeaveApplicationsListResponseModel
    implements LeaveApplicationsListResponseModel {
  const factory _LeaveApplicationsListResponseModel(
          {required final bool success,
          required final int count,
          final Map<String, dynamic>? summary,
          @JsonKey(name: 'filters_applied')
          final Map<String, dynamic>? filtersApplied,
          required final List<LeaveApplicationModel> applications}) =
      _$LeaveApplicationsListResponseModelImpl;

  factory _LeaveApplicationsListResponseModel.fromJson(
          Map<String, dynamic> json) =
      _$LeaveApplicationsListResponseModelImpl.fromJson;

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
  List<LeaveApplicationModel> get applications;

  /// Create a copy of LeaveApplicationsListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveApplicationsListResponseModelImplCopyWith<
          _$LeaveApplicationsListResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
