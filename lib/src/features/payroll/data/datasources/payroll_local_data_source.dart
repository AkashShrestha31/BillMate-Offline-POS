import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/helpers/session_helper.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/features/payroll/data/models/request/delete_payroll_request.dart';
import 'package:hotel/src/features/payroll/data/models/request/generate_payroll_request.dart';
import 'package:hotel/src/features/payroll/data/models/request/payroll_query_params.dart';
import 'package:hotel/src/features/payroll/data/models/request/update_payment_request.dart';
import 'package:hotel/src/features/payroll/data/models/response/delete_payroll_response.dart';
import 'package:hotel/src/features/payroll/data/models/response/filters_applied_model.dart';
import 'package:hotel/src/features/payroll/data/models/response/generate_payroll_response.dart';
import 'package:hotel/src/features/payroll/data/models/response/payroll_list_response.dart';
import 'package:hotel/src/features/payroll/data/models/response/payroll_model.dart';
import 'package:hotel/src/features/payroll/data/models/response/payroll_summary_model.dart';
import 'package:hotel/src/features/payroll/data/models/response/update_payment_response.dart';
class PayrollLocalDataSource {
  PayrollLocalDataSource(this._db);

  final LocalDb _db;

  static const _payrollSelect = '''
    SELECT p.*,
           e.full_name AS employee_full_name,
           e.employee_code AS emp_code,
           e.department AS emp_department,
           e.position AS emp_position
    FROM EmployeePayroll p
    LEFT JOIN Employee e ON e.id = p.employee_id
  ''';

  Future<PayrollListResponse> getPayrolls({
    required PayrollQueryParams params,
  }) async {
    final conditions = <String>[];
    final args = <dynamic>[];

    if (params.employeeId != null) {
      conditions.add('p.employee_id = ?');
      args.add(params.employeeId);
    }
    if (params.payrollMonth != null && params.payrollMonth!.isNotEmpty) {
      conditions.add('p.payroll_month = ?');
      args.add(params.payrollMonth);
    }
    if (params.paymentStatus != null && params.paymentStatus!.isNotEmpty) {
      conditions.add('p.payment_status = ?');
      args.add(params.paymentStatus);
    }
    if (params.year != null) {
      conditions.add("p.payroll_month LIKE ?");
      args.add('${params.year}-%');
    }

    final where = conditions.isEmpty ? '' : 'WHERE ${conditions.join(' AND ')}';
    final sql = '$_payrollSelect $where ORDER BY p.payroll_month DESC, p.id DESC';

    final rows = await _db.rawQuery(sql, args);
    final records = rows.map(_mapRowToPayroll).toList();

    var totalGross = 0.0;
    var totalNet = 0.0;
    var totalDeductions = 0.0;
    for (final p in records) {
      totalGross += p.grossPay ?? 0;
      totalNet += p.netPay ?? 0;
      totalDeductions += p.totalDeductions ?? 0;
    }

    return PayrollListResponse(
      success: true,
      count: records.length,
      summary: PayrollSummaryModel(
        totalGrossPay: totalGross,
        totalNetPay: totalNet,
        totalDeductions: totalDeductions,
      ),
      filtersApplied: FiltersAppliedModel(
        employeeId: params.employeeId,
        payrollMonth: params.payrollMonth,
        paymentStatus: params.paymentStatus,
        year: params.year,
      ),
      payrollRecords: records,
    );
  }

  Future<GeneratePayrollResponse> generatePayroll({
    required GeneratePayrollRequest request,
  }) async {
    final db = await _db.database;
    final actor = await _actorId();

    final employees = await db.query(
      'Employee',
      where: 'id = ?',
      whereArgs: [request.employeeId],
      limit: 1,
    );
    if (employees.isEmpty) {
      throw const AppException(message: 'Employee not found');
    }
    final employee = employees.first;

    final existing = await db.query(
      'EmployeePayroll',
      where: 'employee_id = ? AND payroll_month = ?',
      whereArgs: [request.employeeId, request.payrollMonth],
      limit: 1,
    );
    if (existing.isNotEmpty) {
      throw const AppException(
        message: 'Payroll already exists for this employee and month',
      );
    }

    final parts = request.payrollMonth.split('-');
    if (parts.length != 2) {
      throw const AppException(message: 'Invalid payroll month');
    }
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final periodStart = DateTime(year, month, 1);
    final periodEnd = DateTime(year, month + 1, 0);

    final attendance = await db.rawQuery(
      '''
      SELECT COUNT(*) AS cnt
      FROM EmployeeAttendance
      WHERE employee_id = ?
        AND date(attendance_date) >= date(?)
        AND date(attendance_date) <= date(?)
        AND attendance_status = 'PRESENT'
      ''',
      [
        request.employeeId,
        _dateOnly(periodStart),
        _dateOnly(periodEnd),
      ],
    );
    final daysPresent = (attendance.first['cnt'] as int?) ?? 0;
    final workingDays = periodEnd.day;
    final daysAbsent = (workingDays - daysPresent).clamp(0, workingDays);

    final basic = (employee['basic_salary'] as num?)?.toDouble() ?? 0;
    final hourly = (employee['hourly_rate'] as num?)?.toDouble() ?? 0;
    final hoursPerDay = (employee['working_hours_per_day'] as num?)?.toDouble() ?? 8;

    final regularHours = daysPresent * hoursPerDay;
    final bonusDayHours = request.addBonusDay ? hoursPerDay : 0;
    final overtimeHours = bonusDayHours;
    final overtimePay = overtimeHours * hourly * 1.5;

    final bonus = request.bonus ?? 0;
    final allowances = request.additionalAllowances ?? 0;
    final gross = basic + overtimePay + bonus + allowances;

    final tax = gross * 0.1;
    final insurance = gross * 0.02;
    final pf = gross * 0.05;
    final otherDeductions = request.additionalDeductions ?? 0;
    final totalDeductions = tax + insurance + pf + otherDeductions;
    final net = gross - totalDeductions;

    final now = DateTime.now().toIso8601String();

    final id = await db.insert(
      'EmployeePayroll',
      {
        'employee_id': request.employeeId,
        'payroll_month': request.payrollMonth,
        'pay_period_start': _dateOnly(periodStart),
        'pay_period_end': _dateOnly(periodEnd),
        'total_working_days': workingDays,
        'days_present': daysPresent > 0 ? daysPresent : (workingDays - 2).clamp(1, workingDays),
        'days_absent': daysAbsent,
        'total_hours_worked': regularHours + overtimeHours,
        'regular_hours': regularHours,
        'overtime_hours': overtimeHours,
        'basic_salary': basic,
        'overtime_pay': overtimePay,
        'allowances': allowances,
        'bonus': bonus,
        'gross_pay': gross,
        'tax_deduction': tax,
        'insurance_deduction': insurance,
        'provident_fund': pf,
        'other_deductions': otherDeductions,
        'total_deductions': totalDeductions,
        'net_pay': net,
        'payment_status': 'PENDING',
        'payment_method': 'BANK_TRANSFER',
        'generated_by': actor,
        'is_approved': 0,
        'created_by': actor,
        'modified_by': actor,
        'created': now,
        'modified': now,
      },
    );

    final payroll = await _getPayrollById(id);
    return GeneratePayrollResponse(
      success: true,
      message: 'Payroll generated successfully',
      payroll: payroll,
    );
  }

  Future<UpdatePaymentResponse> updatePaymentStatus({
    required UpdatePaymentRequest request,
  }) async {
    final db = await _db.database;
    final actor = await _actorId();
    final now = DateTime.now().toIso8601String();

    final updated = await db.update(
      'EmployeePayroll',
      {
        'payment_status': 'PAID',
        'payment_date': request.paymentDate,
        'payment_method': request.paymentMethod ?? 'BANK_TRANSFER',
        'bank_reference': request.bankReference,
        'notes': request.notes,
        'paid_by': actor,
        'modified_by': actor,
        'modified': now,
      },
      where: 'id = ?',
      whereArgs: [request.payrollId],
    );

    if (updated == 0) {
      throw const AppException(message: 'Payroll record not found');
    }

    return const UpdatePaymentResponse(
      success: true,
      message: 'Payment status updated',
    );
  }

  Future<DeletePayrollResponse> deletePayroll({
    required DeletePayrollRequest request,
  }) async {
    final db = await _db.database;
    final deleted = await db.delete(
      'EmployeePayroll',
      where: 'id = ?',
      whereArgs: [request.payrollId],
    );

    if (deleted == 0) {
      throw const AppException(message: 'Payroll record not found');
    }

    return const DeletePayrollResponse(
      success: true,
      message: 'Payroll deleted successfully',
    );
  }

  Future<PayrollModel> _getPayrollById(int id) async {
    final rows = await _db.rawQuery(
      '$_payrollSelect WHERE p.id = ?',
      [id],
    );
    if (rows.isEmpty) {
      throw const AppException(message: 'Payroll record not found');
    }
    return _mapRowToPayroll(rows.first);
  }

  PayrollModel _mapRowToPayroll(Map<String, dynamic> row) {
    final isApproved = row['is_approved'];
    return PayrollModel(
      id: row['id'] as int,
      employeeId: row['employee_id'] as int?,
      employeeName: row['employee_full_name']?.toString() ?? 'Employee',
      employeeCode: row['emp_code']?.toString() ?? '',
      department: row['emp_department']?.toString() ?? '',
      position: row['emp_position']?.toString() ?? '',
      payrollMonth: row['payroll_month']?.toString() ?? '',
      payPeriodStart: row['pay_period_start']?.toString() ?? '',
      payPeriodEnd: row['pay_period_end']?.toString() ?? '',
      totalWorkingDays: row['total_working_days'] as int?,
      daysPresent: row['days_present'] as int?,
      daysAbsent: row['days_absent'] as int?,
      sickDays: row['sick_days'] as int?,
      vacationDays: row['vacation_days'] as int?,
      totalHoursWorked: (row['total_hours_worked'] as num?)?.toDouble(),
      regularHours: (row['regular_hours'] as num?)?.toDouble(),
      overtimeHours: (row['overtime_hours'] as num?)?.toDouble(),
      basicSalary: (row['basic_salary'] as num?)?.toDouble(),
      overtimePay: (row['overtime_pay'] as num?)?.toDouble(),
      allowances: (row['allowances'] as num?)?.toDouble(),
      bonus: (row['bonus'] as num?)?.toDouble(),
      grossPay: (row['gross_pay'] as num?)?.toDouble(),
      taxDeduction: (row['tax_deduction'] as num?)?.toDouble(),
      insuranceDeduction: (row['insurance_deduction'] as num?)?.toDouble(),
      providentFund: (row['provident_fund'] as num?)?.toDouble(),
      otherDeductions: (row['other_deductions'] as num?)?.toDouble(),
      totalDeductions: (row['total_deductions'] as num?)?.toDouble(),
      netPay: (row['net_pay'] as num?)?.toDouble(),
      paymentDate: row['payment_date']?.toString(),
      paymentMethod: row['payment_method']?.toString() ?? '',
      paymentStatus: row['payment_status']?.toString() ?? '',
      bankReference: row['bank_reference']?.toString(),
      notes: row['notes']?.toString(),
      generatedBy: row['generated_by']?.toString(),
      approvedBy: row['approved_by']?.toString(),
      paidBy: row['paid_by']?.toString(),
      isApproved: isApproved == 1 || isApproved == true,
      created: row['created']?.toString() ?? '',
      modified: row['modified']?.toString() ?? '',
    );
  }

  Future<String> _actorId() async {
    return (await SessionHelper.getLoggedInEmail()) ?? 'local_user';
  }

  String _dateOnly(DateTime d) {
    return '${d.year.toString().padLeft(4, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }
}
