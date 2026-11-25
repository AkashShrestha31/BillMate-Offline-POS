// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reconciliation_upload_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReconciliationUploadResponse _$ReconciliationUploadResponseFromJson(
    Map<String, dynamic> json) {
  return _ReconciliationUploadResponse.fromJson(json);
}

/// @nodoc
mixin _$ReconciliationUploadResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'successful_uploads')
  int get successfulUploads => throw _privateConstructorUsedError;
  @JsonKey(name: 'failed_uploads')
  int get failedUploads => throw _privateConstructorUsedError;
  @JsonKey(name: 'failed_records')
  List<dynamic> get failedRecords => throw _privateConstructorUsedError;
  @JsonKey(name: 'reporting_date')
  String get reportingDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'upload_batch')
  String get uploadBatch => throw _privateConstructorUsedError;
  @JsonKey(name: 'upload_type')
  String get uploadType => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;

  /// Serializes this ReconciliationUploadResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReconciliationUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReconciliationUploadResponseCopyWith<ReconciliationUploadResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReconciliationUploadResponseCopyWith<$Res> {
  factory $ReconciliationUploadResponseCopyWith(
          ReconciliationUploadResponse value,
          $Res Function(ReconciliationUploadResponse) then) =
      _$ReconciliationUploadResponseCopyWithImpl<$Res,
          ReconciliationUploadResponse>;
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'successful_uploads') int successfulUploads,
      @JsonKey(name: 'failed_uploads') int failedUploads,
      @JsonKey(name: 'failed_records') List<dynamic> failedRecords,
      @JsonKey(name: 'reporting_date') String reportingDate,
      @JsonKey(name: 'upload_batch') String uploadBatch,
      @JsonKey(name: 'upload_type') String uploadType,
      String note});
}

/// @nodoc
class _$ReconciliationUploadResponseCopyWithImpl<$Res,
        $Val extends ReconciliationUploadResponse>
    implements $ReconciliationUploadResponseCopyWith<$Res> {
  _$ReconciliationUploadResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReconciliationUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? successfulUploads = null,
    Object? failedUploads = null,
    Object? failedRecords = null,
    Object? reportingDate = null,
    Object? uploadBatch = null,
    Object? uploadType = null,
    Object? note = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      successfulUploads: null == successfulUploads
          ? _value.successfulUploads
          : successfulUploads // ignore: cast_nullable_to_non_nullable
              as int,
      failedUploads: null == failedUploads
          ? _value.failedUploads
          : failedUploads // ignore: cast_nullable_to_non_nullable
              as int,
      failedRecords: null == failedRecords
          ? _value.failedRecords
          : failedRecords // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      reportingDate: null == reportingDate
          ? _value.reportingDate
          : reportingDate // ignore: cast_nullable_to_non_nullable
              as String,
      uploadBatch: null == uploadBatch
          ? _value.uploadBatch
          : uploadBatch // ignore: cast_nullable_to_non_nullable
              as String,
      uploadType: null == uploadType
          ? _value.uploadType
          : uploadType // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReconciliationUploadResponseImplCopyWith<$Res>
    implements $ReconciliationUploadResponseCopyWith<$Res> {
  factory _$$ReconciliationUploadResponseImplCopyWith(
          _$ReconciliationUploadResponseImpl value,
          $Res Function(_$ReconciliationUploadResponseImpl) then) =
      __$$ReconciliationUploadResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'successful_uploads') int successfulUploads,
      @JsonKey(name: 'failed_uploads') int failedUploads,
      @JsonKey(name: 'failed_records') List<dynamic> failedRecords,
      @JsonKey(name: 'reporting_date') String reportingDate,
      @JsonKey(name: 'upload_batch') String uploadBatch,
      @JsonKey(name: 'upload_type') String uploadType,
      String note});
}

/// @nodoc
class __$$ReconciliationUploadResponseImplCopyWithImpl<$Res>
    extends _$ReconciliationUploadResponseCopyWithImpl<$Res,
        _$ReconciliationUploadResponseImpl>
    implements _$$ReconciliationUploadResponseImplCopyWith<$Res> {
  __$$ReconciliationUploadResponseImplCopyWithImpl(
      _$ReconciliationUploadResponseImpl _value,
      $Res Function(_$ReconciliationUploadResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReconciliationUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? successfulUploads = null,
    Object? failedUploads = null,
    Object? failedRecords = null,
    Object? reportingDate = null,
    Object? uploadBatch = null,
    Object? uploadType = null,
    Object? note = null,
  }) {
    return _then(_$ReconciliationUploadResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      successfulUploads: null == successfulUploads
          ? _value.successfulUploads
          : successfulUploads // ignore: cast_nullable_to_non_nullable
              as int,
      failedUploads: null == failedUploads
          ? _value.failedUploads
          : failedUploads // ignore: cast_nullable_to_non_nullable
              as int,
      failedRecords: null == failedRecords
          ? _value._failedRecords
          : failedRecords // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      reportingDate: null == reportingDate
          ? _value.reportingDate
          : reportingDate // ignore: cast_nullable_to_non_nullable
              as String,
      uploadBatch: null == uploadBatch
          ? _value.uploadBatch
          : uploadBatch // ignore: cast_nullable_to_non_nullable
              as String,
      uploadType: null == uploadType
          ? _value.uploadType
          : uploadType // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReconciliationUploadResponseImpl
    implements _ReconciliationUploadResponse {
  const _$ReconciliationUploadResponseImpl(
      {required this.success,
      required this.message,
      @JsonKey(name: 'successful_uploads') required this.successfulUploads,
      @JsonKey(name: 'failed_uploads') required this.failedUploads,
      @JsonKey(name: 'failed_records')
      required final List<dynamic> failedRecords,
      @JsonKey(name: 'reporting_date') required this.reportingDate,
      @JsonKey(name: 'upload_batch') required this.uploadBatch,
      @JsonKey(name: 'upload_type') required this.uploadType,
      required this.note})
      : _failedRecords = failedRecords;

  factory _$ReconciliationUploadResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReconciliationUploadResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  @JsonKey(name: 'successful_uploads')
  final int successfulUploads;
  @override
  @JsonKey(name: 'failed_uploads')
  final int failedUploads;
  final List<dynamic> _failedRecords;
  @override
  @JsonKey(name: 'failed_records')
  List<dynamic> get failedRecords {
    if (_failedRecords is EqualUnmodifiableListView) return _failedRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_failedRecords);
  }

  @override
  @JsonKey(name: 'reporting_date')
  final String reportingDate;
  @override
  @JsonKey(name: 'upload_batch')
  final String uploadBatch;
  @override
  @JsonKey(name: 'upload_type')
  final String uploadType;
  @override
  final String note;

  @override
  String toString() {
    return 'ReconciliationUploadResponse(success: $success, message: $message, successfulUploads: $successfulUploads, failedUploads: $failedUploads, failedRecords: $failedRecords, reportingDate: $reportingDate, uploadBatch: $uploadBatch, uploadType: $uploadType, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReconciliationUploadResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.successfulUploads, successfulUploads) ||
                other.successfulUploads == successfulUploads) &&
            (identical(other.failedUploads, failedUploads) ||
                other.failedUploads == failedUploads) &&
            const DeepCollectionEquality()
                .equals(other._failedRecords, _failedRecords) &&
            (identical(other.reportingDate, reportingDate) ||
                other.reportingDate == reportingDate) &&
            (identical(other.uploadBatch, uploadBatch) ||
                other.uploadBatch == uploadBatch) &&
            (identical(other.uploadType, uploadType) ||
                other.uploadType == uploadType) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      message,
      successfulUploads,
      failedUploads,
      const DeepCollectionEquality().hash(_failedRecords),
      reportingDate,
      uploadBatch,
      uploadType,
      note);

  /// Create a copy of ReconciliationUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReconciliationUploadResponseImplCopyWith<
          _$ReconciliationUploadResponseImpl>
      get copyWith => __$$ReconciliationUploadResponseImplCopyWithImpl<
          _$ReconciliationUploadResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReconciliationUploadResponseImplToJson(
      this,
    );
  }
}

abstract class _ReconciliationUploadResponse
    implements ReconciliationUploadResponse {
  const factory _ReconciliationUploadResponse(
      {required final bool success,
      required final String message,
      @JsonKey(name: 'successful_uploads') required final int successfulUploads,
      @JsonKey(name: 'failed_uploads') required final int failedUploads,
      @JsonKey(name: 'failed_records')
      required final List<dynamic> failedRecords,
      @JsonKey(name: 'reporting_date') required final String reportingDate,
      @JsonKey(name: 'upload_batch') required final String uploadBatch,
      @JsonKey(name: 'upload_type') required final String uploadType,
      required final String note}) = _$ReconciliationUploadResponseImpl;

  factory _ReconciliationUploadResponse.fromJson(Map<String, dynamic> json) =
      _$ReconciliationUploadResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  @JsonKey(name: 'successful_uploads')
  int get successfulUploads;
  @override
  @JsonKey(name: 'failed_uploads')
  int get failedUploads;
  @override
  @JsonKey(name: 'failed_records')
  List<dynamic> get failedRecords;
  @override
  @JsonKey(name: 'reporting_date')
  String get reportingDate;
  @override
  @JsonKey(name: 'upload_batch')
  String get uploadBatch;
  @override
  @JsonKey(name: 'upload_type')
  String get uploadType;
  @override
  String get note;

  /// Create a copy of ReconciliationUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReconciliationUploadResponseImplCopyWith<
          _$ReconciliationUploadResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
