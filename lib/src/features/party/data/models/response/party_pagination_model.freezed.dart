// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_pagination_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartyPaginationModel _$PartyPaginationModelFromJson(Map<String, dynamic> json) {
  return _PartyPaginationModel.fromJson(json);
}

/// @nodoc
mixin _$PartyPaginationModel {
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int get totalPages => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_rows')
  int get totalRows => throw _privateConstructorUsedError;

  /// Serializes this PartyPaginationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyPaginationModelCopyWith<PartyPaginationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyPaginationModelCopyWith<$Res> {
  factory $PartyPaginationModelCopyWith(PartyPaginationModel value,
          $Res Function(PartyPaginationModel) then) =
      _$PartyPaginationModelCopyWithImpl<$Res, PartyPaginationModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int currentPage,
      @JsonKey(name: 'per_page') int perPage,
      @JsonKey(name: 'total_pages') int totalPages,
      @JsonKey(name: 'total_rows') int totalRows});
}

/// @nodoc
class _$PartyPaginationModelCopyWithImpl<$Res,
        $Val extends PartyPaginationModel>
    implements $PartyPaginationModelCopyWith<$Res> {
  _$PartyPaginationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? perPage = null,
    Object? totalPages = null,
    Object? totalRows = null,
  }) {
    return _then(_value.copyWith(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalRows: null == totalRows
          ? _value.totalRows
          : totalRows // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartyPaginationModelImplCopyWith<$Res>
    implements $PartyPaginationModelCopyWith<$Res> {
  factory _$$PartyPaginationModelImplCopyWith(_$PartyPaginationModelImpl value,
          $Res Function(_$PartyPaginationModelImpl) then) =
      __$$PartyPaginationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int currentPage,
      @JsonKey(name: 'per_page') int perPage,
      @JsonKey(name: 'total_pages') int totalPages,
      @JsonKey(name: 'total_rows') int totalRows});
}

/// @nodoc
class __$$PartyPaginationModelImplCopyWithImpl<$Res>
    extends _$PartyPaginationModelCopyWithImpl<$Res, _$PartyPaginationModelImpl>
    implements _$$PartyPaginationModelImplCopyWith<$Res> {
  __$$PartyPaginationModelImplCopyWithImpl(_$PartyPaginationModelImpl _value,
      $Res Function(_$PartyPaginationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? perPage = null,
    Object? totalPages = null,
    Object? totalRows = null,
  }) {
    return _then(_$PartyPaginationModelImpl(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalRows: null == totalRows
          ? _value.totalRows
          : totalRows // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyPaginationModelImpl implements _PartyPaginationModel {
  const _$PartyPaginationModelImpl(
      {@JsonKey(name: 'current_page') required this.currentPage,
      @JsonKey(name: 'per_page') required this.perPage,
      @JsonKey(name: 'total_pages') required this.totalPages,
      @JsonKey(name: 'total_rows') required this.totalRows});

  factory _$PartyPaginationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartyPaginationModelImplFromJson(json);

  @override
  @JsonKey(name: 'current_page')
  final int currentPage;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;
  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @override
  @JsonKey(name: 'total_rows')
  final int totalRows;

  @override
  String toString() {
    return 'PartyPaginationModel(currentPage: $currentPage, perPage: $perPage, totalPages: $totalPages, totalRows: $totalRows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyPaginationModelImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalRows, totalRows) ||
                other.totalRows == totalRows));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentPage, perPage, totalPages, totalRows);

  /// Create a copy of PartyPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyPaginationModelImplCopyWith<_$PartyPaginationModelImpl>
      get copyWith =>
          __$$PartyPaginationModelImplCopyWithImpl<_$PartyPaginationModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyPaginationModelImplToJson(
      this,
    );
  }
}

abstract class _PartyPaginationModel implements PartyPaginationModel {
  const factory _PartyPaginationModel(
          {@JsonKey(name: 'current_page') required final int currentPage,
          @JsonKey(name: 'per_page') required final int perPage,
          @JsonKey(name: 'total_pages') required final int totalPages,
          @JsonKey(name: 'total_rows') required final int totalRows}) =
      _$PartyPaginationModelImpl;

  factory _PartyPaginationModel.fromJson(Map<String, dynamic> json) =
      _$PartyPaginationModelImpl.fromJson;

  @override
  @JsonKey(name: 'current_page')
  int get currentPage;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;
  @override
  @JsonKey(name: 'total_pages')
  int get totalPages;
  @override
  @JsonKey(name: 'total_rows')
  int get totalRows;

  /// Create a copy of PartyPaginationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyPaginationModelImplCopyWith<_$PartyPaginationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
