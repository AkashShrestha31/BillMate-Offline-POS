// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_balance_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveBalanceListResponseModel _$LeaveBalanceListResponseModelFromJson(
    Map<String, dynamic> json) {
  return _LeaveBalanceListResponseModel.fromJson(json);
}

/// @nodoc
mixin _$LeaveBalanceListResponseModel {
  bool get success => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'filters_applied')
  Map<String, dynamic>? get filtersApplied =>
      throw _privateConstructorUsedError;
  List<LeaveBalanceModel> get balances => throw _privateConstructorUsedError;

  /// Serializes this LeaveBalanceListResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveBalanceListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveBalanceListResponseModelCopyWith<LeaveBalanceListResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveBalanceListResponseModelCopyWith<$Res> {
  factory $LeaveBalanceListResponseModelCopyWith(
          LeaveBalanceListResponseModel value,
          $Res Function(LeaveBalanceListResponseModel) then) =
      _$LeaveBalanceListResponseModelCopyWithImpl<$Res,
          LeaveBalanceListResponseModel>;
  @useResult
  $Res call(
      {bool success,
      int count,
      @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
      List<LeaveBalanceModel> balances});
}

/// @nodoc
class _$LeaveBalanceListResponseModelCopyWithImpl<$Res,
        $Val extends LeaveBalanceListResponseModel>
    implements $LeaveBalanceListResponseModelCopyWith<$Res> {
  _$LeaveBalanceListResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveBalanceListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? filtersApplied = freezed,
    Object? balances = null,
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
      balances: null == balances
          ? _value.balances
          : balances // ignore: cast_nullable_to_non_nullable
              as List<LeaveBalanceModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveBalanceListResponseModelImplCopyWith<$Res>
    implements $LeaveBalanceListResponseModelCopyWith<$Res> {
  factory _$$LeaveBalanceListResponseModelImplCopyWith(
          _$LeaveBalanceListResponseModelImpl value,
          $Res Function(_$LeaveBalanceListResponseModelImpl) then) =
      __$$LeaveBalanceListResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      int count,
      @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
      List<LeaveBalanceModel> balances});
}

/// @nodoc
class __$$LeaveBalanceListResponseModelImplCopyWithImpl<$Res>
    extends _$LeaveBalanceListResponseModelCopyWithImpl<$Res,
        _$LeaveBalanceListResponseModelImpl>
    implements _$$LeaveBalanceListResponseModelImplCopyWith<$Res> {
  __$$LeaveBalanceListResponseModelImplCopyWithImpl(
      _$LeaveBalanceListResponseModelImpl _value,
      $Res Function(_$LeaveBalanceListResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaveBalanceListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? filtersApplied = freezed,
    Object? balances = null,
  }) {
    return _then(_$LeaveBalanceListResponseModelImpl(
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
      balances: null == balances
          ? _value._balances
          : balances // ignore: cast_nullable_to_non_nullable
              as List<LeaveBalanceModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveBalanceListResponseModelImpl
    implements _LeaveBalanceListResponseModel {
  const _$LeaveBalanceListResponseModelImpl(
      {required this.success,
      required this.count,
      @JsonKey(name: 'filters_applied')
      final Map<String, dynamic>? filtersApplied,
      required final List<LeaveBalanceModel> balances})
      : _filtersApplied = filtersApplied,
        _balances = balances;

  factory _$LeaveBalanceListResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$LeaveBalanceListResponseModelImplFromJson(json);

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

  final List<LeaveBalanceModel> _balances;
  @override
  List<LeaveBalanceModel> get balances {
    if (_balances is EqualUnmodifiableListView) return _balances;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_balances);
  }

  @override
  String toString() {
    return 'LeaveBalanceListResponseModel(success: $success, count: $count, filtersApplied: $filtersApplied, balances: $balances)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveBalanceListResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality()
                .equals(other._filtersApplied, _filtersApplied) &&
            const DeepCollectionEquality().equals(other._balances, _balances));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      count,
      const DeepCollectionEquality().hash(_filtersApplied),
      const DeepCollectionEquality().hash(_balances));

  /// Create a copy of LeaveBalanceListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveBalanceListResponseModelImplCopyWith<
          _$LeaveBalanceListResponseModelImpl>
      get copyWith => __$$LeaveBalanceListResponseModelImplCopyWithImpl<
          _$LeaveBalanceListResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveBalanceListResponseModelImplToJson(
      this,
    );
  }
}

abstract class _LeaveBalanceListResponseModel
    implements LeaveBalanceListResponseModel {
  const factory _LeaveBalanceListResponseModel(
          {required final bool success,
          required final int count,
          @JsonKey(name: 'filters_applied')
          final Map<String, dynamic>? filtersApplied,
          required final List<LeaveBalanceModel> balances}) =
      _$LeaveBalanceListResponseModelImpl;

  factory _LeaveBalanceListResponseModel.fromJson(Map<String, dynamic> json) =
      _$LeaveBalanceListResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  int get count;
  @override
  @JsonKey(name: 'filters_applied')
  Map<String, dynamic>? get filtersApplied;
  @override
  List<LeaveBalanceModel> get balances;

  /// Create a copy of LeaveBalanceListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveBalanceListResponseModelImplCopyWith<
          _$LeaveBalanceListResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
