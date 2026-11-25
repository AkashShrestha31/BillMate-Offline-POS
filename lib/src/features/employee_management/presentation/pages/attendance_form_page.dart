import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import '../widgets/employee_hub_scaffold.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/searchable_select_bottom_sheet.dart';
import '../bloc/attendance_cubit.dart';
import '../bloc/employee_cubit.dart';
import '../../data/models/request/attendance_request_params.dart';
import '../../data/models/request/attendance_update_request_params.dart';
import '../../data/models/response/employee_model.dart';

class AttendanceFormPage extends StatelessWidget {
  final int? attendanceId;

  const AttendanceFormPage({super.key, this.attendanceId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = getIt<AttendanceCubit>();
            if (attendanceId != null) {
              cubit.getAttendanceById(attendanceId!);
            }
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) => getIt<EmployeeCubit>()..getEmployees(),
        ),
      ],
      child: _AttendanceFormView(attendanceId: attendanceId),
    );
  }
}

class _AttendanceStatusOption {
  const _AttendanceStatusOption({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;
}

class _AttendanceFormView extends StatefulWidget {
  final int? attendanceId;

  const _AttendanceFormView({this.attendanceId});

  @override
  State<_AttendanceFormView> createState() => _AttendanceFormViewState();
}

class _AttendanceFormViewState extends State<_AttendanceFormView> {
  static const _statusOptions = [
    _AttendanceStatusOption(
      value: 'PRESENT',
      label: 'Present',
      icon: Icons.check_circle,
      color: Colors.green,
    ),
    _AttendanceStatusOption(
      value: 'ABSENT',
      label: 'Absent',
      icon: Icons.cancel,
      color: Colors.red,
    ),
    _AttendanceStatusOption(
      value: 'LATE',
      label: 'Late',
      icon: Icons.schedule,
      color: Colors.orange,
    ),
    _AttendanceStatusOption(
      value: 'HALF_DAY',
      label: 'Half day',
      icon: Icons.access_time,
      color: Colors.blue,
    ),
    _AttendanceStatusOption(
      value: 'SICK_LEAVE',
      label: 'Sick leave',
      icon: Icons.medical_services_outlined,
      color: Colors.purple,
    ),
    _AttendanceStatusOption(
      value: 'VACATION',
      label: 'Vacation',
      icon: Icons.beach_access,
      color: Colors.teal,
    ),
  ];

  final _formKey = GlobalKey<FormState>();
  final _employeeDisplayController = TextEditingController();
  final _statusDisplayController = TextEditingController();
  final _dateController = TextEditingController();
  final _checkInController = TextEditingController();
  final _checkOutController = TextEditingController();
  final _breakStartController = TextEditingController();
  final _breakEndController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

  int? _selectedEmployeeId;
  String? _selectedStatus;
  List<EmployeeModel> _employees = [];

  @override
  void dispose() {
    _employeeDisplayController.dispose();
    _statusDisplayController.dispose();
    _dateController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    _breakStartController.dispose();
    _breakEndController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String _statusLabel(String? value) {
    if (value == null) return '';
    for (final o in _statusOptions) {
      if (o.value == value) return o.label;
    }
    return value;
  }

  void _syncStatusDisplay() {
    _statusDisplayController.text = _statusLabel(_selectedStatus);
  }

  void _syncEmployeeDisplay() {
    if (_selectedEmployeeId == null) {
      _employeeDisplayController.clear();
      return;
    }
    for (final e in _employees) {
      if (e.id == _selectedEmployeeId) {
        _employeeDisplayController.text = e.displayName;
        return;
      }
    }
  }

  Future<void> _showEmployeeBottomSheet() async {
    if (widget.attendanceId != null) return;
    if (_employees.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Employees are still loading')),
      );
      return;
    }

    final theme = Theme.of(context);
    final maxHeight = MediaQuery.of(context).size.height * 0.65;
    final options = _employees
        .map((e) => MapEntry(e.id.toString(), e.displayName))
        .toList();

    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            constraints: BoxConstraints(maxHeight: maxHeight),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SearchableSelectBottomSheet(
              title: 'Select employee',
              searchHint: 'Search by name or code',
              options: options,
              currentValue: _selectedEmployeeId?.toString(),
            ),
          ),
        ),
      ),
    );

    if (selected != null && mounted) {
      setState(() {
        _selectedEmployeeId = int.tryParse(selected);
        _syncEmployeeDisplay();
      });
    }
  }

  Future<void> _showStatusBottomSheet() async {
    final theme = Theme.of(context);
    final maxHeight = MediaQuery.of(context).size.height * 0.55;
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          constraints: BoxConstraints(maxHeight: maxHeight),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Attendance status',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalMarginSmall,
                const Divider(),
                verticalMarginMedium,
                ..._statusOptions.map((option) {
                  final isSelected = _selectedStatus == option.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Material(
                      color: isSelected
                          ? theme.colorScheme.primaryContainer
                              .withValues(alpha: 0.35)
                          : theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => Navigator.pop(ctx, option.value),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              Icon(option.icon, color: option.color, size: 22),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  option.label,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: theme.colorScheme.primary,
                                  size: 22,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );

    if (selected != null && mounted) {
      setState(() {
        _selectedStatus = selected;
        _syncStatusDisplay();
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (widget.attendanceId != null) {
      final updateParams = AttendanceUpdateRequestParams(
        attendanceId: widget.attendanceId!,
        checkInTime:
            _checkInController.text.isEmpty ? null : _checkInController.text,
        checkOutTime:
            _checkOutController.text.isEmpty ? null : _checkOutController.text,
        breakStartTime: _breakStartController.text.isEmpty
            ? null
            : _breakStartController.text,
        breakEndTime:
            _breakEndController.text.isEmpty ? null : _breakEndController.text,
        attendanceStatus: _selectedStatus,
        location:
            _locationController.text.isEmpty ? null : _locationController.text,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      );
      context.read<AttendanceCubit>().updateAttendance(params: updateParams);
    } else {
      final params = AttendanceRequestParams(
        employeeId: _selectedEmployeeId!,
        attendanceDate: _dateController.text,
        attendanceStatus: _selectedStatus!,
        checkInTime:
            _checkInController.text.isEmpty ? null : _checkInController.text,
        checkOutTime:
            _checkOutController.text.isEmpty ? null : _checkOutController.text,
        breakStartTime: _breakStartController.text.isEmpty
            ? null
            : _breakStartController.text,
        breakEndTime:
            _breakEndController.text.isEmpty ? null : _breakEndController.text,
        location:
            _locationController.text.isEmpty ? null : _locationController.text,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      );
      context.read<AttendanceCubit>().recordAttendance(params: params);
    }
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dateController.text.isEmpty
          ? DateTime.now()
          : DateTime.tryParse(_dateController.text) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        _dateController.text =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      });
    }
  }

  Future<void> _selectTime(TextEditingController controller) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        controller.text =
            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return EmployeeHubScaffold(
      title: widget.attendanceId != null ? 'Edit attendance' : 'Mark attendance',
      body: MultiBlocListener(
        listeners: [
          BlocListener<AttendanceCubit, AttendanceState>(
            listener: (context, state) {
              state.maybeWhen(
                attendanceDetail: (attendance) {
                  _selectedEmployeeId = attendance.employeeId;
                  _employeeDisplayController.text = attendance.employeeName;
                  _dateController.text = attendance.attendanceDate;
                  _selectedStatus = attendance.attendanceStatus;
                  _syncStatusDisplay();
                  _checkInController.text = attendance.checkInTime ?? '';
                  _checkOutController.text = attendance.checkOutTime ?? '';
                  _breakStartController.text = attendance.breakStartTime ?? '';
                  _breakEndController.text = attendance.breakEndTime ?? '';
                  _locationController.text = attendance.location ?? '';
                  _notesController.text = attendance.notes ?? '';
                  setState(() {});
                },
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
          ),
          BlocListener<EmployeeCubit, EmployeeState>(
            listener: (context, state) {
              state.maybeWhen(
                loaded: (response) {
                  setState(() {
                    _employees = response.employees;
                    _syncEmployeeDisplay();
                  });
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: BlocBuilder<AttendanceCubit, AttendanceState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              loading: () => true,
              submitting: () => true,
              orElse: () => false,
            );

            return BlocBuilder<EmployeeCubit, EmployeeState>(
              builder: (context, employeeState) {
                final isLoadingEmployees = employeeState.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextFormField(
                          controller: _employeeDisplayController,
                          labelText: 'Employee *',
                          hint: 'Tap to select employee',
                          readOnly: true,
                          enabled: widget.attendanceId == null,
                          prefixIcon: const Icon(Icons.person_outline),
                          suffixIcon: isLoadingEmployees
                              ? const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                )
                              : const Icon(Icons.keyboard_arrow_down),
                          onTap: _showEmployeeBottomSheet,
                          validating: (_) =>
                              _selectedEmployeeId == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: _dateController,
                          labelText: 'Attendance date *',
                          hint: 'Tap to select date',
                          readOnly: true,
                          prefixIcon: const Icon(Icons.calendar_today_outlined),
                          onTap: _selectDate,
                          validating: (v) =>
                              (v?.trim().isEmpty ?? true) ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: _statusDisplayController,
                          labelText: 'Attendance status *',
                          hint: 'Tap to select status',
                          readOnly: true,
                          prefixIcon:
                              const Icon(Icons.assignment_turned_in_outlined),
                          suffixIcon: const Icon(Icons.keyboard_arrow_down),
                          onTap: _showStatusBottomSheet,
                          validating: (_) =>
                              _selectedStatus == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        Card(
                          elevation: 0,
                          color: scheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: scheme.outlineVariant),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 20,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Time details',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Optional',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                CustomTextFormField(
                                  controller: _checkInController,
                                  labelText: 'Check-in time',
                                  hint: 'HH:MM:SS',
                                  readOnly: true,
                                  prefixIcon: const Icon(
                                    Icons.login,
                                    color: Colors.green,
                                  ),
                                  onTap: () => _selectTime(_checkInController),
                                ),
                                const SizedBox(height: 12),
                                CustomTextFormField(
                                  controller: _checkOutController,
                                  labelText: 'Check-out time',
                                  hint: 'HH:MM:SS',
                                  readOnly: true,
                                  prefixIcon: const Icon(
                                    Icons.logout,
                                    color: Colors.red,
                                  ),
                                  onTap: () => _selectTime(_checkOutController),
                                ),
                                const SizedBox(height: 12),
                                CustomTextFormField(
                                  controller: _breakStartController,
                                  labelText: 'Break start',
                                  hint: 'HH:MM:SS',
                                  readOnly: true,
                                  prefixIcon: const Icon(
                                    Icons.free_breakfast_outlined,
                                    color: Colors.orange,
                                  ),
                                  onTap: () => _selectTime(_breakStartController),
                                ),
                                const SizedBox(height: 12),
                                CustomTextFormField(
                                  controller: _breakEndController,
                                  labelText: 'Break end',
                                  hint: 'HH:MM:SS',
                                  readOnly: true,
                                  prefixIcon: const Icon(
                                    Icons.free_breakfast,
                                    color: Colors.orange,
                                  ),
                                  onTap: () => _selectTime(_breakEndController),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: _locationController,
                          labelText: 'Location',
                          hint: 'Office, remote, field, etc.',
                          prefixIcon: const Icon(Icons.location_on_outlined),
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: _notesController,
                          labelText: 'Notes',
                          hint: 'Additional notes or remarks',
                          prefixIcon: const Icon(Icons.notes_outlined),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 24),
                        CustomButtonWidget(
                          title: widget.attendanceId != null
                              ? 'Update attendance'
                              : 'Mark attendance',
                          loading: isLoading,
                          onPressed: isLoading ? null : _submit,
                          icon: const Icon(Icons.save_outlined, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
