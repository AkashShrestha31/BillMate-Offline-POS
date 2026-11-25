// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardResponseModelImpl _$$DashboardResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardResponseModelImpl(
      success: json['success'] as bool,
      reportType: json['report_type'] as String,
      employeeOverview: json['employee_overview'] as Map<String, dynamic>?,
      attendanceToday: json['attendance_today'] as Map<String, dynamic>?,
      leaveManagement: json['leave_management'] as Map<String, dynamic>?,
      payrollStatus: json['payroll_status'] as Map<String, dynamic>?,
      departmentDistribution:
          (json['department_distribution'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList(),
      recentActivities: (json['recent_activities'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      employees: (json['all_employees'] as List<dynamic>)
          .map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DashboardResponseModelImplToJson(
        _$DashboardResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'report_type': instance.reportType,
      'employee_overview': instance.employeeOverview,
      'attendance_today': instance.attendanceToday,
      'leave_management': instance.leaveManagement,
      'payroll_status': instance.payrollStatus,
      'department_distribution': instance.departmentDistribution,
      'recent_activities': instance.recentActivities,
      'all_employees': instance.employees,
    };
