// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employees_list_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmployeesListResponseModel _$EmployeesListResponseModelFromJson(
    Map<String, dynamic> json) {
  return _EmployeesListResponseModel.fromJson(json);
}

/// @nodoc
mixin _$EmployeesListResponseModel {
  bool get success => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'filters_applied')
  Map<String, dynamic>? get filtersApplied =>
      throw _privateConstructorUsedError;
  List<EmployeeModel> get employees => throw _privateConstructorUsedError;

  /// Serializes this EmployeesListResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmployeesListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmployeesListResponseModelCopyWith<EmployeesListResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeesListResponseModelCopyWith<$Res> {
  factory $EmployeesListResponseModelCopyWith(EmployeesListResponseModel value,
          $Res Function(EmployeesListResponseModel) then) =
      _$EmployeesListResponseModelCopyWithImpl<$Res,
          EmployeesListResponseModel>;
  @useResult
  $Res call(
      {bool success,
      int count,
      @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
      List<EmployeeModel> employees});
}

/// @nodoc
class _$EmployeesListResponseModelCopyWithImpl<$Res,
        $Val extends EmployeesListResponseModel>
    implements $EmployeesListResponseModelCopyWith<$Res> {
  _$EmployeesListResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeesListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? filtersApplied = freezed,
    Object? employees = null,
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
      employees: null == employees
          ? _value.employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeesListResponseModelImplCopyWith<$Res>
    implements $EmployeesListResponseModelCopyWith<$Res> {
  factory _$$EmployeesListResponseModelImplCopyWith(
          _$EmployeesListResponseModelImpl value,
          $Res Function(_$EmployeesListResponseModelImpl) then) =
      __$$EmployeesListResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      int count,
      @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
      List<EmployeeModel> employees});
}

/// @nodoc
class __$$EmployeesListResponseModelImplCopyWithImpl<$Res>
    extends _$EmployeesListResponseModelCopyWithImpl<$Res,
        _$EmployeesListResponseModelImpl>
    implements _$$EmployeesListResponseModelImplCopyWith<$Res> {
  __$$EmployeesListResponseModelImplCopyWithImpl(
      _$EmployeesListResponseModelImpl _value,
      $Res Function(_$EmployeesListResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmployeesListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? count = null,
    Object? filtersApplied = freezed,
    Object? employees = null,
  }) {
    return _then(_$EmployeesListResponseModelImpl(
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
      employees: null == employees
          ? _value._employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeesListResponseModelImpl implements _EmployeesListResponseModel {
  const _$EmployeesListResponseModelImpl(
      {required this.success,
      required this.count,
      @JsonKey(name: 'filters_applied')
      final Map<String, dynamic>? filtersApplied,
      required final List<EmployeeModel> employees})
      : _filtersApplied = filtersApplied,
        _employees = employees;

  factory _$EmployeesListResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EmployeesListResponseModelImplFromJson(json);

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

  final List<EmployeeModel> _employees;
  @override
  List<EmployeeModel> get employees {
    if (_employees is EqualUnmodifiableListView) return _employees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_employees);
  }

  @override
  String toString() {
    return 'EmployeesListResponseModel(success: $success, count: $count, filtersApplied: $filtersApplied, employees: $employees)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeesListResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality()
                .equals(other._filtersApplied, _filtersApplied) &&
            const DeepCollectionEquality()
                .equals(other._employees, _employees));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      count,
      const DeepCollectionEquality().hash(_filtersApplied),
      const DeepCollectionEquality().hash(_employees));

  /// Create a copy of EmployeesListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeesListResponseModelImplCopyWith<_$EmployeesListResponseModelImpl>
      get copyWith => __$$EmployeesListResponseModelImplCopyWithImpl<
          _$EmployeesListResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeesListResponseModelImplToJson(
      this,
    );
  }
}

abstract class _EmployeesListResponseModel
    implements EmployeesListResponseModel {
  const factory _EmployeesListResponseModel(
          {required final bool success,
          required final int count,
          @JsonKey(name: 'filters_applied')
          final Map<String, dynamic>? filtersApplied,
          required final List<EmployeeModel> employees}) =
      _$EmployeesListResponseModelImpl;

  factory _EmployeesListResponseModel.fromJson(Map<String, dynamic> json) =
      _$EmployeesListResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  int get count;
  @override
  @JsonKey(name: 'filters_applied')
  Map<String, dynamic>? get filtersApplied;
  @override
  List<EmployeeModel> get employees;

  /// Create a copy of EmployeesListResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeesListResponseModelImplCopyWith<_$EmployeesListResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
