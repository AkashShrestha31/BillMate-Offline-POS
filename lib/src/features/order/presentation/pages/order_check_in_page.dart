import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/action/presentation/widgets/party_picker_sheet.dart';
import 'package:hotel/src/features/party/data/models/request/create_party_request.dart';
import 'package:hotel/src/features/party/data/models/response/party_create_response_model.dart';
import 'package:hotel/src/features/party/domain/usecases/party_use_cases.dart' as party_uc;
import 'package:image_picker/image_picker.dart' as image_picker;

/// After Quick Add (items): capture customer / party before KOT review.
@RoutePage()
class OrderCheckInPage extends StatefulWidget {
  const OrderCheckInPage({
    super.key,
    required this.cartJson,
    this.initialTableLabel,
    this.isExistingOrderAddition = false,
  });

  final String cartJson;
  final String? initialTableLabel;
  final bool isExistingOrderAddition;

  @override
  State<OrderCheckInPage> createState() => _OrderCheckInPageState();
}

class _OrderCheckInPageState extends State<OrderCheckInPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  final _existingPartyName = ValueNotifier<String?>(null);
  final _showSelectedCustomerCard = ValueNotifier<bool>(false);
  final _countryCode = ValueNotifier<String>('+977');
  final _attachment = ValueNotifier<File?>(null);

  bool _continueOrderBusy = false;

  late final Listenable _uiListenable;

  @override
  void initState() {
    super.initState();
    _uiListenable = Listenable.merge([
      _existingPartyName,
      _showSelectedCustomerCard,
      _countryCode,
      _attachment,
    ]);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _existingPartyName.dispose();
    _showSelectedCustomerCard.dispose();
    _countryCode.dispose();
    _attachment.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final file = await image_picker.ImagePicker().pickImage(source: image_picker.ImageSource.gallery);
    if (file != null && mounted) _attachment.value = File(file.path);
  }

  void _openExistingCustomerPicker() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => PartyPickerSheet(
        role: 'customer',
        customerOnly: true,
        selectedPartyName: _existingPartyName.value,
        onSelect: (party) {
          final n = party.name?.trim() ?? '';
          if (n.isEmpty) return;
          _existingPartyName.value = n;
          _showSelectedCustomerCard.value = true;
          _nameController.clear();
          _phoneController.clear();
          _addressController.clear();
          _attachment.value = null;
          Navigator.pop(sheetContext);
        },
      ),
    );
  }

  void _clearSelectedCustomer() {
    _existingPartyName.value = null;
    _showSelectedCustomerCard.value = false;
    _nameController.clear();
    _phoneController.clear();
    _addressController.clear();
    _attachment.value = null;
  }

  /// Same rules as [PartyPickerSheet] list rows — main line without "(…)" for the card title.
  (String, String?) _partyCardTitleSubtitle(String? rawName) {
    final raw = rawName?.trim() ?? '';
    if (raw.isEmpty) return ('', null);
    final open = raw.indexOf('(');
    final close = raw.lastIndexOf(')');
    if (open > 0 && close > open) {
      final main = raw.substring(0, open).trim();
      final sub = raw.substring(open + 1, close).trim();
      if (main.isNotEmpty) {
        return (main, sub.isNotEmpty ? sub : null);
      }
    }
    return (raw, null);
  }

  String _partyAvatarInitials(String? name) {
    final raw = name?.trim() ?? '';
    if (raw.isEmpty) return '?';
    final main = raw.split('(').first.trim();
    final parts = main.split(RegExp(r'[\s,-]+')).where((e) => e.isNotEmpty).toList();
    if (parts.length >= 2) {
      final a = parts[0].isNotEmpty ? parts[0][0] : '';
      final b = parts[1].isNotEmpty ? parts[1][0] : '';
      return ('$a$b').toUpperCase();
    }
    if (main.length >= 2) return main.substring(0, 2).toUpperCase();
    return main[0].toUpperCase();
  }

  Widget _buildSelectedCustomerCard(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final existing = _existingPartyName.value;
    final fullName = (existing?.trim().isNotEmpty ?? false)
        ? existing!.trim()
        : _nameController.text.trim();
    final (titleLine, subLine) = _partyCardTitleSubtitle(fullName);
    final displayTitle = titleLine.isNotEmpty ? titleLine : fullName;

    return Material(
      color: scheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: scheme.outlineVariant.withOpacity(0.8)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26.r,
              backgroundColor: scheme.surfaceContainerHighest,
              child: Text(
                _partyAvatarInitials(fullName),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    displayTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                  if (subLine != null && subLine.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(
                        subLine,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Remove',
              onPressed: _clearSelectedCustomer,
              icon: Icon(Icons.close, color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  String _buildCustomerMetaNotes() {
    final parts = <String>[];
    final phone = _phoneController.text.trim();
    final addr = _addressController.text.trim();
    if (phone.isNotEmpty) parts.add('Tel: ${_countryCode.value} $phone');
    if (addr.isNotEmpty) parts.add('Addr: $addr');
    return parts.join(' | ');
  }

  bool _hasManualCustomerInput() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final addr = _addressController.text.trim();
    return name.isNotEmpty ||
        phone.isNotEmpty ||
        addr.isNotEmpty ||
        _attachment.value != null;
  }

  String _displayTableLabelForRoute(String tableNumber) {
    final preset = widget.initialTableLabel?.trim();
    if (preset != null && preset.isNotEmpty) return preset;
    if (tableNumber.isNotEmpty) return tableNumber;
    return 'Order';
  }

  /// Returns when KOT is closed. If an order was created, pops check-in with that id for the parent to refetch detail (`GET /api/order/orders/<id>/`).
  Future<void> _goToKotReview({
    required String tableNumber,
    required String customerMetaNotes,
  }) async {
    final meta = customerMetaNotes.trim();
    final orderName = await context.router.push<String?>(
      OrderKotReviewRoute(
        cartJson: widget.cartJson,
        tableNumber: tableNumber,
        displayTableLabel: _displayTableLabelForRoute(tableNumber),
        customerMetaNotes: meta.isEmpty ? null : meta,
        hideGuestCount: widget.isExistingOrderAddition,
      ),
    );
    if (!mounted) return;
    if (orderName != null && orderName.trim().isNotEmpty) {
      context.router.popForced<String>(orderName.trim());
    }
  }

  Future<void> _continueOrder() async {
    if (_continueOrderBusy) return;

    final existing = _existingPartyName.value?.trim();
    if (existing != null && existing.isNotEmpty && _showSelectedCustomerCard.value) {
      await _goToKotReview(
        tableNumber: existing,
        customerMetaNotes: _buildCustomerMetaNotes(),
      );
      return;
    }

    if (_hasManualCustomerInput()) {
      setState(() => _continueOrderBusy = true);
      try {
        final name = _nameController.text.trim();
        final phoneRaw = _phoneController.text.trim();
        final addr = _addressController.text.trim();
        final partyName = name.isNotEmpty
            ? name
            : (phoneRaw.isNotEmpty
                ? 'Customer ${_countryCode.value} $phoneRaw'
                : 'Walk-in customer');
        final fullPhone = phoneRaw.isEmpty ? null : '${_countryCode.value} $phoneRaw'.trim();

        final request = CreatePartyRequest(
          name: partyName,
          role: 'customer',
          phone: fullPhone,
          address: addr.isEmpty ? null : addr,
          createdBy: context.employeeData?.email ?? 'hotelroyalrestro@gmail.com',
        );

        final result = await getIt<party_uc.CreatePartyUseCase>().execute(
              request: request,
              imagePath: _attachment.value?.path,
            );
        if (!mounted) return;

        PartyCreateResponseModel? createdParty;
        result.fold(
          (AppError err) {
            err.when(
              serverError: (m) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(m)),
                  ),
              noInternet: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No internet')),
                  ),
            );
          },
          (created) {
            createdParty = created;
          },
        );
        if (!mounted) return;
        if (createdParty != null) {
          final table = createdParty!.party.name.trim();
          await _goToKotReview(
            tableNumber: table,
            customerMetaNotes: _buildCustomerMetaNotes(),
          );
        }
      } finally {
        if (mounted) setState(() => _continueOrderBusy = false);
      }
      return;
    }

    await _goToKotReview(
      tableNumber: '',
      customerMetaNotes: _buildCustomerMetaNotes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: AppBarIosBackButton(),
        title: const Text('Check In'),
        centerTitle: false,
      ),
      body: AnimatedBuilder(
        animation: _uiListenable,
        builder: (context, _) {
          final showCard = _showSelectedCustomerCard.value;
          final attachment = _attachment.value;
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showCard) ...[
                  _buildSelectedCustomerCard(context),
                  SizedBox(height: 20.h),
                ] else ...[
                  CustomButtonWidget.outlined(
                    onPressed: _openExistingCustomerPicker,
                    icon: const Icon(Icons.person_outline),
                    title: 'Select Existing Customer',
                  ),
                  SizedBox(height: 20.h),
                ],
                if (!showCard) ...[
                  Row(
                    children: [
                      Expanded(child: Divider(color: scheme.outlineVariant)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Text(
                          'or, Add Manually',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600
                              ),
                        ),
                      ),
                      Expanded(child: Divider(color: scheme.outlineVariant)),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    controller: _nameController,
                    labelText: 'Enter Customer Name',
                    hint: 'Customer name',
                    onChanged: (_) {
                      _existingPartyName.value = null;
                      _showSelectedCustomerCard.value = false;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 88.w,
                        child: CustomTextFormField(
                          controller: _phoneController,
                          hint: '+977',
                          keyboardType: TextInputType.phone,
                        )
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: CustomTextFormField(
                          controller: _phoneController,
                          labelText: 'Contact Number',
                          hint: 'Enter Contact Number',
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    controller: _addressController,
                    labelText: 'Customer Address',
                    hint: 'Enter Customer Address',
                    maxLines: 2,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Attachment Photo',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 8.h),
                  InkWell(
                    onTap: _pickPhoto,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: scheme.outlineVariant),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: attachment != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(attachment, fit: BoxFit.cover, width: double.infinity),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload_outlined, size: 36, color: scheme.primary),
                                SizedBox(height: 8.h),
                                Text(
                                  'Click here to select or upload photos',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: scheme.onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
          child: CustomButtonWidget(
            onPressed: _continueOrderBusy ? null : () => _continueOrder(),
            loading: _continueOrderBusy,
            title: 'Continue Order',
          ),
        ),
      ),
    );
  }
}
