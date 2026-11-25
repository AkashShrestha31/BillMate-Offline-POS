// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardResponseModel _$DashboardResponseModelFromJson(
    Map<String, dynamic> json) {
  return _DashboardResponseModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardResponseModel {
  bool get success => throw _privateConstructorUsedError;
  @JsonKey(name: 'report_type')
  String get reportType => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee_overview')
  Map<String, dynamic>? get employeeOverview =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'attendance_today')
  Map<String, dynamic>? get attendanceToday =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'leave_management')
  Map<String, dynamic>? get leaveManagement =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'payroll_status')
  Map<String, dynamic>? get payrollStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'department_distribution')
  List<Map<String, dynamic>>? get departmentDistribution =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'recent_activities')
  List<Map<String, dynamic>>? get recentActivities =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'all_employees')
  List<EmployeeModel> get employees => throw _privateConstructorUsedError;

  /// Serializes this DashboardResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardResponseModelCopyWith<DashboardResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardResponseModelCopyWith<$Res> {
  factory $DashboardResponseModelCopyWith(DashboardResponseModel value,
          $Res Function(DashboardResponseModel) then) =
      _$DashboardResponseModelCopyWithImpl<$Res, DashboardResponseModel>;
  @useResult
  $Res call(
      {bool success,
      @JsonKey(name: 'report_type') String reportType,
      @JsonKey(name: 'employee_overview')
      Map<String, dynamic>? employeeOverview,
      @JsonKey(name: 'attendance_today') Map<String, dynamic>? attendanceToday,
      @JsonKey(name: 'leave_management') Map<String, dynamic>? leaveManagement,
      @JsonKey(name: 'payroll_status') Map<String, dynamic>? payrollStatus,
      @JsonKey(name: 'department_distribution')
      List<Map<String, dynamic>>? departmentDistribution,
      @JsonKey(name: 'recent_activities')
      List<Map<String, dynamic>>? recentActivities,
      @JsonKey(name: 'all_employees') List<EmployeeModel> employees});
}

/// @nodoc
class _$DashboardResponseModelCopyWithImpl<$Res,
        $Val extends DashboardResponseModel>
    implements $DashboardResponseModelCopyWith<$Res> {
  _$DashboardResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? reportType = null,
    Object? employeeOverview = freezed,
    Object? attendanceToday = freezed,
    Object? leaveManagement = freezed,
    Object? payrollStatus = freezed,
    Object? departmentDistribution = freezed,
    Object? recentActivities = freezed,
    Object? employees = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      reportType: null == reportType
          ? _value.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as String,
      employeeOverview: freezed == employeeOverview
          ? _value.employeeOverview
          : employeeOverview // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      attendanceToday: freezed == attendanceToday
          ? _value.attendanceToday
          : attendanceToday // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      leaveManagement: freezed == leaveManagement
          ? _value.leaveManagement
          : leaveManagement // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      payrollStatus: freezed == payrollStatus
          ? _value.payrollStatus
          : payrollStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      departmentDistribution: freezed == departmentDistribution
          ? _value.departmentDistribution
          : departmentDistribution // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      recentActivities: freezed == recentActivities
          ? _value.recentActivities
          : recentActivities // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      employees: null == employees
          ? _value.employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardResponseModelImplCopyWith<$Res>
    implements $DashboardResponseModelCopyWith<$Res> {
  factory _$$DashboardResponseModelImplCopyWith(
          _$DashboardResponseModelImpl value,
          $Res Function(_$DashboardResponseModelImpl) then) =
      __$$DashboardResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      @JsonKey(name: 'report_type') String reportType,
      @JsonKey(name: 'employee_overview')
      Map<String, dynamic>? employeeOverview,
      @JsonKey(name: 'attendance_today') Map<String, dynamic>? attendanceToday,
      @JsonKey(name: 'leave_management') Map<String, dynamic>? leaveManagement,
      @JsonKey(name: 'payroll_status') Map<String, dynamic>? payrollStatus,
      @JsonKey(name: 'department_distribution')
      List<Map<String, dynamic>>? departmentDistribution,
      @JsonKey(name: 'recent_activities')
      List<Map<String, dynamic>>? recentActivities,
      @JsonKey(name: 'all_employees') List<EmployeeModel> employees});
}

/// @nodoc
class __$$DashboardResponseModelImplCopyWithImpl<$Res>
    extends _$DashboardResponseModelCopyWithImpl<$Res,
        _$DashboardResponseModelImpl>
    implements _$$DashboardResponseModelImplCopyWith<$Res> {
  __$$DashboardResponseModelImplCopyWithImpl(
      _$DashboardResponseModelImpl _value,
      $Res Function(_$DashboardResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? reportType = null,
    Object? employeeOverview = freezed,
    Object? attendanceToday = freezed,
    Object? leaveManagement = freezed,
    Object? payrollStatus = freezed,
    Object? departmentDistribution = freezed,
    Object? recentActivities = freezed,
    Object? employees = null,
  }) {
    return _then(_$DashboardResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      reportType: null == reportType
          ? _value.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as String,
      employeeOverview: freezed == employeeOverview
          ? _value._employeeOverview
          : employeeOverview // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      attendanceToday: freezed == attendanceToday
          ? _value._attendanceToday
          : attendanceToday // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      leaveManagement: freezed == leaveManagement
          ? _value._leaveManagement
          : leaveManagement // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      payrollStatus: freezed == payrollStatus
          ? _value._payrollStatus
          : payrollStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      departmentDistribution: freezed == departmentDistribution
          ? _value._departmentDistribution
          : departmentDistribution // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      recentActivities: freezed == recentActivities
          ? _value._recentActivities
          : recentActivities // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      employees: null == employees
          ? _value._employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<EmployeeModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardResponseModelImpl implements _DashboardResponseModel {
  const _$DashboardResponseModelImpl(
      {required this.success,
      @JsonKey(name: 'report_type') required this.reportType,
      @JsonKey(name: 'employee_overview')
      final Map<String, dynamic>? employeeOverview,
      @JsonKey(name: 'attendance_today')
      final Map<String, dynamic>? attendanceToday,
      @JsonKey(name: 'leave_management')
      final Map<String, dynamic>? leaveManagement,
      @JsonKey(name: 'payroll_status')
      final Map<String, dynamic>? payrollStatus,
      @JsonKey(name: 'department_distribution')
      final List<Map<String, dynamic>>? departmentDistribution,
      @JsonKey(name: 'recent_activities')
      final List<Map<String, dynamic>>? recentActivities,
      @JsonKey(name: 'all_employees')
      required final List<EmployeeModel> employees})
      : _employeeOverview = employeeOverview,
        _attendanceToday = attendanceToday,
        _leaveManagement = leaveManagement,
        _payrollStatus = payrollStatus,
        _departmentDistribution = departmentDistribution,
        _recentActivities = recentActivities,
        _employees = employees;

  factory _$DashboardResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  @JsonKey(name: 'report_type')
  final String reportType;
  final Map<String, dynamic>? _employeeOverview;
  @override
  @JsonKey(name: 'employee_overview')
  Map<String, dynamic>? get employeeOverview {
    final value = _employeeOverview;
    if (value == null) return null;
    if (_employeeOverview is EqualUnmodifiableMapView) return _employeeOverview;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _attendanceToday;
  @override
  @JsonKey(name: 'attendance_today')
  Map<String, dynamic>? get attendanceToday {
    final value = _attendanceToday;
    if (value == null) return null;
    if (_attendanceToday is EqualUnmodifiableMapView) return _attendanceToday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _leaveManagement;
  @override
  @JsonKey(name: 'leave_management')
  Map<String, dynamic>? get leaveManagement {
    final value = _leaveManagement;
    if (value == null) return null;
    if (_leaveManagement is EqualUnmodifiableMapView) return _leaveManagement;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _payrollStatus;
  @override
  @JsonKey(name: 'payroll_status')
  Map<String, dynamic>? get payrollStatus {
    final value = _payrollStatus;
    if (value == null) return null;
    if (_payrollStatus is EqualUnmodifiableMapView) return _payrollStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<Map<String, dynamic>>? _departmentDistribution;
  @override
  @JsonKey(name: 'department_distribution')
  List<Map<String, dynamic>>? get departmentDistribution {
    final value = _departmentDistribution;
    if (value == null) return null;
    if (_departmentDistribution is EqualUnmodifiableListView)
      return _departmentDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Map<String, dynamic>>? _recentActivities;
  @override
  @JsonKey(name: 'recent_activities')
  List<Map<String, dynamic>>? get recentActivities {
    final value = _recentActivities;
    if (value == null) return null;
    if (_recentActivities is EqualUnmodifiableListView)
      return _recentActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<EmployeeModel> _employees;
  @override
  @JsonKey(name: 'all_employees')
  List<EmployeeModel> get employees {
    if (_employees is EqualUnmodifiableListView) return _employees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_employees);
  }

  @override
  String toString() {
    return 'DashboardResponseModel(success: $success, reportType: $reportType, employeeOverview: $employeeOverview, attendanceToday: $attendanceToday, leaveManagement: $leaveManagement, payrollStatus: $payrollStatus, departmentDistribution: $departmentDistribution, recentActivities: $recentActivities, employees: $employees)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.reportType, reportType) ||
                other.reportType == reportType) &&
            const DeepCollectionEquality()
                .equals(other._employeeOverview, _employeeOverview) &&
            const DeepCollectionEquality()
                .equals(other._attendanceToday, _attendanceToday) &&
            const DeepCollectionEquality()
                .equals(other._leaveManagement, _leaveManagement) &&
            const DeepCollectionEquality()
                .equals(other._payrollStatus, _payrollStatus) &&
            const DeepCollectionEquality().equals(
                other._departmentDistribution, _departmentDistribution) &&
            const DeepCollectionEquality()
                .equals(other._recentActivities, _recentActivities) &&
            const DeepCollectionEquality()
                .equals(other._employees, _employees));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      success,
      reportType,
      const DeepCollectionEquality().hash(_employeeOverview),
      const DeepCollectionEquality().hash(_attendanceToday),
      const DeepCollectionEquality().hash(_leaveManagement),
      const DeepCollectionEquality().hash(_payrollStatus),
      const DeepCollectionEquality().hash(_departmentDistribution),
      const DeepCollectionEquality().hash(_recentActivities),
      const DeepCollectionEquality().hash(_employees));

  /// Create a copy of DashboardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardResponseModelImplCopyWith<_$DashboardResponseModelImpl>
      get copyWith => __$$DashboardResponseModelImplCopyWithImpl<
          _$DashboardResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardResponseModelImplToJson(
      this,
    );
  }
}

abstract class _DashboardResponseModel implements DashboardResponseModel {
  const factory _DashboardResponseModel(
          {required final bool success,
          @JsonKey(name: 'report_type') required final String reportType,
          @JsonKey(name: 'employee_overview')
          final Map<String, dynamic>? employeeOverview,
          @JsonKey(name: 'attendance_today')
          final Map<String, dynamic>? attendanceToday,
          @JsonKey(name: 'leave_management')
          final Map<String, dynamic>? leaveManagement,
          @JsonKey(name: 'payroll_status')
          final Map<String, dynamic>? payrollStatus,
          @JsonKey(name: 'department_distribution')
          final List<Map<String, dynamic>>? departmentDistribution,
          @JsonKey(name: 'recent_activities')
          final List<Map<String, dynamic>>? recentActivities,
          @JsonKey(name: 'all_employees')
          required final List<EmployeeModel> employees}) =
      _$DashboardResponseModelImpl;

  factory _DashboardResponseModel.fromJson(Map<String, dynamic> json) =
      _$DashboardResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  @JsonKey(name: 'report_type')
  String get reportType;
  @override
  @JsonKey(name: 'employee_overview')
  Map<String, dynamic>? get employeeOverview;
  @override
  @JsonKey(name: 'attendance_today')
  Map<String, dynamic>? get attendanceToday;
  @override
  @JsonKey(name: 'leave_management')
  Map<String, dynamic>? get leaveManagement;
  @override
  @JsonKey(name: 'payroll_status')
  Map<String, dynamic>? get payrollStatus;
  @override
  @JsonKey(name: 'department_distribution')
  List<Map<String, dynamic>>? get departmentDistribution;
  @override
  @JsonKey(name: 'recent_activities')
  List<Map<String, dynamic>>? get recentActivities;
  @override
  @JsonKey(name: 'all_employees')
  List<EmployeeModel> get employees;

  /// Create a copy of DashboardResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardResponseModelImplCopyWith<_$DashboardResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
