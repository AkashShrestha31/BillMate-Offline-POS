import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/helpers/item_image_helper.dart';
import 'package:hotel/src/core/helpers/permission_helper.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/constants/item_form_constants.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/pdf_export_option_tile.dart';
import 'package:hotel/src/core/widget/searchable_select_bottom_sheet.dart';
import 'package:hotel/src/core/services/open_facts_barcode_lookup.dart';
import 'package:hotel/src/features/action/data/models/request/create_item_request.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:hotel/src/features/action/presentation/cubit/item_cubit.dart';
import 'package:hotel/src/features/action/presentation/pages/barcode_scanner_page.dart';
import 'package:hotel/src/features/action/presentation/widgets/item_code_sheet.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';
import 'package:hotel/src/features/settings/presentation/live_stock_issue_guard.dart';

enum _ItemPhotoAction { uploadFromGallery, takePhoto }

@RoutePage()
class ItemEditPage extends StatefulWidget {
  final ItemModel? item;
  final bool isEditing;

  /// When adding a new item (no [item]), pre-fills the name field.
  final String? initialItemName;

  /// When adding a new item, pre-selects purpose (`Sales`, `Purchases`, or `Both`).
  final String? initialPurpose;

  /// When adding a new item, pre-selects category.
  final String? initialCategory;

  /// When true, shows a sheet header + drag handle instead of a full [Scaffold] app bar
  /// (for [showModalBottomSheet]).
  final bool asBottomSheet;

  const ItemEditPage({
    super.key,
    this.item,
    this.isEditing = false,
    this.initialItemName,
    this.initialPurpose,
    this.initialCategory,
    this.asBottomSheet = false,
  });

  @override
  State<ItemEditPage> createState() => _ItemEditPageState();
}

class _ItemEditPageState extends State<ItemEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _newNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _rateController;
  late TextEditingController _unitController;
  late TextEditingController _unitDisplayController;
  late TextEditingController _purposeDisplayController;
  late TextEditingController _categoryDisplayController;

  String _selectedItemType = 'Product';
  String _selectedForFilter = 'Sales';
  String? _selectedUnit;
  String _selectedPurpose = 'Sales';
  String? _selectedCategory;
  bool _trackItem = false;
  bool _hasBatch = false;
  bool _hasSerialNumber = false;

  late TextEditingController _barcodeController;
  late TextEditingController _openingStockController;
  bool _lookupInProgress = false;
  final OpenFactsBarcodeLookup _openFactsLookup = OpenFactsBarcodeLookup();

  static final ImagePicker _imagePicker = ImagePicker();
  static const int _maxItemImageBytes = 5 * 1024 * 1024;

  /// Local file path for a new/replacement image (sent as multipart `image`).
  String? _pickedImagePath;

  final List<String> _itemTypes = ['Product', 'Service', 'Inventory'];
  final List<String> _forOptions = ['Sales', 'Purchases', 'Both'];
  final List<String> _purposeOptions = ['Purchases', 'Sales', 'Both'];
  final List<String> _unitOptions = List<String>.from(ItemFormConstants.unitOptions);
  static const List<String> itemCategories = ItemFormConstants.categories;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    if (widget.item != null) {
      _populateFields();
    } else {
      _applyInitialNewItemDefaults();
    }
  }

  void _applyInitialNewItemDefaults() {
    final name = widget.initialItemName?.trim();
    if (name != null && name.isNotEmpty && _nameController.text.isEmpty) {
      _nameController.text = name;
    }
    final purpose = widget.initialPurpose?.trim();
    if (purpose != null &&
        purpose.isNotEmpty &&
        _purposeOptions.contains(purpose)) {
      _selectedPurpose = purpose;
      if (_forOptions.contains(purpose)) {
        _selectedForFilter = purpose;
      }
    }
    _purposeDisplayController.text = _selectedPurpose;
    final category = widget.initialCategory?.trim();
    if (category != null && category.isNotEmpty) {
      _selectedCategory = category;
      _categoryDisplayController.text = category;
    }
  }

  void _initializeControllers() {
    final newItemNameSeed =
        widget.item == null ? (widget.initialItemName?.trim() ?? '') : '';
    _nameController = TextEditingController(text: newItemNameSeed);
    _newNameController = TextEditingController();
    _descriptionController = TextEditingController();
    _rateController = TextEditingController();
    _unitController = TextEditingController();
    _unitDisplayController = TextEditingController();
    _purposeDisplayController = TextEditingController();
    _categoryDisplayController = TextEditingController();
    _barcodeController = TextEditingController();
    _openingStockController = TextEditingController();
  }

  void _populateFields() {
    final item = widget.item!;
    _nameController.text = item.name;
    _newNameController.text = item.name;
    _descriptionController.text = item.description.toString();
    _rateController.text = item.rate.toString();
    _unitController.text = item.unit;

    // Set purpose from existing item
    _selectedPurpose = item.forFilter;

    if (_unitOptions.contains(item.unit)) {
      _selectedUnit = item.unit;
    } else {
      _unitOptions.insert(_unitOptions.length, item.unit);
      _selectedUnit = item.unit;
    }

    _selectedItemType = _itemTypes.contains(item.itemType.toString())
        ? item.itemType.toString()
        : 'Product';
    _selectedForFilter =
        _forOptions.contains(item.forFilter) ? item.forFilter : 'Sales';
    _unitDisplayController.text = _selectedUnit ?? '';
    _purposeDisplayController.text = _selectedPurpose;
    if (item.category != null && item.category!.isNotEmpty) {
      _selectedCategory = item.category;
      _categoryDisplayController.text = _selectedCategory!;
    }
    if (item.barcode != null && item.barcode!.isNotEmpty) {
      _barcodeController.text = item.barcode!;
    }
    final tracking = liveStockOrNull();
    if (tracking != null && tracking.enabled) {
      _openingStockController.text =
          LiveStockTrackingService.formatQty(tracking.onHand(item.name));
    }

    // _trackItem = item.trackItem;
    // _hasBatch = item.hasBatch;
    // _hasSerialNumber = item.hasSerialNumber;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _newNameController.dispose();
    _descriptionController.dispose();
    _rateController.dispose();
    _unitController.dispose();
    _unitDisplayController.dispose();
    _purposeDisplayController.dispose();
    _categoryDisplayController.dispose();
    _barcodeController.dispose();
    _openingStockController.dispose();
    super.dispose();
  }

  void _showItemCode() {
    final sku = _barcodeController.text.trim();
    final name = (widget.isEditing
            ? _newNameController.text
            : _nameController.text)
        .trim();
    final code = sku.isNotEmpty ? sku : name;
    if (code.isEmpty) {
      context.showKiiSnackBarError(context.l10n.itemValidationName);
      return;
    }
    showItemCodeSheet(
      context,
      itemName: name.isEmpty ? code : name,
      code: code,
      usesSku: sku.isNotEmpty,
    );
  }

  Future<void> _scanBarcode() async {
    if (widget.isEditing) return;
    final allowed = await PermissionHelper.cameraPermission();
    if (!mounted) return;
    if (!allowed) {
      context.showKiiSnackBarError(context.l10n.posScanCameraDenied);
      return;
    }
    final code = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const BarcodeScannerPage()),
    );
    if (!mounted || code == null || code.isEmpty) return;

    setState(() {
      _barcodeController.text = code;
    });

    setState(() => _lookupInProgress = true);
    final name = await _openFactsLookup.lookupDisplayName(code);
    if (!mounted) return;
    setState(() => _lookupInProgress = false);

    if (name != null && name.isNotEmpty) {
      setState(() => _nameController.text = name);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.itemNameFromCatalog(name)),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      setState(() => _nameController.text = code);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.itemBarcodePasteHint),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _showCreateUnitDialog() async {
    final newUnit = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) => const _CreateCustomUnitSheet(),
    );
    if (newUnit == null || newUnit.isEmpty || !mounted) return;
    setState(() {
      if (!_unitOptions.contains(newUnit)) {
        _unitOptions.add(newUnit);
      }
      _selectedUnit = newUnit;
      _unitController.text = newUnit;
      _unitDisplayController.text = newUnit;
    });
  }

  Future<void> _showSelectBottomSheet(
    BuildContext context, {
    required String title,
    required List<MapEntry<String, String>> options,
    required String? currentValue,
    required void Function(String?) onSelected,
    required void Function(String) setDisplayText,
    String? searchHint,
    Future<void> Function()? onCreateNew,
  }) async {
    final theme = Theme.of(context);
    final maxHeight = MediaQuery.of(context).size.height * 0.6;
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            height: maxHeight,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SearchableSelectBottomSheet(
              title: title,
              searchHint: searchHint ?? '${context.l10n.search}…',
              options: options,
              currentValue: currentValue,
            ),
          ),
        ),
      ),
    );
    if (!mounted || selected == null) return;
    if (selected == 'create_new') {
      FocusManager.instance.primaryFocus?.unfocus();
      // Let the picker unmount and keyboard highlight listeners flush
      // before another sheet with InkWells is pushed.
      await Future<void>.delayed(const Duration(milliseconds: 150));
      if (mounted) await onCreateNew?.call();
      return;
    }
    setState(() {
      onSelected(selected);
      setDisplayText(selected);
    });
  }

  bool _allowedImageExtension(String path) {
    final lower = path.toLowerCase();
    return lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp');
  }

  Future<void> _showImageSourceSheet() async {
    final theme = Theme.of(context);
    final action = await showModalBottomSheet<_ItemPhotoAction>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Material(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                  child: Text(
                    context.l10n.itemAddPhoto,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.photo_library_outlined,
                      color: theme.colorScheme.primary),
                  title: Text(context.l10n.itemUploadGallery),
                  subtitle: Text(
                    context.l10n.itemUploadGalleryHint,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  onTap: () =>
                      Navigator.pop(ctx, _ItemPhotoAction.uploadFromGallery),
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera_outlined,
                      color: theme.colorScheme.primary),
                  title: Text(context.l10n.itemTakePhoto),
                  onTap: () => Navigator.pop(ctx, _ItemPhotoAction.takePhoto),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
    if (!mounted || action == null) return;
    switch (action) {
      case _ItemPhotoAction.uploadFromGallery:
        await _pickItemImageFromSource(ImageSource.gallery);
        break;
      case _ItemPhotoAction.takePhoto:
        await _pickItemImageFromSource(ImageSource.camera);
        break;
    }
  }

  Future<void> _finalizePickedImagePath(String path) async {
    final trimmed = path.trim();
    if (trimmed.isEmpty) return;
    if (!_allowedImageExtension(trimmed)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.itemImageFormatError)),
      );
      return;
    }
    final file = File(trimmed);
    if (!await file.exists()) return;
    final len = await file.length();
    if (len > _maxItemImageBytes) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.itemImageSizeError)),
      );
      return;
    }
    if (!mounted) return;
    setState(() => _pickedImagePath = trimmed);
  }

  Future<void> _pickItemImageFromSource(ImageSource source) async {
    try {
      final x = await _imagePicker.pickImage(
        source: source,
        maxWidth: 4096,
        imageQuality: 92,
      );
      if (!mounted || x == null) return;
      await _finalizePickedImagePath(x.path);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not get image: $e'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _clearPickedImage() {
    setState(() => _pickedImagePath = null);
  }

  Future<void> _saveItem() async {
    if (_selectedUnit == null || _selectedUnit!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.itemSelectUnitRequired)),
      );
      return;
    }
    if (_selectedPurpose.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.itemSelectPurposeRequired)),
      );
      return;
    }
    if (_selectedCategory == null || _selectedCategory!.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.itemSelectCategoryRequired)),
      );
      return;
    }

    String? imagePath = _pickedImagePath?.trim();
    if (imagePath != null && imagePath.isNotEmpty) {
      final file = File(imagePath);
      if (!await file.exists()) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.itemImageMissing)),
        );
        return;
      }
      if (await file.length() > _maxItemImageBytes) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.itemImageSizeError)),
        );
        return;
      }
    } else {
      imagePath = null;
    }

    if (widget.isEditing) {
      context.read<ItemCubit>().updateItem(
            request: CreateItemRequest(
              id: widget.item?.id,
              name: _nameController.text,
              newName: _nameController.text == _newNameController.text
                  ? null
                  : _newNameController.text,
              description: _descriptionController.text,
              rate: double.parse(_rateController.text),
              unit: _selectedUnit!,
              forFilter: _selectedPurpose,
              itemType: _selectedItemType,
              totalSales: null,
              category: _selectedCategory,
              barcode: _barcodeController.text.trim().isEmpty
                  ? ''
                  : _barcodeController.text.trim(),
              trackItem: _liveTrackItemFlag(),
            ),
            imagePath: imagePath,
          );
    } else {
      context.read<ItemCubit>().createItem(
            request: ItemModel(
              name: _nameController.text,
              description: _descriptionController.text,
              rate: double.parse(_rateController.text),
              unit: _selectedUnit!,
              createdBy: context.employeeData?.email.toString(),
              incomeAccount: 'Sales',
              expenseAccount: 'Cost of Goods Sold',
              forFilter: _selectedPurpose,
              itemType: _selectedItemType,
              category: _selectedCategory,
              barcode: _barcodeController.text.trim().isEmpty
                  ? null
                  : _barcodeController.text.trim(),
              trackItem: _liveTrackItemFlag(),
            ),
            imagePath: imagePath,
          );
    }
  }

  int _liveTrackItemFlag() {
    if (_selectedItemType == 'Service') return 0;
    try {
      if (getIt.isRegistered<LiveStockTrackingService>() &&
          getIt<LiveStockTrackingService>().enabled) {
        return 1;
      }
    } catch (_) {}
    return 0;
  }

  bool get _showOnHandField {
    if (_selectedItemType == 'Service') return false;
    final tracking = liveStockOrNull();
    return tracking != null && tracking.enabled;
  }

  Future<void> _applyPendingOnHand() async {
    if (!_showOnHandField) return;
    final raw = _openingStockController.text.trim();
    if (raw.isEmpty) return;
    final qty = double.tryParse(raw);
    if (qty == null || qty < 0) return;
    final name = widget.isEditing
        ? (widget.item?.name ?? _nameController.text.trim())
        : _nameController.text.trim();
    if (name.isEmpty) return;
    await liveStockOrNull()?.setOnHand(itemName: name, qty: qty);
  }

  IconData _itemTypeIcon(String t) {
    switch (t) {
      case 'Service':
        return Icons.room_service_outlined;
      case 'Inventory':
        return Icons.warehouse_outlined;
      default:
        return Icons.inventory_2_outlined;
    }
  }

  Future<void> _showItemTypeBottomSheet() async {
    final theme = Theme.of(context);
    final next = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.l10n.itemTypeField,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            ..._itemTypes.map(
              (t) => ListTile(
                leading: Icon(_itemTypeIcon(t)),
                title: Text(context.l10n.localizedItemType(t)),
                trailing: _selectedItemType == t
                    ? Icon(Icons.check, color: theme.colorScheme.primary)
                    : null,
                onTap: () => Navigator.pop(ctx, t),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (next != null && mounted) setState(() => _selectedItemType = next);
  }

  /// Matches [CustomTextFormField] so pickers and inputs look identical.
  static const double _fieldHeight = 50;
  static const double _fieldRadius = 10;

  Color _fieldFill(ThemeData theme) => theme.colorScheme.surfaceContainerHighest;

  Color _fieldBorder(ThemeData theme) =>
      theme.colorScheme.outlineVariant.withValues(alpha: 0.6);

  Widget _fieldLabel(
    ThemeData theme,
    String label, {
    bool isRequired = false,
  }) {
    final style =
        theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text.rich(
        TextSpan(
          text: label,
          style: style,
          children: isRequired
              ? [
                  TextSpan(
                    text: ' *',
                    style: style?.copyWith(color: theme.colorScheme.error),
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  Widget _filledSelectField({
    required ThemeData theme,
    required String label,
    required bool isRequired,
    required String value,
    required String hint,
    required VoidCallback onTap,
    bool localizeValue = false,
    IconData? leadingIcon,
  }) {
    final isPlaceholder = value.isEmpty;
    final displayValue = isPlaceholder
        ? hint
        : (localizeValue
            ? context.l10n.localizedItemPickerOption(value)
            : value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _fieldLabel(theme, label, isRequired: isRequired),
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(_fieldRadius),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Ink(
              height: _fieldHeight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: _fieldFill(theme),
                borderRadius: BorderRadius.circular(_fieldRadius),
                border: Border.all(color: _fieldBorder(theme)),
              ),
              child: Row(
                children: [
                  if (leadingIcon != null) ...[
                    Icon(
                      leadingIcon,
                      size: 20,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Text(
                      displayValue,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isPlaceholder
                            ? theme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.75)
                            : theme.colorScheme.onSurface,
                        fontWeight:
                            isPlaceholder ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDishPhotoSection(ThemeData theme) {
    final picked = _pickedImagePath;
    final storedImage = widget.item?.image?.trim();
    final hasLocalPick = picked != null && picked.isNotEmpty;
    const double boxHeight = 128.0;

    Widget buildPreview() {
      if (hasLocalPick) {
        return Image.file(
          File(picked),
          height: boxHeight,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _dishPhotoEmptyState(theme),
        );
      }
      if (storedImage != null &&
          storedImage.isNotEmpty &&
          ItemImageHelper.hasDisplayableImage(storedImage)) {
        return ItemImageHelper.buildImage(
          storedImage,
          height: boxHeight,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _dishPhotoEmptyState(theme),
        );
      }
      return _dishPhotoEmptyState(theme);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _fieldLabel(theme, context.l10n.itemPhotoTitle),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _showImageSourceSheet,
                borderRadius: BorderRadius.circular(12),
                child: Ink(
                  height: 128,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: theme.colorScheme.outlineVariant, width: 1.2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: buildPreview(),
                  ),
                ),
              ),
            ),
            if (hasLocalPick)
              Positioned(
                top: 8.r,
                right: 8.r,
                child: Material(
                  color: Colors.black54,
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: GestureDetector(
                    child: Icon(Icons.close_rounded,
                            size: 16.r, color: Colors.white)
                        .padAll(4.r),
                    onTap: _clearPickedImage,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          context.l10n.itemPhotoFormats,
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _dishPhotoEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined,
                size: 30.sp, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 10),
            Text(
              context.l10n.itemPhotoHint,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditorBody(ThemeData theme) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ItemCubit, ItemState>(
          listener: (context, state) {
            state.maybeWhen(
              updated: (_) async {
                await _applyPendingOnHand();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context.l10n.itemUpdatedSuccess),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context, true);
              },
              created: (_) async {
                await _applyPendingOnHand();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context.l10n.itemCreatedSuccess),
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
      ],
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            widget.asBottomSheet ? 32 : 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDishPhotoSection(theme),
              const SizedBox(height: 20),
              _filledSelectField(
                theme: theme,
                label: context.l10n.itemTypeLabel,
                isRequired: false,
                value: context.l10n.localizedItemType(_selectedItemType),
                hint: context.l10n.itemTypeField,
                leadingIcon: _itemTypeIcon(_selectedItemType),
                onTap: _showItemTypeBottomSheet,
              ),
              const SizedBox(height: 16),
              _fieldLabel(
                theme,
                context.l10n.itemNameLabel,
                isRequired: true,
              ),
              CustomTextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                enabled: widget.isEditing ? false : true,
                padding: EdgeInsets.zero,
                labelText: null,
                hint: context.l10n.itemNameHint,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.itemValidationName;
                  }
                  return null;
                },
              ),
              if (!widget.isEditing) ...[
                const SizedBox(height: 16),
                _fieldLabel(theme, context.l10n.itemSkuLabel),
                CustomTextFormField(
                  controller: _barcodeController,
                  keyboardType: TextInputType.text,
                  padding: EdgeInsets.zero,
                  labelText: null,
                  hint: context.l10n.itemSkuHint,
                ),
              ],
              if (widget.isEditing) ...[
                const SizedBox(height: 16),
                _fieldLabel(
                  theme,
                  context.l10n.itemNameLabel,
                  isRequired: true,
                ),
                CustomTextFormField(
                  controller: _newNameController,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  padding: EdgeInsets.zero,
                  labelText: null,
                  hint: context.l10n.itemNameHint,
                  validating: (value) {
                    if (value == null || value.isEmpty) {
                      return context.l10n.itemValidationName;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _fieldLabel(theme, context.l10n.itemSkuLabel),
                CustomTextFormField(
                  controller: _barcodeController,
                  keyboardType: TextInputType.text,
                  padding: EdgeInsets.zero,
                  labelText: null,
                  hint: context.l10n.itemSkuHint,
                ),
              ],
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _showItemCode,
                  icon: const Icon(Icons.qr_code_2),
                  label: Text(context.l10n.itemBarcodeLabel),
                ),
              ),
              const SizedBox(height: 16),
              _fieldLabel(
                theme,
                context.l10n.itemRateLabel,
                isRequired: true,
              ),
              CustomTextFormField(
                textCapitalization: TextCapitalization.words,
                controller: _rateController,
                padding: EdgeInsets.zero,
                labelText: null,
                hint: '0.00',
                keyboardType: TextInputType.number,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.itemValidationRate;
                  }
                  if (double.tryParse(value) == null) {
                    return context.l10n.itemValidationNumber;
                  }
                  return null;
                },
              ),
              if (_showOnHandField) ...[
                const SizedBox(height: 16),
                _fieldLabel(
                  theme,
                  context.l10n.liveStockOnHandLabel,
                  isRequired: false,
                ),
                CustomTextFormField(
                  controller: _openingStockController,
                  padding: EdgeInsets.zero,
                  labelText: null,
                  hint: context.l10n.liveStockOnHandHint,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              _filledSelectField(
                theme: theme,
                label: context.l10n.itemUnitLabel,
                isRequired: true,
                value: _selectedUnit == null
                    ? ''
                    : context.l10n.localizedItemPickerOption(_selectedUnit!),
                hint: context.l10n.itemSelectUnit,
                onTap: () => _showSelectBottomSheet(
                  context,
                  title: context.l10n.itemSelectUnit,
                  searchHint: context.l10n.itemSearchUnits,
                  options: [
                    ..._unitOptions.map(
                      (u) => MapEntry(u, context.l10n.localizedItemPickerOption(u)),
                    ),
                    MapEntry('create_new', context.l10n.itemCreateCustomUnit),
                  ],
                  currentValue: _selectedUnit,
                  onCreateNew: _showCreateUnitDialog,
                  onSelected: (v) {
                    _selectedUnit = v;
                    _unitController.text = v ?? '';
                  },
                  setDisplayText: (value) {
                    _unitDisplayController.text = value;
                  },
                ),
              ),
              const SizedBox(height: 16),
              _filledSelectField(
                theme: theme,
                label: context.l10n.itemPurposeLabel,
                isRequired: true,
                value: context.l10n.localizedItemPurpose(_selectedPurpose),
                hint: context.l10n.itemSelectPurpose,
                onTap: () => _showSelectBottomSheet(
                  context,
                  title: context.l10n.itemSelectPurpose,
                  searchHint: context.l10n.itemSearchPurpose,
                  options: _purposeOptions
                      .map((p) => MapEntry(p, context.l10n.localizedItemPurpose(p)))
                      .toList(),
                  currentValue: _selectedPurpose,
                  onSelected: (v) => _selectedPurpose = v ?? 'Sales',
                  setDisplayText: (label) =>
                      _purposeDisplayController.text = label,
                ),
              ),
              const SizedBox(height: 16),
              _filledSelectField(
                theme: theme,
                label: context.l10n.category,
                isRequired: true,
                value: _selectedCategory ?? '',
                hint: context.l10n.itemSelectCategory,
                onTap: () => _showSelectBottomSheet(
                  context,
                  title: context.l10n.itemSelectCategory,
                  searchHint: context.l10n.itemSearchCategories,
                  options: itemCategories.map((c) => MapEntry(c, c)).toList(),
                  currentValue: _selectedCategory,
                  onSelected: (v) => _selectedCategory = v,
                  setDisplayText: (label) =>
                      _categoryDisplayController.text = label,
                ),
              ),
              const SizedBox(height: 32),
              CustomButtonWidget(
                width: context.width,
                onPressed: () => _saveItem(),
                title: widget.isEditing
                    ? context.l10n.itemUpdateButton
                    : context.l10n.itemCreateButton,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final body = _buildEditorBody(theme);
    if (widget.asBottomSheet) {
      return Material(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 12, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.isEditing
                            ? context.l10n.itemEditTitle
                            : context.l10n.itemAddSheetTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (!widget.isEditing)
                      IconButton(
                        icon: _lookupInProgress
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.qr_code_scanner),
                        tooltip: context.l10n.itemScanBarcode,
                        onPressed: _lookupInProgress ? null : _scanBarcode,
                      ),
                    Material(
                      color: theme.colorScheme.surfaceContainerHighest,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => Navigator.of(context).pop(false),
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: body),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text(
          widget.isEditing ? context.l10n.itemEditTitle : context.l10n.itemAddTitle,
        ),
        actions: [
          if (!widget.isEditing)
            IconButton(
              icon: _lookupInProgress
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.qr_code_scanner),
              tooltip: context.l10n.itemScanBarcode,
              onPressed: _lookupInProgress ? null : _scanBarcode,
            ),
        ],
      ),
      body: body,
    );
  }
}

class _CreateCustomUnitSheet extends StatefulWidget {
  const _CreateCustomUnitSheet();

  @override
  State<_CreateCustomUnitSheet> createState() => _CreateCustomUnitSheetState();
}

class _CreateCustomUnitSheetState extends State<_CreateCustomUnitSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _pop([String? result]) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pop(context, result);
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    _pop(name);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: scheme.outlineVariant.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.itemCreateCustomUnit,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Material(
                      color: scheme.surfaceContainerHighest.withOpacity(0.8),
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: _pop,
                        customBorder: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.close_rounded,
                            size: 22,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                verticalMarginSmall,
                const Divider(),
                verticalMarginMedium,
                CustomTextFormField(
                  controller: _controller,
                  labelText: context.l10n.itemUnitName,
                  hint: context.l10n.itemUnitNameHint,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: 20),
                CustomButtonWidget(
                  title: context.l10n.createAction,
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
