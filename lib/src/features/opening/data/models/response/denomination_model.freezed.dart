// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'denomination_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DenominationModel _$DenominationModelFromJson(Map<String, dynamic> json) {
  return _DenominationModel.fromJson(json);
}

/// @nodoc
mixin _$DenominationModel {
  double get denomination => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this DenominationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DenominationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DenominationModelCopyWith<DenominationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DenominationModelCopyWith<$Res> {
  factory $DenominationModelCopyWith(
          DenominationModel value, $Res Function(DenominationModel) then) =
      _$DenominationModelCopyWithImpl<$Res, DenominationModel>;
  @useResult
  $Res call({double denomination, int quantity, double amount, String type});
}

/// @nodoc
class _$DenominationModelCopyWithImpl<$Res, $Val extends DenominationModel>
    implements $DenominationModelCopyWith<$Res> {
  _$DenominationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DenominationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? denomination = null,
    Object? quantity = null,
    Object? amount = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      denomination: null == denomination
          ? _value.denomination
          : denomination // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DenominationModelImplCopyWith<$Res>
    implements $DenominationModelCopyWith<$Res> {
  factory _$$DenominationModelImplCopyWith(_$DenominationModelImpl value,
          $Res Function(_$DenominationModelImpl) then) =
      __$$DenominationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double denomination, int quantity, double amount, String type});
}

/// @nodoc
class __$$DenominationModelImplCopyWithImpl<$Res>
    extends _$DenominationModelCopyWithImpl<$Res, _$DenominationModelImpl>
    implements _$$DenominationModelImplCopyWith<$Res> {
  __$$DenominationModelImplCopyWithImpl(_$DenominationModelImpl _value,
      $Res Function(_$DenominationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DenominationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? denomination = null,
    Object? quantity = null,
    Object? amount = null,
    Object? type = null,
  }) {
    return _then(_$DenominationModelImpl(
      denomination: null == denomination
          ? _value.denomination
          : denomination // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DenominationModelImpl implements _DenominationModel {
  const _$DenominationModelImpl(
      {required this.denomination,
      required this.quantity,
      required this.amount,
      required this.type});

  factory _$DenominationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DenominationModelImplFromJson(json);

  @override
  final double denomination;
  @override
  final int quantity;
  @override
  final double amount;
  @override
  final String type;

  @override
  String toString() {
    return 'DenominationModel(denomination: $denomination, quantity: $quantity, amount: $amount, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DenominationModelImpl &&
            (identical(other.denomination, denomination) ||
                other.denomination == denomination) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, denomination, quantity, amount, type);

  /// Create a copy of DenominationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DenominationModelImplCopyWith<_$DenominationModelImpl> get copyWith =>
      __$$DenominationModelImplCopyWithImpl<_$DenominationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DenominationModelImplToJson(
      this,
    );
  }
}

abstract class _DenominationModel implements DenominationModel {
  const factory _DenominationModel(
      {required final double denomination,
      required final int quantity,
      required final double amount,
      required final String type}) = _$DenominationModelImpl;

  factory _DenominationModel.fromJson(Map<String, dynamic> json) =
      _$DenominationModelImpl.fromJson;

  @override
  double get denomination;
  @override
  int get quantity;
  @override
  double get amount;
  @override
  String get type;

  /// Create a copy of DenominationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DenominationModelImplCopyWith<_$DenominationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
