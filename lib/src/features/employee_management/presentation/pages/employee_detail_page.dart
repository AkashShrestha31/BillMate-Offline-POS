import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/employee_profile_avatar.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_advance_request_params.dart';
import 'package:hotel/src/features/employee/data/models/request/employee_outstanding_request_params.dart';
import 'package:hotel/src/features/employee/presentation/bloc/employee_advance_cubit.dart';
import 'package:hotel/src/features/employee/presentation/bloc/employee_outstanding_cubit.dart';
import 'package:hotel/src/features/employee/presentation/pages/advance_invoice_page.dart';
import 'package:hotel/src/features/employee/presentation/pages/employee_outstanding_page.dart';
import 'package:hotel/src/features/employee_management/data/models/response/employee_model.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../widgets/employee_hub_scaffold.dart';
import '../bloc/employee_cubit.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

class EmployeeDetailPage extends StatelessWidget {
  final int employeeId;

  const EmployeeDetailPage({super.key, required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployeeCubit>()..getEmployeeById(employeeId),
      child: const _EmployeeDetailView(),
    );
  }
}

class _EmployeeDetailView extends StatelessWidget {
  const _EmployeeDetailView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: employeeHubShellColor(scheme),
      appBar: AppBar(
        leading: AppBarIosBackButton(color: scheme.onSurface),
        title: Text(
          'Employee',
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
          BlocBuilder<EmployeeCubit, EmployeeState>(
            builder: (context, state) {
              return state.maybeWhen(
                employeeDetail: (employee) => IconButton(
                  tooltip: 'Edit',
                  icon: Icon(Icons.edit_outlined, color: scheme.primary),
                  onPressed: () async {
                    final result = await context.router.push<bool>(
                      EmployeeFormRoute(employeeId: employee.id),
                    );
                    if (result == true) {
                      context.read<EmployeeCubit>().getEmployeeById(employee.id);
                    }
                  },
                ),
                orElse: () => const SizedBox(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<EmployeeCubit, EmployeeState>(
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
            ),
            error: (message) => _buildMessageBody(
              context,
              icon: Icons.error_outline_rounded,
              iconColor: scheme.error,
              title: 'Something went wrong',
              subtitle: message,
            ),
            loaded: (_) => const SizedBox(),
            employeeDetail: (employee) => SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(14),
                    clipBehavior: Clip.antiAlias,
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: scheme.outlineVariant.withOpacity(0.7)),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EmployeeProfileAvatar(
                            profileImage: employee.profileImage,
                            initial: employee.firstName.isNotEmpty
                                ? employee.firstName[0]
                                : '?',
                            radius: 28,
                            backgroundColor: scheme.primaryContainer,
                            initialStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: scheme.onPrimaryContainer,
                                ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  employee.displayName,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        height: 1.2,
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${employee.position} · ${employee.department}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: scheme.onSurfaceVariant,
                                        height: 1.3,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: scheme.secondaryContainer.withOpacity(0.65),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    employee.employmentStatus,
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          color: scheme.onSecondaryContainer,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Contact Information
                  _buildSection(
                    'Contact Information',
                    [
                      _buildInfoRow('Email', employee.email.toString(), context),
                      if (employee.phone != null) _buildInfoRow('Phone', employee.phone!, context),
                      if (employee.address != null) _buildInfoRow('Address', employee.address!, context),
                    ],
                    context,
                  ),

                  // Employment Details
                  _buildSection(
                      'Employment Details',
                      [
                        _buildInfoRow('Employee Code', employee.employeeCode, context),
                        if (employee.dateOfBirth != null)
                          _buildInfoRow('Date of Birth', employee.dateOfBirth!, context),
                        _buildInfoRow('Hire Date', employee.hireDate, context),
                        _buildInfoRow('Employment Type', employee.employmentType, context),
                      ],
                      context),

                  // Salary Information
                  _buildSection(
                      'Salary Information',
                      [
                        _buildInfoRow('Basic Salary', 'NPR ${employee.basicSalary.toStringAsFixed(2)}', context),
                        if (employee.hourlyRate != null)
                          _buildInfoRow('Hourly Rate', 'NPR ${employee.hourlyRate!.toStringAsFixed(2)}', context),
                      ],
                      context),

                  // Emergency Contact
                  if (employee.emergencyContactName != null)
                    _buildSection(
                        'Emergency Contact',
                        [
                          _buildInfoRow('Name', employee.emergencyContactName!, context),
                          if (employee.emergencyContactPhone != null)
                            _buildInfoRow('Phone', employee.emergencyContactPhone!, context),
                        ],
                        context),

                  // Banking Details
                  if (employee.bankName != null)
                    _buildSection(
                        'Banking Details',
                        [
                          _buildInfoRow('Bank Name', employee.bankName!, context),
                          if (employee.bankAccountNumber != null)
                            _buildInfoRow('Account Number', employee.bankAccountNumber!, context),
                        ],
                        context),

                  // Notes
                  if (employee.notes != null)
                    _buildSection(
                      'Notes',
                      [
                        Text(
                          employee.notes!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.45),
                        ),
                      ],
                      context,
                    ),

                  _buildOutstandingEntryTile(context, employee),
                  _buildAdvanceEntryTile(context, employee),
                ],
              ),
            ),
            submitSuccess: (_) => const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _buildLoadingBody(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: scheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading employee…',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
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
  }) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
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
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant, height: 1.35),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children, BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurfaceVariant,
                  letterSpacing: 0.15,
                ),
          ),
        ),
        const SizedBox(height: 8),
        Material(
          color: scheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: scheme.outlineVariant.withOpacity(0.7)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  /// Month start → today; user can change before applying. Syncfusion picker in a bottom sheet.
  Future<DateTimeRange?> _pickEmployeeSheetDateRange(BuildContext context) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final firstOfMonth = DateTime(now.year, now.month, 1);
    final minDate = DateTime(now.year - 10, 1, 1);

    return showModalBottomSheet<DateTimeRange?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (ctx) {
        return _EmployeeDateRangePickerSheet(
          minDate: minDate,
          maxDate: today,
          initialStart: firstOfMonth,
          initialEnd: today,
        );
      },
    );
  }

  Widget _buildOutstandingEntryTile(BuildContext context, EmployeeModel employee) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Material(
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: scheme.outlineVariant.withOpacity(0.7)),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            _openEmployeeOutstandingBottomSheet(context, employee);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Icon(Icons.account_balance_wallet_outlined, color: scheme.primary, size: 24),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.partyUnpaid,
                        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pick a date range (defaults to this month), then view linked balances',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openEmployeeOutstandingBottomSheet(BuildContext context, EmployeeModel employee) async {
    final range = await _pickEmployeeSheetDateRange(context);
    if (range == null || !context.mounted) return;

    final startStr = DateFormat('yyyy-MM-dd').format(range.start);
    final endStr = DateFormat('yyyy-MM-dd').format(range.end);
    final rangeCaption = '$startStr — $endStr';
    debugPrint(
      '[EmployeeDetail] Party outstanding — using date range: $startStr → $endStr '
      '(employee_id=${employee.id})',
    );

    if (!context.mounted) return;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return BlocProvider(
          create: (_) => getIt<EmployeeOutstandingCubit>()
            ..getEmployeeOutstanding(
              params: EmployeeOutstandingRequestParams(
                employeeId: employee.id,
                searchTerm: '',
                outstandingOnly: true,
                startDate: startStr,
                endDate: endStr,
              ),
            ),
          child: _PartyChromeBottomSheet(
            title: context.l10n.partyUnpaid,
            subtitle: employee.displayName,
            caption: rangeCaption,
            content: BlocBuilder<EmployeeOutstandingCubit, EmployeeOutstandingState>(
              builder: (context, state) {
                return state.when(
                  initial: () => _sheetLoadingBody(context, message: context.l10n.loadingUnpaid),
                  loading: () => _sheetLoadingBody(context, message: context.l10n.loadingUnpaid),
                  noInternet: () => _sheetMessageBody(
                    context,
                    icon: Icons.wifi_off_rounded,
                    title: 'No connection',
                    subtitle: 'Check your network and try again.',
                  ),
                  error: (message) => _sheetMessageBody(
                    context,
                    icon: Icons.error_outline_rounded,
                    title: 'Could not load',
                    subtitle: message,
                  ),
                  success: (responseModel) {
                    return EmployeeOutstandingPage(result: responseModel.data);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildAdvanceEntryTile(BuildContext context, EmployeeModel employee) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Material(
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: scheme.outlineVariant.withOpacity(0.7)),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            _openEmployeeAdvanceBottomSheet(context, employee);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Icon(Icons.payments_outlined, color: scheme.primary, size: 24),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Advance purchases',
                        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pick a date range (defaults to this month), then view advances',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openEmployeeAdvanceBottomSheet(BuildContext context, EmployeeModel employee) async {
    final range = await _pickEmployeeSheetDateRange(context);
    if (range == null || !context.mounted) return;

    final startStr = DateFormat('yyyy-MM-dd').format(range.start);
    final endStr = DateFormat('yyyy-MM-dd').format(range.end);
    final rangeCaption = '$startStr — $endStr';
    debugPrint(
      '[EmployeeDetail] Advance purchases — using date range: $startStr → $endStr '
      '(employee_id=${employee.id})',
    );

    if (!context.mounted) return;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return BlocProvider(
          create: (_) => getIt<EmployeeAdvanceCubit>()
            ..getEmployeeAdvance(
              params: EmployeeAdvanceRequestParams(
                employeeId: employee.id,
                startDate: startStr,
                endDate: endStr,
              ),
            ),
          child: _PartyChromeBottomSheet(
            title: 'Advance',
            subtitle: employee.displayName,
            caption: rangeCaption,
            content: BlocBuilder<EmployeeAdvanceCubit, EmployeeAdvanceState>(
              builder: (context, state) {
                return state.when(
                  initial: () => _sheetLoadingBody(context, message: 'Loading advances…'),
                  loading: () => _sheetLoadingBody(context, message: 'Loading advances…'),
                  noInternet: () => _sheetMessageBody(
                    context,
                    icon: Icons.wifi_off_rounded,
                    title: 'No connection',
                    subtitle: 'Check your network and try again.',
                  ),
                  error: (message) => _sheetMessageBody(
                    context,
                    icon: Icons.error_outline_rounded,
                    title: 'Could not load',
                    subtitle: message,
                  ),
                  success: (responseModel) {
                    final data = responseModel.data;
                    if (data.analysisData.isEmpty) {
                      return _sheetMessageBody(
                        context,
                        icon: Icons.receipt_long_rounded,
                        title: 'No advances',
                        subtitle:
                            'No advance records for this employee in the selected period.',
                      );
                    }
                    return AdvanceInvoicePage(response: data);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant, height: 1.35),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sheetLoadingBody(BuildContext context, {String message = 'Loading…'}) {
    final s = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(strokeWidth: 2.5, color: s.primary),
          ),
          const SizedBox(height: 14),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: s.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _sheetMessageBody(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final s = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: s.onSurfaceVariant.withOpacity(0.75)),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: tt.bodyMedium?.copyWith(color: s.onSurfaceVariant, height: 1.35),
            ),
          ],
        ),
      ),
    );
  }
}

/// Themed modal card for party unpaid / advance purchase sheets.
class _PartyChromeBottomSheet extends StatelessWidget {
  const _PartyChromeBottomSheet({
    required this.title,
    this.subtitle,
    this.caption,
    required this.content,
  });

  final String title;
  final String? subtitle;
  final String? caption;
  final Widget content;

  static const _margin = EdgeInsets.only(left: 16, right: 16, bottom: 16);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final sheetHeight = MediaQuery.sizeOf(context).height * 0.88;

    return SafeArea(
      child: Padding(
        padding: _margin,
        child: Container(
          height: sheetHeight,
          decoration: AppBottomSheetTheme.sheetDecoration(context),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 4, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (subtitle != null && subtitle!.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              subtitle!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                          if (caption != null && caption!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              caption!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Close',
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close_rounded, color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Divider(
                height: 1,
                thickness: 1,
                color: scheme.outlineVariant.withValues(alpha: 0.5),
              ),
              Expanded(
                child: ColoredBox(
                  color: scheme.surfaceContainerLowest,
                  child: content,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Syncfusion range picker in a modal bottom sheet (employee outstanding / advance).
class _EmployeeDateRangePickerSheet extends StatefulWidget {
  const _EmployeeDateRangePickerSheet({
    required this.minDate,
    required this.maxDate,
    required this.initialStart,
    required this.initialEnd,
  });

  final DateTime minDate;
  final DateTime maxDate;
  final DateTime initialStart;
  final DateTime initialEnd;

  @override
  State<_EmployeeDateRangePickerSheet> createState() => _EmployeeDateRangePickerSheetState();
}

class _EmployeeDateRangePickerSheetState extends State<_EmployeeDateRangePickerSheet> {
  late final DateRangePickerController _pickerController;
  late PickerDateRange _pickerRange;

  @override
  void initState() {
    super.initState();
    _pickerController = DateRangePickerController();
    _pickerController.displayDate = widget.initialEnd;
    _pickerController.selectedRange = PickerDateRange(widget.initialStart, widget.initialEnd);
    _pickerRange = _pickerController.selectedRange!;
  }

  @override
  void dispose() {
    _pickerController.dispose();
    super.dispose();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    final v = args.value;
    if (v is PickerDateRange) {
      setState(() => _pickerRange = v);
      return;
    }
    if (v is DateTime) {
      setState(() => _pickerRange = PickerDateRange(v, null));
    }
  }

  /// Calendar dates in local time (Syncfusion may supply UTC).
  DateTime _localDateOnly(DateTime d) {
    final l = d.toLocal();
    return DateTime(l.year, l.month, l.day);
  }

  void _apply() {
    final fromController = _pickerController.selectedRange;
    final range = fromController ?? _pickerRange;
    final start = range.startDate;
    final end = range.endDate ?? range.startDate;
    if (start == null || end == null) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text('Select a start and end date')),
      );
      return;
    }
    var s = _localDateOnly(start);
    var e = _localDateOnly(end);
    if (e.isBefore(s)) {
      final t = s;
      s = e;
      e = t;
    }
    if (s.isBefore(widget.minDate)) s = widget.minDate;
    if (e.isAfter(widget.maxDate)) e = widget.maxDate;
    final apiStart = DateFormat('yyyy-MM-dd').format(s);
    final apiEnd = DateFormat('yyyy-MM-dd').format(e);
    debugPrint('[EmployeeDateRangePicker] OK pressed — chosen range: $apiStart → $apiEnd');
    Navigator.pop(context, DateTimeRange(start: s, end: e));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final sheetColor = scheme.surfaceContainerHigh;
    final accent = scheme.primary;
    final rangeFill = scheme.primaryContainer;
    final ink = scheme.onSurface;
    final weekendMuted = scheme.onSurfaceVariant;
    final adjacentMonth = scheme.outlineVariant;

    final actionStyle = TextButton.styleFrom(
      foregroundColor: accent,
      textStyle: theme.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Material(
            color: sheetColor,
            elevation: 0,
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                Center(child: AppBottomSheetTheme.dragHandle(context)),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Select date range',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: SizedBox(
                    height: 396,
                    child: SfDateRangePicker(
                      view: DateRangePickerView.month,
                      monthFormat: 'MMMM',
                      controller: _pickerController,
                      selectionMode: DateRangePickerSelectionMode.range,
                      minDate: widget.minDate,
                      maxDate: widget.maxDate,
                      showTodayButton: false,
                      showNavigationArrow: true,
                      navigationDirection: DateRangePickerNavigationDirection.horizontal,
                      navigationMode: DateRangePickerNavigationMode.snap,
                      backgroundColor: sheetColor,
                      todayHighlightColor: Colors.transparent,
                      selectionShape: DateRangePickerSelectionShape.circle,
                      startRangeSelectionColor: accent,
                      endRangeSelectionColor: accent,
                      rangeSelectionColor: rangeFill,
                      selectionTextStyle: AppFonts.interStyle(
                        color: scheme.onPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      rangeTextStyle: AppFonts.interStyle(
                        color: ink,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      headerHeight: 52,
                      headerStyle: DateRangePickerHeaderStyle(
                        backgroundColor: sheetColor,
                        textAlign: TextAlign.center,
                        textStyle: AppFonts.interStyle(
                          color: ink,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          letterSpacing: -0.3,
                        ),
                      ),
                      monthViewSettings: DateRangePickerMonthViewSettings(
                        firstDayOfWeek: 1,
                        viewHeaderHeight: 40,
                        dayFormat: 'EEE',
                        weekendDays: const [DateTime.saturday, DateTime.sunday],
                        enableSwipeSelection: true,
                        viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          backgroundColor: sheetColor,
                          textStyle: AppFonts.interStyle(
                            color: ink.withValues(alpha: 0.5),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      monthCellStyle: DateRangePickerMonthCellStyle(
                        textStyle: AppFonts.interStyle(
                          color: ink,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        weekendTextStyle: AppFonts.interStyle(
                          color: weekendMuted,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        leadingDatesTextStyle: AppFonts.interStyle(
                          color: adjacentMonth,
                          fontSize: 13,
                        ),
                        trailingDatesTextStyle: AppFonts.interStyle(
                          color: adjacentMonth,
                          fontSize: 13,
                        ),
                        todayTextStyle: AppFonts.interStyle(
                          color: accent,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                        todayCellDecoration: BoxDecoration(
                          border: Border.all(color: accent, width: 1.5),
                          shape: BoxShape.circle,
                        ),
                        disabledDatesTextStyle: AppFonts.interStyle(
                          color: ink.withValues(alpha: 0.22),
                          fontSize: 13,
                        ),
                      ),
                      onSelectionChanged: _onSelectionChanged,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: actionStyle,
                        onPressed: () => Navigator.pop<DateTimeRange?>(context),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        style: actionStyle,
                        onPressed: _apply,
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
