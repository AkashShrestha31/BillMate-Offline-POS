import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/widget/action_bottom_sheet.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/employee_profile_avatar.dart';
import '../widgets/employee_hub_scaffold.dart';
import '../bloc/employee_cubit.dart';
import '../../data/models/response/employee_model.dart';
import 'employee_detail_page.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/widget/freemium_access_scope.dart';
import 'package:hotel/src/core/widget/freemium_record_gate.dart';

class EmployeesListPage extends StatelessWidget {
  const EmployeesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployeeCubit>()..getEmployees(employmentStatus: 'ACTIVE'),
      child: const _EmployeesListView(),
    );
  }
}

class _EmployeesListView extends StatefulWidget {
  const _EmployeesListView();

  @override
  State<_EmployeesListView> createState() => _EmployeesListViewState();
}

class _EmployeesListViewState extends State<_EmployeesListView> {
  String? _selectedDepartment;
  String? _selectedStatus = 'ACTIVE';

  void _loadEmployees() {
    context.read<EmployeeCubit>().getEmployees(
          department: _selectedDepartment,
          employmentStatus: _selectedStatus,
        );
  }

  /// Same layout as [AttendanceListPage] filter: department + status, Clear / Apply.
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
                      isExpanded: true,
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
                      isExpanded: true,
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

  void _showEmployeeBottomSheet(BuildContext context, EmployeeModel employee) {
    final scheme = Theme.of(context).colorScheme;
    ActionBottomSheet.show(
      context,
      title: employee.displayName,
      items: [
        ActionSheetItem(
          icon: Icons.edit_outlined,
          title: 'Edit',
          onTap: () async {
            final result = await context.router.push<bool>(
              EmployeeFormRoute(employeeId: employee.id),
            );
            if (result == true) _loadEmployees();
          },
        ),
        ActionSheetItem(
          icon: Icons.delete_outline,
          title: 'Delete',
          color: scheme.error,
          onTap: () => _confirmDelete(employee),
        ),
      ],
    );
  }

  void _confirmDelete(EmployeeModel employee) {
    final scheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        title: Text('Delete employee'),
        content: Text('Are you sure you want to delete ${employee.displayName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<EmployeeCubit>().deleteEmployee(employee.id);
            },
            style: FilledButton.styleFrom(backgroundColor: scheme.error, foregroundColor: scheme.onError),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingBody(BuildContext context) {
    final s = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(strokeWidth: 2.5, color: s.primary),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading employees…',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: s.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBody(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    Widget? action,
  }) {
    final s = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 56, color: iconColor.withOpacity(0.9)),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: tt.bodyMedium?.copyWith(color: s.onSurfaceVariant, height: 1.35),
            ),
            if (action != null) ...[
              const SizedBox(height: 20),
              action,
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: employeeHubShellColor(scheme),
      appBar: AppBar(
        leading: AppBarIosBackButton(color: scheme.onSurface),
        title: Text(
          'Employees',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: -0.3,
              ),
        ),
        centerTitle: false,
        backgroundColor: employeeHubShellColor(scheme),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Filter',
            icon: Icon(Icons.filter_list_rounded, color: scheme.primary),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body: FreemiumAccessHost(
        feature: FreemiumFeature.employee,
        child: BlocConsumer<EmployeeCubit, EmployeeState>(
        listener: (context, state) {
          final s = Theme.of(context).colorScheme;
          state.maybeWhen(
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message, style: AppFonts.interStyle(color: s.onError)),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: s.error,
                ),
              );
            },
            submitSuccess: (response) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(response.message, style: AppFonts.interStyle(color: s.onPrimary)),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: s.primary,
                ),
              );
              _loadEmployees();
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => _buildLoadingBody(context),
            loading: () => _buildLoadingBody(context),
            submitting: () => _buildLoadingBody(context),
            noInternet: () => _buildMessageBody(
              context,
              icon: Icons.wifi_off_rounded,
              iconColor: scheme.tertiary,
              title: 'No connection',
              subtitle: 'Check your network and try again.',
              action: FilledButton.tonalIcon(
                onPressed: _loadEmployees,
                icon: Icon(Icons.refresh_rounded, size: 20),
                label: Text('Retry'),
              ),
            ),
            error: (message) => _buildMessageBody(
              context,
              icon: Icons.error_outline_rounded,
              iconColor: scheme.error,
              title: 'Something went wrong',
              subtitle: message,
              action: FilledButton.tonalIcon(
                onPressed: _loadEmployees,
                icon: Icon(Icons.refresh_rounded, size: 20),
                label: Text('Retry'),
              ),
            ),
            loaded: (response) {
              final employees = response.employees;

              if (employees.isEmpty) {
                return _buildMessageBody(
                  context,
                  icon: Icons.groups_outlined,
                  iconColor: scheme.onSurfaceVariant,
                  title: 'No employees',
                  subtitle: 'Try changing filters or add a new employee.',
                  action: FilledButton.icon(
                    onPressed: () async {
                      final result = await context.router.push<bool>(
                        EmployeeFormRoute(),
                      );
                      if (result == true) _loadEmployees();
                    },
                    icon: Icon(Icons.add_rounded),
                    label: Text('Add employee'),
                  ),
                );
              }

              return RefreshIndicator(
                color: scheme.primary,
                onRefresh: () async => _loadEmployees(),
                child: Column(
                  children: [
                    if (_selectedDepartment != null || (_selectedStatus != null && _selectedStatus != 'ACTIVE'))
                      Material(
                        color: scheme.surfaceContainerHigh,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              if (_selectedDepartment != null)
                                Chip(
                                  label: Text(_selectedDepartment!),
                                  onDeleted: () {
                                    setState(() => _selectedDepartment = null);
                                    _loadEmployees();
                                  },
                                  backgroundColor: scheme.surfaceContainerHighest,
                                  side: BorderSide(color: scheme.outlineVariant.withOpacity(0.7)),
                                  deleteIconColor: scheme.onSurfaceVariant,
                                ),
                              if (_selectedStatus != null && _selectedStatus != 'ACTIVE')
                                Chip(
                                  label: Text(_selectedStatus!),
                                  onDeleted: () {
                                    setState(() => _selectedStatus = 'ACTIVE');
                                    _loadEmployees();
                                  },
                                  backgroundColor: scheme.surfaceContainerHighest,
                                  side: BorderSide(color: scheme.outlineVariant.withOpacity(0.7)),
                                  deleteIconColor: scheme.onSurfaceVariant,
                                ),
                            ],
                          ),
                        ),
                      ),
                    Expanded(
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                        itemCount: employees.length + 1,
                        itemBuilder: (context, index) {
                          if (index == employees.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 12, bottom: 8),
                              child: Center(
                                child: Text(
                                  '',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: scheme.onSurfaceVariant,
                                      ),
                                ),
                              ),
                            );
                          }
                          final employee = employees[index];
                          return FreemiumRecordGate(
                            recordKey: employee.id.toString(),
                            child: _EmployeeListItem(
                            employee: employee,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmployeeDetailPage(employeeId: employee.id),
                                ),
                              );
                            },
                            onDelete: () => _showEmployeeBottomSheet(context, employee),
                          ),
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
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New employee',
        onPressed: () async {
          final result = await context.router.push<bool>(
            EmployeeFormRoute(),
          );
          if (result == true) _loadEmployees();
        },
        elevation: 2,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        child: Icon(Icons.add_rounded, size: 28),
      ),
    );
  }
}

(Color, Color) _employmentStatusChipColors(ColorScheme scheme, String status) {
  switch (status.toUpperCase()) {
    case 'ACTIVE':
      return (scheme.primaryContainer, scheme.onPrimaryContainer);
    case 'INACTIVE':
      return (scheme.tertiaryContainer, scheme.onTertiaryContainer);
    case 'TERMINATED':
      return (scheme.errorContainer, scheme.onErrorContainer);
    case 'RESIGNED':
      return (scheme.surfaceContainerHighest, scheme.onSurfaceVariant);
    default:
      return (scheme.secondaryContainer, scheme.onSecondaryContainer);
  }
}

class _EmployeeListItem extends StatelessWidget {
  final EmployeeModel employee;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _EmployeeListItem({
    required this.employee,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final initial = employee.firstName.isNotEmpty ? employee.firstName[0].toUpperCase() : '?';
    final (chipBg, chipFg) = _employmentStatusChipColors(scheme, employee.employmentStatus);

    return Material(
      color: scheme.surface,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              horizontalMarginMedium,
              EmployeeProfileAvatar(
                profileImage: employee.profileImage,
                initial: initial,
                radius: 22,
                backgroundColor: scheme.surfaceContainerHighest,
                initialStyle: textTheme.titleMedium?.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              horizontalMarginMedium,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.displayName,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        color: scheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      employee.department,
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: chipBg.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                  child: Text(
                    employee.employmentStatus,
                    style: textTheme.labelSmall?.copyWith(
                      color: chipFg,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'More',
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: scheme.onSurfaceVariant,
                    size: context.theme.appTheme.spacing16,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ),
    );
  }
}
