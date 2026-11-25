import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/services/billing/freemium_gate_service.dart';
import 'package:hotel/src/core/widget/freemium_access_scope.dart';
import 'package:hotel/src/core/widget/freemium_record_gate.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/action_bottom_sheet.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';
import 'package:hotel/src/features/action/data/models/request/item_request_params.dart';
import 'package:hotel/src/features/action/presentation/pages/item_details_page.dart';
import 'package:hotel/src/features/action/domain/usecases/item_use_cases.dart';
import 'package:hotel/src/features/category/data/models/category_model.dart';
import 'package:hotel/src/features/category/presentation/cubit/category_cubit.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';

Color _categoryShellColor(ColorScheme scheme) => scheme.surfaceContainerLowest;

const _deleteColor = Color(0xFFEF4444);

@RoutePage()
class CategoriesListPage extends StatelessWidget {
  const CategoriesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CategoryCubit>()..loadCategories(),
      child: const _CategoriesListView(),
    );
  }
}

class _CategoriesListView extends StatefulWidget {
  const _CategoriesListView();

  @override
  State<_CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<_CategoriesListView> {
  Map<String, int> _inventoryCategoryCounts = const {};
  bool _isSelectionMode = false;
  final Set<String> _selectedNames = {};
  int? _pendingDeleteCount;
  String? _pendingTransferTarget;
  int? _pendingTransferredItemCount;

  @override
  void initState() {
    super.initState();
    _loadInventoryCategoryCounts();
  }

  Future<void> _loadInventoryCategoryCounts() async {
    final useCase = getIt<GetItemsUseCase>();
    final counts = <String, int>{};
    var page = 1;
    const perPage = 500;

    while (true) {
      final result = await useCase.execute(
        ItemRequestParams(
          page: page,
          perPage: perPage,
          sortBy: 'name',
          sortOrder: 'asc',
        ),
      );

      bool shouldStop = true;
      result.fold(
        (_) => shouldStop = true,
        (response) {
          final itemResponse = response.data;
          for (final item in itemResponse.data) {
            final rawCategory = item.category?.trim();
            if (rawCategory == null || rawCategory.isEmpty) continue;
            final key = rawCategory.toLowerCase();
            counts[key] = (counts[key] ?? 0) + 1;
          }
          shouldStop = itemResponse.pagination.currentPage >= itemResponse.pagination.totalPages;
        },
      );

      if (shouldStop) break;
      page++;
    }

    if (!mounted) return;
    setState(() {
      _inventoryCategoryCounts = counts;
    });
  }

  int _resolvedCategoryItemCount(CategoryModel category) {
    final key = category.name.trim().toLowerCase();
    final displayKey = _categoryDisplayName(category.name).toLowerCase();
    return _inventoryCategoryCounts[key] ??
        _inventoryCategoryCounts[displayKey] ??
        category.itemCount ??
        0;
  }

  bool _isCategoryLocked(BuildContext context, CategoryModel category) {
    final scope = FreemiumAccessScope.maybeOf(context);
    return scope != null && scope.isLocked(category.id.toString());
  }

  void _clearSelection() {
    if (!_isSelectionMode && _selectedNames.isEmpty) return;
    setState(() {
      _isSelectionMode = false;
      _selectedNames.clear();
    });
  }

  void _enterSelection(String name) {
    setState(() {
      _isSelectionMode = true;
      _selectedNames.add(name);
    });
  }

  void _toggleSelection(String name) {
    setState(() {
      if (_selectedNames.contains(name)) {
        _selectedNames.remove(name);
      } else {
        _selectedNames.add(name);
      }
      if (_selectedNames.isEmpty) {
        _isSelectionMode = false;
      }
    });
  }

  void _selectAll(BuildContext context, List<CategoryModel> categories) {
    final selectable = categories
        .where((category) => !_isCategoryLocked(context, category))
        .map((category) => category.name)
        .toSet();
    setState(() {
      if (selectable.isNotEmpty &&
          _selectedNames.length == selectable.length &&
          _selectedNames.containsAll(selectable)) {
        _isSelectionMode = false;
        _selectedNames.clear();
      } else {
        _isSelectionMode = true;
        _selectedNames
          ..clear()
          ..addAll(selectable);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final primary = scheme.primary;

    return PopScope(
      canPop: !_isSelectionMode,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _clearSelection();
      },
      child: Scaffold(
      backgroundColor: _categoryShellColor(scheme),
      appBar: AppBar(
        leading: _isSelectionMode
            ? IconButton(
                icon: Icon(Icons.close_rounded, color: scheme.onSurface),
                onPressed: _clearSelection,
              )
            : AppBarIosBackButton(color: scheme.onSurface),
        backgroundColor: _categoryShellColor(scheme),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          _isSelectionMode
              ? context.l10n.invoiceCommonSelectedCount(_selectedNames.length)
              : context.l10n.categories,
        ),
        actions: [
          if (_isSelectionMode) ...[
            TextButton(
              onPressed: () {
                final categories = context.read<CategoryCubit>().state.maybeWhen(
                      loaded: (list) => list,
                      orElse: () => const <CategoryModel>[],
                    );
                _selectAll(context, categories);
              },
              child: Text(context.l10n.invoiceCommonSelectAll),
            ),
            IconButton(
              onPressed: _selectedNames.isEmpty
                  ? null
                  : () => _showBulkDeleteDialog(context),
              icon: AppDeleteIcon(
                color: _selectedNames.isEmpty ? scheme.outline : _deleteColor,
              ),
            ),
          ],
        ],
      ),
      body: FreemiumAccessHost(
        feature: FreemiumFeature.category,
        child: MultiBlocListener(
        listeners: [
          BlocListener<CategoryCubit, CategoryState>(
            listener: (context, state) {
              state.maybeWhen(
                createSuccess: (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(context.l10n.catCreated),
                        backgroundColor: Colors.green),
                  );
                  context.read<CategoryCubit>().loadCategories();
                  _loadInventoryCategoryCounts();
                },
                renameSuccess: (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(context.l10n.catRenamed),
                        backgroundColor: Colors.green),
                  );
                  context.read<CategoryCubit>().loadCategories();
                  _loadInventoryCategoryCounts();
                },
                deleteSuccess: (_) {
                  final count = _pendingDeleteCount ?? 1;
                  final transferTarget = _pendingTransferTarget;
                  final transferred = _pendingTransferredItemCount ?? 0;
                  _pendingDeleteCount = null;
                  _pendingTransferTarget = null;
                  _pendingTransferredItemCount = null;
                  _clearSelection();
                  final message = transferTarget != null && transferred > 0
                      ? context.l10n.catDeletedItemsTransferred(
                          transferred,
                          _categoryDisplayName(transferTarget),
                        )
                      : (count <= 1
                          ? context.l10n.catDeleted
                          : context.l10n.catDeletedBulk(count));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.green),
                  );
                  context.read<CategoryCubit>().loadCategories();
                  _loadInventoryCategoryCounts();
                },
                error: (message) {
                  if (message.startsWith(FreemiumGateService.blockedMessagePrefix)) {
                    context.showKiiSnackBarWarning(context.l10n.upgradeToPremiumContinue);
                    context.router.push(PremiumPaywallRoute(fromSettings: true));
                    return;
                  }
                  context.showKiiSnackBarError(message);
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (categories) => categories.isEmpty
                  ? Center(
                      child: Text(
                        context.l10n.catNoCategories,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 88),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final c = categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: FreemiumRecordGate(
                          recordKey: c.id.toString(),
                          child: _CategoryTile(
                          category: c,
                          itemCount: _resolvedCategoryItemCount(c),
                          isLocked: _isCategoryLocked(context, c),
                          isSelectionMode: _isSelectionMode,
                          isSelected: _selectedNames.contains(c.name),
                          onToggle: () => _toggleSelection(c.name),
                          onLongPress: () => _enterSelection(c.name),
                          onOpen: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => ItemDetailsPage(
                                  initialCategory: c.name,
                                ),
                              ),
                            );
                            if (context.mounted) {
                              _loadInventoryCategoryCounts();
                            }
                          },
                          onRename: () => _showRenameDialog(context, c),
                          onDelete: () => _showDeleteDialog(
                            context,
                            c,
                            itemCount: _resolvedCategoryItemCount(c),
                          ),
                        ),
                          ),
                        );
                      },
                    ),
              orElse: () => Center(child: Text(context.l10n.catLoadCategories)),
            );
          },
        ),
      ),
      ),
      floatingActionButton: _isSelectionMode
          ? null
          : FloatingActionButton(
        onPressed: () => _showCreateDialog(context),
        backgroundColor: primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded),
      ),
    ),
    );
  }

  Future<void> _showCreateDialog(BuildContext context) {
    final l10n = context.l10n;
    return showAppBottomSheet<void>(
      context: context,
      title: l10n.catNewTitle,
      shrinkWrap: true,
      bodyBuilder: (sheetContext) => _CategoryNameSheetBody(
        fieldLabel: l10n.name,
        submitLabel: l10n.createAction,
        onSubmit: (name) async {
          if (!await gateFreemiumFeature(
            context,
            FreemiumFeature.category,
          )) {
            return;
          }
          if (!sheetContext.mounted) return;
          Navigator.pop(sheetContext);
          if (!context.mounted) return;
          context.read<CategoryCubit>().createCategory(name);
        },
      ),
    );
  }

  void _showRenameDialog(BuildContext context, CategoryModel category) {
    final l10n = context.l10n;
    showAppBottomSheet<void>(
      context: context,
      title: l10n.catRenameTitle,
      shrinkWrap: true,
      bodyBuilder: (sheetContext) => _CategoryNameSheetBody(
        initialName: category.name,
        fieldLabel: l10n.catNewName,
        submitLabel: l10n.catRename,
        onSubmit: (newName) async {
          Navigator.pop(sheetContext);
          if (newName.isEmpty || newName == category.name) return;
          context.read<CategoryCubit>().renameCategory(
                oldName: category.name,
                newName: newName,
              );
        },
      ),
    );
  }

  List<CategoryModel> _loadedCategories() {
    return context.read<CategoryCubit>().state.maybeWhen(
          loaded: (list) => list,
          orElse: () => const <CategoryModel>[],
        );
  }

  void _showDeleteDialog(
    BuildContext context,
    CategoryModel category, {
    required int itemCount,
  }) {
    if (itemCount > 0) {
      _showTransferThenDelete(
        context,
        names: [category.name],
        itemCount: itemCount,
      );
      return;
    }

    final l10n = context.l10n;
    showAppBottomSheet<void>(
      context: context,
      title: l10n.catDeleteTitle,
      shrinkWrap: true,
      bodyBuilder: (sheetContext) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.catDeleteConfirm(category.name),
              style: AppFonts.interStyle(
                fontSize: 14,
                height: 1.45,
                color: Theme.of(sheetContext).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget.outlined(
                    onPressed: () => Navigator.pop(sheetContext),
                    title: l10n.cancel,
                    width: double.infinity,
                    height: 48,
                    borderRadius: 12,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButtonWidget(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _pendingDeleteCount = 1;
                      context
                          .read<CategoryCubit>()
                          .deleteCategory(name: category.name);
                    },
                    title: l10n.delete,
                    width: double.infinity,
                    height: 48,
                    borderRadius: 12,
                    backgroundColor: _deleteColor,
                    titleColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showBulkDeleteDialog(BuildContext context) {
    if (_selectedNames.isEmpty) return;
    final selected = _loadedCategories()
        .where((category) => _selectedNames.contains(category.name))
        .toList(growable: false);
    final names = selected.map((category) => category.name).toList(growable: false);
    if (names.isEmpty) return;
    final itemCount = selected.fold<int>(
      0,
      (sum, category) => sum + _resolvedCategoryItemCount(category),
    );
    if (itemCount > 0) {
      _showTransferThenDelete(
        context,
        names: names,
        itemCount: itemCount,
      );
      return;
    }

    final l10n = context.l10n;
    showAppBottomSheet<void>(
      context: context,
      title: l10n.catDeleteBulkTitle,
      shrinkWrap: true,
      bodyBuilder: (sheetContext) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.catDeleteBulkConfirm(names.length),
              style: AppFonts.interStyle(
                fontSize: 14,
                height: 1.45,
                color: Theme.of(sheetContext).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget.outlined(
                    onPressed: () => Navigator.pop(sheetContext),
                    title: l10n.cancel,
                    width: double.infinity,
                    height: 48,
                    borderRadius: 12,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButtonWidget(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _pendingDeleteCount = names.length;
                      context.read<CategoryCubit>().deleteCategories(names: names);
                    },
                    title: l10n.delete,
                    width: double.infinity,
                    height: 48,
                    borderRadius: 12,
                    backgroundColor: _deleteColor,
                    titleColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showTransferThenDelete(
    BuildContext context, {
    required List<String> names,
    required int itemCount,
  }) {
    final l10n = context.l10n;
    final exclude = names.map((name) => name.toLowerCase()).toSet();
    final targets = _loadedCategories()
        .where((category) => !exclude.contains(category.name.toLowerCase()))
        .toList(growable: false);
    if (targets.isEmpty) {
      context.showKiiSnackBarError(l10n.catAddAnotherBeforeDelete);
      return;
    }

    showAppBottomSheet<void>(
      context: context,
      title: l10n.catTransferItems,
      shrinkWrap: true,
      bodyBuilder: (sheetContext) => _TransferItemsSheetBody(
        itemCount: itemCount,
        sourceName: names.length == 1
            ? _categoryDisplayName(names.first)
            : null,
        targets: targets,
        onCancel: () => Navigator.pop(sheetContext),
        onTransfer: (targetName) {
          Navigator.pop(sheetContext);
          _pendingDeleteCount = names.length;
          _pendingTransferTarget = targetName;
          _pendingTransferredItemCount = itemCount;
          context.read<CategoryCubit>().deleteCategories(
                names: names,
                transferItemsTo: targetName,
              );
        },
      ),
    );
  }
}

class _TransferItemsSheetBody extends StatefulWidget {
  const _TransferItemsSheetBody({
    required this.itemCount,
    required this.targets,
    required this.onCancel,
    required this.onTransfer,
    this.sourceName,
  });

  final int itemCount;
  final String? sourceName;
  final List<CategoryModel> targets;
  final VoidCallback onCancel;
  final ValueChanged<String> onTransfer;

  @override
  State<_TransferItemsSheetBody> createState() => _TransferItemsSheetBodyState();
}

class _TransferItemsSheetBodyState extends State<_TransferItemsSheetBody> {
  late String _selectedName;

  @override
  void initState() {
    super.initState();
    _selectedName = widget.targets.first.name;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.sourceName == null
              ? l10n.catTransferItemsMoveMessage(widget.itemCount)
              : l10n.catDeleteHasItemsMessage(
                  widget.sourceName!,
                  widget.itemCount,
                ),
          style: AppFonts.interStyle(
            fontSize: 14,
            height: 1.45,
            color: scheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 280),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: widget.targets.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final category = widget.targets[index];
              final selected = category.name == _selectedName;
              return Material(
                color: selected
                    ? scheme.primaryContainer.withValues(alpha: 0.45)
                    : scheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(
                    color: selected
                        ? scheme.primary
                        : scheme.outlineVariant.withValues(alpha: 0.5),
                    width: selected ? 2 : 1,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => setState(() => _selectedName = category.name),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selected
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_off_rounded,
                          color: selected ? scheme.primary : scheme.outline,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _categoryDisplayName(category.name),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: scheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        CustomButtonWidget(
          onPressed: () => widget.onTransfer(_selectedName),
          title: l10n.catTransferAndDelete,
          width: double.infinity,
          height: 48,
          borderRadius: 12,
          backgroundColor: _deleteColor,
          titleColor: Colors.white,
        ),
        const SizedBox(height: 12),
        CustomButtonWidget.outlined(
          onPressed: widget.onCancel,
          title: l10n.cancel,
          width: double.infinity,
          height: 48,
          borderRadius: 12,
        ),
      ],
    );
  }
}

class _CategoryNameSheetBody extends StatefulWidget {
  const _CategoryNameSheetBody({
    this.initialName = '',
    required this.fieldLabel,
    required this.submitLabel,
    required this.onSubmit,
  });

  final String initialName;
  final String fieldLabel;
  final String submitLabel;
  final Future<void> Function(String name) onSubmit;

  @override
  State<_CategoryNameSheetBody> createState() => _CategoryNameSheetBodyState();
}

class _CategoryNameSheetBodyState extends State<_CategoryNameSheetBody> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    await widget.onSubmit(name);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextFormField(
          controller: _controller,
          focusNode: _focusNode,
          labelText: widget.fieldLabel,
          hint: widget.fieldLabel,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.words,
          onFieldSubmitted: (_) => _submit(),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomButtonWidget.outlined(
                onPressed: () => Navigator.pop(context),
                title: l10n.cancel,
                width: double.infinity,
                height: 48,
                borderRadius: 12,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButtonWidget(
                onPressed: _submit,
                title: widget.submitLabel,
                width: double.infinity,
                height: 48,
                borderRadius: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Show just the name part for display, e.g. "Food - Main Course (Chicken)" → "Main Course (Chicken)".
String _categoryDisplayName(String fullName) {
  final idx = fullName.indexOf(' - ');
  if (idx >= 0 && idx + 3 < fullName.length) {
    return fullName.substring(idx + 3).trim();
  }
  return fullName;
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.category,
    required this.itemCount,
    required this.isLocked,
    required this.isSelectionMode,
    required this.isSelected,
    required this.onToggle,
    required this.onLongPress,
    required this.onOpen,
    required this.onRename,
    required this.onDelete,
  });

  final CategoryModel category;
  final int itemCount;
  final bool isLocked;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback onToggle;
  final VoidCallback onLongPress;
  final VoidCallback onOpen;
  final VoidCallback onRename;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: scheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isSelected
              ? scheme.primary
              : scheme.outlineVariant.withValues(alpha: 0.5),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: isSelectionMode ? onToggle : onOpen,
        onLongPress: isSelectionMode ? onToggle : onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              if (isSelectionMode) ...[
                Icon(
                  isSelected
                      ? Icons.check_circle_rounded
                      : Icons.circle_outlined,
                  color: isSelected ? scheme.primary : scheme.outline,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _categoryDisplayName(category.name),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      context.l10n.catItemsCount(context.l10n.formatCount(itemCount)),
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              if (!isSelectionMode && !isLocked)
                IconButton(
                  icon: Icon(Icons.more_vert, color: scheme.onSurfaceVariant),
                  onPressed: () => _showActionsBottomSheet(context),
                )
              else if (!isSelectionMode)
                const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }

  void _showActionsBottomSheet(BuildContext context) {
    final l10n = context.l10n;
    ActionBottomSheet.show(
      context,
      title: _categoryDisplayName(category.name),
      items: [
        ActionSheetItem(
          icon: Icons.edit,
          title: l10n.catRename,
          onTap: onRename,
        ),
        ActionSheetItem(
          icon: Icons.delete,
          title: l10n.delete,
          color: _deleteColor,
          onTap: onDelete,
        ),
      ],
    );
  }
}
