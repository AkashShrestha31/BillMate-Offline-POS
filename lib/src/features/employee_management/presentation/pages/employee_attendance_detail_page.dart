import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/action_bottom_sheet.dart';
import 'package:intl/intl.dart';

import '../bloc/attendance_cubit.dart';
import '../../data/models/response/attendance_model.dart';
import '../../data/models/response/employee_model.dart';
import '../widgets/employee_hub_scaffold.dart';
import 'attendance_detail_page.dart';
import 'attendance_form_page.dart';

/// Wrapper that provides [AttendanceCubit] and loads current month for the employee.
class EmployeeAttendanceDetailPage extends StatelessWidget {
  final EmployeeModel employee;

  const EmployeeAttendanceDetailPage({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<AttendanceCubit>();
        final now = DateTime.now();
        final first = DateTime(now.year, now.month, 1);
        final last = DateTime(now.year, now.month + 1, 0);
        final dateFrom = '${first.year}-${first.month.toString().padLeft(2, '0')}-01';
        final dateTo = '${last.year}-${last.month.toString().padLeft(2, '0')}-${last.day.toString().padLeft(2, '0')}';
        cubit.getAttendance(employeeId: employee.id, dateFrom: dateFrom, dateTo: dateTo);
        return cubit;
      },
      child: _EmployeeAttendanceView(employee: employee),
    );
  }
}

class _EmployeeAttendanceView extends StatefulWidget {
  final EmployeeModel employee;

  const _EmployeeAttendanceView({required this.employee});

  @override
  State<_EmployeeAttendanceView> createState() => _EmployeeAttendanceViewState();
}

class _EmployeeAttendanceViewState extends State<_EmployeeAttendanceView> {
  String? _selectedStatus;
  late DateTime _selectedMonth;

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
  }

  String _dateFrom(DateTime month) {
    return '${month.year}-${month.month.toString().padLeft(2, '0')}-01';
  }

  String _dateTo(DateTime month) {
    final last = DateTime(month.year, month.month + 1, 0);
    return '${last.year}-${last.month.toString().padLeft(2, '0')}-${last.day.toString().padLeft(2, '0')}';
  }

  void _loadAttendance() {
    context.read<AttendanceCubit>().getAttendance(
          employeeId: widget.employee.id,
          dateFrom: _dateFrom(_selectedMonth),
          dateTo: _dateTo(_selectedMonth),
          attendanceStatus: _selectedStatus,
        );
  }

  void _previousMonth() {
    setState(() {
      if (_selectedMonth.month == 1) {
        _selectedMonth = DateTime(_selectedMonth.year - 1, 12, 1);
      } else {
        _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1, 1);
      }
    });
    _loadAttendance();
  }

  void _nextMonth() {
    setState(() {
      if (_selectedMonth.month == 12) {
        _selectedMonth = DateTime(_selectedMonth.year + 1, 1, 1);
      } else {
        _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);
      }
    });
    _loadAttendance();
  }

  void _showAttendanceRecordSheet(BuildContext context, AttendanceModel record) {
    ActionBottomSheet.show(
      context,
      title: '${record.attendanceDate} · ${record.attendanceStatus}',
      items: [
        ActionSheetItem(
          icon: Icons.edit,
          title: 'Update',
          color: Colors.blue,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AttendanceFormPage(attendanceId: record.id),
              ),
            ).then((result) {
              if (result == true) _loadAttendance();
            });
          },
        ),
        ActionSheetItem(
          icon: Icons.delete,
          title: 'Delete',
          color: Colors.red,
          onTap: () {
            final cubit = context.read<AttendanceCubit>();
            _confirmDeleteAttendance(context, cubit, record.id);
          },
        ),
      ],
    );
  }

  void _confirmDeleteAttendance(
    BuildContext context,
    AttendanceCubit cubit,
    int attendanceId,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Delete attendance?'),
        content: Text(
          'This attendance record will be permanently deleted. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(dialogContext);
              cubit.deleteAttendance(attendanceId);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    ).then((_) {
      if (context.mounted) Navigator.pop(context);
    });
  }

  // void _showFilterDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Filter Attendance'),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           DropdownButtonFormField<String>(
  //             value: _selectedStatus,
  //             decoration: InputDecoration(
  //               labelText: 'Attendance Status',
  //               border: OutlineInputBorder(),
  //             ),
  //             items: const [
  //               DropdownMenuItem(value: null, child: Text('All Status')),
  //               DropdownMenuItem(value: 'PRESENT', child: Text('Present')),
  //               DropdownMenuItem(value: 'ABSENT', child: Text('Absent')),
  //               DropdownMenuItem(value: 'LATE', child: Text('Late')),
  //               DropdownMenuItem(value: 'HALF_DAY', child: Text('Half Day')),
  //               DropdownMenuItem(value: 'ON_LEAVE', child: Text('On Leave')),
  //             ],
  //             onChanged: (value) {
  //               setState(() => _selectedStatus = value);
  //             },
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             setState(() => _selectedStatus = null);
  //             Navigator.pop(context);
  //             _loadAttendance();
  //           },
  //           child: Text('Clear'),
  //         ),
  //         FilledButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //             _loadAttendance();
  //           },
  //           child: Text('Apply'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return EmployeeHubScaffold(
      titleWidget: Text(widget.employee.displayName),
      body: BlocListener<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          state.whenOrNull(
            submitSuccess: (_) {
              _loadAttendance();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Attendance record updated successfully')),
              );
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
          );
        },
        child: BlocBuilder<AttendanceCubit, AttendanceState>(
          builder: (context, state) {
            return state.when(
              initial: () => Center(child: CircularProgressIndicator()),
              loading: () => Center(child: CircularProgressIndicator()),
              submitting: () => Center(child: CircularProgressIndicator()),
              noInternet: () => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, size: 64, color: scheme.onSurfaceVariant),
                    const SizedBox(height: 16),
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
                      onPressed: _loadAttendance,
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
              loaded: (response) {
                final records = response.attendanceRecords;
                // When empty, show calendar with all dates in green (no absent dates)
                final absentDates = records
                    .where((r) => r.attendanceStatus.toUpperCase() == 'ABSENT')
                    .map((r) => r.attendanceDate)
                    .toSet();

                return RefreshIndicator(
                  onRefresh: () async => _loadAttendance(),
                  child: Column(
                    children: [
                      _buildCalendarSection(records, absentDates),
                      if (_selectedStatus != null)
                        Container(
                          padding: const EdgeInsets.all(12),
                          color: scheme.surfaceContainerHigh,
                          child: Row(
                            children: [
                              Text(
                                'Filtered by:',
                                style: AppFonts.interStyle(fontSize: 12, color: scheme.onSurfaceVariant),
                              ),
                              const SizedBox(width: 8),
                              Chip(
                                label: Text(_selectedStatus!),
                                deleteIcon: Icon(Icons.close, size: 16),
                                onDeleted: () {
                                  setState(() => _selectedStatus = null);
                                  _loadAttendance();
                                },
                              ),
                            ],
                          ),
                        ),
                      verticalMarginMedium,
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: records.length,
                          itemBuilder: (context, index) {
                            final record = records[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Material(
                                color: scheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                child: InkWell(
                                  onTap: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AttendanceDetailPage(
                                          attendanceId: record.id,
                                        ),
                                      ),
                                    );
                                    if (result == true) {
                                      _loadAttendance();
                                    }
                                  },
                                  onLongPress: () => _showAttendanceRecordSheet(context, record),
                                  borderRadius: BorderRadius.circular(12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(context.theme.appTheme.spacing16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_today,
                                                    size: 14,
                                                    color: scheme.onSurfaceVariant,
                                                  ),
                                                  horizontalMarginMedium,
                                                  Text(
                                                    record.attendanceDate,
                                                    style: context.theme.textTheme.bodyMedium?.copyWith(
                                                      fontWeight: FontWeight.w700
                                                    )
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Row(
                                        children: [
                                         
                                          Text(
                                            record.attendanceStatus,
                                            style: context.theme.textTheme.bodySmall?.copyWith(
                                              color: _getStatusColor(record.attendanceStatus),
                                              fontWeight: FontWeight.w700
                                            )

                                          ),
                                          const SizedBox(width: 8),
                                          Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              attendanceDetail: (_) => const SizedBox(),
              submitSuccess: (_) => const SizedBox(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCalendarSection(
    List<AttendanceModel> records,
    Set<String> absentDates,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: employeeHubCardDecoration(context),
      child: Column(
        children: [
          _buildCalendarHeader(),
          _buildCalendarGrid(absentDates),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: _previousMonth,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                Icons.chevron_left_rounded,
                color: scheme.onPrimary,
                size: 20,
              ),
            ),
          ),
          Text(
            DateFormat('MMM yyyy').format(_selectedMonth),
            style: AppFonts.interStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
          GestureDetector(
            onTap: _nextMonth,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                color: scheme.onPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(Set<String> absentDates) {
    final scheme = Theme.of(context).colorScheme;
    final daysInMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0).day;
    final firstWeekday = DateTime(_selectedMonth.year, _selectedMonth.month, 1).weekday;
    final today = DateTime.now();

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Column(
        children: [
          Row(
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: context.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
              crossAxisSpacing: 6,
              mainAxisSpacing: 4,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              final dayNumber = index - firstWeekday + 2;
              if (dayNumber <= 0 || dayNumber > daysInMonth) {
                return const SizedBox.shrink();
              }
              final date = DateTime(
                _selectedMonth.year,
                _selectedMonth.month,
                dayNumber,
              );
              final dateStr =
                  '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
              final isAbsent = absentDates.contains(dateStr);
              final isToday = date.year == today.year && date.month == today.month && date.day == today.day;
              final isPresentOrNotAvailable = !isAbsent;

              return Container(
                decoration: BoxDecoration(
                  color: isAbsent
                      ? Colors.red.withOpacity(0.2)
                      : isPresentOrNotAvailable
                          ? Colors.green.withOpacity(0.2)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: isAbsent
                      ? Border.all(color: Colors.red.withOpacity(0.6), width: 1)
                      : isPresentOrNotAvailable
                          ? Border.all(color: Colors.green.withOpacity(0.5), width: 1)
                          : null,
                ),
                child: Center(
                  child: Text(dayNumber.toString(),
                      style: context.theme.textTheme.labelLarge?.copyWith(
                        fontWeight: isToday ? FontWeight.w600 : FontWeight.w500,
                        color: isAbsent
                            ? Colors.red[700]
                            : isPresentOrNotAvailable
                                ? Colors.green[800]
                                : scheme.onSurface,
                      )),
                ),
              );
            },
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
}
