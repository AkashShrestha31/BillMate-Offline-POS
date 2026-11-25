import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/features/employee_management/data/models/response/dashboard_response_model.dart';
import 'package:hotel/src/features/employee_management/data/models/response/employee_model.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

import '../../../payroll/presentation/pages/payroll_list_page.dart';
import '../widgets/employee_hub_scaffold.dart';
import '../bloc/dashboard_cubit.dart';
import 'employees_list_page.dart';
import 'attendance_list_page.dart';
import 'leave_applications_list_page.dart';

@RoutePage()
class EmployeeDashboardPage extends StatelessWidget {
  const EmployeeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardCubit>()..getDashboard(),
      child: const _EmployeeDashboardView(),
    );
  }
}

class _EmployeeDashboardView extends StatelessWidget {
  const _EmployeeDashboardView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: employeeHubShellColor(scheme),
      appBar: AppBar(
        leading: AppBarIosBackButton(color: scheme.onSurface),
        backgroundColor: employeeHubShellColor(scheme),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Employee',
          style: AppFonts.interStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: CircularProgressIndicator()),
            loading: () => Center(child: CircularProgressIndicator()),
            noInternet: () => _buildErrorState(
              context: context,
              icon: Icons.wifi_off_rounded,
              title: 'No Internet',
              message: 'Please check your connection',
              onRetry: () => context.read<DashboardCubit>().getDashboard(),
            ),
            error: (message) => _buildErrorState(
              context: context,
              icon: Icons.error_outline_rounded,
              title: 'Error',
              message: message,
              onRetry: () => context.read<DashboardCubit>().getDashboard(),
            ),
            loaded: (response) => _buildDashboardContent(context, response),
            reportLoaded: (reportData) => _buildReportContent(context, reportData),
          );
        },
      ),
    );
  }

  Widget _buildErrorState({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String message,
    required VoidCallback onRetry,
  }) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: scheme.onSurfaceVariant),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppFonts.interStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(message, style: AppFonts.interStyle(color: scheme.onSurfaceVariant)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: Icon(Icons.refresh),
            label: Text('Retry'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, DashboardResponseModel response) {
    final employeeOverview = response.employeeOverview;
    final attendanceToday = response.attendanceToday;
    final leaveManagement = response.leaveManagement;
    final payrollStatus = response.payrollStatus;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<DashboardCubit>().getDashboard();
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Attendance Card
          // _buildAttendanceCard(context, attendanceToday),
          // const SizedBox(height: 16),

          // Leave & Payroll Row
          Row(
            children: [
              // Expanded(child: _buildLeaveCard(context, leaveManagement)),
              // const SizedBox(width: 16),
              // Expanded(child: _buildPayrollCard(context, payrollStatus)),
            ],
          ),
          // const SizedBox(height: 16),

          // Quick Actions
          _buildQuickActions(context, response.employees),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, List<EmployeeModel> employees) {
    final scheme = Theme.of(context).colorScheme;
    final actions = [
      {
        'label': 'Attendance',
        'icon': Icons.access_time_rounded,
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AttendanceListPage()),
        ),
      },
      {
        'label': 'Payroll',
        'icon': Icons.payments_rounded,
        'onTap': () => context.router.push(PayrollListRoute()),
      },
      {
        'label': 'Leave',
        'icon': Icons.event_note_rounded,
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LeaveApplicationsListPage()),
        ),
      },
    ];

    return Row(
      children: actions.map((action) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: action == actions.last ? 0 : 8,
              left: action == actions.first ? 0 : 8,
            ),
            child: Material(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: action['onTap'] as VoidCallback,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Icon(
                        action['icon'] as IconData,
                        size: 28,
                        color: context.theme.colorScheme.primary,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        action['label'] as String,
                        style: AppFonts.interStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: scheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAttendanceCard(BuildContext context, Map<String, dynamic>? attendance) {
    if (attendance == null) return const SizedBox.shrink();

    final presentToday = attendance['present_today'] ?? 0;
    final totalExpected = attendance['total_expected'] ?? 0;
    final absentToday = attendance['absent_today'] ?? 0;
    final onLeaveToday = attendance['on_leave_today'] ?? 0;
    final attendanceRate = attendance['attendance_rate'] ?? 0.0;

    final progressValue = totalExpected > 0 ? presentToday / totalExpected : 0.0;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AttendanceListPage()),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today\'s Attendance',
                    style: AppFonts.interStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${attendanceRate.toStringAsFixed(0)}%',
                    style: AppFonts.interStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '$presentToday / $totalExpected Present',
                style: AppFonts.interStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progressValue,
                  minHeight: 6,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[800]!),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildChip('Absent: $absentToday'),
                  const SizedBox(width: 8),
                  _buildChip('On Leave: $onLeaveToday'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        label,
        style: AppFonts.interStyle(
          fontSize: 12,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildLeaveCard(BuildContext context, Map<String, dynamic>? leave) {
    if (leave == null) return const SizedBox.shrink();

    final pendingCount = leave['pending_applications'] ?? 0;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LeaveApplicationsListPage()),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Leave Requests',
                style: AppFonts.interStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$pendingCount',
                style: AppFonts.interStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Pending',
                style: context.theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPayrollCard(BuildContext context, Map<String, dynamic>? payroll) {
    if (payroll == null) return const SizedBox.shrink();

    final pendingCount = payroll['pending_count'] ?? 0;
    final paidCount = payroll['paid_count'] ?? 0;
    final completionRate = payroll['completion_rate'] ?? 0.0;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          // Navigate to payroll
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payroll Status',
                style: AppFonts.interStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${completionRate.toStringAsFixed(0)}%',
                style: AppFonts.interStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$paidCount Paid • $pendingCount Pending',
                style: context.theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportContent(BuildContext context, Map<String, dynamic> reportData) {
    return Center(
      child: Text('Report: ${reportData['report_type']}'),
    );
  }
}