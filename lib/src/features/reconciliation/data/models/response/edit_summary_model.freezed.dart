// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EditSummaryModel _$EditSummaryModelFromJson(Map<String, dynamic> json) {
  return _EditSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$EditSummaryModel {
  @JsonKey(name: 'total_requested')
  int get totalRequested => throw _privateConstructorUsedError;
  @JsonKey(name: 'successfully_updated')
  int get successfullyUpdated => throw _privateConstructorUsedError;
  int get failed => throw _privateConstructorUsedError;

  /// Serializes this EditSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EditSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditSummaryModelCopyWith<EditSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditSummaryModelCopyWith<$Res> {
  factory $EditSummaryModelCopyWith(
          EditSummaryModel value, $Res Function(EditSummaryModel) then) =
      _$EditSummaryModelCopyWithImpl<$Res, EditSummaryModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_requested') int totalRequested,
      @JsonKey(name: 'successfully_updated') int successfullyUpdated,
      int failed});
}

/// @nodoc
class _$EditSummaryModelCopyWithImpl<$Res, $Val extends EditSummaryModel>
    implements $EditSummaryModelCopyWith<$Res> {
  _$EditSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRequested = null,
    Object? successfullyUpdated = null,
    Object? failed = null,
  }) {
    return _then(_value.copyWith(
      totalRequested: null == totalRequested
          ? _value.totalRequested
          : totalRequested // ignore: cast_nullable_to_non_nullable
              as int,
      successfullyUpdated: null == successfullyUpdated
          ? _value.successfullyUpdated
          : successfullyUpdated // ignore: cast_nullable_to_non_nullable
              as int,
      failed: null == failed
          ? _value.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditSummaryModelImplCopyWith<$Res>
    implements $EditSummaryModelCopyWith<$Res> {
  factory _$$EditSummaryModelImplCopyWith(_$EditSummaryModelImpl value,
          $Res Function(_$EditSummaryModelImpl) then) =
      __$$EditSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_requested') int totalRequested,
      @JsonKey(name: 'successfully_updated') int successfullyUpdated,
      int failed});
}

/// @nodoc
class __$$EditSummaryModelImplCopyWithImpl<$Res>
    extends _$EditSummaryModelCopyWithImpl<$Res, _$EditSummaryModelImpl>
    implements _$$EditSummaryModelImplCopyWith<$Res> {
  __$$EditSummaryModelImplCopyWithImpl(_$EditSummaryModelImpl _value,
      $Res Function(_$EditSummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRequested = null,
    Object? successfullyUpdated = null,
    Object? failed = null,
  }) {
    return _then(_$EditSummaryModelImpl(
      totalRequested: null == totalRequested
          ? _value.totalRequested
          : totalRequested // ignore: cast_nullable_to_non_nullable
              as int,
      successfullyUpdated: null == successfullyUpdated
          ? _value.successfullyUpdated
          : successfullyUpdated // ignore: cast_nullable_to_non_nullable
              as int,
      failed: null == failed
          ? _value.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EditSummaryModelImpl implements _EditSummaryModel {
  const _$EditSummaryModelImpl(
      {@JsonKey(name: 'total_requested') required this.totalRequested,
      @JsonKey(name: 'successfully_updated') required this.successfullyUpdated,
      required this.failed});

  factory _$EditSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EditSummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'total_requested')
  final int totalRequested;
  @override
  @JsonKey(name: 'successfully_updated')
  final int successfullyUpdated;
  @override
  final int failed;

  @override
  String toString() {
    return 'EditSummaryModel(totalRequested: $totalRequested, successfullyUpdated: $successfullyUpdated, failed: $failed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditSummaryModelImpl &&
            (identical(other.totalRequested, totalRequested) ||
                other.totalRequested == totalRequested) &&
            (identical(other.successfullyUpdated, successfullyUpdated) ||
                other.successfullyUpdated == successfullyUpdated) &&
            (identical(other.failed, failed) || other.failed == failed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, totalRequested, successfullyUpdated, failed);

  /// Create a copy of EditSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditSummaryModelImplCopyWith<_$EditSummaryModelImpl> get copyWith =>
      __$$EditSummaryModelImplCopyWithImpl<_$EditSummaryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EditSummaryModelImplToJson(
      this,
    );
  }
}

abstract class _EditSummaryModel implements EditSummaryModel {
  const factory _EditSummaryModel(
      {@JsonKey(name: 'total_requested') required final int totalRequested,
      @JsonKey(name: 'successfully_updated')
      required final int successfullyUpdated,
      required final int failed}) = _$EditSummaryModelImpl;

  factory _EditSummaryModel.fromJson(Map<String, dynamic> json) =
      _$EditSummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'total_requested')
  int get totalRequested;
  @override
  @JsonKey(name: 'successfully_updated')
  int get successfullyUpdated;
  @override
  int get failed;

  /// Create a copy of EditSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditSummaryModelImplCopyWith<_$EditSummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
