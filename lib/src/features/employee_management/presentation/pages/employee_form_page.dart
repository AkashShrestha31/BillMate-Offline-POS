import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/image_picker_helper.dart';
import 'package:hotel/src/core/helpers/item_image_helper.dart';
import 'package:hotel/src/core/helpers/phone_number_helper.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/themes/app_colors.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/themed_country_code_picker.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/pdf_export_option_tile.dart';
import 'package:hotel/src/core/widget/uploadable_image_avatar.dart';
import 'package:intl/intl.dart';

import '../widgets/employee_hub_scaffold.dart';
import '../bloc/employee_cubit.dart';
import '../../data/models/request/employee_request_params.dart';

@RoutePage()
class EmployeeFormPage extends StatelessWidget {
  final int? employeeId;

  const EmployeeFormPage({super.key, this.employeeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<EmployeeCubit>();
        if (employeeId != null) {
          cubit.getEmployeeById(employeeId!);
        }
        return cubit;
      },
      child: _EmployeeFormView(employeeId: employeeId),
    );
  }
}

class _EmployeeFormView extends StatefulWidget {
  final int? employeeId;

  const _EmployeeFormView({this.employeeId});

  @override
  State<_EmployeeFormView> createState() => _EmployeeFormViewState();
}

class _EmployeeFormViewState extends State<_EmployeeFormView> {
  final _formKey = GlobalKey<FormState>();
  final _employeeCodeController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _hireDateController = TextEditingController();
  final _basicSalaryController = TextEditingController();
  final _departmentDisplayController = TextEditingController();
  final _positionDisplayController = TextEditingController();
  final _employmentTypeDisplayController = TextEditingController();
  final _employmentStatusDisplayController = TextEditingController();

  String? _selectedDepartment;
  String? _selectedPosition;
  String? _selectedEmploymentType;
  String? _selectedEmploymentStatus;
  /// Sent as `is_active`: 1 active, 0 inactive.
  bool _employeeActive = true;

  CountryCode _countryCode = CountryCode.fromCountryCode('NP');
  String? _allowedEmailDomain;
  bool _emailManuallyEdited = false;
  String? _storedProfileImage;
  final _profilePathNotifier = ValueNotifier<String?>(null);
  final _profileRemovedNotifier = ValueNotifier<bool>(false);
  bool _profileDirty = false;

  @override
  void initState() {
    super.initState();
    if (widget.employeeId == null) {
      _employeeCodeController.text = _generateRandomEmployeeCode();
    }
    _loadAllowedEmailDomain();
  }

  String _emailLocalFromFirstName(String firstName) {
    return firstName.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
  }

  void _syncEmailFromFirstName(String firstName) {
    if (_emailManuallyEdited) return;
    _emailController.text = _emailLocalFromFirstName(firstName);
  }

  void _onFirstNameChanged(String value) {
    _syncEmailFromFirstName(value);
  }

  void _onEmailChanged(String value) {
    final auto = _emailLocalFromFirstName(_firstNameController.text);
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      _emailManuallyEdited = false;
      return;
    }
    if (trimmed != auto) {
      _emailManuallyEdited = true;
    }
  }

  Future<void> _loadAllowedEmailDomain() async {
    final domain = await OrgStorage.getAllowedEmailDomain();
    if (!mounted) return;
    setState(() => _allowedEmailDomain = domain);
  }

  String? _employeeEmailForSubmit() {
    final raw = _emailController.text.trim();
    if (raw.isEmpty) return null;
    final domain = _allowedEmailDomain?.trim();
    if (domain == null || domain.isEmpty) return raw;
    final local = raw.replaceAll('@', '');
    return '$local@$domain';
  }

  String _emailLocalPart(String? email) {
    if (email == null || email.trim().isEmpty) return '';
    final trimmed = email.trim();
    final domain = _allowedEmailDomain?.trim();
    if (domain != null && domain.isNotEmpty) {
      final suffix = '@$domain';
      if (trimmed.toLowerCase().endsWith(suffix.toLowerCase())) {
        return trimmed.substring(0, trimmed.length - suffix.length);
      }
    }
    final at = trimmed.indexOf('@');
    if (at > 0) return trimmed.substring(0, at);
    return trimmed;
  }

  /// Longest dial codes first so +977 wins over +9…
  static final List<MapEntry<String, String>> _dialPrefixToIso = () {
    final list = <MapEntry<String, String>>[
      const MapEntry('+971', 'AE'),
      const MapEntry('+974', 'QA'),
      const MapEntry('+966', 'SA'),
      const MapEntry('+977', 'NP'),
      const MapEntry('+880', 'BD'),
      const MapEntry('+91', 'IN'),
      const MapEntry('+44', 'GB'),
      const MapEntry('+61', 'AU'),
      const MapEntry('+64', 'NZ'),
      const MapEntry('+86', 'CN'),
      const MapEntry('+81', 'JP'),
      const MapEntry('+82', 'KR'),
      const MapEntry('+65', 'SG'),
      const MapEntry('+1', 'US'),
    ];
    list.sort((a, b) => b.key.length.compareTo(a.key.length));
    return list;
  }();

  static const List<MapEntry<String, String>> _departmentOptions = [
    MapEntry('Front Desk', 'Front Desk'),
    MapEntry('Housekeeping', 'Housekeeping'),
    MapEntry('Kitchen', 'Kitchen'),
    MapEntry('Maintenance', 'Maintenance'),
    MapEntry('Management', 'Management'),
  ];
  static const List<MapEntry<String, String>> _positionOptions = [
    MapEntry('Receptionist', 'Receptionist'),
    MapEntry('Housekeeper', 'Housekeeper'),
    MapEntry('Chef', 'Chef'),
    MapEntry('Waiter', 'Waiter'),
    MapEntry('Manager', 'Manager'),
    MapEntry('Supervisor', 'Supervisor'),
  ];
  static const List<MapEntry<String, String>> _employmentTypeOptions = [
    MapEntry('FULL_TIME', 'Full Time'),
    MapEntry('PART_TIME', 'Part Time'),
    MapEntry('CONTRACT', 'Contract'),
    MapEntry('INTERN', 'Intern'),
  ];
  static const List<MapEntry<String, String>> _employmentStatusOptions = [
    MapEntry('ACTIVE', 'Active'),
    MapEntry('INACTIVE', 'Inactive'),
    MapEntry('TERMINATED', 'Terminated'),
    MapEntry('RESIGNED', 'Resigned'),
  ];

  @override
  void dispose() {
    _employeeCodeController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _hireDateController.dispose();
    _basicSalaryController.dispose();
    _departmentDisplayController.dispose();
    _positionDisplayController.dispose();
    _employmentTypeDisplayController.dispose();
    _employmentStatusDisplayController.dispose();
    _profilePathNotifier.dispose();
    _profileRemovedNotifier.dispose();
    super.dispose();
  }

  Future<void> _pickProfilePhoto() async {
    final path = await ImagePickerHelper.pickImagePath(context);
    if (path == null || !mounted) return;
    _profilePathNotifier.value = path;
    _profileRemovedNotifier.value = false;
    _profileDirty = true;
    setState(() {});
  }

  String _labelFor(List<MapEntry<String, String>> options, String? value) {
    if (value == null) return '';
    for (final e in options) {
      if (e.key == value) return e.value;
    }
    return value;
  }

  Future<void> _showSelectBottomSheet(
    BuildContext context, {
    required String title,
    required List<MapEntry<String, String>> options,
    required String? currentValue,
    required void Function(String?) onSelected,
    required void Function(String) setDisplayText,
  }) async {
    final theme = Theme.of(context);
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                verticalMarginSmall,
                const Divider(),
                verticalMarginMedium,
                ...options.expand((e) => [
                      PdfExportOptionTile(
                        icon: currentValue == e.key ? Icons.check_circle : Icons.radio_button_unchecked,
                        title: e.value,
                        color: currentValue == e.key ? Colors.green : null,
                        onTap: () => Navigator.pop(ctx, e.key),
                      ),
                      verticalMarginLarge,
                    ]).toList()
                  ..removeLast(),
              ],
            ),
          ),
        ),
      ),
    );
    if (selected != null && mounted) {
      setState(() {
        onSelected(selected);
        setDisplayText(_labelFor(options, selected));
      });
    }
  }

  Future<void> _pickHireDate(BuildContext context) async {
    final currentText = _hireDateController.text.trim();
    DateTime initialDate = DateTime.now();
    if (currentText.isNotEmpty) {
      final parsed = DateTime.tryParse(currentText);
      if (parsed != null) initialDate = parsed;
    }
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null && mounted) {
      setState(() {
        _hireDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  /// Random readable code (no ambiguous 0/O, 1/I).
  String _generateRandomEmployeeCode() {
    const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final r = Random.secure();
    final suffix = String.fromCharCodes(
      List.generate(6, (_) => alphabet.codeUnitAt(r.nextInt(alphabet.length))),
    );
    return 'EMP$suffix';
  }

  void _applyPhoneFromServer(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      _phoneController.clear();
      return;
    }
    final p = phone.trim();
    if (!p.startsWith('+')) {
      _phoneController.text = p;
      return;
    }
    for (final e in _dialPrefixToIso) {
      if (p.startsWith(e.key)) {
        setState(() {
          _countryCode = CountryCode.fromCountryCode(e.value);
        });
        _phoneController.text = p.substring(e.key.length).trim();
        return;
      }
    }
    _phoneController.text = p.replaceFirst(RegExp(r'^\+'), '').trim();
  }

  String? _composedPhoneForSubmit() {
    return composePhoneWithCountryCode(_phoneController.text, _countryCode);
  }

  String? _validatePhone(String? value) =>
      validateLocalPhoneForCountry(value, _countryCode);

  void _submit() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    final department = _selectedDepartment;
    final position = _selectedPosition;
    final employmentType = _selectedEmploymentType;
    final employmentStatus = _selectedEmploymentStatus;
    if (department == null ||
        position == null ||
        employmentType == null ||
        employmentStatus == null) {
      return;
    }

    String? profileImage;
    if (_profileDirty) {
      if (_profileRemovedNotifier.value) {
        profileImage = '';
      } else {
        final localPath = _profilePathNotifier.value;
        if (localPath != null && localPath.isNotEmpty) {
          profileImage = await ItemImageHelper.encodeFileForStorage(localPath);
          if (profileImage == null && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.l10n.itemImageSizeError),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
        }
      }
    }

    if (!mounted) return;

    final params = EmployeeRequestParams(
      employeeCode: _employeeCodeController.text.trim(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _employeeEmailForSubmit(),
      phone: _composedPhoneForSubmit(),
      address: _addressController.text.trim().isEmpty
          ? null
          : _addressController.text.trim(),
      hireDate: _hireDateController.text.trim().isEmpty
          ? null
          : _hireDateController.text.trim(),
      department: department,
      position: position,
      employmentType: employmentType,
      employmentStatus: employmentStatus,
      basicSalary: _basicSalaryController.text.trim().isEmpty
          ? null
          : double.tryParse(_basicSalaryController.text.trim()),
      profileImage: profileImage,
    );

    final isActiveFlag = _employeeActive ? 1 : 0;
    if (widget.employeeId != null) {
      context.read<EmployeeCubit>().updateEmployee(
            id: widget.employeeId!,
            params: params,
            isActive: isActiveFlag,
          );
    } else {
      context.read<EmployeeCubit>().createEmployee(
            params: params,
            isActive: isActiveFlag,
          );
    }
  }

  Widget _buildEmailField(BuildContext context) {
    final domain = _allowedEmailDomain?.trim();
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    String? validateEmail(String? value) {
      final local = value?.trim() ?? '';
      if (local.isEmpty) return null;
      if (domain != null && domain.isNotEmpty) {
        if (local.contains('@')) return 'Enter only the part before @';
        if (!RegExp(r'^[\w\.\-]+$').hasMatch(local)) return 'Please enter a valid email';
        return null;
      }
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(local)) {
        return 'Please enter a valid email';
      }
      return null;
    }

    if (domain == null || domain.isEmpty) {
      return CustomTextFormField(
        controller: _emailController,
        labelText: 'Email',
        hint: 'Enter email',
        keyboardType: TextInputType.emailAddress,
        onChanged: _onEmailChanged,
        validating: validateEmail,
      );
    }

    return CustomTextFormField(
      controller: _emailController,
      labelText: 'Email',
      hint: 'Enter email',
      keyboardType: TextInputType.emailAddress,
      onChanged: _onEmailChanged,
      validating: validateEmail,
      inputDecoration: InputDecoration(
        hintText: 'Enter email',
        hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        filled: true,
        fillColor: scheme.surface,
        labelText: 'Email',
        labelStyle: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.cfaColor,
        ),
        floatingLabelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.primaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderLight),
          borderRadius: BorderRadius.circular(10),
          gapPadding: 8,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderLight),
          borderRadius: BorderRadius.circular(10),
          gapPadding: 8,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor),
          borderRadius: BorderRadius.circular(10),
          gapPadding: 8,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderLight),
          borderRadius: BorderRadius.circular(10),
          gapPadding: 8,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderLight),
          borderRadius: BorderRadius.circular(10),
          gapPadding: 8,
        ),
        isDense: true,
        suffix: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Text(
            '@$domain',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF555555),
              fontWeight: FontWeight.w600,
            ),
          ),
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
        backgroundColor: employeeHubShellColor(scheme),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.employeeId != null ? 'Edit Employee' : 'Add Employee'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<EmployeeCubit, EmployeeState>(
            listener: (context, state) {
              state.maybeWhen(
                submitSuccess: (response) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(response.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.router.maybePop(true);
                },
                orElse: () {},
              );
            },
          ),
          BlocListener<EmployeeCubit, EmployeeState>(
            listener: (context, state) {
              state.maybeWhen(
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
                employeeDetail: (employee) {
                  _employeeCodeController.text = employee.employeeCode;
                  _firstNameController.text = employee.firstName;
                  _lastNameController.text = employee.lastName;
                  _emailManuallyEdited = true;
                  _emailController.text = _emailLocalPart(employee.email?.toString());
                  _applyPhoneFromServer(employee.phone);
                  _addressController.text = employee.address ?? '';
                  _hireDateController.text = employee.hireDate;
                  _basicSalaryController.text = employee.basicSalary.toString();
                  setState(() {
                    _storedProfileImage = employee.profileImage;
                    _profilePathNotifier.value = null;
                    _profileRemovedNotifier.value = false;
                    _profileDirty = false;
                    _selectedDepartment = employee.department;
                    _selectedPosition = employee.position;
                    _selectedEmploymentType = employee.employmentType;
                    _selectedEmploymentStatus = employee.employmentStatus;
                    _departmentDisplayController.text = _labelFor(_departmentOptions, employee.department);
                    _positionDisplayController.text = _labelFor(_positionOptions, employee.position);
                    _employmentTypeDisplayController.text = _labelFor(_employmentTypeOptions, employee.employmentType);
                    _employmentStatusDisplayController.text =
                        _labelFor(_employmentStatusOptions, employee.employmentStatus);
                    _employeeActive = employee.isActive ?? true;
                  });
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: BlocBuilder<EmployeeCubit, EmployeeState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              loading: () => true,
              submitting: () => true,
              orElse: () => false,
            );

            return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: UploadableImageAvatar(
                      localPathNotifier: _profilePathNotifier,
                      userRemovedNotifier: _profileRemovedNotifier,
                      storedImage: _storedProfileImage,
                      onPick: _pickProfilePhoto,
                      onChanged: () => _profileDirty = true,
                      placeholderLabel: context.l10n.employeeProfilePhotoHint,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _employeeCodeController,
                    labelText: 'Employee Code *',
                    validating: (value) =>
                        value?.trim().isEmpty ?? true ? 'Required' : null,
                    suffixIcon: widget.employeeId != null
                        ? null
                        : SizedBox(
                            width: 48,
                            height: 48,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints.tightFor(width: 48, height: 48),
                              tooltip: 'Generate employee code',
                              icon: Icon(Icons.refresh_rounded),
                              onPressed: () {
                                setState(() {
                                  _employeeCodeController.text = _generateRandomEmployeeCode();
                                });
                              },
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _firstNameController,
                    labelText: 'First Name *',
                    onChanged: _onFirstNameChanged,
                    validating: (value) =>
                        value?.trim().isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _lastNameController,
                    labelText: 'Last Name *',
                    validating: (value) =>
                        value?.trim().isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  _buildEmailField(context),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 132,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: scheme.outlineVariant),
                            ),
                            child: SizedBox(
                              height: 52,
                              width: 132,
                              child: ThemedCountryCodePickerField(
                                countryCode: _countryCode,
                                onChanged: (c) {
                                  setState(() => _countryCode = c);
                                  _formKey.currentState?.validate();
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomTextFormField(
                            controller: _phoneController,
                            labelText: 'Mobile number',
                            keyboardType: TextInputType.phone,
                            padding: EdgeInsets.zero,
                            validating: _validatePhone,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _addressController,
                    labelText: 'Address',
                    maxLines: 1,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _hireDateController,
                    labelText: 'Hire Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    hint: 'Tap to select date',
                    readOnly: true,
                    onTap: () => _pickHireDate(context),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _departmentDisplayController,
                    labelText: 'Department *',
                    hint: 'Tap to select',
                    readOnly: true,
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                    onTap: () => _showSelectBottomSheet(
                      context,
                      title: 'Select Department',
                      options: _departmentOptions,
                      currentValue: _selectedDepartment,
                      onSelected: (v) => _selectedDepartment = v,
                      setDisplayText: (label) => _departmentDisplayController.text = label,
                    ),
                    validating: (v) => (v?.trim().isEmpty ?? true) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _positionDisplayController,
                    labelText: 'Position *',
                    hint: 'Tap to select',
                    readOnly: true,
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                    onTap: () => _showSelectBottomSheet(
                      context,
                      title: 'Select Position',
                      options: _positionOptions,
                      currentValue: _selectedPosition,
                      onSelected: (v) => _selectedPosition = v,
                      setDisplayText: (label) => _positionDisplayController.text = label,
                    ),
                    validating: (v) => (v?.trim().isEmpty ?? true) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _employmentTypeDisplayController,
                    labelText: 'Employment Type *',
                    hint: 'Tap to select',
                    readOnly: true,
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                    onTap: () => _showSelectBottomSheet(
                      context,
                      title: 'Select Employment Type',
                      options: _employmentTypeOptions,
                      currentValue: _selectedEmploymentType,
                      onSelected: (v) => _selectedEmploymentType = v,
                      setDisplayText: (label) => _employmentTypeDisplayController.text = label,
                    ),
                    validating: (v) => (v?.trim().isEmpty ?? true) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _employmentStatusDisplayController,
                    labelText: 'Employment Status *',
                    hint: 'Tap to select',
                    readOnly: true,
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                    onTap: () => _showSelectBottomSheet(
                      context,
                      title: 'Select Employment Status',
                      options: _employmentStatusOptions,
                      currentValue: _selectedEmploymentStatus,
                      onSelected: (v) => _selectedEmploymentStatus = v,
                      setDisplayText: (label) => _employmentStatusDisplayController.text = label,
                    ),
                    validating: (v) => (v?.trim().isEmpty ?? true) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _basicSalaryController,
                    labelText: 'Basic Salary',
                    keyboardType: TextInputType.number,
                    validating: (value) {
                      if (value == null || value.trim().isEmpty) return null;
                      if (double.tryParse(value.trim()) == null) {
                        return 'Enter a valid amount';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Active'),
                    subtitle: Text(
                      _employeeActive
                          ? 'Employee is active and can use the system'
                          : 'Employee is inactive',
                      style: AppFonts.interStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: Switch(
                      value: _employeeActive,
                      onChanged: (v) => setState(() => _employeeActive = v),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButtonWidget(
                    title: widget.employeeId != null ? 'Update' : 'Create',
                    onPressed: isLoading ? null : _submit,
                  )
                ],
              ),
            ),
          );
          },
        ),
      ),
    );
  }
}
