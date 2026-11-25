// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) {
  return _ContactModel.fromJson(json);
}

/// @nodoc
mixin _$ContactModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_favorite')
  bool get isFavorite => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_url')
  String? get photoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'modified_at')
  String? get modifiedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'modified_by')
  String? get modifiedBy => throw _privateConstructorUsedError;

  /// Serializes this ContactModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactModelCopyWith<ContactModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactModelCopyWith<$Res> {
  factory $ContactModelCopyWith(
          ContactModel value, $Res Function(ContactModel) then) =
      _$ContactModelCopyWithImpl<$Res, ContactModel>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? phone,
      String? email,
      String? address,
      String? category,
      String? company,
      String? notes,
      @JsonKey(name: 'is_favorite') bool isFavorite,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'modified_at') String? modifiedAt,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'modified_by') String? modifiedBy});
}

/// @nodoc
class _$ContactModelCopyWithImpl<$Res, $Val extends ContactModel>
    implements $ContactModelCopyWith<$Res> {
  _$ContactModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = freezed,
    Object? category = freezed,
    Object? company = freezed,
    Object? notes = freezed,
    Object? isFavorite = null,
    Object? photoUrl = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
    Object? createdBy = freezed,
    Object? modifiedBy = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactModelImplCopyWith<$Res>
    implements $ContactModelCopyWith<$Res> {
  factory _$$ContactModelImplCopyWith(
          _$ContactModelImpl value, $Res Function(_$ContactModelImpl) then) =
      __$$ContactModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? phone,
      String? email,
      String? address,
      String? category,
      String? company,
      String? notes,
      @JsonKey(name: 'is_favorite') bool isFavorite,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'modified_at') String? modifiedAt,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'modified_by') String? modifiedBy});
}

/// @nodoc
class __$$ContactModelImplCopyWithImpl<$Res>
    extends _$ContactModelCopyWithImpl<$Res, _$ContactModelImpl>
    implements _$$ContactModelImplCopyWith<$Res> {
  __$$ContactModelImplCopyWithImpl(
      _$ContactModelImpl _value, $Res Function(_$ContactModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = freezed,
    Object? category = freezed,
    Object? company = freezed,
    Object? notes = freezed,
    Object? isFavorite = null,
    Object? photoUrl = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
    Object? createdBy = freezed,
    Object? modifiedBy = freezed,
  }) {
    return _then(_$ContactModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedBy: freezed == modifiedBy
          ? _value.modifiedBy
          : modifiedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactModelImpl implements _ContactModel {
  const _$ContactModelImpl(
      {required this.id,
      required this.name,
      this.phone,
      this.email,
      this.address,
      this.category,
      this.company,
      this.notes,
      @JsonKey(name: 'is_favorite') this.isFavorite = false,
      @JsonKey(name: 'photo_url') this.photoUrl,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'modified_at') this.modifiedAt,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'modified_by') this.modifiedBy});

  factory _$ContactModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? address;
  @override
  final String? category;
  @override
  final String? company;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'is_favorite')
  final bool isFavorite;
  @override
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'modified_at')
  final String? modifiedAt;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'modified_by')
  final String? modifiedBy;

  @override
  String toString() {
    return 'ContactModel(id: $id, name: $name, phone: $phone, email: $email, address: $address, category: $category, company: $company, notes: $notes, isFavorite: $isFavorite, photoUrl: $photoUrl, createdAt: $createdAt, modifiedAt: $modifiedAt, createdBy: $createdBy, modifiedBy: $modifiedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.modifiedBy, modifiedBy) ||
                other.modifiedBy == modifiedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      phone,
      email,
      address,
      category,
      company,
      notes,
      isFavorite,
      photoUrl,
      createdAt,
      modifiedAt,
      createdBy,
      modifiedBy);

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactModelImplCopyWith<_$ContactModelImpl> get copyWith =>
      __$$ContactModelImplCopyWithImpl<_$ContactModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactModelImplToJson(
      this,
    );
  }
}

abstract class _ContactModel implements ContactModel {
  const factory _ContactModel(
          {required final int? id,
          required final String? name,
          final String? phone,
          final String? email,
          final String? address,
          final String? category,
          final String? company,
          final String? notes,
          @JsonKey(name: 'is_favorite') final bool isFavorite,
          @JsonKey(name: 'photo_url') final String? photoUrl,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'modified_at') final String? modifiedAt,
          @JsonKey(name: 'created_by') final String? createdBy,
          @JsonKey(name: 'modified_by') final String? modifiedBy}) =
      _$ContactModelImpl;

  factory _ContactModel.fromJson(Map<String, dynamic> json) =
      _$ContactModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String? get address;
  @override
  String? get category;
  @override
  String? get company;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'is_favorite')
  bool get isFavorite;
  @override
  @JsonKey(name: 'photo_url')
  String? get photoUrl;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'modified_at')
  String? get modifiedAt;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'modified_by')
  String? get modifiedBy;

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactModelImplCopyWith<_$ContactModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContactListResponse _$ContactListResponseFromJson(Map<String, dynamic> json) {
  return _ContactListResponse.fromJson(json);
}

/// @nodoc
mixin _$ContactListResponse {
  bool get success => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'filters_applied')
  Map<String, dynamic>? get filtersApplied =>
      throw _privateConstructorUsedError;
  List<ContactModel> get contacts => throw _privateConstructorUsedError;

  /// Serializes this ContactListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContactListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactListResponseCopyWith<ContactListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactListResponseCopyWith<$Res> {
  factory $ContactListResponseCopyWith(
          ContactListResponse value, $Res Function(ContactListResponse) then) =
      _$ContactListResponseCopyWithImpl<$Res, ContactListResponse>;
  @useResult
  $Res call(
      {bool success,
      int count,
      @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
      List<ContactModel> contacts});
}

/// @nodoc
class _$ContactListResponseCopyWithImpl<$Res, $Val extends ContactListResponse>
    implements $ContactListResponseCopyWith<$Res> {
  _$ContactListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? filtersApplied = freezed,
    Object? contacts = null,
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
      filtersApplied: freezed == filtersApplied
          ? _value.filtersApplied
          : filtersApplied // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      contacts: null == contacts
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<ContactModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactListResponseImplCopyWith<$Res>
    implements $ContactListResponseCopyWith<$Res> {
  factory _$$ContactListResponseImplCopyWith(_$ContactListResponseImpl value,
          $Res Function(_$ContactListResponseImpl) then) =
      __$$ContactListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      int count,
      @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
      List<ContactModel> contacts});
}

/// @nodoc
class __$$ContactListResponseImplCopyWithImpl<$Res>
    extends _$ContactListResponseCopyWithImpl<$Res, _$ContactListResponseImpl>
    implements _$$ContactListResponseImplCopyWith<$Res> {
  __$$ContactListResponseImplCopyWithImpl(_$ContactListResponseImpl _value,
      $Res Function(_$ContactListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? filtersApplied = freezed,
    Object? contacts = null,
  }) {
    return _then(_$ContactListResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      filtersApplied: freezed == filtersApplied
          ? _value._filtersApplied
          : filtersApplied // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      contacts: null == contacts
          ? _value._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<ContactModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactListResponseImpl implements _ContactListResponse {
  const _$ContactListResponseImpl(
      {required this.success,
      required this.count,
      @JsonKey(name: 'filters_applied')
      final Map<String, dynamic>? filtersApplied,
      required final List<ContactModel> contacts})
      : _filtersApplied = filtersApplied,
        _contacts = contacts;

  factory _$ContactListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactListResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final int count;
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

  final List<ContactModel> _contacts;
  @override
  List<ContactModel> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  @override
  String toString() {
    return 'ContactListResponse(success: $success, count: $count, filtersApplied: $filtersApplied, contacts: $contacts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactListResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality()
                .equals(other._filtersApplied, _filtersApplied) &&
            const DeepCollectionEquality().equals(other._contacts, _contacts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      count,
      const DeepCollectionEquality().hash(_filtersApplied),
      const DeepCollectionEquality().hash(_contacts));

  /// Create a copy of ContactListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactListResponseImplCopyWith<_$ContactListResponseImpl> get copyWith =>
      __$$ContactListResponseImplCopyWithImpl<_$ContactListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactListResponseImplToJson(
      this,
    );
  }
}

abstract class _ContactListResponse implements ContactListResponse {
  const factory _ContactListResponse(
      {required final bool success,
      required final int count,
      @JsonKey(name: 'filters_applied')
      final Map<String, dynamic>? filtersApplied,
      required final List<ContactModel> contacts}) = _$ContactListResponseImpl;

  factory _ContactListResponse.fromJson(Map<String, dynamic> json) =
      _$ContactListResponseImpl.fromJson;

  @override
  bool get success;
  @override
  int get count;
  @override
  @JsonKey(name: 'filters_applied')
  Map<String, dynamic>? get filtersApplied;
  @override
  List<ContactModel> get contacts;

  /// Create a copy of ContactListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactListResponseImplCopyWith<_$ContactListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContactSingleResponse _$ContactSingleResponseFromJson(
    Map<String, dynamic> json) {
  return _ContactSingleResponse.fromJson(json);
}

/// @nodoc
mixin _$ContactSingleResponse {
  bool get success => throw _privateConstructorUsedError;
  ContactModel get contact => throw _privateConstructorUsedError;

  /// Serializes this ContactSingleResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContactSingleResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactSingleResponseCopyWith<ContactSingleResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactSingleResponseCopyWith<$Res> {
  factory $ContactSingleResponseCopyWith(ContactSingleResponse value,
          $Res Function(ContactSingleResponse) then) =
      _$ContactSingleResponseCopyWithImpl<$Res, ContactSingleResponse>;
  @useResult
  $Res call({bool success, ContactModel contact});

  $ContactModelCopyWith<$Res> get contact;
}

/// @nodoc
class _$ContactSingleResponseCopyWithImpl<$Res,
        $Val extends ContactSingleResponse>
    implements $ContactSingleResponseCopyWith<$Res> {
  _$ContactSingleResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactSingleResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? contact = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      contact: null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as ContactModel,
    ) as $Val);
  }

  /// Create a copy of ContactSingleResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContactModelCopyWith<$Res> get contact {
    return $ContactModelCopyWith<$Res>(_value.contact, (value) {
      return _then(_value.copyWith(contact: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ContactSingleResponseImplCopyWith<$Res>
    implements $ContactSingleResponseCopyWith<$Res> {
  factory _$$ContactSingleResponseImplCopyWith(
          _$ContactSingleResponseImpl value,
          $Res Function(_$ContactSingleResponseImpl) then) =
      __$$ContactSingleResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, ContactModel contact});

  @override
  $ContactModelCopyWith<$Res> get contact;
}

/// @nodoc
class __$$ContactSingleResponseImplCopyWithImpl<$Res>
    extends _$ContactSingleResponseCopyWithImpl<$Res,
        _$ContactSingleResponseImpl>
    implements _$$ContactSingleResponseImplCopyWith<$Res> {
  __$$ContactSingleResponseImplCopyWithImpl(_$ContactSingleResponseImpl _value,
      $Res Function(_$ContactSingleResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactSingleResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? contact = null,
  }) {
    return _then(_$ContactSingleResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      contact: null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as ContactModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactSingleResponseImpl implements _ContactSingleResponse {
  const _$ContactSingleResponseImpl(
      {required this.success, required this.contact});

  factory _$ContactSingleResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactSingleResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final ContactModel contact;

  @override
  String toString() {
    return 'ContactSingleResponse(success: $success, contact: $contact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactSingleResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.contact, contact) || other.contact == contact));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, contact);

  /// Create a copy of ContactSingleResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactSingleResponseImplCopyWith<_$ContactSingleResponseImpl>
      get copyWith => __$$ContactSingleResponseImplCopyWithImpl<
          _$ContactSingleResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactSingleResponseImplToJson(
      this,
    );
  }
}

abstract class _ContactSingleResponse implements ContactSingleResponse {
  const factory _ContactSingleResponse(
      {required final bool success,
      required final ContactModel contact}) = _$ContactSingleResponseImpl;

  factory _ContactSingleResponse.fromJson(Map<String, dynamic> json) =
      _$ContactSingleResponseImpl.fromJson;

  @override
  bool get success;
  @override
  ContactModel get contact;

  /// Create a copy of ContactSingleResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactSingleResponseImplCopyWith<_$ContactSingleResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CreateContactResponse _$CreateContactResponseFromJson(
    Map<String, dynamic> json) {
  return _CreateContactResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateContactResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  ContactModel get contact => throw _privateConstructorUsedError;

  /// Serializes this CreateContactResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateContactResponseCopyWith<CreateContactResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateContactResponseCopyWith<$Res> {
  factory $CreateContactResponseCopyWith(CreateContactResponse value,
          $Res Function(CreateContactResponse) then) =
      _$CreateContactResponseCopyWithImpl<$Res, CreateContactResponse>;
  @useResult
  $Res call({bool success, String? message, ContactModel contact});

  $ContactModelCopyWith<$Res> get contact;
}

/// @nodoc
class _$CreateContactResponseCopyWithImpl<$Res,
        $Val extends CreateContactResponse>
    implements $CreateContactResponseCopyWith<$Res> {
  _$CreateContactResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? contact = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      contact: null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as ContactModel,
    ) as $Val);
  }

  /// Create a copy of CreateContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContactModelCopyWith<$Res> get contact {
    return $ContactModelCopyWith<$Res>(_value.contact, (value) {
      return _then(_value.copyWith(contact: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateContactResponseImplCopyWith<$Res>
    implements $CreateContactResponseCopyWith<$Res> {
  factory _$$CreateContactResponseImplCopyWith(
          _$CreateContactResponseImpl value,
          $Res Function(_$CreateContactResponseImpl) then) =
      __$$CreateContactResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String? message, ContactModel contact});

  @override
  $ContactModelCopyWith<$Res> get contact;
}

/// @nodoc
class __$$CreateContactResponseImplCopyWithImpl<$Res>
    extends _$CreateContactResponseCopyWithImpl<$Res,
        _$CreateContactResponseImpl>
    implements _$$CreateContactResponseImplCopyWith<$Res> {
  __$$CreateContactResponseImplCopyWithImpl(_$CreateContactResponseImpl _value,
      $Res Function(_$CreateContactResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? contact = null,
  }) {
    return _then(_$CreateContactResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      contact: null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as ContactModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateContactResponseImpl implements _CreateContactResponse {
  const _$CreateContactResponseImpl(
      {required this.success, this.message, required this.contact});

  factory _$CreateContactResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateContactResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String? message;
  @override
  final ContactModel contact;

  @override
  String toString() {
    return 'CreateContactResponse(success: $success, message: $message, contact: $contact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateContactResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.contact, contact) || other.contact == contact));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, contact);

  /// Create a copy of CreateContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateContactResponseImplCopyWith<_$CreateContactResponseImpl>
      get copyWith => __$$CreateContactResponseImplCopyWithImpl<
          _$CreateContactResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateContactResponseImplToJson(
      this,
    );
  }
}

abstract class _CreateContactResponse implements CreateContactResponse {
  const factory _CreateContactResponse(
      {required final bool success,
      final String? message,
      required final ContactModel contact}) = _$CreateContactResponseImpl;

  factory _CreateContactResponse.fromJson(Map<String, dynamic> json) =
      _$CreateContactResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  ContactModel get contact;

  /// Create a copy of CreateContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateContactResponseImplCopyWith<_$CreateContactResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UpdateContactResponse _$UpdateContactResponseFromJson(
    Map<String, dynamic> json) {
  return _UpdateContactResponse.fromJson(json);
}

/// @nodoc
mixin _$UpdateContactResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_id')
  int get contactId => throw _privateConstructorUsedError;

  /// Serializes this UpdateContactResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateContactResponseCopyWith<UpdateContactResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateContactResponseCopyWith<$Res> {
  factory $UpdateContactResponseCopyWith(UpdateContactResponse value,
          $Res Function(UpdateContactResponse) then) =
      _$UpdateContactResponseCopyWithImpl<$Res, UpdateContactResponse>;
  @useResult
  $Res call(
      {bool success,
      String? message,
      @JsonKey(name: 'contact_id') int contactId});
}

/// @nodoc
class _$UpdateContactResponseCopyWithImpl<$Res,
        $Val extends UpdateContactResponse>
    implements $UpdateContactResponseCopyWith<$Res> {
  _$UpdateContactResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? contactId = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      contactId: null == contactId
          ? _value.contactId
          : contactId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateContactResponseImplCopyWith<$Res>
    implements $UpdateContactResponseCopyWith<$Res> {
  factory _$$UpdateContactResponseImplCopyWith(
          _$UpdateContactResponseImpl value,
          $Res Function(_$UpdateContactResponseImpl) then) =
      __$$UpdateContactResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String? message,
      @JsonKey(name: 'contact_id') int contactId});
}

/// @nodoc
class __$$UpdateContactResponseImplCopyWithImpl<$Res>
    extends _$UpdateContactResponseCopyWithImpl<$Res,
        _$UpdateContactResponseImpl>
    implements _$$UpdateContactResponseImplCopyWith<$Res> {
  __$$UpdateContactResponseImplCopyWithImpl(_$UpdateContactResponseImpl _value,
      $Res Function(_$UpdateContactResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? contactId = null,
  }) {
    return _then(_$UpdateContactResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      contactId: null == contactId
          ? _value.contactId
          : contactId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateContactResponseImpl implements _UpdateContactResponse {
  const _$UpdateContactResponseImpl(
      {required this.success,
      this.message,
      @JsonKey(name: 'contact_id') required this.contactId});

  factory _$UpdateContactResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateContactResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String? message;
  @override
  @JsonKey(name: 'contact_id')
  final int contactId;

  @override
  String toString() {
    return 'UpdateContactResponse(success: $success, message: $message, contactId: $contactId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateContactResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, contactId);

  /// Create a copy of UpdateContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateContactResponseImplCopyWith<_$UpdateContactResponseImpl>
      get copyWith => __$$UpdateContactResponseImplCopyWithImpl<
          _$UpdateContactResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateContactResponseImplToJson(
      this,
    );
  }
}

abstract class _UpdateContactResponse implements UpdateContactResponse {
  const factory _UpdateContactResponse(
          {required final bool success,
          final String? message,
          @JsonKey(name: 'contact_id') required final int contactId}) =
      _$UpdateContactResponseImpl;

  factory _UpdateContactResponse.fromJson(Map<String, dynamic> json) =
      _$UpdateContactResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  @JsonKey(name: 'contact_id')
  int get contactId;

  /// Create a copy of UpdateContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateContactResponseImplCopyWith<_$UpdateContactResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DeleteContactResponse _$DeleteContactResponseFromJson(
    Map<String, dynamic> json) {
  return _DeleteContactResponse.fromJson(json);
}

/// @nodoc
mixin _$DeleteContactResponse {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_contact')
  ContactModel? get deletedContact => throw _privateConstructorUsedError;

  /// Serializes this DeleteContactResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeleteContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeleteContactResponseCopyWith<DeleteContactResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteContactResponseCopyWith<$Res> {
  factory $DeleteContactResponseCopyWith(DeleteContactResponse value,
          $Res Function(DeleteContactResponse) then) =
      _$DeleteContactResponseCopyWithImpl<$Res, DeleteContactResponse>;
  @useResult
  $Res call(
      {bool success,
      String? message,
      @JsonKey(name: 'deleted_contact') ContactModel? deletedContact});

  $ContactModelCopyWith<$Res>? get deletedContact;
}

/// @nodoc
class _$DeleteContactResponseCopyWithImpl<$Res,
        $Val extends DeleteContactResponse>
    implements $DeleteContactResponseCopyWith<$Res> {
  _$DeleteContactResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeleteContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? deletedContact = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      deletedContact: freezed == deletedContact
          ? _value.deletedContact
          : deletedContact // ignore: cast_nullable_to_non_nullable
              as ContactModel?,
    ) as $Val);
  }

  /// Create a copy of DeleteContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContactModelCopyWith<$Res>? get deletedContact {
    if (_value.deletedContact == null) {
      return null;
    }

    return $ContactModelCopyWith<$Res>(_value.deletedContact!, (value) {
      return _then(_value.copyWith(deletedContact: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DeleteContactResponseImplCopyWith<$Res>
    implements $DeleteContactResponseCopyWith<$Res> {
  factory _$$DeleteContactResponseImplCopyWith(
          _$DeleteContactResponseImpl value,
          $Res Function(_$DeleteContactResponseImpl) then) =
      __$$DeleteContactResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String? message,
      @JsonKey(name: 'deleted_contact') ContactModel? deletedContact});

  @override
  $ContactModelCopyWith<$Res>? get deletedContact;
}

/// @nodoc
class __$$DeleteContactResponseImplCopyWithImpl<$Res>
    extends _$DeleteContactResponseCopyWithImpl<$Res,
        _$DeleteContactResponseImpl>
    implements _$$DeleteContactResponseImplCopyWith<$Res> {
  __$$DeleteContactResponseImplCopyWithImpl(_$DeleteContactResponseImpl _value,
      $Res Function(_$DeleteContactResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeleteContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? deletedContact = freezed,
  }) {
    return _then(_$DeleteContactResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      deletedContact: freezed == deletedContact
          ? _value.deletedContact
          : deletedContact // ignore: cast_nullable_to_non_nullable
              as ContactModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteContactResponseImpl implements _DeleteContactResponse {
  const _$DeleteContactResponseImpl(
      {required this.success,
      this.message,
      @JsonKey(name: 'deleted_contact') this.deletedContact});

  factory _$DeleteContactResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeleteContactResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String? message;
  @override
  @JsonKey(name: 'deleted_contact')
  final ContactModel? deletedContact;

  @override
  String toString() {
    return 'DeleteContactResponse(success: $success, message: $message, deletedContact: $deletedContact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteContactResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.deletedContact, deletedContact) ||
                other.deletedContact == deletedContact));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, message, deletedContact);

  /// Create a copy of DeleteContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteContactResponseImplCopyWith<_$DeleteContactResponseImpl>
      get copyWith => __$$DeleteContactResponseImplCopyWithImpl<
          _$DeleteContactResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteContactResponseImplToJson(
      this,
    );
  }
}

abstract class _DeleteContactResponse implements DeleteContactResponse {
  const factory _DeleteContactResponse(
      {required final bool success,
      final String? message,
      @JsonKey(name: 'deleted_contact')
      final ContactModel? deletedContact}) = _$DeleteContactResponseImpl;

  factory _DeleteContactResponse.fromJson(Map<String, dynamic> json) =
      _$DeleteContactResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  @JsonKey(name: 'deleted_contact')
  ContactModel? get deletedContact;

  /// Create a copy of DeleteContactResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteContactResponseImplCopyWith<_$DeleteContactResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
