import 'package:dio/dio.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import '../models/request/employee_request_params.dart';
import '../models/request/attendance_request_params.dart';
import '../models/request/attendance_update_request_params.dart';
import '../models/request/payroll_request_params.dart';
import '../models/request/leave_application_request_params.dart';
import '../models/request/leave_approval_request_params.dart';
import '../models/request/leave_type_request_params.dart';
import '../models/response/employees_list_response_model.dart';
import '../models/response/employee_model.dart';
import '../models/response/attendance_list_response_model.dart';
import '../models/response/attendance_model.dart';
import '../models/response/payroll_list_response_model.dart';
import '../models/response/payroll_model.dart';
import '../models/response/leave_types_list_response_model.dart';
import '../models/response/leave_type_model.dart';
import '../models/response/leave_applications_list_response_model.dart';
import '../models/response/leave_application_model.dart';
import '../models/response/leave_balance_list_response_model.dart';
import '../models/response/common_success_response_model.dart';
import '../models/response/dashboard_response_model.dart';

abstract class EmployeeManagementRemoteDataSource {
  // Table Management
  Future<CommonSuccessResponseModel> createEmployeeTables();
  Future<CommonSuccessResponseModel> createLeaveTables();

  // Employee Management
  Future<EmployeesListResponseModel> getEmployees({
    String? department,
    String? position,
    String? employmentStatus,
    String? employmentType,
  });
  Future<EmployeeModel> getEmployeeById(dynamic id);
  Future<CommonSuccessResponseModel> createEmployee(
    EmployeeRequestParams params, {
    required int isActive,
  });
  Future<CommonSuccessResponseModel> updateEmployee(
    int id,
    EmployeeRequestParams params, {
    required int isActive,
  });
  Future<CommonSuccessResponseModel> deleteEmployee(int id);

  // Attendance Management
  Future<AttendanceListResponseModel> getAttendance({
    int? employeeId,
    String? dateFrom,
    String? dateTo,
    String? attendanceStatus,
  });
  Future<AttendanceModel> getAttendanceById(dynamic id);
  Future<CommonSuccessResponseModel> recordAttendance(AttendanceRequestParams params);
  Future<CommonSuccessResponseModel> updateAttendance(AttendanceUpdateRequestParams params);
  Future<CommonSuccessResponseModel> deleteAttendance(int id);

  // Payroll Management
  Future<PayrollListResponseModel> getPayrolls({
    int? employeeId,
    String? payrollMonth,
    String? paymentStatus,
  });
  Future<PayrollModel> getPayrollById(int id);
  Future<CommonSuccessResponseModel> generatePayroll(PayrollRequestParams params);
  Future<CommonSuccessResponseModel> updatePayroll(int id, PayrollRequestParams params);

  // Leave Type Management
  Future<LeaveTypesListResponseModel> getLeaveTypes();
  Future<LeaveTypeModel> getLeaveTypeById(int id);
  Future<CommonSuccessResponseModel> createLeaveType(LeaveTypeRequestParams params);
  Future<CommonSuccessResponseModel> updateLeaveType(int id, LeaveTypeRequestParams params);
  Future<CommonSuccessResponseModel> deleteLeaveType(int id);

  // Leave Application Management
  Future<LeaveApplicationsListResponseModel> getLeaveApplications({
    int? employeeId,
    String? status,
    int? leaveTypeId,
    String? dateFrom,
    String? dateTo,
  });
  Future<LeaveApplicationModel> getLeaveApplicationById(int id);
  Future<CommonSuccessResponseModel> submitLeaveApplication(LeaveApplicationRequestParams params);
  Future<CommonSuccessResponseModel> updateLeaveApplication(int id, LeaveApplicationRequestParams params);
  Future<CommonSuccessResponseModel> approveRejectLeaveApplication(int id, LeaveApprovalRequestParams params);
  Future<CommonSuccessResponseModel> cancelLeaveApplication(int id);

  // Leave Balance
  Future<LeaveBalanceListResponseModel> getLeaveBalance({
    int? employeeId,
    int? year,
    int? leaveTypeId,
  });

  // Reports & Analytics
  Future<DashboardResponseModel> getDashboard();
  Future<Map<String, dynamic>> getReport({
    required String reportType,
    String? dateFrom,
    String? dateTo,
    String? department,
    int? employeeId,
  });
}

// @LazySingleton(as: EmployeeManagementRemoteDataSource) — replaced by EmployeeManagementLocalDataSource
class EmployeeManagementRemoteDataSourceImpl implements EmployeeManagementRemoteDataSource {
  EmployeeManagementRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<CommonSuccessResponseModel> createEmployeeTables() async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(options: options, ApiEndPoints.createEmployeeTables);
      if (response.statusCode == 201) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to create employee tables');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> createLeaveTables() async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(options: options, ApiEndPoints.createLeaveTables);
      if (response.statusCode == 201) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to create leave tables');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<EmployeesListResponseModel> getEmployees({
    String? department,
    String? position,
    String? employmentStatus,
    String? employmentType,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (department != null) queryParams['department'] = department;
      if (position != null) queryParams['position'] = position;
      if (employmentStatus != null) queryParams['employment_status'] = employmentStatus;
      if (employmentType != null) queryParams['employment_type'] = employmentType;

      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        ApiEndPoints.employees,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return EmployeesListResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to fetch employees');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<EmployeeModel> getEmployeeById(dynamic id) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(options: options, '${ApiEndPoints.employees}$id/');
      if (response.statusCode == 200) {
        return EmployeeModel.fromJson(response.data['employee']);
      }
      throw const AppException(message: 'Failed to fetch employee details');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  Map<String, dynamic> _employeeWriteBody(EmployeeRequestParams params, int isActive) {
    final map = Map<String, dynamic>.from(params.toJson())..removeWhere((_, v) => v == null);
    map['is_active'] = isActive;
    return map;
  }

  @override
  Future<CommonSuccessResponseModel> createEmployee(
    EmployeeRequestParams params, {
    required int isActive,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        options: options,
        ApiEndPoints.employees,
        data: _employeeWriteBody(params, isActive),
      );
      if (response.statusCode == 201) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to create employee');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> updateEmployee(
    int id,
    EmployeeRequestParams params, {
    required int isActive,
  }) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        options: options,
        '${ApiEndPoints.employees}$id/',
        data: _employeeWriteBody(params, isActive),
      );
      if (response.statusCode == 200) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to update employee');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> deleteEmployee(int id) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.delete(options: options, '${ApiEndPoints.employees}$id/');
      if (response.statusCode == 200) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to delete employee');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<AttendanceListResponseModel> getAttendance({
    int? employeeId,
    String? dateFrom,
    String? dateTo,
    String? attendanceStatus,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (employeeId != null) queryParams['employee_id'] = employeeId;
      if (dateFrom != null) queryParams['date_from'] = dateFrom;
      if (dateTo != null) queryParams['date_to'] = dateTo;
      if (attendanceStatus != null) queryParams['attendance_status'] = attendanceStatus;

      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        ApiEndPoints.attendance,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return AttendanceListResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to fetch attendance records');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<AttendanceModel> getAttendanceById(dynamic id) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        ApiEndPoints.attendanceById(id is int ? id : int.tryParse(id.toString()) ?? 0),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        final map = data is Map<String, dynamic>
            ? (data['attendance'] as Map<String, dynamic>? ?? data)
            : data as Map<String, dynamic>;
        return AttendanceModel.fromJson(map);
      }
      throw const AppException(message: 'Failed to fetch attendance details');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> recordAttendance(AttendanceRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final body = <String, dynamic>{
        'employee_id': params.employeeId,
        'attendance_status': params.attendanceStatus,
      };
      if (params.attendanceDate != null) body['attendance_date'] = params.attendanceDate;
      if (params.startDate != null) body['start_date'] = params.startDate;
      if (params.endDate != null) body['end_date'] = params.endDate;
      if (params.checkInTime != null) body['check_in_time'] = params.checkInTime;
      if (params.checkOutTime != null) body['check_out_time'] = params.checkOutTime;
      if (params.breakStartTime != null) body['break_start_time'] = params.breakStartTime;
      if (params.breakEndTime != null) body['break_end_time'] = params.breakEndTime;
      if (params.location != null) body['location'] = params.location;
      if (params.notes != null) body['notes'] = params.notes;
      final response = await _dio.post(
        options: options,
        ApiEndPoints.attendance,
        data: body,
      );
      if (response.statusCode == 201) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to record attendance');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> updateAttendance(AttendanceUpdateRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        options: options,
        ApiEndPoints.attendance,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to update attendance');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> deleteAttendance(int id) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.delete(
        options: options,
        ApiEndPoints.attendance,
        queryParameters: {'attendance_id': id},
      );
      if (response.statusCode == 200) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to delete attendance');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<PayrollListResponseModel> getPayrolls({
    int? employeeId,
    String? payrollMonth,
    String? paymentStatus,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (employeeId != null) queryParams['employee_id'] = employeeId;
      if (payrollMonth != null) queryParams['payroll_month'] = payrollMonth;
      if (paymentStatus != null) queryParams['payment_status'] = paymentStatus;

      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        ApiEndPoints.payroll,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return PayrollListResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to fetch payroll records');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<PayrollModel> getPayrollById(int id) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(options: options, '${ApiEndPoints.payroll}$id/');
      if (response.statusCode == 200) {
        return PayrollModel.fromJson(response.data['payroll']);
      }
      throw const AppException(message: 'Failed to fetch payroll details');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> generatePayroll(PayrollRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        options: options,
        ApiEndPoints.payroll,
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to generate payroll');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> updatePayroll(int id, PayrollRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        options: options,
        '${ApiEndPoints.payroll}$id/',
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to update payroll');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<LeaveTypesListResponseModel> getLeaveTypes() async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(options: options, ApiEndPoints.leaveTypes);
      if (response.statusCode == 200) {
        return LeaveTypesListResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to fetch leave types');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<LeaveTypeModel> getLeaveTypeById(int id) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(options: options, '${ApiEndPoints.leaveTypes}$id/');
      if (response.statusCode == 200) {
        return LeaveTypeModel.fromJson(response.data['leave_type']);
      }
      throw const AppException(message: 'Failed to fetch leave type details');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> createLeaveType(LeaveTypeRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        options: options,
        ApiEndPoints.leaveTypes,
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to create leave type');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> updateLeaveType(int id, LeaveTypeRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        options: options,
        '${ApiEndPoints.leaveTypes}$id/',
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to update leave type');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> deleteLeaveType(int id) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.delete(options: options, '${ApiEndPoints.leaveTypes}$id/');
      if (response.statusCode == 200) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to delete leave type');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<LeaveApplicationsListResponseModel> getLeaveApplications({
    int? employeeId,
    String? status,
    int? leaveTypeId,
    String? dateFrom,
    String? dateTo,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (employeeId != null) queryParams['employee_id'] = employeeId;
      if (status != null) queryParams['status'] = status;
      if (leaveTypeId != null) queryParams['leave_type_id'] = leaveTypeId;
      if (dateFrom != null) queryParams['date_from'] = dateFrom;
      if (dateTo != null) queryParams['date_to'] = dateTo;

      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        ApiEndPoints.leaveApplications,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return LeaveApplicationsListResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to fetch leave applications');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<LeaveApplicationModel> getLeaveApplicationById(int id) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(options: options, '${ApiEndPoints.leaveApplications}$id/');
      if (response.statusCode == 200) {
        return LeaveApplicationModel.fromJson(response.data['application']);
      }
      throw const AppException(message: 'Failed to fetch leave application details');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> submitLeaveApplication(LeaveApplicationRequestParams params) async {
    try {
      final response = await _dio.post(
        ApiEndPoints.leaveApplications,
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to submit leave application');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> updateLeaveApplication(int id, LeaveApplicationRequestParams params) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        options: options,
        '${ApiEndPoints.leaveApplications}$id/',
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to update leave application');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> approveRejectLeaveApplication(
    int id,
    LeaveApprovalRequestParams params,
  ) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.put(
        options: options,
        '${ApiEndPoints.leaveApplications}$id/approve/',
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to process leave application');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<CommonSuccessResponseModel> cancelLeaveApplication(int id) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.delete(options: options, '${ApiEndPoints.leaveApplications}$id/');
      if (response.statusCode == 200) {
        return CommonSuccessResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to cancel leave application');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<LeaveBalanceListResponseModel> getLeaveBalance({
    int? employeeId,
    int? year,
    int? leaveTypeId,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (employeeId != null) queryParams['employee_id'] = employeeId;
      if (year != null) queryParams['year'] = year;
      if (leaveTypeId != null) queryParams['leave_type_id'] = leaveTypeId;

      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        ApiEndPoints.leaveBalance,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return LeaveBalanceListResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to fetch leave balance');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<DashboardResponseModel> getDashboard() async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        ApiEndPoints.reports,
        queryParameters: {'report_type': 'dashboard'},
      );
      if (response.statusCode == 200) {
        return DashboardResponseModel.fromJson(response.data);
      }
      throw const AppException(message: 'Failed to fetch dashboard data');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getReport({
    required String reportType,
    String? dateFrom,
    String? dateTo,
    String? department,
    int? employeeId,
  }) async {
    try {
      final queryParams = <String, dynamic>{'report_type': reportType};
      if (dateFrom != null) queryParams['date_from'] = dateFrom;
      if (dateTo != null) queryParams['date_to'] = dateTo;
      if (department != null) queryParams['department'] = department;
      if (employeeId != null) queryParams['employee_id'] = employeeId;

      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.get(
        options: options,
        ApiEndPoints.reports,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      throw const AppException(message: 'Failed to fetch report');
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
