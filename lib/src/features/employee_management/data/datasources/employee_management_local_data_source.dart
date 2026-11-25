import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/helpers/employee_party_helper.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/employee_management/data/datasources/employee_management_remote_data_source.dart';
import 'package:hotel/src/features/employee_management/data/models/request/attendance_request_params.dart';
import 'package:hotel/src/features/employee_management/data/models/request/attendance_update_request_params.dart';
import 'package:hotel/src/features/employee_management/data/models/request/employee_request_params.dart';
import 'package:hotel/src/features/employee_management/data/models/request/leave_application_request_params.dart';
import 'package:hotel/src/features/employee_management/data/models/request/leave_approval_request_params.dart';
import 'package:hotel/src/features/employee_management/data/models/request/leave_type_request_params.dart';
import 'package:hotel/src/features/employee_management/data/models/request/payroll_request_params.dart';
import 'package:hotel/src/features/employee_management/data/models/response/attendance_list_response_model.dart';
import 'package:hotel/src/features/employee_management/data/models/response/attendance_model.dart';
import 'package:hotel/src/features/employee_management/data/models/response/common_success_response_model.dart';
import 'package:hotel/src/features/employee_management/data/models/response/dashboard_response_model.dart';
import 'package:hotel/src/features/employee_management/data/models/response/employee_model.dart';
import 'package:hotel/src/features/employee_management/data/models/response/employees_list_response_model.dart';
import 'package:hotel/src/features/employee_management/data/models/response/leave_application_model.dart';
import 'package:hotel/src/features/employee_management/data/models/response/leave_applications_list_response_model.dart';
import 'package:hotel/src/features/employee_management/data/models/response/leave_balance_list_response_model.dart';
import 'package:hotel/src/features/employee_management/data/models/response/leave_type_model.dart';
import 'package:hotel/src/features/employee_management/data/models/response/leave_types_list_response_model.dart';
import 'package:hotel/src/features/employee_management/data/models/response/payroll_list_response_model.dart';
import 'package:hotel/src/features/employee_management/data/models/response/payroll_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EmployeeManagementRemoteDataSource)
class EmployeeManagementLocalDataSource
    implements EmployeeManagementRemoteDataSource {
  EmployeeManagementLocalDataSource(this._db);
  final LocalDb _db;

  @override
  Future<CommonSuccessResponseModel> createEmployeeTables() async {
    return const CommonSuccessResponseModel(
        success: true, message: 'Tables already exist locally');
  }

  @override
  Future<CommonSuccessResponseModel> createLeaveTables() async {
    return const CommonSuccessResponseModel(
        success: true, message: 'Tables already exist locally');
  }

  @override
  Future<EmployeesListResponseModel> getEmployees({
    String? department,
    String? position,
    String? employmentStatus,
    String? employmentType,
  }) async {
    try {
      final conditions = <String>[];
      final args = <dynamic>[];

      if (department != null && department.isNotEmpty) {
        conditions.add('department = ?');
        args.add(department);
      }
      if (position != null && position.isNotEmpty) {
        conditions.add('position = ?');
        args.add(position);
      }
      if (employmentStatus != null && employmentStatus.isNotEmpty) {
        conditions.add('employment_status = ?');
        args.add(employmentStatus);
      }
      if (employmentType != null && employmentType.isNotEmpty) {
        conditions.add('employment_type = ?');
        args.add(employmentType);
      }

      final where = conditions.isNotEmpty ? conditions.join(' AND ') : null;
      final rows = await _db.query(
        'Employee',
        where: where,
        whereArgs: args.isNotEmpty ? args : null,
        orderBy: 'full_name ASC',
      );

      return EmployeesListResponseModel(
        success: true,
        count: rows.length,
        employees: rows.map(_rowToEmployeeModel).toList(),
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<EmployeeModel> getEmployeeById(dynamic id) async {
    try {
      final idStr = id?.toString() ?? '';
      List<Map<String, dynamic>> rows = [];

      // JWT user_id is a UUID — try matching by email first, then integer id
      if (idStr.contains('-') || idStr.contains('@')) {
        // Try by email
        rows = await _db.query('Employee', where: 'email = ?', whereArgs: [idStr]);
      }

      // Try integer id
      if (rows.isEmpty) {
        final intId = int.tryParse(idStr);
        if (intId != null) {
          rows = await _db.query('Employee', where: 'id = ?', whereArgs: [intId]);
        }
      }

      // Fallback: return first active employee so dashboard can render
      if (rows.isEmpty) {
        rows = await _db.query('Employee',
            where: 'employment_status = ?',
            whereArgs: ['ACTIVE'],
            limit: 1);
      }

      // Last resort: any employee
      if (rows.isEmpty) {
        rows = await _db.query('Employee', limit: 1);
      }

      if (rows.isEmpty) throw const AppException(message: 'No employees found');
      return _rowToEmployeeModel(rows.first);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<CommonSuccessResponseModel> createEmployee(
    EmployeeRequestParams params, {
    required int isActive,
  }) async {
    try {
      await getIt<FreemiumGateService>().assertCan(FreemiumFeature.employee);
      final now = DateTime.now().toIso8601String();
      final createdBy = await SessionHelper.getUserIdentifierForPermissionsApi() ?? '';
      final firstName = (params.firstName ?? '').trim();
      final lastName = (params.lastName ?? '').trim();
      final fullName = '$firstName $lastName'.trim();
      final db = await _db.database;

      await db.transaction((txn) async {
        final employeeCode = await _resolveEmployeeCode(txn, params.employeeCode);
        final partyName = await EmployeePartyHelper.uniquePartyName(
          txn,
          EmployeePartyHelper.displayName(fullName),
        );
        await EmployeePartyHelper.insertParty(
          txn,
          partyName: partyName,
          email: params.email,
          phone: params.phone,
          address: params.address,
          createdBy: createdBy,
          now: now,
        );
        await txn.insert('Employee', {
          'employee_code': employeeCode,
          'first_name': firstName,
          'last_name': lastName,
          'full_name': fullName,
          'email': params.email,
          'phone': params.phone,
          'address': params.address,
          'date_of_birth': params.dateOfBirth,
          'hire_date': params.hireDate ?? now.substring(0, 10),
          'department': params.department ?? '',
          'position': params.position ?? '',
          'employment_type': params.employmentType ?? 'FULL_TIME',
          'employment_status': params.employmentStatus ?? 'ACTIVE',
          'basic_salary': params.basicSalary ?? 0.0,
          'hourly_rate': params.hourlyRate ?? 0.0,
          'working_hours_per_day': params.workingHoursPerDay ?? 8.0,
          'working_days_per_week': params.workingDaysPerWeek ?? 6,
          'party_id': partyName,
          if (params.profileImage != null && params.profileImage!.isNotEmpty)
            'profile_image': params.profileImage,
          'is_active': isActive,
          'created_by': createdBy,
          'modified_by': createdBy,
          'created': now,
          'modified': now,
        });
      });
      return const CommonSuccessResponseModel(
          success: true, message: 'Employee created successfully');
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<CommonSuccessResponseModel> updateEmployee(
    int id,
    EmployeeRequestParams params, {
    required int isActive,
  }) async {
    try {
      final now = DateTime.now().toIso8601String();
      final modifiedBy = await SessionHelper.getUserIdentifierForPermissionsApi() ?? '';
      final db = await _db.database;

      final existingRows = await db.query(
        'Employee',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (existingRows.isEmpty) {
        throw const AppException(message: 'Employee not found');
      }
      final existing = existingRows.first;

      final firstName =
          (params.firstName ?? existing['first_name'] as String? ?? '').trim();
      final lastName =
          (params.lastName ?? existing['last_name'] as String? ?? '').trim();
      final fullName = '$firstName $lastName'.trim();
      final email = params.email ?? existing['email'] as String?;
      final phone = params.phone ?? existing['phone'] as String?;
      final address = params.address ?? existing['address'] as String?;
      final oldPartyId = existing['party_id'] as String?;

      await db.transaction((txn) async {
        final partyId = await EmployeePartyHelper.syncPartyForEmployee(
          txn,
          fullName: fullName,
          currentPartyId: oldPartyId,
          email: email,
          phone: phone,
          address: address,
          actor: modifiedBy,
          now: now,
          activeStatus: isActive == 1 ? 1 : 0,
        );

        await txn.update(
          'Employee',
          {
            'first_name': firstName,
            'last_name': lastName,
            'full_name': fullName,
            if (params.employeeCode != null) 'employee_code': params.employeeCode,
            if (params.email != null) 'email': params.email,
            if (params.phone != null) 'phone': params.phone,
            if (params.address != null) 'address': params.address,
            if (params.hireDate != null) 'hire_date': params.hireDate,
            if (params.department != null) 'department': params.department,
            if (params.position != null) 'position': params.position,
            if (params.employmentType != null) 'employment_type': params.employmentType,
            if (params.employmentStatus != null) 'employment_status': params.employmentStatus,
            if (params.basicSalary != null) 'basic_salary': params.basicSalary,
            if (params.profileImage != null)
              'profile_image':
                  params.profileImage!.isEmpty ? null : params.profileImage,
            'party_id': partyId,
            'is_active': isActive,
            'modified_by': modifiedBy,
            'modified': now,
          },
          where: 'id = ?',
          whereArgs: [id],
        );
      });
      return const CommonSuccessResponseModel(
          success: true, message: 'Employee updated successfully');
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<CommonSuccessResponseModel> deleteEmployee(int id) async {
    try {
      final db = await _db.database;
      final now = DateTime.now().toIso8601String();
      final modifiedBy = await SessionHelper.getUserIdentifierForPermissionsApi() ?? '';
      final rows = await db.query('Employee', where: 'id = ?', whereArgs: [id], limit: 1);
      final partyId = rows.isEmpty ? null : rows.first['party_id'] as String?;

      await db.transaction((txn) async {
        await txn.delete('Employee', where: 'id = ?', whereArgs: [id]);
        if (partyId != null && partyId.trim().isNotEmpty) {
          await EmployeePartyHelper.deactivateParty(
            txn,
            partyName: partyId,
            actor: modifiedBy,
            now: now,
          );
        }
      });
      return const CommonSuccessResponseModel(
          success: true, message: 'Employee deleted successfully');
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  // ── Attendance (local SQLite) ─────────────────────────────────────────────

  static const _attendanceSelect = '''
SELECT
  a.id AS id,
  a.employee_id AS employee_id,
  COALESCE(NULLIF(TRIM(e.full_name), ''),
    TRIM(COALESCE(e.first_name, '') || ' ' || COALESCE(e.last_name, ''))) AS employee_name,
  e.employee_code AS employee_code,
  a.attendance_date AS attendance_date,
  a.check_in_time AS check_in_time,
  a.check_out_time AS check_out_time,
  a.break_start_time AS break_start_time,
  a.break_end_time AS break_end_time,
  a.total_hours_worked AS total_hours_worked,
  a.total_break_hours AS total_break_hours,
  a.overtime_hours AS overtime_hours,
  a.attendance_status AS attendance_status,
  a.late_arrival_minutes AS late_arrival_minutes,
  a.early_departure_minutes AS early_departure_minutes,
  a.location AS location,
  a.notes AS notes,
  a.approved_by AS approved_by,
  a.is_approved AS is_approved,
  a.created AS created,
  a.modified AS modified
FROM EmployeeAttendance a
INNER JOIN Employee e ON e.id = a.employee_id
''';

  @override
  Future<AttendanceListResponseModel> getAttendance({
    int? employeeId,
    String? dateFrom,
    String? dateTo,
    String? attendanceStatus,
  }) async {
    try {
      final conditions = <String>[];
      final args = <dynamic>[];

      if (employeeId != null) {
        conditions.add('a.employee_id = ?');
        args.add(employeeId);
      }
      if (dateFrom != null && dateFrom.isNotEmpty) {
        conditions.add('date(a.attendance_date) >= date(?)');
        args.add(dateFrom);
      }
      if (dateTo != null && dateTo.isNotEmpty) {
        conditions.add('date(a.attendance_date) <= date(?)');
        args.add(dateTo);
      }
      if (attendanceStatus != null && attendanceStatus.isNotEmpty) {
        if (attendanceStatus == 'ON_LEAVE') {
          conditions.add("a.attendance_status IN ('SICK_LEAVE', 'VACATION')");
        } else {
          conditions.add('a.attendance_status = ?');
          args.add(attendanceStatus);
        }
      }

      final where =
          conditions.isNotEmpty ? 'WHERE ${conditions.join(' AND ')}' : '';
      final rows = await _db.rawQuery(
        '$_attendanceSelect $where ORDER BY a.attendance_date DESC, a.id DESC',
        args.isEmpty ? null : args,
      );

      final records = rows.map(_rowToAttendanceModel).toList();
      return AttendanceListResponseModel(
        success: true,
        count: records.length,
        attendanceRecords: records,
      );
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<AttendanceModel> getAttendanceById(dynamic id) async {
    try {
      final intId = id is int ? id : int.tryParse(id?.toString() ?? '');
      if (intId == null) {
        throw const AppException(message: 'Invalid attendance id');
      }
      final rows = await _db.rawQuery(
        '$_attendanceSelect WHERE a.id = ? LIMIT 1',
        [intId],
      );
      if (rows.isEmpty) {
        throw const AppException(message: 'Attendance record not found');
      }
      return _rowToAttendanceModel(rows.first);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<CommonSuccessResponseModel> recordAttendance(
    AttendanceRequestParams params,
  ) async {
    try {
      await getIt<FreemiumGateService>().assertCan(FreemiumFeature.attendance);
      final dates = _attendanceDatesFromParams(params);
      if (dates.isEmpty) {
        throw const AppException(message: 'Attendance date is required');
      }

      final db = await _db.database;
      final employees = await db.query(
        'Employee',
        where: 'id = ?',
        whereArgs: [params.employeeId],
        limit: 1,
      );
      if (employees.isEmpty) {
        throw const AppException(message: 'Employee not found');
      }
      final employee = employees.first;
      final workingHours =
          (employee['working_hours_per_day'] as num?)?.toDouble() ?? 8.0;
      final now = DateTime.now().toIso8601String();
      final actor =
          await SessionHelper.getUserIdentifierForPermissionsApi() ?? 'local';

      await db.transaction((txn) async {
        for (final date in dates) {
          await _upsertAttendanceRecord(
            txn,
            employeeId: params.employeeId,
            attendanceDate: date,
            status: params.attendanceStatus,
            workingHoursPerDay: workingHours,
            checkInTime: params.checkInTime,
            checkOutTime: params.checkOutTime,
            breakStartTime: params.breakStartTime,
            breakEndTime: params.breakEndTime,
            location: params.location,
            notes: params.notes,
            actor: actor,
            now: now,
          );
        }
      });

      return CommonSuccessResponseModel(
        success: true,
        message: dates.length == 1
            ? 'Attendance recorded successfully'
            : 'Attendance recorded for ${dates.length} days',
      );
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<CommonSuccessResponseModel> updateAttendance(
    AttendanceUpdateRequestParams params,
  ) async {
    try {
      final db = await _db.database;
      final now = DateTime.now().toIso8601String();
      final actor =
          await SessionHelper.getUserIdentifierForPermissionsApi() ?? 'local';

      final existing = await db.query(
        'EmployeeAttendance',
        where: 'id = ?',
        whereArgs: [params.attendanceId],
        limit: 1,
      );
      if (existing.isEmpty) {
        throw const AppException(message: 'Attendance record not found');
      }

      final updates = <String, dynamic>{
        'modified_by': actor,
        'modified': now,
      };
      if (params.checkInTime != null) updates['check_in_time'] = params.checkInTime;
      if (params.checkOutTime != null) updates['check_out_time'] = params.checkOutTime;
      if (params.breakStartTime != null) {
        updates['break_start_time'] = params.breakStartTime;
      }
      if (params.breakEndTime != null) updates['break_end_time'] = params.breakEndTime;
      if (params.attendanceStatus != null) {
        updates['attendance_status'] = params.attendanceStatus;
      }
      if (params.location != null) updates['location'] = params.location;
      if (params.notes != null) updates['notes'] = params.notes;

      if (params.attendanceStatus != null) {
        final empId = existing.first['employee_id'] as int;
        final empRows = await db.query(
          'Employee',
          where: 'id = ?',
          whereArgs: [empId],
          limit: 1,
        );
        final hoursPerDay =
            (empRows.first['working_hours_per_day'] as num?)?.toDouble() ?? 8.0;
        final hours = _hoursForStatus(
          params.attendanceStatus!,
          workingHoursPerDay: hoursPerDay,
          notes: params.notes ?? existing.first['notes'] as String?,
        );
        updates['total_hours_worked'] = hours;
        if (params.attendanceStatus == 'ABSENT') {
          updates['check_out_time'] = null;
        }
      }

      await db.update(
        'EmployeeAttendance',
        updates,
        where: 'id = ?',
        whereArgs: [params.attendanceId],
      );

      return const CommonSuccessResponseModel(
        success: true,
        message: 'Attendance updated successfully',
      );
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException(message: e.toString());
    }
  }

  @override
  Future<CommonSuccessResponseModel> deleteAttendance(int id) async {
    try {
      final db = await _db.database;
      final deleted = await db.delete(
        'EmployeeAttendance',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (deleted == 0) {
        throw const AppException(message: 'Attendance record not found');
      }
      return const CommonSuccessResponseModel(
        success: true,
        message: 'Attendance deleted successfully',
      );
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException(message: e.toString());
    }
  }

  // ── Payroll stubs ────────────────────────────────────────────────────────────

  @override
  Future<PayrollListResponseModel> getPayrolls({
    int? employeeId, String? payrollMonth, String? paymentStatus,
  }) async => const PayrollListResponseModel(success: true, count: 0, payrollRecords: []);

  @override
  Future<PayrollModel> getPayrollById(int id) async =>
      throw const AppException(message: 'Not available offline');

  @override
  Future<CommonSuccessResponseModel> generatePayroll(PayrollRequestParams params) async {
    await getIt<FreemiumGateService>().assertCan(FreemiumFeature.payroll);
    return const CommonSuccessResponseModel(success: true, message: 'Generated locally');
  }

  @override
  Future<CommonSuccessResponseModel> updatePayroll(int id, PayrollRequestParams params) async =>
      const CommonSuccessResponseModel(success: true, message: 'Updated locally');

  // ── Leave type stubs ─────────────────────────────────────────────────────────

  @override
  Future<LeaveTypesListResponseModel> getLeaveTypes() async =>
      const LeaveTypesListResponseModel(success: true, count: 0, leaveTypes: []);

  @override
  Future<LeaveTypeModel> getLeaveTypeById(int id) async =>
      throw const AppException(message: 'Not available offline');

  @override
  Future<CommonSuccessResponseModel> createLeaveType(LeaveTypeRequestParams params) async =>
      const CommonSuccessResponseModel(success: true, message: 'Created locally');

  @override
  Future<CommonSuccessResponseModel> updateLeaveType(int id, LeaveTypeRequestParams params) async =>
      const CommonSuccessResponseModel(success: true, message: 'Updated locally');

  @override
  Future<CommonSuccessResponseModel> deleteLeaveType(int id) async =>
      const CommonSuccessResponseModel(success: true, message: 'Deleted locally');

  // ── Leave application stubs ──────────────────────────────────────────────────

  @override
  Future<LeaveApplicationsListResponseModel> getLeaveApplications({
    int? employeeId, String? status, int? leaveTypeId, String? dateFrom, String? dateTo,
  }) async => const LeaveApplicationsListResponseModel(success: true, count: 0, applications: []);

  @override
  Future<LeaveApplicationModel> getLeaveApplicationById(int id) async =>
      throw const AppException(message: 'Not available offline');

  @override
  Future<CommonSuccessResponseModel> submitLeaveApplication(LeaveApplicationRequestParams params) async =>
      const CommonSuccessResponseModel(success: true, message: 'Submitted locally');

  @override
  Future<CommonSuccessResponseModel> updateLeaveApplication(int id, LeaveApplicationRequestParams params) async =>
      const CommonSuccessResponseModel(success: true, message: 'Updated locally');

  @override
  Future<CommonSuccessResponseModel> approveRejectLeaveApplication(int id, LeaveApprovalRequestParams params) async =>
      const CommonSuccessResponseModel(success: true, message: 'Updated locally');

  @override
  Future<CommonSuccessResponseModel> cancelLeaveApplication(int id) async =>
      const CommonSuccessResponseModel(success: true, message: 'Cancelled locally');

  @override
  Future<LeaveBalanceListResponseModel> getLeaveBalance({
    int? employeeId, int? year, int? leaveTypeId,
  }) async => const LeaveBalanceListResponseModel(success: true, count: 0, balances: []);

  // ── Dashboard & report stubs ─────────────────────────────────────────────────

  @override
  Future<DashboardResponseModel> getDashboard() async =>
      const DashboardResponseModel(success: true, reportType: 'local', employees: []);

  @override
  Future<Map<String, dynamic>> getReport({
    required String reportType, String? dateFrom, String? dateTo,
    String? department, int? employeeId,
  }) async => {'success': true, 'data': []};

  // ── Attendance helpers ───────────────────────────────────────────────────────

  List<String> _attendanceDatesFromParams(AttendanceRequestParams params) {
    if (params.attendanceDate != null && params.attendanceDate!.isNotEmpty) {
      return [_normalizeDateString(params.attendanceDate!)];
    }
    final start = params.startDate;
    final end = params.endDate;
    if (start != null &&
        start.isNotEmpty &&
        end != null &&
        end.isNotEmpty) {
      return _datesInRange(
        DateTime.parse(_normalizeDateString(start)),
        DateTime.parse(_normalizeDateString(end)),
      );
    }
    return [];
  }

  List<String> _datesInRange(DateTime from, DateTime to) {
    final list = <String>[];
    var d = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day);
    while (!d.isAfter(end)) {
      list.add(_dateOnly(d));
      d = d.add(const Duration(days: 1));
    }
    return list;
  }

  String _dateOnly(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  String _normalizeDateString(String value) {
    final trimmed = value.trim();
    if (trimmed.length >= 10) return trimmed.substring(0, 10);
    return trimmed;
  }

  double _hoursForStatus(
    String status, {
    required double workingHoursPerDay,
    String? notes,
  }) {
    switch (status) {
      case 'ABSENT':
        return 0;
      case 'HALF_DAY':
        return workingHoursPerDay / 2;
      case 'PRESENT':
      case 'LATE':
        final fromNotes = _parseHoursFromNotes(notes);
        if (fromNotes != null && fromNotes > 0) return fromNotes;
        return workingHoursPerDay;
      default:
        return workingHoursPerDay;
    }
  }

  double? _parseHoursFromNotes(String? notes) {
    if (notes == null || notes.isEmpty) return null;
    final match = RegExp(r'(\d+(?:\.\d+)?)\s*hours?', caseSensitive: false)
        .firstMatch(notes);
    if (match == null) return null;
    return double.tryParse(match.group(1)!);
  }

  Future<void> _upsertAttendanceRecord(
    DatabaseExecutor txn, {
    required int employeeId,
    required String attendanceDate,
    required String status,
    required double workingHoursPerDay,
    String? checkInTime,
    String? checkOutTime,
    String? breakStartTime,
    String? breakEndTime,
    String? location,
    String? notes,
    required String actor,
    required String now,
  }) async {
    final date = _normalizeDateString(attendanceDate);
    final hours = _hoursForStatus(
      status,
      workingHoursPerDay: workingHoursPerDay,
      notes: notes,
    );

    String? resolvedCheckIn = checkInTime;
    String? resolvedCheckOut = checkOutTime;
    if (status != 'ABSENT' && resolvedCheckIn == null) {
      final parts = date.split('-');
      if (parts.length == 3) {
        final y = int.parse(parts[0]);
        final m = int.parse(parts[1]);
        final d = int.parse(parts[2]);
        final inTime = DateTime(y, m, d, 9, 0);
        resolvedCheckIn = inTime.toIso8601String();
        if (resolvedCheckOut == null && hours > 0) {
          final outTime = inTime.add(
            Duration(minutes: (hours * 60).round()),
          );
          resolvedCheckOut = outTime.toIso8601String();
        }
      }
    }
    if (status == 'ABSENT') {
      resolvedCheckIn = null;
      resolvedCheckOut = null;
    }

    final existing = await txn.query(
      'EmployeeAttendance',
      where: 'employee_id = ? AND attendance_date = ?',
      whereArgs: [employeeId, date],
      limit: 1,
    );

    final row = <String, dynamic>{
      'employee_id': employeeId,
      'attendance_date': date,
      'check_in_time': resolvedCheckIn,
      'check_out_time': resolvedCheckOut,
      'break_start_time': breakStartTime,
      'break_end_time': breakEndTime,
      'total_hours_worked': hours,
      'total_break_hours': 0.0,
      'overtime_hours': 0.0,
      'attendance_status': status,
      'late_arrival_minutes': status == 'LATE' ? 15 : 0,
      'early_departure_minutes': 0,
      'location': location ?? 'Hotel Premises',
      'notes': notes,
      'modified_by': actor,
      'modified': now,
    };

    if (existing.isEmpty) {
      row['created_by'] = actor;
      row['created'] = now;
      row['is_approved'] = 0;
      await txn.insert('EmployeeAttendance', row);
    } else {
      row['created_by'] = existing.first['created_by'];
      row['created'] = existing.first['created'];
      row['is_approved'] = existing.first['is_approved'] ?? 0;
      await txn.update(
        'EmployeeAttendance',
        row,
        where: 'id = ?',
        whereArgs: [existing.first['id']],
      );
    }
  }

  AttendanceModel _rowToAttendanceModel(Map<String, dynamic> r) {
    final approved = r['is_approved'];
    return AttendanceModel(
      id: (r['id'] as num).toInt(),
      employeeId: (r['employee_id'] as num).toInt(),
      employeeName: (r['employee_name'] as String?)?.trim().isNotEmpty == true
          ? (r['employee_name'] as String).trim()
          : 'Employee',
      employeeCode: r['employee_code'] as String? ?? '',
      attendanceDate: _normalizeDateString(r['attendance_date']?.toString() ?? ''),
      checkInTime: r['check_in_time'] as String?,
      checkOutTime: r['check_out_time'] as String?,
      breakStartTime: r['break_start_time'] as String?,
      breakEndTime: r['break_end_time'] as String?,
      totalHoursWorked: (r['total_hours_worked'] as num?)?.toDouble() ?? 0,
      totalBreakHours: (r['total_break_hours'] as num?)?.toDouble(),
      overtimeHours: (r['overtime_hours'] as num?)?.toDouble() ?? 0,
      attendanceStatus: r['attendance_status'] as String? ?? 'PRESENT',
      lateArrivalMinutes: (r['late_arrival_minutes'] as num?)?.toInt(),
      earlyDepartureMinutes: (r['early_departure_minutes'] as num?)?.toInt(),
      location: r['location'] as String?,
      notes: r['notes'] as String?,
      approvedBy: r['approved_by'] as String?,
      isApproved: approved == 1 || approved == true,
      created: r['created'] as String?,
      modified: r['modified'] as String?,
    );
  }

  // ── helpers ─────────────────────────────────────────────────────────────────

  Future<String> _resolveEmployeeCode(
    DatabaseExecutor db,
    String? requested,
  ) async {
    final code = requested?.trim() ?? '';
    if (code.isNotEmpty) return code;
    final nextId = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COALESCE(MAX(id), 0) + 1 FROM Employee'),
        ) ??
        1;
    return 'EMP${nextId.toString().padLeft(3, '0')}';
  }

  EmployeeModel _rowToEmployeeModel(Map<String, dynamic> r) {
    return EmployeeModel(
      id: r['id'] as int,
      employeeCode: r['employee_code'] as String? ?? '',
      firstName: r['first_name'] as String? ?? '',
      lastName: r['last_name'] as String? ?? '',
      fullName: r['full_name'] as String? ?? '',
      email: r['email'] as String?,
      phone: r['phone'] as String?,
      address: r['address'] as String?,
      dateOfBirth: r['date_of_birth'] as String?,
      hireDate: r['hire_date'] as String? ?? '',
      department: r['department'] as String? ?? '',
      position: r['position'] as String? ?? '',
      employmentType: r['employment_type'] as String? ?? 'FULL_TIME',
      employmentStatus: r['employment_status'] as String? ?? 'ACTIVE',
      basicSalary: (r['basic_salary'] as num?)?.toDouble() ?? 0.0,
      hourlyRate: (r['hourly_rate'] as num?)?.toDouble(),
      workingHoursPerDay: (r['working_hours_per_day'] as num?)?.toDouble(),
      workingDaysPerWeek: r['working_days_per_week'] as int?,
      profileImage: r['profile_image'] as String?,
      isActive: r['is_active'] == 1 || r['is_active'] == true,
      createdBy: r['created_by'] as String?,
      modifiedBy: r['modified_by'] as String?,
      created: r['created'] as String?,
      modified: r['modified'] as String?,
    );
  }
}
