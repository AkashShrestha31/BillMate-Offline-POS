import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/action_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../bloc/attendance_cubit.dart';
import '../bloc/employee_cubit.dart';
import '../widgets/employee_attendance_item.dart';
import '../widgets/employee_hub_scaffold.dart';
import '../../data/models/request/attendance_request_params.dart';
import '../../data/models/response/employee_model.dart';
import 'attendance_form_page.dart';
import 'employee_attendance_detail_page.dart';

class AttendanceListPage extends StatelessWidget {
  const AttendanceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<EmployeeCubit>()..getEmployees(employmentStatus: 'ACTIVE'),
        ),
        BlocProvider(
          create: (context) => getIt<AttendanceCubit>(),
        ),
      ],
      child: const _AttendanceListView(),
    );
  }
}

class _AttendanceListView extends StatefulWidget {
  const _AttendanceListView();

  @override
  State<_AttendanceListView> createState() => _AttendanceListViewState();
}

class _AttendanceListViewState extends State<_AttendanceListView> {
  String? _selectedDepartment;
  /// Default: active employees only (matches API filter).
  String? _selectedStatus = 'ACTIVE';

  /// When recording for a date range, we queue remaining dates and process one by one.
  List<String> _pendingDates = [];
  EmployeeModel? _pendingEmployee;
  String? _pendingStatus;
  String? _pendingNotes;

  void _loadEmployees() {
    context.read<EmployeeCubit>().getEmployees(
          department: _selectedDepartment,
          employmentStatus: _selectedStatus,
        );
  }

  String _formatDate(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Opens a new bottom sheet with calendar and Done button. Returns (start, end) when Done is pressed.
  Future<(DateTime, DateTime)?> _showCalendarBottomSheet(
    BuildContext context, {
    required DateTime initialStart,
    required DateTime initialEnd,
    required DateTime today,
  }) async {
    DateTime rangeStart = initialStart;
    DateTime rangeEnd = initialEnd;
    DateTime focusedDay = initialEnd;

    return showModalBottomSheet<(DateTime, DateTime)>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(ctx).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select date range',
                      style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    TableCalendar(
                      firstDay: DateTime(2020),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      focusedDay: focusedDay,
                      currentDay: today,
                      rangeStartDay: rangeStart,
                      rangeEndDay: rangeEnd,
                      rangeSelectionMode: RangeSelectionMode.enforced,
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Theme.of(ctx).colorScheme.primary.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: Color(0xFF6750A4),
                          shape: BoxShape.circle,
                        ),
                        rangeStartDecoration: const BoxDecoration(
                          color: Color(0xFF6750A4),
                          shape: BoxShape.circle,
                        ),
                        rangeEndDecoration: const BoxDecoration(
                          color: Color(0xFF6750A4),
                          shape: BoxShape.circle,
                        ),
                        rangeHighlightColor: const Color(0xFF6750A4).withOpacity(0.2),
                        outsideDaysVisible: false,
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronIcon: Icon(Icons.chevron_left),
                        rightChevronIcon: Icon(Icons.chevron_right),
                      ),
                      onRangeSelected: (start, end, _) {
                        setState(() {
                          if (start != null) rangeStart = start;
                          rangeEnd = end ?? start ?? rangeStart;
                          if (end != null) focusedDay = end;
                        });
                      },
                      onPageChanged: (day) {
                        setState(() => focusedDay = day);
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => Navigator.pop(ctx, (rangeStart, rangeEnd)),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text('Done'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<String> _datesInRange(DateTime from, DateTime to) {
    final list = <String>[];
    var d = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day);
    while (!d.isAfter(end)) {
      list.add(_formatDate(d));
      d = d.add(const Duration(days: 1));
    }
    return list;
  }

  void _recordForDate(String date, EmployeeModel employee, String status, {String? notes}) {
    context.read<AttendanceCubit>().recordAttendance(
          params: AttendanceRequestParams(
            employeeId: employee.id,
            attendanceDate: date,
            attendanceStatus: status,
            notes: notes,
          ),
        );
  }

  void _showAttendanceSheet(BuildContext context, EmployeeModel employee) {
    ActionBottomSheet.show(
      context,
      title: employee.displayName,
      items: [
        ActionSheetItem(
          icon: Icons.check_circle,
          title: 'Mark as present',
          color: Colors.green,
          onTap: () => _showMarkPresentAbsentFormSheet(context, employee, 'PRESENT'),
        ),
        ActionSheetItem(
          icon: Icons.cancel,
          title: 'Mark as absent',
          color: Colors.red,
          onTap: () => _showMarkPresentAbsentFormSheet(context, employee, 'ABSENT'),
        ),
      ],
    );
  }

  /// Form bottom sheet: Full / Half / Specific hour, calendar range, then button to hit API.
  void _showMarkPresentAbsentFormSheet(BuildContext context, EmployeeModel employee, String status) {
    final isPresent = status == 'PRESENT';
    final buttonLabel = isPresent ? 'Mark as present' : 'Mark as absent';
    int dayType = 0; // 0 = full, 1 = half, 2 = specific hour
    final today = DateTime.now();
    DateTime? startDate = today;
    DateTime? endDate = today; // same as start = single day by default
    final specificHoursController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setSheetState) {
          return SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(ctx).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 20, 24, 24 + MediaQuery.of(ctx).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        buttonLabel,
                        style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      // Text(
                      //   'Day type',
                      //   style: Theme.of(ctx).textTheme.titleSmall?.copyWith(
                      //         color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                      //       ),
                      // ),
                      // const SizedBox(height: 8),
                      Column(
                        children: [
                          RadioListTile<int>(
                            value: 0,
                            groupValue: dayType,
                            onChanged: (v) => setSheetState(() => dayType = 0),
                            title: Text('Full time', style: context.theme.textTheme.bodyLarge),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          ),
                          RadioListTile<int>(
                            value: 1,
                            groupValue: dayType,
                            onChanged: (v) => setSheetState(() => dayType = 1),
                            title: Text('Half', style: context.theme.textTheme.bodyLarge),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          ),
                          RadioListTile<int>(
                            value: 2,
                            groupValue: dayType,
                            onChanged: (v) => setSheetState(() => dayType = 2),
                            title: Text('Specific hour', style: context.theme.textTheme.bodyLarge),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                      if (dayType == 2) ...[
                        const SizedBox(height: 12),
                        TextField(
                          controller: specificHoursController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Hours',
                            hintText: 'e.g. 2',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (_) => setSheetState(() {}),
                        ),
                      ],
                      const SizedBox(height: 20),
                      Text(
                        'Date range',
                        style: Theme.of(ctx).textTheme.titleSmall?.copyWith(
                              color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w700
                            ),
                      ),
                     verticalMarginMedium,
                      InkWell(
                        onTap: () async {
                          final result = await _showCalendarBottomSheet(
                            ctx,
                            initialStart: startDate ?? today,
                            initialEnd: endDate ?? today,
                            today: today,
                          );
                          if (result != null && context.mounted) {
                            setSheetState(() {
                              startDate = result.$1;
                              endDate = result.$2;
                            });
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(ctx).colorScheme.outlineVariant,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(ctx).colorScheme.surfaceContainerHigh,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 22,
                                color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  startDate == null
                                      ? 'Select date'
                                      : (endDate != null && !_isSameDay(startDate!, endDate!))
                                          ? '${DateFormat('d MMM yy').format(startDate!)} - ${DateFormat('d MMM yy').format(endDate!)}'
                                          : DateFormat('d MMM yy').format(startDate!),
                                  style: Theme.of(ctx).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              if (startDate != null)
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                                  ),
                                  onPressed: () => setSheetState(() {
                                    startDate = today;
                                    endDate = today;
                                  }),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 24,
                                color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            if (dayType == 2) {
                              final hours = specificHoursController.text.trim();
                              if (hours.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Enter hours for specific hour')),
                                );
                                return;
                              }
                              if (double.tryParse(hours) == null || double.tryParse(hours)! <= 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Enter a valid number of hours')),
                                );
                                return;
                              }
                            }
                            final from = DateTime((startDate ?? DateTime.now()).year,
                                (startDate ?? DateTime.now()).month, (startDate ?? DateTime.now()).day);
                            final toDate = endDate ?? startDate ?? DateTime.now();
                            final to = DateTime(toDate.year, toDate.month, toDate.day);
                            if (to.isBefore(from)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('End date must be on or after start date')),
                              );
                              return;
                            }
                            final dates = _datesInRange(from, to);
                            if (dates.isEmpty) return;

                            String recordStatus;
                            String? notes;
                            if (dayType == 0) {
                              recordStatus = status;
                              notes = null;
                            } else if (dayType == 1) {
                              recordStatus = isPresent ? 'HALF_DAY' : 'ABSENT';
                              notes = isPresent ? null : 'Half day';
                            } else {
                              recordStatus = status;
                              notes = '${specificHoursController.text.trim()} hours';
                            }

                            Navigator.pop(ctx);

                            if (dates.length == 1) {
                              _recordForDate(dates.first, employee, recordStatus, notes: notes);
                            } else {
                              context.read<AttendanceCubit>().recordAttendance(
                                    params: AttendanceRequestParams(
                                      employeeId: employee.id,
                                      startDate: dates.first,
                                      endDate: dates.last,
                                      attendanceStatus: recordStatus,
                                      notes: notes,
                                    ),
                                  );
                            }
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: isPresent ? Colors.green : Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(buttonLabel),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ).whenComplete(() => specificHoursController.dispose());
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setSheetState) {
          return SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(ctx).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Filter Employees',
                      style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedDepartment,
                      decoration: InputDecoration(
                        labelText: 'Department',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: null, child: Text('All Departments')),
                        DropdownMenuItem(value: 'Front Desk', child: Text('Front Desk')),
                        DropdownMenuItem(value: 'Housekeeping', child: Text('Housekeeping')),
                        DropdownMenuItem(value: 'Kitchen', child: Text('Kitchen')),
                        DropdownMenuItem(value: 'Maintenance', child: Text('Maintenance')),
                        DropdownMenuItem(value: 'Management', child: Text('Management')),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedDepartment = value);
                        setSheetState(() {});
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedStatus,
                      decoration: InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: null, child: Text('All statuses')),
                        DropdownMenuItem(value: 'ACTIVE', child: Text('Active')),
                        DropdownMenuItem(value: 'INACTIVE', child: Text('Inactive')),
                        DropdownMenuItem(value: 'TERMINATED', child: Text('Terminated')),
                        DropdownMenuItem(value: 'RESIGNED', child: Text('Resigned')),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedStatus = value);
                        setSheetState(() {});
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedDepartment = null;
                              _selectedStatus = 'ACTIVE';
                            });
                            Navigator.pop(ctx);
                            _loadEmployees();
                          },
                          child: Text('Clear'),
                        ),
                        const SizedBox(width: 12),
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            _loadEmployees();
                          },
                          child: Text('Apply'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocListener<AttendanceCubit, AttendanceState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          submitting: () => AppLoadingOverlay.of(context).show(),
          noInternet: () {
            AppLoadingOverlay.of(context).hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No internet connection')),
            );
          },
          error: (message) {
            AppLoadingOverlay.of(context).hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          loaded: (_) {},
          attendanceDetail: (_) {},
          submitSuccess: (_) {
            if (_pendingDates.isNotEmpty && _pendingEmployee != null && _pendingStatus != null) {
              final nextDate = _pendingDates.first;
              setState(() => _pendingDates = _pendingDates.sublist(1));
              _recordForDate(nextDate, _pendingEmployee!, _pendingStatus!, notes: _pendingNotes);
              return;
            }
            if (_pendingEmployee != null || _pendingStatus != null) {
              setState(() {
                _pendingDates = [];
                _pendingEmployee = null;
                _pendingStatus = null;
                _pendingNotes = null;
              });
            }
            AppLoadingOverlay.of(context).hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Attendance recorded')),
            );
            _loadEmployees();
          },
        );
      },
      child: EmployeeHubScaffold(
        title: 'Attendance',
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list_rounded, color: scheme.primary),
            onPressed: _showFilterBottomSheet,
          ),
        ],
        body: BlocBuilder<EmployeeCubit, EmployeeState>(
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
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _loadEmployees,
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(message),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _loadEmployees,
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
              loaded: (response) {
                final employees = response.employees;

                if (employees.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline, size: 64, color: scheme.onSurfaceVariant),
                        const SizedBox(height: 16),
                        Text('No employees found'),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => _loadEmployees(),
                  child: Column(
                    children: [
                      if (_selectedDepartment != null ||
                          (_selectedStatus != null && _selectedStatus != 'ACTIVE'))
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: scheme.surfaceContainerHigh,
                          child: Wrap(
                            spacing: 8,
                            children: [
                              if (_selectedDepartment != null)
                                Chip(
                                  label: Text(_selectedDepartment!),
                                  onDeleted: () {
                                    setState(() => _selectedDepartment = null);
                                    _loadEmployees();
                                  },
                                ),
                              if (_selectedStatus != null && _selectedStatus != 'ACTIVE')
                                Chip(
                                  label: Text(_selectedStatus!),
                                  onDeleted: () {
                                    setState(() => _selectedStatus = 'ACTIVE');
                                    _loadEmployees();
                                  },
                                ),
                            ],
                          ),
                        ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16),
                      //   child: Text(
                      //     '${employees.length} employee${employees.length != 1 ? 's' : ''}',
                      //     style: AppFonts.interStyle(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w600,
                      //       color: Colors.grey[700],
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: employees.length,
                          itemBuilder: (context, index) {
                            final employee = employees[index];
                            return EmployeeAttendanceItem(
                              employee: employee,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EmployeeAttendanceDetailPage(
                                      employee: employee,
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () => _showAttendanceSheet(context, employee),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              employeeDetail: (_) => const SizedBox(),
              submitSuccess: (_) => const SizedBox(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Mark attendance',
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AttendanceFormPage(),
              ),
            );
            if (result == true) {
              _loadEmployees();
            }
          },
          elevation: 4,
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: const CircleBorder(),
          child: Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}
