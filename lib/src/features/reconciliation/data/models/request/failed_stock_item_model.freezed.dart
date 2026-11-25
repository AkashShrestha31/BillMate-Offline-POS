// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failed_stock_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FailedStockItemModel _$FailedStockItemModelFromJson(Map<String, dynamic> json) {
  return _FailedStockItemModel.fromJson(json);
}

/// @nodoc
mixin _$FailedStockItemModel {
  String get name => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  /// Serializes this FailedStockItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FailedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FailedStockItemModelCopyWith<FailedStockItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailedStockItemModelCopyWith<$Res> {
  factory $FailedStockItemModelCopyWith(FailedStockItemModel value,
          $Res Function(FailedStockItemModel) then) =
      _$FailedStockItemModelCopyWithImpl<$Res, FailedStockItemModel>;
  @useResult
  $Res call({String name, String error});
}

/// @nodoc
class _$FailedStockItemModelCopyWithImpl<$Res,
        $Val extends FailedStockItemModel>
    implements $FailedStockItemModelCopyWith<$Res> {
  _$FailedStockItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FailedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FailedStockItemModelImplCopyWith<$Res>
    implements $FailedStockItemModelCopyWith<$Res> {
  factory _$$FailedStockItemModelImplCopyWith(_$FailedStockItemModelImpl value,
          $Res Function(_$FailedStockItemModelImpl) then) =
      __$$FailedStockItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String error});
}

/// @nodoc
class __$$FailedStockItemModelImplCopyWithImpl<$Res>
    extends _$FailedStockItemModelCopyWithImpl<$Res, _$FailedStockItemModelImpl>
    implements _$$FailedStockItemModelImplCopyWith<$Res> {
  __$$FailedStockItemModelImplCopyWithImpl(_$FailedStockItemModelImpl _value,
      $Res Function(_$FailedStockItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FailedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? error = null,
  }) {
    return _then(_$FailedStockItemModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FailedStockItemModelImpl implements _FailedStockItemModel {
  const _$FailedStockItemModelImpl({required this.name, required this.error});

  factory _$FailedStockItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FailedStockItemModelImplFromJson(json);

  @override
  final String name;
  @override
  final String error;

  @override
  String toString() {
    return 'FailedStockItemModel(name: $name, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedStockItemModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, error);

  /// Create a copy of FailedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedStockItemModelImplCopyWith<_$FailedStockItemModelImpl>
      get copyWith =>
          __$$FailedStockItemModelImplCopyWithImpl<_$FailedStockItemModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FailedStockItemModelImplToJson(
      this,
    );
  }
}

abstract class _FailedStockItemModel implements FailedStockItemModel {
  const factory _FailedStockItemModel(
      {required final String name,
      required final String error}) = _$FailedStockItemModelImpl;

  factory _FailedStockItemModel.fromJson(Map<String, dynamic> json) =
      _$FailedStockItemModelImpl.fromJson;

  @override
  String get name;
  @override
  String get error;

  /// Create a copy of FailedStockItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailedStockItemModelImplCopyWith<_$FailedStockItemModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
