import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/role/data/models/delete_role_options.dart';
import 'package:hotel/src/features/role/data/models/role_item.dart';
import 'package:hotel/src/features/role/data/models/role_request.dart';
import 'package:hotel/src/features/role/presentation/cubit/role_manage_cubit.dart';
import 'package:hotel/src/features/role/presentation/cubit/role_manage_success_kind.dart';
import 'package:hotel/src/features/role/presentation/utils/role_visuals.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

Color _roleShellColor(ColorScheme scheme) => scheme.surfaceContainerLowest;

Color _roleSheetColor(ColorScheme scheme) => scheme.surface;

class RolesListPage extends StatefulWidget {
  const RolesListPage({super.key});

  @override
  State<RolesListPage> createState() => _RolesListPageState();
}

class _RolesListPageState extends State<RolesListPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reload(BuildContext context) {
    final q = _searchController.text.trim();
    context.read<RoleManageCubit>().load(search: q.isEmpty ? null : q);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RoleManageCubit>()..load(),
      child: BlocConsumer<RoleManageCubit, RoleManageState>(
        listener: (context, state) {
          if (state is RoleManageLoaded && state.successKind != null) {
            final l10n = context.l10n;
            final message = switch (state.successKind!) {
              RoleManageSuccessKind.created => l10n.roleCreated,
              RoleManageSuccessKind.updated => l10n.roleUpdated,
              RoleManageSuccessKind.deleted => l10n.roleDeleted,
              RoleManageSuccessKind.transferred =>
                l10n.roleDeletedPartiesTransferred(
                  state.transferredPartyCount ?? 0,
                  state.transferTargetRole ?? '',
                ),
              RoleManageSuccessKind.hardDeleted => l10n.roleAndPartiesDeleted(
                  state.transferredPartyCount ?? 0,
                ),
            };
            context.showKiiSnackBarSuccess(message);
          } else if (state is RoleManageError) {
            context.showKiiSnackBarError(state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is RoleManageLoading;
          final roles = switch (state) {
            RoleManageLoaded(:final roles) => roles,
            _ => const <RoleItem>[],
          };

          final l10n = context.l10n;
          final scheme = Theme.of(context).colorScheme;
          return Scaffold(
            backgroundColor: _roleShellColor(scheme),
            appBar: AppBar(
              leading: AppBarIosBackButton(color: scheme.onSurface),
              elevation: 0,
              backgroundColor: _roleShellColor(scheme),
              surfaceTintColor: Colors.transparent,
              foregroundColor: scheme.onSurface,
              title: Text(
                l10n.partyRolesTitle,
                style: AppFonts.interStyle(
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isLoading ? null : () => _openAddRoleSheet(context),
                  child: Text(l10n.add),
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: CustomTextFormField(
                    controller: _searchController,
                    hint: l10n.searchRoles,
                    textInputAction: TextInputAction.search,
                    prefixIcon: AppSearchIcon.inputDecoration(size: 22),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.close_rounded, size: 20),
                            onPressed: () {
                              _searchController.clear();
                              _reload(context);
                              setState(() {});
                            },
                          )
                        : null,
                    onChanged: (_) => _reload(context),
                    onFieldSubmitted: (_) => _reload(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Text(
                    l10n.roleCount(roles.length),
                    style: AppFonts.interStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(
                  child: isLoading && roles.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : roles.isEmpty
                          ? _EmptyRoles(onAdd: () => _openAddRoleSheet(context))
                          : RefreshIndicator(
                              onRefresh: () async => _reload(context),
                              child: ListView.separated(
                                padding: const EdgeInsets.all(16),
                                itemCount: roles.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 10),
                                itemBuilder: (context, index) {
                                  final item = roles[index];
                                  return _RoleCard(
                                    item: item,
                                    onTap: () => _showFormSheet(
                                      context,
                                      existing: item,
                                    ),
                                    onMenu: () => _showActionsSheet(
                                      context,
                                      item,
                                      roles,
                                    ),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: isLoading ? null : () => _openAddRoleSheet(context),
              tooltip: l10n.addRole,
              backgroundColor: scheme.primary,
              foregroundColor: scheme.onPrimary,
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  void _showActionsSheet(
    BuildContext context,
    RoleItem item,
    List<RoleItem> allRoles,
  ) {
    final l10n = context.l10n;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: _roleSheetColor(Theme.of(ctx).colorScheme),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(ctx).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                  leading: Icon(Icons.edit_outlined),
                  title: Text(l10n.edit),
                  onTap: () {
                    Navigator.pop(ctx);
                    _showFormSheet(context, existing: item);
                  },
                ),
              ListTile(
                  leading: AppDeleteIcon(color: Colors.red[400], size: 24),
                  title: Text(l10n.delete, style: AppFonts.interStyle(color: Colors.red[400])),
                  onTap: () async {
                    Navigator.pop(ctx);
                    final cubit = context.read<RoleManageCubit>();
                    final q = _searchController.text.trim();
                    await cubit.load(search: q.isEmpty ? null : q);
                    if (!context.mounted) return;
                    final freshRoles = switch (cubit.state) {
                      RoleManageLoaded(:final roles) => roles,
                      _ => allRoles,
                    };
                    final freshItem = freshRoles.firstWhere(
                      (r) => r.name.toLowerCase() == item.name.toLowerCase(),
                      orElse: () => item,
                    );
                    _confirmDelete(context, freshItem, freshRoles);
                  },
                ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    RoleItem item,
    List<RoleItem> allRoles,
  ) {
    if (item.partyCount > 0) {
      _showDeleteRoleWithPartiesSheet(context, item, allRoles);
      return;
    }

    final l10n = context.l10n;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: _roleSheetColor(Theme.of(ctx).colorScheme),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.deleteRoleTitle,
                  style: AppFonts.interStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(l10n.deleteRoleConfirm(item.name)),
                const SizedBox(height: 20),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(ctx);
                    context.read<RoleManageCubit>().delete(item.name);
                  },
                  child: Text(l10n.delete),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(l10n.cancel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteRoleWithPartiesSheet(
    BuildContext context,
    RoleItem item,
    List<RoleItem> allRoles,
  ) {
    final l10n = context.l10n;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: _roleSheetColor(Theme.of(ctx).colorScheme),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.deleteRoleTitle,
                  style: AppFonts.interStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(l10n.deleteRoleHasPartiesMessage(item.name, item.partyCount)),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _showTransferPartiesSheet(context, item, allRoles);
                  },
                  icon: Icon(Icons.swap_horiz),
                  label: Text(l10n.transferParties),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red[700],
                    side: BorderSide(color: Colors.red.shade300),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    _confirmHardDelete(context, item);
                  },
                  icon: AppDeleteIcon(color: Colors.red[700], size: 20),
                  label: Text(l10n.hardDeleteLoseParties),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(l10n.cancel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showTransferPartiesSheet(
    BuildContext context,
    RoleItem item,
    List<RoleItem> allRoles,
  ) {
    final targets = allRoles
        .where((r) => r.name.toLowerCase() != item.name.toLowerCase())
        .toList()
      ..sort((a, b) {
        final c = a.sortOrder.compareTo(b.sortOrder);
        return c != 0 ? c : a.name.compareTo(b.name);
      });

    if (targets.isEmpty) {
      context.showKiiSnackBarError(context.l10n.addAnotherRoleBeforeDelete);
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _TransferPartiesSheet(
        roleToDelete: item,
        targetRoles: targets,
        onTransfer: (targetRole) {
          Navigator.pop(sheetContext);
          context.read<RoleManageCubit>().delete(
                item.name,
                options: DeleteRoleOptions(transferPartiesToRole: targetRole),
                transferredPartyCount: item.partyCount,
                transferTargetRole: targetRole,
              );
        },
      ),
    );
  }

  void _confirmHardDelete(BuildContext context, RoleItem item) {
    final l10n = context.l10n;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: _roleSheetColor(Theme.of(ctx).colorScheme),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.hardDeleteRoleTitle,
                  style: AppFonts.interStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.red[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(l10n.hardDeleteRoleMessage(item.name, item.partyCount)),
                const SizedBox(height: 20),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(ctx);
                    context.read<RoleManageCubit>().delete(
                          item.name,
                          options: const DeleteRoleOptions(
                            deleteAssociatedParties: true,
                          ),
                          transferredPartyCount: item.partyCount,
                        );
                  },
                  child: Text(l10n.deleteRoleAndParties),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(l10n.cancel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openAddRoleSheet(BuildContext context) async {
    if (!await gateFreemiumFeature(context, FreemiumFeature.partyRole)) {
      return;
    }
    if (!context.mounted) return;
    _showFormSheet(context);
  }

  void _showFormSheet(BuildContext context, {RoleItem? existing}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _RoleFormSheet(
        existing: existing,
        onSave: (request, originalName) {
          Navigator.pop(sheetContext);
          final cubit = context.read<RoleManageCubit>();
          if (originalName != null) {
            cubit.update(originalName: originalName, request: request);
          } else {
            cubit.create(request);
          }
        },
      ),
    );
  }
}

class _EmptyRoles extends StatelessWidget {
  const _EmptyRoles({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.badge_outlined, size: 64, color: scheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              l10n.noRolesYet,
              style: AppFonts.interStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noRolesYetHint,
              textAlign: TextAlign.center,
              style: AppFonts.interStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onAdd,
              icon: Icon(Icons.add),
              label: Text(l10n.addRole),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.item,
    this.onTap,
    this.onMenu,
  });

  final RoleItem item;
  final VoidCallback? onTap;
  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final visual = roleVisual(item.name);
    final subtitle = item.description?.trim().isNotEmpty == true
        ? item.description!
        : (item.partyCount > 0
            ? l10n.rolePartyCount(item.partyCount)
            : l10n.noPartiesYet);

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashFactory: onTap == null ? NoSplash.splashFactory : null,
        highlightColor: onTap == null ? Colors.transparent : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: visual.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(visual.icon, color: visual.color, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: AppFonts.interStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: scheme.onSurface,
                            ),
                          ),
                        ),
                        if (item.isSystem)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: scheme.primaryContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              l10n.builtInRole,
                              style: AppFonts.interStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: scheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppFonts.interStyle(fontSize: 13, color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              if (onMenu != null)
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: onMenu,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransferPartiesSheet extends StatefulWidget {
  const _TransferPartiesSheet({
    required this.roleToDelete,
    required this.targetRoles,
    required this.onTransfer,
  });

  final RoleItem roleToDelete;
  final List<RoleItem> targetRoles;
  final void Function(String targetRole) onTransfer;

  @override
  State<_TransferPartiesSheet> createState() => _TransferPartiesSheetState();
}

class _TransferPartiesSheetState extends State<_TransferPartiesSheet> {
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    if (widget.targetRoles.isNotEmpty) {
      _selectedRole = widget.targetRoles.first.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.75;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          constraints: BoxConstraints(maxHeight: maxHeight),
          decoration: BoxDecoration(
            color: _roleSheetColor(scheme),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: scheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.transferParties,
                      style: AppFonts.interStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.transferPartiesMoveMessage(
                        widget.roleToDelete.partyCount,
                        widget.roleToDelete.name,
                      ),
                      style: AppFonts.interStyle(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: widget.targetRoles.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 4),
                  itemBuilder: (context, index) {
                    final role = widget.targetRoles[index];
                    final visual = roleVisual(role.name);
                    final selected = _selectedRole == role.name;

                    return Material(
                      color: selected
                          ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.35)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: RadioListTile<String>(
                        value: role.name,
                        groupValue: _selectedRole,
                        onChanged: (value) => setState(() => _selectedRole = value),
                        title: Text(
                          role.name,
                          style: AppFonts.interStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: role.description?.trim().isNotEmpty == true
                            ? Text(role.description!)
                            : null,
                        secondary: Icon(visual.icon, color: visual.color),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FilledButton(
                      onPressed: _selectedRole == null
                          ? null
                          : () => widget.onTransfer(_selectedRole!),
                      child: Text(l10n.transferAndDeleteRole),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(l10n.cancel),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleFormSheet extends StatefulWidget {
  const _RoleFormSheet({
    required this.onSave,
    this.existing,
  });

  final RoleItem? existing;
  final void Function(RoleRequest request, String? originalName) onSave;

  @override
  State<_RoleFormSheet> createState() => _RoleFormSheetState();
}

class _RoleFormSheetState extends State<_RoleFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _sortController;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _nameController = TextEditingController(text: e?.name ?? '');
    _descriptionController = TextEditingController(text: e?.description ?? '');
    _sortController = TextEditingController(
      text: e != null ? '${e.sortOrder}' : '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _sortController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.85;
    final isEdit = widget.existing != null;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          constraints: BoxConstraints(maxHeight: maxHeight),
          decoration: BoxDecoration(
            color: _roleSheetColor(scheme),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: scheme.outlineVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isEdit ? l10n.editRole : l10n.newRole,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _nameController,
                    labelText: l10n.roleNameLabel,
                    hint: l10n.roleNameHint,
                    validating: (v) =>
                        v == null || v.trim().isEmpty ? l10n.required : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _descriptionController,
                    labelText: l10n.roleDescriptionLabel,
                    hint: l10n.roleDescriptionHint,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _sortController,
                    labelText: l10n.roleSortOrderLabel,
                    hint: l10n.roleSortOrderHint,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  CustomButtonWidget(
                    title: isEdit ? l10n.save : l10n.createAction,
                    onPressed: () {
                      if (_formKey.currentState?.validate() != true) return;
                      final sortText = _sortController.text.trim();
                      widget.onSave(
                        RoleRequest(
                          name: _nameController.text.trim(),
                          description: _descriptionController.text.trim(),
                          sortOrder: sortText.isEmpty
                              ? null
                              : int.tryParse(sortText),
                        ),
                        widget.existing?.name,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
