import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/app_empty_state_assets.dart';
import 'package:hotel/src/core/constants/margin_constants.dart';
import 'package:hotel/src/core/widget/list_empty_state.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/contact_book/data/models/request/create_contact_request.dart';
import 'package:hotel/src/features/contact_book/data/models/request/update_contact_request.dart';
import 'package:hotel/src/features/contact_book/data/models/request/contact_query_params.dart';
import 'package:hotel/src/features/contact_book/data/models/response/contact_model.dart';
import 'package:hotel/src/features/contact_book/presentation/cubit/contact_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'dart:io' show Platform;
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

@RoutePage()
class ContactFormPage extends StatefulWidget implements AutoRouteWrapper {
  final ContactModel? contact;

  const ContactFormPage({super.key, this.contact});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContactCubit>(),
      child: this,
    );
  }

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _categoryController = TextEditingController();
  final _companyController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isFavorite = false;

  /// Currently loaded contact for editing (initial from route or selected via "Load existing contact").
  ContactModel? _currentContact;

  bool get _isEdit => _currentContact != null;

  @override
  void initState() {
    super.initState();
    _currentContact = widget.contact;
    _populateFromContact(_currentContact);
  }

  void _populateFromContact(ContactModel? c) {
    if (c == null) {
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _addressController.clear();
      _categoryController.text = 'general';
      _companyController.clear();
      _notesController.clear();
      setState(() {
        _currentContact = null;
        _isFavorite = false;
      });
      return;
    }
    _nameController.text = c.name ?? '';
    _phoneController.text = c.phone ?? '';
    _emailController.text = c.email ?? '';
    _addressController.text = c.address ?? '';
    _categoryController.text = c.category ?? 'general';
    _companyController.text = c.company ?? '';
    _notesController.text = c.notes ?? '';
    setState(() {
      _currentContact = c;
      _isFavorite = c.isFavorite;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _categoryController.dispose();
    _companyController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    // if (!_formKey.currentState!.validate()) return;
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.contactNameRequired)),
      );
      return;
    }
    if (_isEdit) {
      context.read<ContactCubit>().updateContact(
            UpdateContactRequest(
              contactId: _currentContact!.id!,
              name: name,
              phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
              email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
              address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
              category: _categoryController.text.trim().isEmpty ? null : _categoryController.text.trim(),
              company: _companyController.text.trim().isEmpty ? null : _companyController.text.trim(),
              notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
              isFavorite: _isFavorite,
            ),
          );
    } else {
      context.read<ContactCubit>().createContact(
            CreateContactRequest(
              name: name,
              phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
              email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
              address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
              category: _categoryController.text.trim().isEmpty ? null : _categoryController.text.trim(),
              company: _companyController.text.trim().isEmpty ? null : _companyController.text.trim(),
              notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
              isFavorite: _isFavorite,
            ),
          );
    }
  }

  Future<void> _launchCall() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) return;
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.contactCannotCall)),
      );
    }
  }

  /// Fills the form from a device contact (keeps form in "new contact" mode so user can save to app).
  void _fillFormFromPhoneContact(Contact nativeContact) {
    final display = nativeContact.displayName?.trim() ?? '';
    final nameParts = nativeContact.name;
    final name = display.isNotEmpty
        ? display
        : '${nameParts?.first ?? ''} ${nameParts?.last ?? ''}'.trim();
    _nameController.text = name;
    _phoneController.text = nativeContact.phones.isNotEmpty
        ? nativeContact.phones.first.number.replaceAll('-', '').replaceAll(' ', '')
        : '';
    _emailController.text =
        nativeContact.emails.isNotEmpty ? nativeContact.emails.first.address : '';
    _addressController.text = nativeContact.addresses.isNotEmpty
        ? (nativeContact.addresses.first.formatted ?? '')
        : '';
    _companyController.text = nativeContact.organizations.isNotEmpty
        ? (nativeContact.organizations.first.name ?? '')
        : '';
    _notesController.text =
        nativeContact.notes.isNotEmpty ? nativeContact.notes.first.note : '';
    setState(() {
      _currentContact = null;
      _isFavorite = false;
    });
  }

  Future<void> _pickFromPhoneContacts() async {
    if (Platform.isAndroid) {
      if (!await FlutterContacts.permissions.has(PermissionType.read)) {
        final status =
            await FlutterContacts.permissions.request(PermissionType.read);
        if (!mounted) return;
        if (status != PermissionStatus.granted &&
            status != PermissionStatus.limited) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.contactPermissionRequired),
            ),
          );
          return;
        }
      }
    }

    final contact = await FlutterContacts.native.showPicker(
      properties: ContactProperties.allProperties,
    );
    if (!mounted) return;
    if (contact == null) return;
    _fillFormFromPhoneContact(contact);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.contactImported)),
      );
    }
  }

  void _showLoadContactPicker() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => BlocProvider(
        create: (_) => getIt<ContactCubit>()..loadContacts(),
        child: _LoadContactSheet(
          onSelect: (c) {
            Navigator.pop(ctx);
            _populateFromContact(c);
          },
        ),
      ),
    );
  }

  void _delete() {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.contactDeleteTitle),
        content: Text(context.l10n.contactDeleteUndo),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(context.l10n.delete, style: AppFonts.interStyle(color: Colors.red[700])),
          ),
        ],
      ),
    ).then((ok) {
      if (ok == true && _currentContact?.id != null) {
        context.read<ContactCubit>().deleteContact(_currentContact!.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactCubit, ContactState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () => AppLoadingOverlay.of(context).show(),
          noInternet: () {
            AppLoadingOverlay.of(context).hide();
            context.showKiiSnackBarError(context.l10n.noInternetConnection);
          },
          error: (message) {
            AppLoadingOverlay.of(context).hide();
            context.showKiiSnackBarError(message);
          },
          listLoaded: (_) {},
          contactLoaded: (_) {},
          created: (_) {
            AppLoadingOverlay.of(context).hide();
            context.showKiiSnackBarSuccess(context.l10n.contactCreated);
            context.router.maybePop();
          },
          updated: () {
            AppLoadingOverlay.of(context).hide();
            context.showKiiSnackBarSuccess(context.l10n.contactUpdated);
            context.router.maybePop();
          },
          deleted: () {
            AppLoadingOverlay.of(context).hide();
            context.showKiiSnackBarSuccess(context.l10n.contactDeleted);
            context.router.maybePop();
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBarIosBackButton(),
          title: Text(_isEdit ? context.l10n.contactEditTitle : context.l10n.contactNewTitle),
          actions: [
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _phoneController,
              builder: (context, value, _) {
                if (value.text.trim().isEmpty) return const SizedBox.shrink();
                return IconButton(
                  icon: Icon(Icons.call),
                  onPressed: _launchCall,
                  tooltip: context.l10n.contactCallTooltip,
                );
              },
            ),
            if (_isEdit)
              IconButton(
                icon: const AppDeleteIcon(),
                onPressed: _delete,
              ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: _nameController,
                        labelText: context.l10n.contactNameLabel,
                        hint: context.l10n.contactNameHint,
                        validating: (v) => (v == null || v.trim().isEmpty) ? context.l10n.required : null,
                      ),
                    ),
                    IconButton(onPressed: _pickFromPhoneContacts, icon: Icon(Icons.contacts))
                  ],
                ),
                verticalMarginMedium,
                CustomTextFormField(
                  controller: _phoneController,
                  labelText: context.l10n.phone,
                  hint: context.l10n.contactPhoneHint,
                  keyboardType: TextInputType.phone,
                ),
                verticalMarginMedium,
                CustomTextFormField(
                  controller: _emailController,
                  labelText: context.l10n.email,
                  hint: context.l10n.contactEmailHint,
                  keyboardType: TextInputType.emailAddress,
                ),
                verticalMarginMedium,
                CustomTextFormField(
                  controller: _addressController,
                  labelText: context.l10n.address,
                  hint: context.l10n.address,
                  maxLines: 2,
                ),
                verticalMarginMedium,
                CustomTextFormField(
                  controller: _categoryController,
                  labelText: context.l10n.category,
                  hint: context.l10n.contactCategoryHint,
                ),
                verticalMarginMedium,
                CustomTextFormField(
                  controller: _companyController,
                  labelText: context.l10n.contactCompanyHint,
                  hint: context.l10n.contactCompanyHint,
                ),
                verticalMarginMedium,
                CustomTextFormField(
                  controller: _notesController,
                  labelText: context.l10n.notes,
                  hint: context.l10n.notes,
                  maxLines: 3,
                ),
                verticalMarginMedium,
                CheckboxListTile(
                  title: Text(context.l10n.contactFavorite),
                  value: _isFavorite,
                  onChanged: (v) => setState(() => _isFavorite = v ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                verticalMarginXLarge,
                CustomButtonWidget(
                  title: _isEdit ? context.l10n.saveChanges : context.l10n.createAction,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Bottom sheet to pick an existing contact and populate the form.
class _LoadContactSheet extends StatefulWidget {
  const _LoadContactSheet({required this.onSelect});

  final void Function(ContactModel contact) onSelect;

  @override
  State<_LoadContactSheet> createState() => _LoadContactSheetState();
}

class _LoadContactSheetState extends State<_LoadContactSheet> {
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocus.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    context.read<ContactCubit>().loadContacts(
          params: value.trim().isEmpty ? null : ContactQueryParams(search: value.trim()),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Text(
                  context.l10n.contactSelectTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocus,
              style: AppFonts.interStyle(color: scheme.onSurface),
              cursorColor: scheme.primary,
              decoration: InputDecoration(
                hintText: context.l10n.contactImportSearchHint,
                hintStyle: AppFonts.interStyle(color: scheme.onSurfaceVariant),
                prefixIcon: AppSearchIcon.inputDecoration(
                  size: 22,
                  color: scheme.onSurfaceVariant,
                ),
                filled: true,
                fillColor: scheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: scheme.primary, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          const Divider(height: 1),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: BlocBuilder<ContactCubit, ContactState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    loading: () => Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    noInternet: () => Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.wifi_off,
                            size: 48,
                            color: scheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            context.l10n.noInternetConnection,
                            style: AppFonts.interStyle(color: scheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    error: (message) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    listLoaded: (response) {
                      final list = response.contacts;
                      if (list.isEmpty) {
                        return ListEmptyState(
                          illustrationPath: AppEmptyStateAssets.contacts,
                          title: context.l10n.contactImportNoResults,
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: list.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 4),
                        itemBuilder: (context, index) {
                          final c = list[index];
                          final name = c.name ?? context.l10n.contactUnknown;
                          final subtitle = [
                            if (c.phone != null && c.phone!.isNotEmpty) c.phone,
                            if (c.email != null && c.email!.isNotEmpty) c.email,
                          ].where((e) => e != null).join(' · ');
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: theme.colorScheme.primaryContainer,
                              child: Text(
                                name.isNotEmpty ? name[0].toUpperCase() : '?',
                                style: AppFonts.interStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ),
                            title: Text(name),
                            subtitle: subtitle.isNotEmpty
                                ? Text(
                                    subtitle,
                                    style: AppFonts.interStyle(
                                      fontSize: 12,
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  )
                                : null,
                            onTap: () => widget.onSelect(c),
                          );
                        },
                      );
                    },
                    contactLoaded: (_) => const SizedBox.shrink(),
                    created: (_) => const SizedBox.shrink(),
                    updated: () => const SizedBox.shrink(),
                    deleted: () => const SizedBox.shrink(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
