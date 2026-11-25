import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import '../bloc/attendance_cubit.dart';
import 'attendance_form_page.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';

class AttendanceDetailPage extends StatelessWidget {
  final int attendanceId;

  const AttendanceDetailPage({super.key, required this.attendanceId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AttendanceCubit>()..getAttendanceById(attendanceId),
      child: const _AttendanceDetailView(),
    );
  }
}

class _AttendanceDetailView extends StatelessWidget {
  const _AttendanceDetailView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      appBar: AppBar(
        leading: AppBarIosBackButton(color: scheme.onSurface),
        backgroundColor: scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text('Attendance Details'),
        actions: [
          BlocBuilder<AttendanceCubit, AttendanceState>(
            builder: (context, state) {
              return state.maybeWhen(
                attendanceDetail: (attendance) => PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 100));
                        if (context.mounted) {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttendanceFormPage(
                                attendanceId: attendance.id,
                              ),
                            ),
                          );
                          if (result == true && context.mounted) {
                            context.read<AttendanceCubit>().getAttendanceById(attendance.id);
                          }
                        }
                      },
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          const AppDeleteIcon(size: 20, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: AppFonts.interStyle(color: Colors.red)),
                        ],
                      ),
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 100));
                        if (context.mounted) {
                          _showDeleteConfirmation(context, attendance.id);
                        }
                      },
                    ),
                  ],
                ),
                orElse: () => const SizedBox(),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          state.maybeWhen(
            submitSuccess: (response) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(response.message),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context, true);
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: Text('Loading...')),
            loading: () => Center(child: CircularProgressIndicator()),
            submitting: () => Center(child: CircularProgressIndicator()),
            noInternet: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No internet connection'),
                ],
              ),
            ),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: $message'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Go Back'),
                  ),
                ],
              ),
            ),
            attendanceDetail: (attendance) => _buildDetailContent(context, attendance),
            loaded: (_) => const SizedBox(),
            submitSuccess: (_) => const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _buildDetailContent(BuildContext context, attendance) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _getStatusColor(attendance.attendanceStatus),
                  _getStatusColor(attendance.attendanceStatus).withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _getStatusColor(attendance.attendanceStatus).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  _getStatusIcon(attendance.attendanceStatus),
                  size: 56,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                Text(
                  attendance.attendanceStatus,
                  style: AppFonts.interStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  attendance.attendanceDate,
                  style: AppFonts.interStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (!attendance.isApproved)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.pending, size: 16, color: Colors.white),
                          SizedBox(width: 6),
                          Text(
                            'Pending Approval',
                            style: AppFonts.interStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Employee Information
          _buildSection(
            context,
            'Employee Information',
            Icons.person,
            [
              _buildInfoRow(context, 'Employee', attendance.employeeName),
              _buildInfoRow(context, 'Employee Code', attendance.employeeCode),
            ],
          ),

          // Time Information
          _buildSection(
            context,
            'Time Details',
            Icons.access_time,
            [
              _buildInfoRow(context, 'Date', attendance.attendanceDate),
              if (attendance.checkInTime != null)
                _buildTimeRow(context, 'Check-in', attendance.checkInTime!, Icons.login, Colors.green),
              if (attendance.checkOutTime != null)
                _buildTimeRow(context, 'Check-out', attendance.checkOutTime!, Icons.logout, Colors.red),
              if (attendance.breakStartTime != null)
                _buildTimeRow(context, 'Break Start', attendance.breakStartTime!, Icons.free_breakfast, Colors.orange),
              if (attendance.breakEndTime != null)
                _buildTimeRow(context, 'Break End', attendance.breakEndTime!, Icons.free_breakfast_outlined, Colors.orange),
              const Divider(height: 24),
              _buildHighlightRow(
                'Total Hours Worked',
                '${attendance.totalHoursWorked.toStringAsFixed(2)}h',
                Icons.timer,
                Colors.blue,
              ),
              if (attendance.totalBreakHours != null && attendance.totalBreakHours! > 0)
                _buildHighlightRow(
                  'Break Hours',
                  '${attendance.totalBreakHours!.toStringAsFixed(2)}h',
                  Icons.coffee,
                  Colors.brown,
                ),
              if (attendance.overtimeHours > 0)
                _buildHighlightRow(
                  'Overtime Hours',
                  '${attendance.overtimeHours.toStringAsFixed(2)}h',
                  Icons.access_alarm,
                  Colors.orange,
                ),
            ],
          ),

          // Late/Early Information
          if ((attendance.lateArrivalMinutes != null && attendance.lateArrivalMinutes! > 0) ||
              (attendance.earlyDepartureMinutes != null && attendance.earlyDepartureMinutes! > 0))
            _buildSection(
              context,
              'Deviations',
              Icons.warning_amber,
              [
                if (attendance.lateArrivalMinutes != null && attendance.lateArrivalMinutes! > 0)
                  _buildWarningRow(
                    'Late Arrival',
                    '${attendance.lateArrivalMinutes} minutes',
                    Icons.schedule,
                  ),
                if (attendance.earlyDepartureMinutes != null && attendance.earlyDepartureMinutes! > 0)
                  _buildWarningRow(
                    'Early Departure',
                    '${attendance.earlyDepartureMinutes} minutes',
                    Icons.directions_run,
                  ),
              ],
            ),

          // Location
          if (attendance.location != null && attendance.location!.isNotEmpty)
            _buildSection(
              context,
              'Location',
              Icons.location_on,
              [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.place, color: Colors.blue[700]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          attendance.location!,
                          style: AppFonts.interStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          // Notes
          if (attendance.notes != null && attendance.notes!.isNotEmpty)
            _buildSection(
              context,
              'Notes',
              Icons.note,
              [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    attendance.notes!,
                    style: AppFonts.interStyle(fontSize: 14),
                  ),
                ),
              ],
            ),

          // Approval Information
          if (attendance.approvedBy != null)
            _buildSection(
              context,
              'Approval Information',
              Icons.check_circle,
              [
                _buildInfoRow(context, 'Approved By', attendance.approvedBy!),
                _buildInfoRow(context, 'Status', attendance.isApproved ? 'Approved' : 'Pending'),
              ],
            ),

          // Metadata
          // _buildSection(
          //   'Record Information',
          //   Icons.info_outline,
          //   [
          //     if (attendance.createdBy != null)
          //       _buildInfoRow('Created By', attendance.createdBy!),
          //     if (attendance.created != null)
          //       _buildInfoRow('Created At', _formatDateTime(attendance.created!)),
          //     if (attendance.modifiedBy != null)
          //       _buildInfoRow('Modified By', attendance.modifiedBy!),
          //     if (attendance.modified != null)
          //       _buildInfoRow('Modified At', _formatDateTime(attendance.modified!)),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, IconData icon, List<Widget> children) {
    final scheme = Theme.of(context).colorScheme;
    final primary = scheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: AppFonts.interStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppFonts.interStyle(
                fontWeight: FontWeight.w500,
                color: scheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppFonts.interStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRow(BuildContext context, String label, String time, IconData icon, Color color) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppFonts.interStyle(
                fontWeight: FontWeight.w500,
                color: scheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            time,
            style: AppFonts.interStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightRow(String label, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: AppFonts.interStyle(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          Text(
            value,
            style: AppFonts.interStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningRow(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: AppFonts.interStyle(
                fontWeight: FontWeight.w600,
                color: Colors.orange[900],
              ),
            ),
          ),
          Text(
            value,
            style: AppFonts.interStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange[900],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PRESENT':
        return Colors.green;
      case 'ABSENT':
        return Colors.red;
      case 'LATE':
        return Colors.orange;
      case 'HALF_DAY':
        return Colors.blue;
      case 'ON_LEAVE':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toUpperCase()) {
      case 'PRESENT':
        return Icons.check_circle;
      case 'ABSENT':
        return Icons.cancel;
      case 'LATE':
        return Icons.schedule;
      case 'HALF_DAY':
        return Icons.access_time;
      case 'ON_LEAVE':
        return Icons.event_note;
      default:
        return Icons.help;
    }
  }

  String _formatDateTime(String dateTime) {
    try {
      final dt = DateTime.parse(dateTime);
      return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTime;
    }
  }

  void _showDeleteConfirmation(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 12),
            Text('Delete Attendance'),
          ],
        ),
        content: Text(
          'Are you sure you want to delete this attendance record? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AttendanceCubit>().deleteAttendance(id);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
