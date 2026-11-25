import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import '../../data/models/request/employee_request_params.dart';
import '../../data/models/request/attendance_request_params.dart';
import '../../data/models/request/attendance_update_request_params.dart';
import '../../data/models/request/payroll_request_params.dart';
import '../../data/models/request/leave_application_request_params.dart';
import '../../data/models/request/leave_approval_request_params.dart';
import '../../data/models/request/leave_type_request_params.dart';
import '../../data/models/response/employees_list_response_model.dart';
import '../../data/models/response/employee_model.dart';
import '../../data/models/response/attendance_list_response_model.dart';
import '../../data/models/response/attendance_model.dart';
import '../../data/models/response/payroll_list_response_model.dart';
import '../../data/models/response/payroll_model.dart';
import '../../data/models/response/leave_types_list_response_model.dart';
import '../../data/models/response/leave_type_model.dart';
import '../../data/models/response/leave_applications_list_response_model.dart';
import '../../data/models/response/leave_application_model.dart';
import '../../data/models/response/leave_balance_list_response_model.dart';
import '../../data/models/response/common_success_response_model.dart';
import '../../data/models/response/dashboard_response_model.dart';

abstract class EmployeeManagementRepository {
  // Table Management
  Future<Either<AppError, CommonSuccessResponseModel>> createEmployeeTables();
  Future<Either<AppError, CommonSuccessResponseModel>> createLeaveTables();

  // Employee Management
  Future<Either<AppError, EmployeesListResponseModel>> getEmployees({
    String? department,
    String? position,
    String? employmentStatus,
    String? employmentType,
  });
  Future<Either<AppError, EmployeeModel>> getEmployeeById(dynamic id);
  Future<Either<AppError, CommonSuccessResponseModel>> createEmployee(
    EmployeeRequestParams params, {
    required int isActive,
  });
  Future<Either<AppError, CommonSuccessResponseModel>> updateEmployee(
    int id,
    EmployeeRequestParams params, {
    required int isActive,
  });
  Future<Either<AppError, CommonSuccessResponseModel>> deleteEmployee(int id);

  // Attendance Management
  Future<Either<AppError, AttendanceListResponseModel>> getAttendance({
    int? employeeId,
    String? dateFrom,
    String? dateTo,
    String? attendanceStatus,
  });
  Future<Either<AppError, AttendanceModel>> getAttendanceById(dynamic id);
  Future<Either<AppError, CommonSuccessResponseModel>> recordAttendance(AttendanceRequestParams params);
  Future<Either<AppError, CommonSuccessResponseModel>> updateAttendance(AttendanceUpdateRequestParams params);
  Future<Either<AppError, CommonSuccessResponseModel>> deleteAttendance(int id);

  // Payroll Management
  Future<Either<AppError, PayrollListResponseModel>> getPayrolls({
    int? employeeId,
    String? payrollMonth,
    String? paymentStatus,
  });
  Future<Either<AppError, PayrollModel>> getPayrollById(int id);
  Future<Either<AppError, CommonSuccessResponseModel>> generatePayroll(PayrollRequestParams params);
  Future<Either<AppError, CommonSuccessResponseModel>> updatePayroll(int id, PayrollRequestParams params);

  // Leave Type Management
  Future<Either<AppError, LeaveTypesListResponseModel>> getLeaveTypes();
  Future<Either<AppError, LeaveTypeModel>> getLeaveTypeById(int id);
  Future<Either<AppError, CommonSuccessResponseModel>> createLeaveType(LeaveTypeRequestParams params);
  Future<Either<AppError, CommonSuccessResponseModel>> updateLeaveType(int id, LeaveTypeRequestParams params);
  Future<Either<AppError, CommonSuccessResponseModel>> deleteLeaveType(int id);

  // Leave Application Management
  Future<Either<AppError, LeaveApplicationsListResponseModel>> getLeaveApplications({
    int? employeeId,
    String? status,
    int? leaveTypeId,
    String? dateFrom,
    String? dateTo,
  });
  Future<Either<AppError, LeaveApplicationModel>> getLeaveApplicationById(int id);
  Future<Either<AppError, CommonSuccessResponseModel>> submitLeaveApplication(LeaveApplicationRequestParams params);
  Future<Either<AppError, CommonSuccessResponseModel>> updateLeaveApplication(int id, LeaveApplicationRequestParams params);
  Future<Either<AppError, CommonSuccessResponseModel>> approveRejectLeaveApplication(int id, LeaveApprovalRequestParams params);
  Future<Either<AppError, CommonSuccessResponseModel>> cancelLeaveApplication(int id);

  // Leave Balance
  Future<Either<AppError, LeaveBalanceListResponseModel>> getLeaveBalance({
    int? employeeId,
    int? year,
    int? leaveTypeId,
  });

  // Reports & Analytics
  Future<Either<AppError, DashboardResponseModel>> getDashboard();
  Future<Either<AppError, Map<String, dynamic>>> getReport({
    required String reportType,
    String? dateFrom,
    String? dateTo,
    String? department,
    int? employeeId,
  });
}
