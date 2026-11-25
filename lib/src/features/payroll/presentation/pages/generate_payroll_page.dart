import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/features/employee_management/presentation/widgets/employee_hub_scaffold.dart';
import 'package:hotel/src/features/employee_management/data/models/response/employee_model.dart';
import 'package:hotel/src/features/employee_management/domain/usecases/get_employees_use_case.dart';
import 'package:intl/intl.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

import '../../data/models/request/generate_payroll_request.dart';
import '../../domain/usecases/payroll_use_cases.dart';

@RoutePage()
class GeneratePayrollPage extends StatefulWidget {
  const GeneratePayrollPage({super.key});

  @override
  State<GeneratePayrollPage> createState() => _GeneratePayrollPageState();
}

class _GeneratePayrollPageState extends State<GeneratePayrollPage> {
  final _formKey = GlobalKey<FormState>();
  final _bonusController = TextEditingController();
  final _allowancesController = TextEditingController();
  final _deductionsController = TextEditingController();

  final ValueNotifier<EmployeeModel?> _selectedEmployee = ValueNotifier(null);
  final ValueNotifier<String> _selectedMonth =
      ValueNotifier(DateFormat('yyyy-MM').format(DateTime.now()));
  final ValueNotifier<bool> _addBonusDay = ValueNotifier(true);

  List<EmployeeModel> _employees = [];
  bool _loadingEmployees = true;
  String? _loadError;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    setState(() {
      _loadingEmployees = true;
      _loadError = null;
    });
    final result = await getIt<GetEmployeesUseCase>().execute();
    if (!mounted) return;
    result.fold(
      (error) {
        setState(() {
          _loadingEmployees = false;
          _loadError = error.when(
            serverError: (m) => m,
            noInternet: () => 'No internet connection',
          );
        });
      },
      (data) {
        setState(() {
          _loadingEmployees = false;
          _employees = data.employees;
        });
      },
    );
  }

  @override
  void dispose() {
    _bonusController.dispose();
    _allowancesController.dispose();
    _deductionsController.dispose();
    _selectedEmployee.dispose();
    _selectedMonth.dispose();
    _addBonusDay.dispose();
    super.dispose();
  }

  Future<void> _pickEmployee() async {
    FocusScope.of(context).unfocus();
    final theme = Theme.of(context);
    final picked = await showModalBottomSheet<EmployeeModel>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        final maxH = MediaQuery.sizeOf(ctx).height * 0.55;
        return SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            constraints: BoxConstraints(maxHeight: maxH),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 8.w, 8.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Select employee',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _employees.length,
                    itemBuilder: (_, i) {
                      final e = _employees[i];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              theme.colorScheme.primary.withValues(alpha: 0.12),
                          child: Text(
                            e.fullName.isNotEmpty
                                ? e.fullName[0].toUpperCase()
                                : '?',
                            style: AppFonts.interStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        title: Text(
                          e.fullName,
                          style: AppFonts.interStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: e.department.isNotEmpty
                            ? Text('${e.department} · ${e.position}')
                            : null,
                        onTap: () => Navigator.pop(ctx, e),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (picked != null) {
      HapticFeedback.selectionClick();
      _selectedEmployee.value = picked;
    }
  }

  Future<void> _selectMonth() async {
    HapticFeedback.selectionClick();
    FocusScope.of(context).unfocus();
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse('${_selectedMonth.value}-01'),
      firstDate: DateTime(now.year - 2),
      lastDate: now,
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      HapticFeedback.selectionClick();
      _selectedMonth.value = DateFormat('yyyy-MM').format(picked);
    }
  }

  bool _validateOptionalMoneyField(String raw, String fieldLabel) {
    final t = raw.trim();
    if (t.isEmpty) return true;
    final v = double.tryParse(t);
    if (v == null || v < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Enter a valid amount for $fieldLabel'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
    return true;
  }

  double? _readOptionalMoney(String raw) {
    final t = raw.trim();
    if (t.isEmpty) return null;
    return double.tryParse(t);
  }

  Future<void> _handleGenerate() async {
    FocusScope.of(context).unfocus();
    if (_selectedEmployee.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an employee'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    if (!_validateOptionalMoneyField(_bonusController.text, 'bonus')) return;
    if (!_validateOptionalMoneyField(_allowancesController.text, 'allowances')) {
      return;
    }
    if (!_validateOptionalMoneyField(_deductionsController.text, 'deductions')) {
      return;
    }

    final bonus = _readOptionalMoney(_bonusController.text);
    final allowances = _readOptionalMoney(_allowancesController.text);
    final deductions = _readOptionalMoney(_deductionsController.text);

    HapticFeedback.mediumImpact();
    setState(() => _submitting = true);
    final request = GeneratePayrollRequest(
      employeeId: _selectedEmployee.value!.id,
      addBonusDay: _addBonusDay.value,
      payrollMonth: _selectedMonth.value,
      bonus: bonus,
      additionalAllowances: allowances,
      additionalDeductions: deductions,
    );

    final result = await getIt<GeneratePayrollUseCase>().execute(request: request);
    if (!mounted) return;
    setState(() => _submitting = false);

    result.fold(
      (error) {
        error.when(
          serverError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          noInternet: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Could not save payroll'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        );
      },
      (data) {
        HapticFeedback.lightImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data.message),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pop(true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: employeeHubShellColor(scheme),
      appBar: AppBar(
        leading: AppBarIosBackButton(color: scheme.onSurface),
        title: Text('Generate payroll'),
        backgroundColor: employeeHubShellColor(scheme),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget? _buildBottomBar() {
    if (_loadingEmployees || _loadError != null || _employees.isEmpty) {
      return null;
    }

    final theme = Theme.of(context);
    return ListenableBuilder(
      listenable: Listenable.merge([_selectedEmployee, _addBonusDay]),
      builder: (context, _) {
        final canSubmit = _selectedEmployee.value != null && !_submitting;
        return SafeArea(
          child: Material(
            color: employeeHubShellColor(theme.colorScheme),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
              child: FilledButton(
                onPressed: canSubmit ? _handleGenerate : null,
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  disabledBackgroundColor:
                      theme.colorScheme.onSurface.withValues(alpha: 0.12),
                  disabledForegroundColor:
                      theme.colorScheme.onSurface.withValues(alpha: 0.38),
                  minimumSize: Size(double.infinity, 52.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: _submitting
                    ? SizedBox(
                        height: 22.h,
                        width: 22.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.colorScheme.onPrimary,
                        ),
                      )
                    : Text(
                        'Generate payroll',
                        style: AppFonts.interStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    final theme = Theme.of(context);

    if (_loadingEmployees) {
      return Center(child: CircularProgressIndicator());
    }
    if (_loadError != null) {
      return _messageState(
        icon: Icons.error_outline_rounded,
        message: _loadError!,
        action: FilledButton(onPressed: _loadEmployees, child: Text('Retry')),
      );
    }
    if (_employees.isEmpty) {
      return _messageState(
        icon: Icons.people_outline_rounded,
        message: 'No employees found. Add staff first.',
        action: OutlinedButton(onPressed: _loadEmployees, child: Text('Refresh')),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _FormCard(
              title: 'Payroll details',
              children: [
                ValueListenableBuilder<EmployeeModel?>(
                  valueListenable: _selectedEmployee,
                  builder: (context, employee, _) {
                    return _SelectRow(
                      title: 'Employee',
                      subtitle: employee?.fullName ?? 'Tap to choose',
                      isPlaceholder: employee == null,
                      icon: Icons.person_outline_rounded,
                      onTap: _pickEmployee,
                    );
                  },
                ),
                const _FormDivider(),
                ValueListenableBuilder<String>(
                  valueListenable: _selectedMonth,
                  builder: (context, month, _) {
                    return _SelectRow(
                      title: 'Month',
                      subtitle: DateFormat('MMMM yyyy')
                          .format(DateTime.parse('$month-01')),
                      icon: Icons.calendar_month_outlined,
                      onTap: _selectMonth,
                    );
                  },
                ),
                const _FormDivider(),
                ValueListenableBuilder<bool>(
                  valueListenable: _addBonusDay,
                  builder: (context, isOn, _) {
                    return _SwitchRow(
                      title: 'Bonus day',
                      subtitle: 'Extra working day in calculation',
                      value: isOn,
                      onChanged: (v) {
                        HapticFeedback.selectionClick();
                        _addBonusDay.value = v;
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _FormCard(
              title: 'Adjustments',
              caption: 'Optional — leave blank if none',
              children: [
                _MoneyRow(label: 'Bonus', controller: _bonusController),
                const _FormDivider(),
                _MoneyRow(
                  label: 'Allowances',
                  controller: _allowancesController,
                ),
                const _FormDivider(),
                _MoneyRow(
                  label: 'Deductions',
                  controller: _deductionsController,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              'Calculated from attendance and base salary for the selected month.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _messageState({
    required IconData icon,
    required String message,
    required Widget action,
  }) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48.r, color: theme.colorScheme.onSurfaceVariant),
            SizedBox(height: 16.h),
            Text(message, textAlign: TextAlign.center),
            SizedBox(height: 20.h),
            action,
          ],
        ),
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  const _FormCard({
    required this.title,
    required this.children,
    this.caption,
  });

  final String title;
  final String? caption;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (caption != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    caption!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _FormDivider extends StatelessWidget {
  const _FormDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 16.w,
      endIndent: 16.w,
      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.6),
    );
  }
}

class _SelectRow extends StatelessWidget {
  const _SelectRow({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isPlaceholder = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPlaceholder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, size: 22.r, color: theme.colorScheme.primary),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight:
                          isPlaceholder ? FontWeight.w400 : FontWeight.w600,
                      color: isPlaceholder
                          ? theme.colorScheme.onSurfaceVariant
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 4.h, 16.w, 4.h),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            activeColor: theme.colorScheme.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _MoneyRow extends StatelessWidget {
  const _MoneyRow({
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 88.w,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            'Rs',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.primary,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                isDense: true,
                hintText: '0',
                hintStyle: AppFonts.interStyle(
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
