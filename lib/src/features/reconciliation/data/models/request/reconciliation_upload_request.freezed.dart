// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reconciliation_upload_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReconciliationUploadRequest _$ReconciliationUploadRequestFromJson(
    Map<String, dynamic> json) {
  return _ReconciliationUploadRequest.fromJson(json);
}

/// @nodoc
mixin _$ReconciliationUploadRequest {
  @JsonKey(name: 'reporting_date')
  String get reportingDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'uploaded_by')
  String get uploadedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'replace_existing')
  bool get replaceExisting => throw _privateConstructorUsedError;
  @JsonKey(name: 'create_missing_items')
  bool get createMissingItems => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get file => throw _privateConstructorUsedError;

  /// Serializes this ReconciliationUploadRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReconciliationUploadRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReconciliationUploadRequestCopyWith<ReconciliationUploadRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReconciliationUploadRequestCopyWith<$Res> {
  factory $ReconciliationUploadRequestCopyWith(
          ReconciliationUploadRequest value,
          $Res Function(ReconciliationUploadRequest) then) =
      _$ReconciliationUploadRequestCopyWithImpl<$Res,
          ReconciliationUploadRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'reporting_date') String reportingDate,
      @JsonKey(name: 'uploaded_by') String uploadedBy,
      @JsonKey(name: 'replace_existing') bool replaceExisting,
      @JsonKey(name: 'create_missing_items') bool createMissingItems,
      @JsonKey(includeFromJson: false, includeToJson: false) File? file});
}

/// @nodoc
class _$ReconciliationUploadRequestCopyWithImpl<$Res,
        $Val extends ReconciliationUploadRequest>
    implements $ReconciliationUploadRequestCopyWith<$Res> {
  _$ReconciliationUploadRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReconciliationUploadRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportingDate = null,
    Object? uploadedBy = null,
    Object? replaceExisting = null,
    Object? createMissingItems = null,
    Object? file = freezed,
  }) {
    return _then(_value.copyWith(
      reportingDate: null == reportingDate
          ? _value.reportingDate
          : reportingDate // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedBy: null == uploadedBy
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as String,
      replaceExisting: null == replaceExisting
          ? _value.replaceExisting
          : replaceExisting // ignore: cast_nullable_to_non_nullable
              as bool,
      createMissingItems: null == createMissingItems
          ? _value.createMissingItems
          : createMissingItems // ignore: cast_nullable_to_non_nullable
              as bool,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReconciliationUploadRequestImplCopyWith<$Res>
    implements $ReconciliationUploadRequestCopyWith<$Res> {
  factory _$$ReconciliationUploadRequestImplCopyWith(
          _$ReconciliationUploadRequestImpl value,
          $Res Function(_$ReconciliationUploadRequestImpl) then) =
      __$$ReconciliationUploadRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'reporting_date') String reportingDate,
      @JsonKey(name: 'uploaded_by') String uploadedBy,
      @JsonKey(name: 'replace_existing') bool replaceExisting,
      @JsonKey(name: 'create_missing_items') bool createMissingItems,
      @JsonKey(includeFromJson: false, includeToJson: false) File? file});
}

/// @nodoc
class __$$ReconciliationUploadRequestImplCopyWithImpl<$Res>
    extends _$ReconciliationUploadRequestCopyWithImpl<$Res,
        _$ReconciliationUploadRequestImpl>
    implements _$$ReconciliationUploadRequestImplCopyWith<$Res> {
  __$$ReconciliationUploadRequestImplCopyWithImpl(
      _$ReconciliationUploadRequestImpl _value,
      $Res Function(_$ReconciliationUploadRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReconciliationUploadRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reportingDate = null,
    Object? uploadedBy = null,
    Object? replaceExisting = null,
    Object? createMissingItems = null,
    Object? file = freezed,
  }) {
    return _then(_$ReconciliationUploadRequestImpl(
      reportingDate: null == reportingDate
          ? _value.reportingDate
          : reportingDate // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedBy: null == uploadedBy
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
              as String,
      replaceExisting: null == replaceExisting
          ? _value.replaceExisting
          : replaceExisting // ignore: cast_nullable_to_non_nullable
              as bool,
      createMissingItems: null == createMissingItems
          ? _value.createMissingItems
          : createMissingItems // ignore: cast_nullable_to_non_nullable
              as bool,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReconciliationUploadRequestImpl
    implements _ReconciliationUploadRequest {
  const _$ReconciliationUploadRequestImpl(
      {@JsonKey(name: 'reporting_date') required this.reportingDate,
      @JsonKey(name: 'uploaded_by') required this.uploadedBy,
      @JsonKey(name: 'replace_existing') required this.replaceExisting,
      @JsonKey(name: 'create_missing_items') required this.createMissingItems,
      @JsonKey(includeFromJson: false, includeToJson: false) this.file});

  factory _$ReconciliationUploadRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReconciliationUploadRequestImplFromJson(json);

  @override
  @JsonKey(name: 'reporting_date')
  final String reportingDate;
  @override
  @JsonKey(name: 'uploaded_by')
  final String uploadedBy;
  @override
  @JsonKey(name: 'replace_existing')
  final bool replaceExisting;
  @override
  @JsonKey(name: 'create_missing_items')
  final bool createMissingItems;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? file;

  @override
  String toString() {
    return 'ReconciliationUploadRequest(reportingDate: $reportingDate, uploadedBy: $uploadedBy, replaceExisting: $replaceExisting, createMissingItems: $createMissingItems, file: $file)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReconciliationUploadRequestImpl &&
            (identical(other.reportingDate, reportingDate) ||
                other.reportingDate == reportingDate) &&
            (identical(other.uploadedBy, uploadedBy) ||
                other.uploadedBy == uploadedBy) &&
            (identical(other.replaceExisting, replaceExisting) ||
                other.replaceExisting == replaceExisting) &&
            (identical(other.createMissingItems, createMissingItems) ||
                other.createMissingItems == createMissingItems) &&
            (identical(other.file, file) || other.file == file));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reportingDate, uploadedBy,
      replaceExisting, createMissingItems, file);

  /// Create a copy of ReconciliationUploadRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReconciliationUploadRequestImplCopyWith<_$ReconciliationUploadRequestImpl>
      get copyWith => __$$ReconciliationUploadRequestImplCopyWithImpl<
          _$ReconciliationUploadRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReconciliationUploadRequestImplToJson(
      this,
    );
  }
}

abstract class _ReconciliationUploadRequest
    implements ReconciliationUploadRequest {
  const factory _ReconciliationUploadRequest(
      {@JsonKey(name: 'reporting_date') required final String reportingDate,
      @JsonKey(name: 'uploaded_by') required final String uploadedBy,
      @JsonKey(name: 'replace_existing') required final bool replaceExisting,
      @JsonKey(name: 'create_missing_items')
      required final bool createMissingItems,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final File? file}) = _$ReconciliationUploadRequestImpl;

  factory _ReconciliationUploadRequest.fromJson(Map<String, dynamic> json) =
      _$ReconciliationUploadRequestImpl.fromJson;

  @override
  @JsonKey(name: 'reporting_date')
  String get reportingDate;
  @override
  @JsonKey(name: 'uploaded_by')
  String get uploadedBy;
  @override
  @JsonKey(name: 'replace_existing')
  bool get replaceExisting;
  @override
  @JsonKey(name: 'create_missing_items')
  bool get createMissingItems;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? get file;

  /// Create a copy of ReconciliationUploadRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReconciliationUploadRequestImplCopyWith<_$ReconciliationUploadRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
