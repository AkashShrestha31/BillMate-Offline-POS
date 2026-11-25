import 'dart:async';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/services/currency/app_currency_service.dart';
import 'package:hotel/src/core/services/currency/currency_picker_option.dart';
import 'package:hotel/src/core/widget/currency_searchable_bottom_sheet.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/pdf_export_option_tile.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_features.dart';
import 'package:hotel/src/features/loyalty/domain/loyalty_program_service.dart';
import 'package:hotel/src/features/party/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/party/data/models/request/update_party_request.dart';
import 'package:hotel/src/features/party/data/models/response/party_model.dart';
import 'package:hotel/src/features/role/domain/party_picker_role_helper.dart';
import 'package:hotel/src/features/role/domain/repositories/roles_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/party_cubit.dart';

@RoutePage()
class PartyEditPage extends StatefulWidget {
  final PartyModel? party;
  final bool isEditing;

  /// API-style role from parties list tab: `customer` or `supplier`. Used when creating.
  final String? presetRole;

  const PartyEditPage({
    super.key,
    this.party,
    this.isEditing = false,
    this.presetRole,
  });

  @override
  State<PartyEditPage> createState() => _PartyEditPageState();
}

class _PartyEditPageState extends State<PartyEditPage>
    with SingleTickerProviderStateMixin {
  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _newNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _loyaltyPointsController;
  late TextEditingController _outstandingAmountController;
  late TextEditingController _roleDisplayController;
  late TextEditingController _currencyDisplayController;
  late TextEditingController _defaultAccountDisplayController;
  late TextEditingController _loyaltyProgramDisplayController;

  final _selectedRoleNotifier = ValueNotifier<String>('Customer');
  final _selectedCurrencyNotifier = ValueNotifier<String?>(null);
  final _selectedLoyaltyProgramNotifier = ValueNotifier<String?>(null);
  final _selectedDefaultAccountNotifier = ValueNotifier<String?>(null);
  final _photoPathNotifier = ValueNotifier<String?>(null);
  /// When true, hide [PartyModel.displayImageUrl] until user picks a new photo (edit mode).
  final _userRemovedPartyPhotoNotifier = ValueNotifier<bool>(false);
  final _loyaltyProgramOptionsNotifier = ValueNotifier<List<String>>([]);

  late Listenable _formListenable;
  late TabController _tabController;

  List<String> _roleOptions = ['Customer', 'Supplier', 'Both'];
  final List<String> _defaultAccountOptions = ['Debtors', 'Creditors'];

  bool _isEmployeeRole(String role) =>
      role.trim().toLowerCase() == 'employee';

  List<String> _partyFormRoleOptions(List<String> roles) =>
      roles.where((role) => !_isEmployeeRole(role)).toList();

  static final ImagePicker _imagePicker = ImagePicker();

  bool get _isTablet => DeviceLayout.isTablet(context);

  static const double _tabletContentMaxWidth = 640;

  double _tabletContentWidth(BuildContext context) {
    final available = MediaQuery.sizeOf(context).width - 48;
    return available < _tabletContentMaxWidth
        ? available
        : _tabletContentMaxWidth;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _formListenable = Listenable.merge([
      _selectedRoleNotifier,
      _selectedCurrencyNotifier,
      _selectedLoyaltyProgramNotifier,
      _selectedDefaultAccountNotifier,
      _photoPathNotifier,
      _userRemovedPartyPhotoNotifier,
      _loyaltyProgramOptionsNotifier,
    ]);
    _initializeControllers();
    if (widget.party != null) {
      _populateFields();
    } else if (!widget.isEditing) {
      _applyInitialCreateDefaults();
    }
    _selectedRoleNotifier.addListener(_onCreateRoleChanged);
    _loadRoleOptions();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncRoleDisplayText();
    _syncDefaultAccountDisplayText();
    _syncNumericDisplayTexts();
  }

  Future<void> _loadRoleOptions() async {
    if (!getIt.isRegistered<RolesRepository>()) return;
    final result = await getIt<RolesRepository>().getRoles();
    result.fold((_) {}, (roles) {
      if (!mounted || roles.isEmpty) return;
      setState(() {
        _roleOptions = _partyFormRoleOptions(roles.map((r) => r.name).toList());
        final current = _selectedRoleNotifier.value;
        if (!_roleOptions.contains(current) && _roleOptions.isNotEmpty) {
          _selectedRoleNotifier.value = _roleOptions.first;
          _syncRoleDisplayText();
        }
      });
    });
  }

  /// Customer → Debtors; Supplier / Employee → Creditors (per accounting role mapping).
  String _defaultAccountForRole(String role) {
    switch (role) {
      case 'Supplier':
      case 'Employee':
        return 'Creditors';
      case 'Both':
        return 'Debtors';
      case 'Customer':
      case 'Room':
      case 'Cabin':
      default:
        return 'Debtors';
    }
  }

  String? _roleOptionSubtitle(String role) {
    if (PartyPickerRoleHelper.isBothRole(role)) {
      return 'Customer and Supplier tabs only';
    }
    return null;
  }

  String _displayRoleFromPreset(String? preset) {
    switch (preset?.toLowerCase()) {
      case 'supplier':
        return 'Supplier';
      case 'room':
        return 'Room';
      case 'cabin':
        return 'Cabin';
      case 'employee':
      case 'customer':
      default:
        return 'Customer';
    }
  }

  void _applyInitialCreateDefaults() {
    final role = _displayRoleFromPreset(widget.presetRole);
    _selectedRoleNotifier.value = role;
    _roleDisplayController.text = role;
    final currencyService = getIt<AppCurrencyService>();
    _selectedCurrencyNotifier.value = currencyService.code;
    _currencyDisplayController.text = currencyService.reportingLabel;
    _loyaltyPointsController.text = '0';
    _outstandingAmountController.text = '0';
    final account = _defaultAccountForRole(role);
    _selectedDefaultAccountNotifier.value = account;
    _defaultAccountDisplayController.text = account;
    unawaited(_loadLoyaltyPrograms());
  }

  Future<void> _loadLoyaltyPrograms() async {
    if (!LoyaltyFeatures.enabled) return;
    try {
      ensureLoyaltyProgramServiceRegistered();
      final programs = await getIt<LoyaltyProgramService>().listPrograms();
      if (!mounted) return;
      final names = programs.map((p) => p.name).toList();
      final selected = _selectedLoyaltyProgramNotifier.value;
      if (selected != null &&
          selected.isNotEmpty &&
          !names.contains(selected)) {
        names.add(selected);
      }
      _loyaltyProgramOptionsNotifier.value = names;
    } catch (_) {
      // Keep whatever options we already have.
    }
  }

  Future<void> _syncCurrencyDisplayLabel() async {
    final code = _selectedCurrencyNotifier.value?.trim();
    if (code == null || code.isEmpty) {
      _currencyDisplayController.text = '';
      return;
    }
    final option = await getIt<AppCurrencyService>().pickerOptionForCode(code);
    if (!mounted) return;
    _currencyDisplayController.text = option?.fieldLabel ?? code;
  }

  Future<void> _showCurrencyPicker() async {
    final currencyService = getIt<AppCurrencyService>();
    final options = await currencyService.listCurrenciesForPicker();
    if (!mounted) return;
    final current = _selectedCurrencyNotifier.value;

    final selected = await showCurrencyPickerBottomSheet(
      context: context,
      title: context.l10n.selectCurrency,
      searchHint: '${context.l10n.search} code or symbol',
      options: options,
      currentCode: current,
    );

    if (selected == null || !mounted) return;
    _selectedCurrencyNotifier.value = selected;
    CurrencyPickerOption? matched;
    for (final o in options) {
      if (o.code == selected) {
        matched = o;
        break;
      }
    }
    _currencyDisplayController.text = matched?.fieldLabel ?? selected;
  }

  void _onCreateRoleChanged() {
    if (!mounted || widget.isEditing || widget.party != null) return;
    final account = _defaultAccountForRole(_selectedRoleNotifier.value);
    _selectedDefaultAccountNotifier.value = account;
    _syncDefaultAccountDisplayText();
  }

  void _initializeControllers() {
    _nameController = TextEditingController();
    _newNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _loyaltyPointsController = TextEditingController();
    _outstandingAmountController = TextEditingController();
    _roleDisplayController = TextEditingController();
    _currencyDisplayController = TextEditingController();
    _defaultAccountDisplayController = TextEditingController();
    _loyaltyProgramDisplayController = TextEditingController();
  }

  String _apiRoleToDisplay(String role) {
    switch (role.toLowerCase()) {
      case 'customer':
        return 'Customer';
      case 'supplier':
        return 'Supplier';
      case 'employee':
        return 'Employee';
      case 'room':
        return 'Room';
      case 'cabin':
        return 'Cabin';
      case 'both':
        return 'Both';
      default:
        return role;
    }
  }

  String _localizedRoleLabel(String role) =>
      context.l10n.localizedPartyRoleName(role);

  void _syncRoleDisplayText() {
    _roleDisplayController.text = _localizedRoleLabel(_selectedRoleNotifier.value);
  }

  void _syncDefaultAccountDisplayText() {
    final account = _selectedDefaultAccountNotifier.value;
    if (account == null || account.isEmpty) return;
    _defaultAccountDisplayController.text =
        context.l10n.localizedDefaultAccountName(account);
  }

  void _syncNumericDisplayTexts() {
    if (!context.l10n.usesDevanagariDigits) return;
    for (final controller in [
      _loyaltyPointsController,
      _outstandingAmountController,
    ]) {
      if (controller.text.isEmpty) continue;
      controller.text = context.l10n.localizeDigits(
        context.l10n.westernizeDigits(controller.text),
      );
    }
  }

  int? _parseIntField(String text) {
    if (text.isEmpty) return null;
    return int.tryParse(context.l10n.westernizeDigits(text));
  }

  String? _parseAmountField(String text) {
    if (text.isEmpty) return null;
    return context.l10n.westernizeDigits(text);
  }

  Future<void> _showPartyRoleBottomSheet(BuildContext context) async {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final maxHeight = MediaQuery.of(context).size.height * 0.55;
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          constraints: BoxConstraints(maxHeight: maxHeight),
          decoration: AppBottomSheetTheme.floatingCardDecoration(ctx),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.l10n.partySelectPartyRole,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                verticalMarginSmall,
                const Divider(),
                verticalMarginMedium,
                ..._roleOptions.map((role) {
                  final isSelected = _selectedRoleNotifier.value == role;
                  final subtitle = _roleOptionSubtitle(role);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => Navigator.pop(ctx, role),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: isSelected ? Colors.green : scheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _localizedRoleLabel(role),
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (subtitle != null) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      subtitle,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: scheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
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
      _selectedRoleNotifier.value = selected;
      _syncRoleDisplayText();
    }
  }

  void _populateFields() {
    final party = widget.party!;
    _nameController.text = party.name;
    _newNameController.text = party.name;
    _emailController.text = party.email ?? '';
    _phoneController.text = party.phone ?? '';
    _addressController.text = party.address ?? '';
    _loyaltyPointsController.text = party.loyaltyPoints?.toString() ?? '';
    _outstandingAmountController.text = party.outstandingAmount?.toString() ?? '';

    final displayRole = _apiRoleToDisplay(party.role);
    _selectedRoleNotifier.value = displayRole;
    _selectedCurrencyNotifier.value = party.currency;
    _selectedLoyaltyProgramNotifier.value = party.loyaltyProgram;
    final options = List<String>.from(_loyaltyProgramOptionsNotifier.value);
    if (party.loyaltyProgram != null && party.loyaltyProgram!.isNotEmpty && !options.contains(party.loyaltyProgram)) {
      options.add(party.loyaltyProgram!);
      _loyaltyProgramOptionsNotifier.value = options;
    }
    _roleDisplayController.text = _selectedRoleNotifier.value;
    _currencyDisplayController.text = party.currency ?? '';
    final account = party.defaultAccount ?? '';
    _defaultAccountDisplayController.text = account;
    _selectedDefaultAccountNotifier.value = account.isEmpty ? null : account;
    _loyaltyProgramDisplayController.text = party.loyaltyProgram ?? '';
    _userRemovedPartyPhotoNotifier.value = false;
    _syncCurrencyDisplayLabel();
    unawaited(_loadLoyaltyPrograms());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _selectedRoleNotifier.removeListener(_onCreateRoleChanged);
    _selectedRoleNotifier.dispose();
    _selectedCurrencyNotifier.dispose();
    _selectedLoyaltyProgramNotifier.dispose();
    _selectedDefaultAccountNotifier.dispose();
    _photoPathNotifier.dispose();
    _userRemovedPartyPhotoNotifier.dispose();
    _loyaltyProgramOptionsNotifier.dispose();
    _nameController.dispose();
    _newNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _loyaltyPointsController.dispose();
    _outstandingAmountController.dispose();
    _roleDisplayController.dispose();
    _currencyDisplayController.dispose();
    _defaultAccountDisplayController.dispose();
    _loyaltyProgramDisplayController.dispose();
    super.dispose();
  }

  Future<void> _showPhotoOptions() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(context.l10n.takePhoto),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(context.l10n.chooseFromGallery),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source != null) await _pickImage(source);
  }

  void _clearPartyPhoto() {
    _photoPathNotifier.value = null;
    _userRemovedPartyPhotoNotifier.value = true;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? file = await _imagePicker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (file != null && mounted) {
        _userRemovedPartyPhotoNotifier.value = false;
        _photoPathNotifier.value = file.path;
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.couldNotPickImage(e.toString())),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Widget _buildAvatar() {
    final colorScheme = context.theme.colorScheme;
    final spacing = context.theme.appTheme;
    final hasLocalPhoto = _photoPathNotifier.value != null;
    final remoteUri = widget.party?.displayImageUrl;
    final showRemote =
        !_userRemovedPartyPhotoNotifier.value && remoteUri != null && remoteUri.isNotEmpty;
    final hasDisplayPhoto = hasLocalPhoto || showRemote;
    final avatarRadius = spacing.spacing32;
    final cameraBadgeSize = spacing.spacing12 * 2;

    return GestureDetector(
      onTap: _showPhotoOptions,
      child: SizedBox(
        width: avatarRadius * 2,
        height: avatarRadius * 2,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundColor: colorScheme.surfaceContainerHighest,
              backgroundImage: hasLocalPhoto
                  ? FileImage(File(_photoPathNotifier.value!))
                  : showRemote
                      ? NetworkImage(remoteUri) as ImageProvider?
                      : null,
              child: hasDisplayPhoto
                  ? null
                  : Center(
                      child: Icon(
                        Icons.person_rounded,
                        size: avatarRadius * 1.15,
                        color: colorScheme.primary.withValues(alpha: 0.85),
                      ),
                    ),
            ),
            if (hasDisplayPhoto)
              Positioned(
                top: -2,
                left: -2,
                child: GestureDetector(
                  onTap: _clearPartyPhoto,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Icon(
                      Icons.close,
                      size: spacing.spacing16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: cameraBadgeSize,
                height: cameraBadgeSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: cameraBadgeSize * 0.48,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCreateLoyaltyProgramSheet() async {
    final created = await showAppBottomSheet<String>(
      context: context,
      title: 'Create Loyalty Program',
      shrinkWrap: true,
      compactHeader: true,
      child: const _CreateLoyaltyProgramSheetBody(),
    );
    if (created == null || !mounted) return;
    final options = List<String>.from(_loyaltyProgramOptionsNotifier.value);
    if (!options.contains(created)) {
      options.add(created);
      _loyaltyProgramOptionsNotifier.value = options;
    }
    _selectedLoyaltyProgramNotifier.value = created;
    _loyaltyProgramDisplayController.text = created;
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
          decoration: AppBottomSheetTheme.floatingCardDecoration(ctx),
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
      onSelected(selected);
      setDisplayText(selected);
    }
  }

  bool _validateForm() {
    final form = _formKey.currentState;
    if (form == null) return false;
    if (form.validate()) return true;

    final tabWithError = _firstTabWithValidationError();
    if (tabWithError != null && tabWithError != _tabController.index) {
      _tabController.animateTo(tabWithError);
    }
    return false;
  }

  /// Top fields (name, role) sit above the tabs and stay visible — only switch
  /// when a tab-specific field failed validation.
  int? _firstTabWithValidationError() {
    final email = _emailController.text;
    if (email.trim().isNotEmpty && !_emailRegex.hasMatch(email.trim())) {
      return 0;
    }

    final loyaltyPoints = _loyaltyPointsController.text;
    if (LoyaltyFeatures.enabled &&
        loyaltyPoints.isNotEmpty &&
        _parseIntField(loyaltyPoints) == null) {
      return 1;
    }

    final outstanding = _outstandingAmountController.text;
    if (outstanding.isNotEmpty) {
      final western = context.l10n.westernizeDigits(outstanding);
      if (double.tryParse(western) == null) {
        return 1;
      }
    }

    return null;
  }

  Future<void> _saveParty() async {
    if (!_validateForm()) return;

    final name = _nameController.text.trim();
    final newName = _newNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final address = _addressController.text.trim();

    if (widget.isEditing) {
      context.read<PartyCubit>().updateParty(
            request: UpdatePartyRequest(
              name: name,
              newName: name == newName ? null : newName,
              role: _selectedRoleNotifier.value.toLowerCase(),
              email: email.isEmpty ? null : email,
              phone: phone.isEmpty ? null : phone,
              address: address.isEmpty ? null : address,
              currency: _selectedCurrencyNotifier.value,
              loyaltyProgram:
                  LoyaltyFeatures.enabled ? _selectedLoyaltyProgramNotifier.value : null,
              loyaltyPoints: LoyaltyFeatures.enabled
                  ? _parseIntField(_loyaltyPointsController.text)
                  : null,
              outstandingAmount: _parseAmountField(_outstandingAmountController.text),
              modifiedBy: context.employeeData?.email ?? 'system',
              defaultAccount: _selectedDefaultAccountNotifier.value,
            ),
            imagePath: _photoPathNotifier.value,
            clearPartyImage: _userRemovedPartyPhotoNotifier.value,
          );
    } else {
      if (!await gateFreemiumFeature(
        context,
        FreemiumFeature.party,
        partyRole: _selectedRoleNotifier.value.toLowerCase(),
      )) {
        return;
      }
      if (!context.mounted) return;

      context.read<PartyCubit>().createParty(
            request: CreatePartyRequest(
              name: name,
              role: _selectedRoleNotifier.value.toLowerCase(),
              email: email.isEmpty ? null : email,
              phone: phone.isEmpty ? null : phone,
              address: address.isEmpty ? null : address,
              currency: _selectedCurrencyNotifier.value,
              loyaltyProgram:
                  LoyaltyFeatures.enabled ? _selectedLoyaltyProgramNotifier.value : null,
              loyaltyPoints: LoyaltyFeatures.enabled
                  ? _parseIntField(_loyaltyPointsController.text)
                  : null,
              outstandingAmount: _parseAmountField(_outstandingAmountController.text),
              createdBy: context.employeeData?.email ?? 'system',
              defaultAccount: _selectedDefaultAccountNotifier.value,
            ),
            imagePath: _photoPathNotifier.value,
          );
    }
  }

  Widget _buildSaveButton({double? width}) {
    return BlocBuilder<PartyCubit, PartyState>(
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        return CustomButtonWidget(
          width: width ?? double.infinity,
          onPressed: isLoading ? null : _saveParty,
          title: widget.isEditing
              ? context.l10n.partyUpdate
              : context.l10n.partyAddNew,
        );
      },
    );
  }

  Widget _buildTopFieldsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(child: _buildAvatar()),
        verticalMarginXXLarge,
        if (widget.isEditing)
          CustomTextFormField(
            controller: _newNameController,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            labelText: context.l10n.partyNameLabel,
            hint: context.l10n.partyNameHint,
            validating: (value) {
              if (value == null || value.trim().isEmpty) {
                return context.l10n.partyEnterNameValidation;
              }
              return null;
            },
          )
        else
          CustomTextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            labelText: context.l10n.partyNameLabel,
            hint: context.l10n.partyNameHint,
            validating: (value) {
              if (value == null || value.trim().isEmpty) {
                return context.l10n.partyEnterNameValidation;
              }
              return null;
            },
          ),
        verticalMarginMedium,
        CustomTextFormField(
          controller: _roleDisplayController,
          labelText: context.l10n.partyRoleLabel,
          hint: context.l10n.partyTapToSelect,
          readOnly: true,
          suffixIcon: _isEmployeeRole(_selectedRoleNotifier.value)
              ? null
              : const Icon(Icons.keyboard_arrow_down),
          onTap: _isEmployeeRole(_selectedRoleNotifier.value)
              ? null
              : () => _showPartyRoleBottomSheet(context),
          validating: (v) => (v?.trim().isEmpty ?? true)
              ? context.l10n.partySelectRoleValidation
              : null,
        ),
        ValueListenableBuilder<String>(
          valueListenable: _selectedRoleNotifier,
          builder: (context, role, _) {
            if (!PartyPickerRoleHelper.isBothRole(role)) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.primaryContainer
                      .withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: context.theme.colorScheme.primary
                        .withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.swap_horiz,
                      size: 20,
                      color: context.theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        context.l10n.partyBothRoleHint,
                        style: context.theme.textTheme.bodySmall?.copyWith(
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        verticalMarginSmall,
      ],
    );
  }

  Widget _buildTabBar() {
    final scheme = context.theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TabBar(
          controller: _tabController,
          labelStyle: context.theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
          unselectedLabelStyle: context.theme.textTheme.bodyMedium,
          labelColor: scheme.primary,
          unselectedLabelColor: scheme.onSurfaceVariant,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: scheme.primary, width: 3),
            insets: const EdgeInsets.symmetric(horizontal: 16),
          ),
          tabs: [
            Tab(text: context.l10n.partyBasicInfo),
            Tab(text: context.l10n.partyAdditionalInfo),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneFormContent() {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: _buildTopFieldsSection(),
          ),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildBasicInfoTabFields(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildAdditionalInfoTabFields(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildSaveButton(width: context.width),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletFormContent() {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return AnimatedBuilder(
      animation: _tabController,
      builder: (context, _) {
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            24,
            16,
            24,
            24 + bottomInset,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: _tabletContentWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTopFieldsSection(),
                    _buildTabBar(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: _tabController.index == 0
                          ? _buildBasicInfoTabFields()
                          : _buildAdditionalInfoTabFields(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBasicInfoTabFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          labelText: context.l10n.partyEmail,
          hint: context.l10n.partyEmailHint,
          validating: (value) {
            if (value != null && value.trim().isNotEmpty) {
              if (!_emailRegex.hasMatch(value.trim())) {
                return context.l10n.invalidEmailAddress;
              }
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          labelText: context.l10n.partyPhone,
          hint: context.l10n.partyPhoneHint,
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: _addressController,
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.streetAddress,
          labelText: context.l10n.partyAddress,
          hint: context.l10n.partyAddressHint,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoTabFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextFormField(
          controller: _currencyDisplayController,
          labelText: context.l10n.currency,
          hint: context.l10n.partyTapToSelect,
          readOnly: true,
          suffixIcon: const Icon(Icons.keyboard_arrow_down),
          onTap: _showCurrencyPicker,
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: _defaultAccountDisplayController,
          labelText: context.l10n.partyDefaultAccount,
          hint: context.l10n.partyTapToSelect,
          readOnly: true,
          suffixIcon: const Icon(Icons.keyboard_arrow_down),
          onTap: () => _showSelectBottomSheet(
            context,
            title: context.l10n.partySelectDefaultAccount,
            options: _defaultAccountOptions
                .map((a) => MapEntry(
                      a,
                      context.l10n.localizedDefaultAccountName(a),
                    ))
                .toList(),
            currentValue: _selectedDefaultAccountNotifier.value,
            onSelected: (v) {
              _selectedDefaultAccountNotifier.value = v;
              if (v != null) {
                _defaultAccountDisplayController.text =
                    context.l10n.localizedDefaultAccountName(v);
              }
            },
            setDisplayText: (label) {
              _defaultAccountDisplayController.text = label == null
                  ? ''
                  : context.l10n.localizedDefaultAccountName(label);
            },
          ),
        ),
        const SizedBox(height: 16),
        if (LoyaltyFeatures.enabled) ...[
          CustomTextFormField(
            controller: _loyaltyProgramDisplayController,
            labelText: context.l10n.partyLoyaltyProgram,
            hint: context.l10n.partyTapToSelect,
            readOnly: true,
            suffixIcon: const Icon(Icons.keyboard_arrow_down),
            onTap: () async {
              final options = [
                ..._loyaltyProgramOptionsNotifier.value.map((p) => MapEntry(p, p)),
                MapEntry(
                  'create_new',
                  context.l10n.partyCreateNewProgram,
                ),
              ];
              final theme = Theme.of(context);
              final selected = await showModalBottomSheet<String>(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (ctx) => SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    decoration: AppBottomSheetTheme.floatingCardDecoration(ctx),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            context.l10n.partySelectLoyaltyProgram,
                            style: theme.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          verticalMarginSmall,
                          const Divider(),
                          verticalMarginMedium,
                          ...options.expand((e) => [
                                PdfExportOptionTile(
                                  icon: e.key == 'create_new'
                                      ? Icons.add_circle_outline
                                      : (_selectedLoyaltyProgramNotifier.value == e.key
                                          ? Icons.check_circle
                                          : Icons.radio_button_unchecked),
                                  title: e.value,
                                  color: _selectedLoyaltyProgramNotifier.value == e.key
                                      ? Colors.green
                                      : null,
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
                if (selected == 'create_new') {
                  _showCreateLoyaltyProgramSheet();
                } else {
                  _selectedLoyaltyProgramNotifier.value = selected;
                  _loyaltyProgramDisplayController.text = selected;
                }
              }
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: _loyaltyPointsController,
            keyboardType: TextInputType.number,
            labelText: context.l10n.partyLoyaltyPoints,
            hint: context.l10n.formatCount(0),
            validating: (value) {
              if (value != null && value.isNotEmpty) {
                if (_parseIntField(value) == null) {
                  return context.l10n.partyValidNumber;
                }
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
        ],
        CustomTextFormField(
          controller: _outstandingAmountController,
          keyboardType: TextInputType.number,
          labelText: context.l10n.unpaidAmount,
          hint: context.l10n.formatDecimal(0),
          readOnly: true,
          validating: (value) {
            if (value != null && value.isNotEmpty) {
              final western = context.l10n.westernizeDigits(value);
              if (double.tryParse(western) == null) {
                return context.l10n.partyValidAmount;
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(
          widget.isEditing ? context.l10n.partyEdit : context.l10n.partyAddNew,
        ),
      ),
      bottomNavigationBar: _isTablet
          ? Material(
              color: Theme.of(context).colorScheme.surface,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: _tabletContentWidth(context),
                        child: _buildSaveButton(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      body: BlocListener<PartyCubit, PartyState>(
        listener: (context, state) {
          state.maybeWhen(
            created: (response) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(response.message),
                  backgroundColor: Colors.green.shade400,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
              Navigator.pop(context, true);
            },
            updated: (response) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(response.message),
                  backgroundColor: Colors.green.shade400,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
              Navigator.pop(context, true);
            },
            error: (message) {
              if (message.startsWith(FreemiumGateService.blockedMessagePrefix)) {
                context.showKiiSnackBarWarning(context.l10n.upgradeToPremiumContinue);
                context.router.push(PremiumPaywallRoute(fromSettings: true));
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red.shade400,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            orElse: () {},
          );
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: _formKey,
            child: AnimatedBuilder(
              animation: _formListenable,
              builder: (context, _) {
                return _isTablet
                    ? _buildTabletFormContent()
                    : _buildPhoneFormContent();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateLoyaltyProgramSheetBody extends StatefulWidget {
  const _CreateLoyaltyProgramSheetBody();

  @override
  State<_CreateLoyaltyProgramSheetBody> createState() =>
      _CreateLoyaltyProgramSheetBodyState();
}

class _CreateLoyaltyProgramSheetBodyState
    extends State<_CreateLoyaltyProgramSheetBody> {
  late final TextEditingController _nameController;
  bool _creating = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final newProgram = _nameController.text.trim();
    if (newProgram.isEmpty || _creating) return;
    setState(() => _creating = true);
    try {
      ensureLoyaltyProgramServiceRegistered();
      await getIt<LoyaltyProgramService>().createProgram(name: newProgram);
      if (!mounted) return;
      Navigator.of(context).pop(newProgram);
    } catch (e) {
      if (!mounted) return;
      setState(() => _creating = false);
      context.showKiiSnackBarError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextFormField(
          controller: _nameController,
          labelText: 'Program Name',
          hint: 'e.g., VIP Member, Premium',
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          maxLines: 1,
          onFieldSubmitted: (_) => _create(),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomButtonWidget(
                title: 'Cancel',
                buttonState: CustomButtonState.outlined,
                onPressed: _creating
                    ? null
                    : () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButtonWidget(
                title: 'Create',
                loading: _creating,
                onPressed: _creating ? null : _create,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
