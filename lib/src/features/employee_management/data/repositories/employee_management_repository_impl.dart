import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import '../../domain/repositories/employee_management_repository.dart';
import '../datasources/employee_management_remote_data_source.dart';
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

@LazySingleton(as: EmployeeManagementRepository)
class EmployeeManagementRepositoryImpl implements EmployeeManagementRepository {
  EmployeeManagementRepositoryImpl(this._dataSource);
  final EmployeeManagementRemoteDataSource _dataSource;

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> createEmployeeTables() async {
    try { return right(await _dataSource.createEmployeeTables()); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> createLeaveTables() async {
    try { return right(await _dataSource.createLeaveTables()); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, EmployeesListResponseModel>> getEmployees({
    String? department, String? position, String? employmentStatus, String? employmentType,
  }) async {
    try {
      return right(await _dataSource.getEmployees(
        department: department, position: position,
        employmentStatus: employmentStatus, employmentType: employmentType,
      ));
    } on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, EmployeeModel>> getEmployeeById(dynamic id) async {
    try { return right(await _dataSource.getEmployeeById(id)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> createEmployee(
    EmployeeRequestParams params, {required int isActive}) async {
    try { return right(await _dataSource.createEmployee(params, isActive: isActive)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> updateEmployee(
    int id, EmployeeRequestParams params, {required int isActive}) async {
    try { return right(await _dataSource.updateEmployee(id, params, isActive: isActive)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> deleteEmployee(int id) async {
    try { return right(await _dataSource.deleteEmployee(id)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, AttendanceListResponseModel>> getAttendance({
    int? employeeId, String? dateFrom, String? dateTo, String? attendanceStatus,
  }) async {
    try {
      return right(await _dataSource.getAttendance(
        employeeId: employeeId, dateFrom: dateFrom,
        dateTo: dateTo, attendanceStatus: attendanceStatus,
      ));
    } on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, AttendanceModel>> getAttendanceById(dynamic id) async {
    try { return right(await _dataSource.getAttendanceById(id)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> recordAttendance(
    AttendanceRequestParams params) async {
    try { return right(await _dataSource.recordAttendance(params)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> updateAttendance(
    AttendanceUpdateRequestParams params) async {
    try { return right(await _dataSource.updateAttendance(params)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> deleteAttendance(int id) async {
    try { return right(await _dataSource.deleteAttendance(id)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, PayrollListResponseModel>> getPayrolls({
    int? employeeId, String? payrollMonth, String? paymentStatus,
  }) async {
    try {
      return right(await _dataSource.getPayrolls(
        employeeId: employeeId, payrollMonth: payrollMonth, paymentStatus: paymentStatus,
      ));
    } on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, PayrollModel>> getPayrollById(int id) async {
    try { return right(await _dataSource.getPayrollById(id)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> generatePayroll(
    PayrollRequestParams params) async {
    try { return right(await _dataSource.generatePayroll(params)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> updatePayroll(
    int id, PayrollRequestParams params) async {
    try { return right(await _dataSource.updatePayroll(id, params)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, LeaveTypesListResponseModel>> getLeaveTypes() async {
    try { return right(await _dataSource.getLeaveTypes()); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, LeaveTypeModel>> getLeaveTypeById(int id) async {
    try { return right(await _dataSource.getLeaveTypeById(id)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> createLeaveType(
    LeaveTypeRequestParams params) async {
    try { return right(await _dataSource.createLeaveType(params)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> updateLeaveType(
    int id, LeaveTypeRequestParams params) async {
    try { return right(await _dataSource.updateLeaveType(id, params)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> deleteLeaveType(int id) async {
    try { return right(await _dataSource.deleteLeaveType(id)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, LeaveApplicationsListResponseModel>> getLeaveApplications({
    int? employeeId, String? status, int? leaveTypeId, String? dateFrom, String? dateTo,
  }) async {
    try {
      return right(await _dataSource.getLeaveApplications(
        employeeId: employeeId, status: status,
        leaveTypeId: leaveTypeId, dateFrom: dateFrom, dateTo: dateTo,
      ));
    } on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, LeaveApplicationModel>> getLeaveApplicationById(int id) async {
    try { return right(await _dataSource.getLeaveApplicationById(id)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> submitLeaveApplication(
    LeaveApplicationRequestParams params) async {
    try { return right(await _dataSource.submitLeaveApplication(params)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> updateLeaveApplication(
    int id, LeaveApplicationRequestParams params) async {
    try { return right(await _dataSource.updateLeaveApplication(id, params)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> approveRejectLeaveApplication(
    int id, LeaveApprovalRequestParams params) async {
    try { return right(await _dataSource.approveRejectLeaveApplication(id, params)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, CommonSuccessResponseModel>> cancelLeaveApplication(int id) async {
    try { return right(await _dataSource.cancelLeaveApplication(id)); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, LeaveBalanceListResponseModel>> getLeaveBalance({
    int? employeeId, int? year, int? leaveTypeId,
  }) async {
    try {
      return right(await _dataSource.getLeaveBalance(
        employeeId: employeeId, year: year, leaveTypeId: leaveTypeId,
      ));
    } on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, DashboardResponseModel>> getDashboard() async {
    try { return right(await _dataSource.getDashboard()); }
    on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> getReport({
    required String reportType, String? dateFrom, String? dateTo,
    String? department, int? employeeId,
  }) async {
    try {
      return right(await _dataSource.getReport(
        reportType: reportType, dateFrom: dateFrom,
        dateTo: dateTo, department: department, employeeId: employeeId,
      ));
    } on AppException catch (e) { return left(AppError.serverError(message: e.message)); }
  }
}
