// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_party_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeletePartyRequest _$DeletePartyRequestFromJson(Map<String, dynamic> json) {
  return _DeletePartyRequest.fromJson(json);
}

/// @nodoc
mixin _$DeletePartyRequest {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'confirm_delete')
  bool? get confirmDelete => throw _privateConstructorUsedError;
  @JsonKey(name: 'force_delete')
  bool? get forceDelete => throw _privateConstructorUsedError;
  @JsonKey(name: 'delete_transactions')
  bool? get deleteTransactions => throw _privateConstructorUsedError;
  String? get deletedBy => throw _privateConstructorUsedError;

  /// Serializes this DeletePartyRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeletePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeletePartyRequestCopyWith<DeletePartyRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletePartyRequestCopyWith<$Res> {
  factory $DeletePartyRequestCopyWith(
          DeletePartyRequest value, $Res Function(DeletePartyRequest) then) =
      _$DeletePartyRequestCopyWithImpl<$Res, DeletePartyRequest>;
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'confirm_delete') bool? confirmDelete,
      @JsonKey(name: 'force_delete') bool? forceDelete,
      @JsonKey(name: 'delete_transactions') bool? deleteTransactions,
      String? deletedBy});
}

/// @nodoc
class _$DeletePartyRequestCopyWithImpl<$Res, $Val extends DeletePartyRequest>
    implements $DeletePartyRequestCopyWith<$Res> {
  _$DeletePartyRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeletePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? confirmDelete = freezed,
    Object? forceDelete = freezed,
    Object? deleteTransactions = freezed,
    Object? deletedBy = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      confirmDelete: freezed == confirmDelete
          ? _value.confirmDelete
          : confirmDelete // ignore: cast_nullable_to_non_nullable
              as bool?,
      forceDelete: freezed == forceDelete
          ? _value.forceDelete
          : forceDelete // ignore: cast_nullable_to_non_nullable
              as bool?,
      deleteTransactions: freezed == deleteTransactions
          ? _value.deleteTransactions
          : deleteTransactions // ignore: cast_nullable_to_non_nullable
              as bool?,
      deletedBy: freezed == deletedBy
          ? _value.deletedBy
          : deletedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeletePartyRequestImplCopyWith<$Res>
    implements $DeletePartyRequestCopyWith<$Res> {
  factory _$$DeletePartyRequestImplCopyWith(_$DeletePartyRequestImpl value,
          $Res Function(_$DeletePartyRequestImpl) then) =
      __$$DeletePartyRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'confirm_delete') bool? confirmDelete,
      @JsonKey(name: 'force_delete') bool? forceDelete,
      @JsonKey(name: 'delete_transactions') bool? deleteTransactions,
      String? deletedBy});
}

/// @nodoc
class __$$DeletePartyRequestImplCopyWithImpl<$Res>
    extends _$DeletePartyRequestCopyWithImpl<$Res, _$DeletePartyRequestImpl>
    implements _$$DeletePartyRequestImplCopyWith<$Res> {
  __$$DeletePartyRequestImplCopyWithImpl(_$DeletePartyRequestImpl _value,
      $Res Function(_$DeletePartyRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeletePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? confirmDelete = freezed,
    Object? forceDelete = freezed,
    Object? deleteTransactions = freezed,
    Object? deletedBy = freezed,
  }) {
    return _then(_$DeletePartyRequestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      confirmDelete: freezed == confirmDelete
          ? _value.confirmDelete
          : confirmDelete // ignore: cast_nullable_to_non_nullable
              as bool?,
      forceDelete: freezed == forceDelete
          ? _value.forceDelete
          : forceDelete // ignore: cast_nullable_to_non_nullable
              as bool?,
      deleteTransactions: freezed == deleteTransactions
          ? _value.deleteTransactions
          : deleteTransactions // ignore: cast_nullable_to_non_nullable
              as bool?,
      deletedBy: freezed == deletedBy
          ? _value.deletedBy
          : deletedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeletePartyRequestImpl implements _DeletePartyRequest {
  const _$DeletePartyRequestImpl(
      {required this.name,
      @JsonKey(name: 'confirm_delete') this.confirmDelete,
      @JsonKey(name: 'force_delete') this.forceDelete,
      @JsonKey(name: 'delete_transactions') this.deleteTransactions,
      this.deletedBy});

  factory _$DeletePartyRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeletePartyRequestImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'confirm_delete')
  final bool? confirmDelete;
  @override
  @JsonKey(name: 'force_delete')
  final bool? forceDelete;
  @override
  @JsonKey(name: 'delete_transactions')
  final bool? deleteTransactions;
  @override
  final String? deletedBy;

  @override
  String toString() {
    return 'DeletePartyRequest(name: $name, confirmDelete: $confirmDelete, forceDelete: $forceDelete, deleteTransactions: $deleteTransactions, deletedBy: $deletedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletePartyRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.confirmDelete, confirmDelete) ||
                other.confirmDelete == confirmDelete) &&
            (identical(other.forceDelete, forceDelete) ||
                other.forceDelete == forceDelete) &&
            (identical(other.deleteTransactions, deleteTransactions) ||
                other.deleteTransactions == deleteTransactions) &&
            (identical(other.deletedBy, deletedBy) ||
                other.deletedBy == deletedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, confirmDelete, forceDelete,
      deleteTransactions, deletedBy);

  /// Create a copy of DeletePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletePartyRequestImplCopyWith<_$DeletePartyRequestImpl> get copyWith =>
      __$$DeletePartyRequestImplCopyWithImpl<_$DeletePartyRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeletePartyRequestImplToJson(
      this,
    );
  }
}

abstract class _DeletePartyRequest implements DeletePartyRequest {
  const factory _DeletePartyRequest(
      {required final String name,
      @JsonKey(name: 'confirm_delete') final bool? confirmDelete,
      @JsonKey(name: 'force_delete') final bool? forceDelete,
      @JsonKey(name: 'delete_transactions') final bool? deleteTransactions,
      final String? deletedBy}) = _$DeletePartyRequestImpl;

  factory _DeletePartyRequest.fromJson(Map<String, dynamic> json) =
      _$DeletePartyRequestImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'confirm_delete')
  bool? get confirmDelete;
  @override
  @JsonKey(name: 'force_delete')
  bool? get forceDelete;
  @override
  @JsonKey(name: 'delete_transactions')
  bool? get deleteTransactions;
  @override
  String? get deletedBy;

  /// Create a copy of DeletePartyRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeletePartyRequestImplCopyWith<_$DeletePartyRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
