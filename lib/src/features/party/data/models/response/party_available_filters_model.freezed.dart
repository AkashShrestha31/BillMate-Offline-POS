// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_available_filters_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartyAvailableFiltersModel _$PartyAvailableFiltersModelFromJson(
    Map<String, dynamic> json) {
  return _PartyAvailableFiltersModel.fromJson(json);
}

/// @nodoc
mixin _$PartyAvailableFiltersModel {
  @JsonKey(name: 'role_options')
  List<String>? get roleOptions => throw _privateConstructorUsedError;
  @JsonKey(name: 'currency_options')
  List<String>? get currencyOptions => throw _privateConstructorUsedError;
  @JsonKey(name: 'loyalty_program_options')
  List<String>? get loyaltyProgramOptions => throw _privateConstructorUsedError;

  /// Serializes this PartyAvailableFiltersModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartyAvailableFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartyAvailableFiltersModelCopyWith<PartyAvailableFiltersModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartyAvailableFiltersModelCopyWith<$Res> {
  factory $PartyAvailableFiltersModelCopyWith(PartyAvailableFiltersModel value,
          $Res Function(PartyAvailableFiltersModel) then) =
      _$PartyAvailableFiltersModelCopyWithImpl<$Res,
          PartyAvailableFiltersModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'role_options') List<String>? roleOptions,
      @JsonKey(name: 'currency_options') List<String>? currencyOptions,
      @JsonKey(name: 'loyalty_program_options')
      List<String>? loyaltyProgramOptions});
}

/// @nodoc
class _$PartyAvailableFiltersModelCopyWithImpl<$Res,
        $Val extends PartyAvailableFiltersModel>
    implements $PartyAvailableFiltersModelCopyWith<$Res> {
  _$PartyAvailableFiltersModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartyAvailableFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roleOptions = freezed,
    Object? currencyOptions = freezed,
    Object? loyaltyProgramOptions = freezed,
  }) {
    return _then(_value.copyWith(
      roleOptions: freezed == roleOptions
          ? _value.roleOptions
          : roleOptions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currencyOptions: freezed == currencyOptions
          ? _value.currencyOptions
          : currencyOptions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      loyaltyProgramOptions: freezed == loyaltyProgramOptions
          ? _value.loyaltyProgramOptions
          : loyaltyProgramOptions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartyAvailableFiltersModelImplCopyWith<$Res>
    implements $PartyAvailableFiltersModelCopyWith<$Res> {
  factory _$$PartyAvailableFiltersModelImplCopyWith(
          _$PartyAvailableFiltersModelImpl value,
          $Res Function(_$PartyAvailableFiltersModelImpl) then) =
      __$$PartyAvailableFiltersModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'role_options') List<String>? roleOptions,
      @JsonKey(name: 'currency_options') List<String>? currencyOptions,
      @JsonKey(name: 'loyalty_program_options')
      List<String>? loyaltyProgramOptions});
}

/// @nodoc
class __$$PartyAvailableFiltersModelImplCopyWithImpl<$Res>
    extends _$PartyAvailableFiltersModelCopyWithImpl<$Res,
        _$PartyAvailableFiltersModelImpl>
    implements _$$PartyAvailableFiltersModelImplCopyWith<$Res> {
  __$$PartyAvailableFiltersModelImplCopyWithImpl(
      _$PartyAvailableFiltersModelImpl _value,
      $Res Function(_$PartyAvailableFiltersModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartyAvailableFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roleOptions = freezed,
    Object? currencyOptions = freezed,
    Object? loyaltyProgramOptions = freezed,
  }) {
    return _then(_$PartyAvailableFiltersModelImpl(
      roleOptions: freezed == roleOptions
          ? _value._roleOptions
          : roleOptions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      currencyOptions: freezed == currencyOptions
          ? _value._currencyOptions
          : currencyOptions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      loyaltyProgramOptions: freezed == loyaltyProgramOptions
          ? _value._loyaltyProgramOptions
          : loyaltyProgramOptions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartyAvailableFiltersModelImpl implements _PartyAvailableFiltersModel {
  const _$PartyAvailableFiltersModelImpl(
      {@JsonKey(name: 'role_options') final List<String>? roleOptions,
      @JsonKey(name: 'currency_options') final List<String>? currencyOptions,
      @JsonKey(name: 'loyalty_program_options')
      final List<String>? loyaltyProgramOptions})
      : _roleOptions = roleOptions,
        _currencyOptions = currencyOptions,
        _loyaltyProgramOptions = loyaltyProgramOptions;

  factory _$PartyAvailableFiltersModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PartyAvailableFiltersModelImplFromJson(json);

  final List<String>? _roleOptions;
  @override
  @JsonKey(name: 'role_options')
  List<String>? get roleOptions {
    final value = _roleOptions;
    if (value == null) return null;
    if (_roleOptions is EqualUnmodifiableListView) return _roleOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _currencyOptions;
  @override
  @JsonKey(name: 'currency_options')
  List<String>? get currencyOptions {
    final value = _currencyOptions;
    if (value == null) return null;
    if (_currencyOptions is EqualUnmodifiableListView) return _currencyOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _loyaltyProgramOptions;
  @override
  @JsonKey(name: 'loyalty_program_options')
  List<String>? get loyaltyProgramOptions {
    final value = _loyaltyProgramOptions;
    if (value == null) return null;
    if (_loyaltyProgramOptions is EqualUnmodifiableListView)
      return _loyaltyProgramOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PartyAvailableFiltersModel(roleOptions: $roleOptions, currencyOptions: $currencyOptions, loyaltyProgramOptions: $loyaltyProgramOptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartyAvailableFiltersModelImpl &&
            const DeepCollectionEquality()
                .equals(other._roleOptions, _roleOptions) &&
            const DeepCollectionEquality()
                .equals(other._currencyOptions, _currencyOptions) &&
            const DeepCollectionEquality()
                .equals(other._loyaltyProgramOptions, _loyaltyProgramOptions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_roleOptions),
      const DeepCollectionEquality().hash(_currencyOptions),
      const DeepCollectionEquality().hash(_loyaltyProgramOptions));

  /// Create a copy of PartyAvailableFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartyAvailableFiltersModelImplCopyWith<_$PartyAvailableFiltersModelImpl>
      get copyWith => __$$PartyAvailableFiltersModelImplCopyWithImpl<
          _$PartyAvailableFiltersModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartyAvailableFiltersModelImplToJson(
      this,
    );
  }
}

abstract class _PartyAvailableFiltersModel
    implements PartyAvailableFiltersModel {
  const factory _PartyAvailableFiltersModel(
      {@JsonKey(name: 'role_options') final List<String>? roleOptions,
      @JsonKey(name: 'currency_options') final List<String>? currencyOptions,
      @JsonKey(name: 'loyalty_program_options')
      final List<String>?
          loyaltyProgramOptions}) = _$PartyAvailableFiltersModelImpl;

  factory _PartyAvailableFiltersModel.fromJson(Map<String, dynamic> json) =
      _$PartyAvailableFiltersModelImpl.fromJson;

  @override
  @JsonKey(name: 'role_options')
  List<String>? get roleOptions;
  @override
  @JsonKey(name: 'currency_options')
  List<String>? get currencyOptions;
  @override
  @JsonKey(name: 'loyalty_program_options')
  List<String>? get loyaltyProgramOptions;

  /// Create a copy of PartyAvailableFiltersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartyAvailableFiltersModelImplCopyWith<_$PartyAvailableFiltersModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
