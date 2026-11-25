import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/employee_management/data/models/response/employee_model.dart';

part 'dashboard_response_model.freezed.dart';
part 'dashboard_response_model.g.dart';

@freezed
class DashboardResponseModel with _$DashboardResponseModel {
  const factory DashboardResponseModel({
    required bool success,
    @JsonKey(name: 'report_type') required String reportType,
    @JsonKey(name: 'employee_overview') Map<String, dynamic>? employeeOverview,
    @JsonKey(name: 'attendance_today') Map<String, dynamic>? attendanceToday,
    @JsonKey(name: 'leave_management') Map<String, dynamic>? leaveManagement,
    @JsonKey(name: 'payroll_status') Map<String, dynamic>? payrollStatus,
    @JsonKey(name: 'department_distribution') List<Map<String, dynamic>>? departmentDistribution,
    @JsonKey(name: 'recent_activities') List<Map<String, dynamic>>? recentActivities,
    @JsonKey(name: 'all_employees') required List<EmployeeModel> employees,
  }) = _DashboardResponseModel;

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) => _$DashboardResponseModelFromJson(json);
}
