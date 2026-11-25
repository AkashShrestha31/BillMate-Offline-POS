// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_delete_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuditLogModel _$AuditLogModelFromJson(Map<String, dynamic> json) {
  return _AuditLogModel.fromJson(json);
}

/// @nodoc
mixin _$AuditLogModel {
  String get action => throw _privateConstructorUsedError;
  @JsonKey(name: 'party_name')
  String get partyName => throw _privateConstructorUsedError;
  @JsonKey(name: 'party_details')
  Map<String, dynamic> get partyDetails => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_by')
  String get deletedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_at')
  String get deletedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'records_deleted')
  int get recordsDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'records_modified')
  int? get recordsModified => throw _privateConstructorUsedError;
  @JsonKey(name: 'transactions_deleted')
  bool get transactionsDeleted => throw _privateConstructorUsedError;

  /// Serializes this AuditLogModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuditLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuditLogModelCopyWith<AuditLogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuditLogModelCopyWith<$Res> {
  factory $AuditLogModelCopyWith(
          AuditLogModel value, $Res Function(AuditLogModel) then) =
      _$AuditLogModelCopyWithImpl<$Res, AuditLogModel>;
  @useResult
  $Res call(
      {String action,
      @JsonKey(name: 'party_name') String partyName,
      @JsonKey(name: 'party_details') Map<String, dynamic> partyDetails,
      @JsonKey(name: 'deleted_by') String deletedBy,
      @JsonKey(name: 'deleted_at') String deletedAt,
      @JsonKey(name: 'records_deleted') int recordsDeleted,
      @JsonKey(name: 'records_modified') int? recordsModified,
      @JsonKey(name: 'transactions_deleted') bool transactionsDeleted});
}

/// @nodoc
class _$AuditLogModelCopyWithImpl<$Res, $Val extends AuditLogModel>
    implements $AuditLogModelCopyWith<$Res> {
  _$AuditLogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuditLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? partyName = null,
    Object? partyDetails = null,
    Object? deletedBy = null,
    Object? deletedAt = null,
    Object? recordsDeleted = null,
    Object? recordsModified = freezed,
    Object? transactionsDeleted = null,
  }) {
    return _then(_value.copyWith(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      partyName: null == partyName
          ? _value.partyName
          : partyName // ignore: cast_nullable_to_non_nullable
              as String,
      partyDetails: null == partyDetails
          ? _value.partyDetails
          : partyDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      deletedBy: null == deletedBy
          ? _value.deletedBy
          : deletedBy // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: null == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String,
      recordsDeleted: null == recordsDeleted
          ? _value.recordsDeleted
          : recordsDeleted // ignore: cast_nullable_to_non_nullable
              as int,
      recordsModified: freezed == recordsModified
          ? _value.recordsModified
          : recordsModified // ignore: cast_nullable_to_non_nullable
              as int?,
      transactionsDeleted: null == transactionsDeleted
          ? _value.transactionsDeleted
          : transactionsDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuditLogModelImplCopyWith<$Res>
    implements $AuditLogModelCopyWith<$Res> {
  factory _$$AuditLogModelImplCopyWith(
          _$AuditLogModelImpl value, $Res Function(_$AuditLogModelImpl) then) =
      __$$AuditLogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String action,
      @JsonKey(name: 'party_name') String partyName,
      @JsonKey(name: 'party_details') Map<String, dynamic> partyDetails,
      @JsonKey(name: 'deleted_by') String deletedBy,
      @JsonKey(name: 'deleted_at') String deletedAt,
      @JsonKey(name: 'records_deleted') int recordsDeleted,
      @JsonKey(name: 'records_modified') int? recordsModified,
      @JsonKey(name: 'transactions_deleted') bool transactionsDeleted});
}

/// @nodoc
class __$$AuditLogModelImplCopyWithImpl<$Res>
    extends _$AuditLogModelCopyWithImpl<$Res, _$AuditLogModelImpl>
    implements _$$AuditLogModelImplCopyWith<$Res> {
  __$$AuditLogModelImplCopyWithImpl(
      _$AuditLogModelImpl _value, $Res Function(_$AuditLogModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuditLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? partyName = null,
    Object? partyDetails = null,
    Object? deletedBy = null,
    Object? deletedAt = null,
    Object? recordsDeleted = null,
    Object? recordsModified = freezed,
    Object? transactionsDeleted = null,
  }) {
    return _then(_$AuditLogModelImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      partyName: null == partyName
          ? _value.partyName
          : partyName // ignore: cast_nullable_to_non_nullable
              as String,
      partyDetails: null == partyDetails
          ? _value._partyDetails
          : partyDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      deletedBy: null == deletedBy
          ? _value.deletedBy
          : deletedBy // ignore: cast_nullable_to_non_nullable
              as String,
      deletedAt: null == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as String,
      recordsDeleted: null == recordsDeleted
          ? _value.recordsDeleted
          : recordsDeleted // ignore: cast_nullable_to_non_nullable
              as int,
      recordsModified: freezed == recordsModified
          ? _value.recordsModified
          : recordsModified // ignore: cast_nullable_to_non_nullable
              as int?,
      transactionsDeleted: null == transactionsDeleted
          ? _value.transactionsDeleted
          : transactionsDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuditLogModelImpl implements _AuditLogModel {
  const _$AuditLogModelImpl(
      {required this.action,
      @JsonKey(name: 'party_name') required this.partyName,
      @JsonKey(name: 'party_details')
      required final Map<String, dynamic> partyDetails,
      @JsonKey(name: 'deleted_by') required this.deletedBy,
      @JsonKey(name: 'deleted_at') required this.deletedAt,
      @JsonKey(name: 'records_deleted') required this.recordsDeleted,
      @JsonKey(name: 'records_modified') this.recordsModified,
      @JsonKey(name: 'transactions_deleted') required this.transactionsDeleted})
      : _partyDetails = partyDetails;

  factory _$AuditLogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuditLogModelImplFromJson(json);

  @override
  final String action;
  @override
  @JsonKey(name: 'party_name')
  final String partyName;
  final Map<String, dynamic> _partyDetails;
  @override
  @JsonKey(name: 'party_details')
  Map<String, dynamic> get partyDetails {
    if (_partyDetails is EqualUnmodifiableMapView) return _partyDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_partyDetails);
  }

  @override
  @JsonKey(name: 'deleted_by')
  final String deletedBy;
  @override
  @JsonKey(name: 'deleted_at')
  final String deletedAt;
  @override
  @JsonKey(name: 'records_deleted')
  final int recordsDeleted;
  @override
  @JsonKey(name: 'records_modified')
  final int? recordsModified;
  @override
  @JsonKey(name: 'transactions_deleted')
  final bool transactionsDeleted;

  @override
  String toString() {
    return 'AuditLogModel(action: $action, partyName: $partyName, partyDetails: $partyDetails, deletedBy: $deletedBy, deletedAt: $deletedAt, recordsDeleted: $recordsDeleted, recordsModified: $recordsModified, transactionsDeleted: $transactionsDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuditLogModelImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.partyName, partyName) ||
                other.partyName == partyName) &&
            const DeepCollectionEquality()
                .equals(other._partyDetails, _partyDetails) &&
            (identical(other.deletedBy, deletedBy) ||
                other.deletedBy == deletedBy) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.recordsDeleted, recordsDeleted) ||
                other.recordsDeleted == recordsDeleted) &&
            (identical(other.recordsModified, recordsModified) ||
                other.recordsModified == recordsModified) &&
            (identical(other.transactionsDeleted, transactionsDeleted) ||
                other.transactionsDeleted == transactionsDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      action,
      partyName,
      const DeepCollectionEquality().hash(_partyDetails),
      deletedBy,
      deletedAt,
      recordsDeleted,
      recordsModified,
      transactionsDeleted);

  /// Create a copy of AuditLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuditLogModelImplCopyWith<_$AuditLogModelImpl> get copyWith =>
      __$$AuditLogModelImplCopyWithImpl<_$AuditLogModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuditLogModelImplToJson(
      this,
    );
  }
}

abstract class _AuditLogModel implements AuditLogModel {
  const factory _AuditLogModel(
      {required final String action,
      @JsonKey(name: 'party_name') required final String partyName,
      @JsonKey(name: 'party_details')
      required final Map<String, dynamic> partyDetails,
      @JsonKey(name: 'deleted_by') required final String deletedBy,
      @JsonKey(name: 'deleted_at') required final String deletedAt,
      @JsonKey(name: 'records_deleted') required final int recordsDeleted,
      @JsonKey(name: 'records_modified') final int? recordsModified,
      @JsonKey(name: 'transactions_deleted')
      required final bool transactionsDeleted}) = _$AuditLogModelImpl;

  factory _AuditLogModel.fromJson(Map<String, dynamic> json) =
      _$AuditLogModelImpl.fromJson;

  @override
  String get action;
  @override
  @JsonKey(name: 'party_name')
  String get partyName;
  @override
  @JsonKey(name: 'party_details')
  Map<String, dynamic> get partyDetails;
  @override
  @JsonKey(name: 'deleted_by')
  String get deletedBy;
  @override
  @JsonKey(name: 'deleted_at')
  String get deletedAt;
  @override
  @JsonKey(name: 'records_deleted')
  int get recordsDeleted;
  @override
  @JsonKey(name: 'records_modified')
  int? get recordsModified;
  @override
  @JsonKey(name: 'transactions_deleted')
  bool get transactionsDeleted;

  /// Create a copy of AuditLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuditLogModelImplCopyWith<_$AuditLogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PartyDeleteResponseModel _$PartyDeleteResponseModelFromJson(
    Map<String, dynamic> json) {
  return _PartyDeleteResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PartyDeleteResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_records_deleted')
  int? get totalRecordsDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_records_modified')
  int? get totalRecordsModified => throw _privateConstructorUsedError;
  @JsonKey(name: 'deletion_summary')
  Map<String, dynamic>? get deletionSummary =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_party')
  PartyModel? get deletedParty => throw _privateConstructorUsedError;
  @JsonKey(name: 'audit_log')
  AuditLogModel? get auditLog => throw _privateConstructorUsedError;
  String? get warning => throw _privateConstructorUsedError;

  /// Serializes this PartyDeleteResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyDeleteResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyDeleteResponseModelCopyWith<PartyDeleteResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyDeleteResponseModelCopyWith<$Res> {
  factory $PartyDeleteResponseModelCopyWith(PartyDeleteResponseModel value,
          $Res Function(PartyDeleteResponseModel) then) =
      _$PartyDeleteResponseModelCopyWithImpl<$Res, PartyDeleteResponseModel>;
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'total_records_deleted') int? totalRecordsDeleted,
      @JsonKey(name: 'total_records_modified') int? totalRecordsModified,
      @JsonKey(name: 'deletion_summary') Map<String, dynamic>? deletionSummary,
      @JsonKey(name: 'deleted_party') PartyModel? deletedParty,
      @JsonKey(name: 'audit_log') AuditLogModel? auditLog,
      String? warning});

  $AuditLogModelCopyWith<$Res>? get auditLog;
}

/// @nodoc
class _$PartyDeleteResponseModelCopyWithImpl<$Res,
        $Val extends PartyDeleteResponseModel>
    implements $PartyDeleteResponseModelCopyWith<$Res> {
  _$PartyDeleteResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyDeleteResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? totalRecordsDeleted = freezed,
    Object? totalRecordsModified = freezed,
    Object? deletionSummary = freezed,
    Object? deletedParty = freezed,
    Object? auditLog = freezed,
    Object? warning = freezed,
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
      totalRecordsDeleted: freezed == totalRecordsDeleted
          ? _value.totalRecordsDeleted
          : totalRecordsDeleted // ignore: cast_nullable_to_non_nullable
              as int?,
      totalRecordsModified: freezed == totalRecordsModified
          ? _value.totalRecordsModified
          : totalRecordsModified // ignore: cast_nullable_to_non_nullable
              as int?,
      deletionSummary: freezed == deletionSummary
          ? _value.deletionSummary
          : deletionSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      deletedParty: freezed == deletedParty
          ? _value.deletedParty
          : deletedParty // ignore: cast_nullable_to_non_nullable
              as PartyModel?,
      auditLog: freezed == auditLog
          ? _value.auditLog
          : auditLog // ignore: cast_nullable_to_non_nullable
              as AuditLogModel?,
      warning: freezed == warning
          ? _value.warning
          : warning // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of PartyDeleteResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuditLogModelCopyWith<$Res>? get auditLog {
    if (_value.auditLog == null) {
      return null;
    }

    return $AuditLogModelCopyWith<$Res>(_value.auditLog!, (value) {
      return _then(_value.copyWith(auditLog: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PartyDeleteResponseModelImplCopyWith<$Res>
    implements $PartyDeleteResponseModelCopyWith<$Res> {
  factory _$$PartyDeleteResponseModelImplCopyWith(
          _$PartyDeleteResponseModelImpl value,
          $Res Function(_$PartyDeleteResponseModelImpl) then) =
      __$$PartyDeleteResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      @JsonKey(name: 'total_records_deleted') int? totalRecordsDeleted,
      @JsonKey(name: 'total_records_modified') int? totalRecordsModified,
      @JsonKey(name: 'deletion_summary') Map<String, dynamic>? deletionSummary,
      @JsonKey(name: 'deleted_party') PartyModel? deletedParty,
      @JsonKey(name: 'audit_log') AuditLogModel? auditLog,
      String? warning});

  @override
  $AuditLogModelCopyWith<$Res>? get auditLog;
}

/// @nodoc
class __$$PartyDeleteResponseModelImplCopyWithImpl<$Res>
    extends _$PartyDeleteResponseModelCopyWithImpl<$Res,
        _$PartyDeleteResponseModelImpl>
    implements _$$PartyDeleteResponseModelImplCopyWith<$Res> {
  __$$PartyDeleteResponseModelImplCopyWithImpl(
      _$PartyDeleteResponseModelImpl _value,
      $Res Function(_$PartyDeleteResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyDeleteResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? totalRecordsDeleted = freezed,
    Object? totalRecordsModified = freezed,
    Object? deletionSummary = freezed,
    Object? deletedParty = freezed,
    Object? auditLog = freezed,
    Object? warning = freezed,
  }) {
    return _then(_$PartyDeleteResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      totalRecordsDeleted: freezed == totalRecordsDeleted
          ? _value.totalRecordsDeleted
          : totalRecordsDeleted // ignore: cast_nullable_to_non_nullable
              as int?,
      totalRecordsModified: freezed == totalRecordsModified
          ? _value.totalRecordsModified
          : totalRecordsModified // ignore: cast_nullable_to_non_nullable
              as int?,
      deletionSummary: freezed == deletionSummary
          ? _value._deletionSummary
          : deletionSummary // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      deletedParty: freezed == deletedParty
          ? _value.deletedParty
          : deletedParty // ignore: cast_nullable_to_non_nullable
              as PartyModel?,
      auditLog: freezed == auditLog
          ? _value.auditLog
          : auditLog // ignore: cast_nullable_to_non_nullable
              as AuditLogModel?,
      warning: freezed == warning
          ? _value.warning
          : warning // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyDeleteResponseModelImpl implements _PartyDeleteResponseModel {
  const _$PartyDeleteResponseModelImpl(
      {required this.success,
      required this.message,
      @JsonKey(name: 'total_records_deleted') this.totalRecordsDeleted,
      @JsonKey(name: 'total_records_modified') this.totalRecordsModified,
      @JsonKey(name: 'deletion_summary')
      final Map<String, dynamic>? deletionSummary,
      @JsonKey(name: 'deleted_party') this.deletedParty,
      @JsonKey(name: 'audit_log') this.auditLog,
      this.warning})
      : _deletionSummary = deletionSummary;

  factory _$PartyDeleteResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartyDeleteResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  @JsonKey(name: 'total_records_deleted')
  final int? totalRecordsDeleted;
  @override
  @JsonKey(name: 'total_records_modified')
  final int? totalRecordsModified;
  final Map<String, dynamic>? _deletionSummary;
  @override
  @JsonKey(name: 'deletion_summary')
  Map<String, dynamic>? get deletionSummary {
    final value = _deletionSummary;
    if (value == null) return null;
    if (_deletionSummary is EqualUnmodifiableMapView) return _deletionSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'deleted_party')
  final PartyModel? deletedParty;
  @override
  @JsonKey(name: 'audit_log')
  final AuditLogModel? auditLog;
  @override
  final String? warning;

  @override
  String toString() {
    return 'PartyDeleteResponseModel(success: $success, message: $message, totalRecordsDeleted: $totalRecordsDeleted, totalRecordsModified: $totalRecordsModified, deletionSummary: $deletionSummary, deletedParty: $deletedParty, auditLog: $auditLog, warning: $warning)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyDeleteResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.totalRecordsDeleted, totalRecordsDeleted) ||
                other.totalRecordsDeleted == totalRecordsDeleted) &&
            (identical(other.totalRecordsModified, totalRecordsModified) ||
                other.totalRecordsModified == totalRecordsModified) &&
            const DeepCollectionEquality()
                .equals(other._deletionSummary, _deletionSummary) &&
            (identical(other.deletedParty, deletedParty) ||
                other.deletedParty == deletedParty) &&
            (identical(other.auditLog, auditLog) ||
                other.auditLog == auditLog) &&
            (identical(other.warning, warning) || other.warning == warning));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      message,
      totalRecordsDeleted,
      totalRecordsModified,
      const DeepCollectionEquality().hash(_deletionSummary),
      deletedParty,
      auditLog,
      warning);

  /// Create a copy of PartyDeleteResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyDeleteResponseModelImplCopyWith<_$PartyDeleteResponseModelImpl>
      get copyWith => __$$PartyDeleteResponseModelImplCopyWithImpl<
          _$PartyDeleteResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyDeleteResponseModelImplToJson(
      this,
    );
  }
}

abstract class _PartyDeleteResponseModel implements PartyDeleteResponseModel {
  const factory _PartyDeleteResponseModel(
      {required final bool success,
      required final String message,
      @JsonKey(name: 'total_records_deleted') final int? totalRecordsDeleted,
      @JsonKey(name: 'total_records_modified') final int? totalRecordsModified,
      @JsonKey(name: 'deletion_summary')
      final Map<String, dynamic>? deletionSummary,
      @JsonKey(name: 'deleted_party') final PartyModel? deletedParty,
      @JsonKey(name: 'audit_log') final AuditLogModel? auditLog,
      final String? warning}) = _$PartyDeleteResponseModelImpl;

  factory _PartyDeleteResponseModel.fromJson(Map<String, dynamic> json) =
      _$PartyDeleteResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  @JsonKey(name: 'total_records_deleted')
  int? get totalRecordsDeleted;
  @override
  @JsonKey(name: 'total_records_modified')
  int? get totalRecordsModified;
  @override
  @JsonKey(name: 'deletion_summary')
  Map<String, dynamic>? get deletionSummary;
  @override
  @JsonKey(name: 'deleted_party')
  PartyModel? get deletedParty;
  @override
  @JsonKey(name: 'audit_log')
  AuditLogModel? get auditLog;
  @override
  String? get warning;

  /// Create a copy of PartyDeleteResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyDeleteResponseModelImplCopyWith<_$PartyDeleteResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
