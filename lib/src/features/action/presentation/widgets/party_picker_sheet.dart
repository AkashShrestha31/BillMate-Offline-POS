import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/features/action/data/models/request/party_request_params.dart';
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart';
import 'package:hotel/src/features/action/presentation/cubit/party_cubit.dart';
import 'package:hotel/src/core/constants/app_empty_state_assets.dart';
import 'package:hotel/src/core/helpers/freemium_navigation.dart';
import 'package:hotel/src/core/widget/freemium_access_scope.dart';
import 'package:hotel/src/core/widget/freemium_record_gate.dart';
import 'package:hotel/src/core/widget/list_empty_state.dart';
import 'package:hotel/src/features/action/presentation/widgets/party_picker_freemium.dart';
import 'package:hotel/src/features/action/presentation/widgets/party_picker_widgets.dart';
import 'package:hotel/src/features/role/data/models/role_item.dart';
import 'package:hotel/src/features/role/domain/party_picker_role_helper.dart';
import 'package:hotel/src/features/role/domain/repositories/roles_repository.dart';

/// Bottom sheet to pick a party (customer / room / cabin, customers only, or suppliers only).
class PartyPickerSheet extends StatefulWidget {
  const PartyPickerSheet({
    super.key,
    required this.role,
    required this.onSelect,
    this.selectedPartyName,
    this.customerOnly = false,
    this.supplierOnly = false,
    this.roomAndCabinOnly = false,
    this.includeEmployeeTab = false,
    this.supplierIncludeEmployeeTab = false,
  })  : assert(!(customerOnly && roomAndCabinOnly), 'Use either customerOnly or roomAndCabinOnly'),
        assert(!(supplierOnly && roomAndCabinOnly), 'Use either supplierOnly or roomAndCabinOnly'),
        assert(!(customerOnly && supplierOnly), 'Use either customerOnly or supplierOnly'),
        assert(!(supplierOnly && supplierIncludeEmployeeTab), 'Use supplierIncludeEmployeeTab instead of supplierOnly'),
        assert(!(includeEmployeeTab && supplierIncludeEmployeeTab), 'Use one employee-tab mode at a time'),
        assert(
          !(includeEmployeeTab && (customerOnly || supplierOnly)),
          'Employee tab is for Customer/Room/Cabin or Room/Cabin modes only',
        ),
        assert(
          !(supplierIncludeEmployeeTab && (customerOnly || roomAndCabinOnly || includeEmployeeTab)),
          'supplierIncludeEmployeeTab is for Supplier + Employee purchase pickers only',
        );

  final String role;
  final String? selectedPartyName;
  final void Function(PartyItem party) onSelect;
  final bool customerOnly;
  final bool supplierOnly;
  final bool roomAndCabinOnly;
  final bool includeEmployeeTab;
  final bool supplierIncludeEmployeeTab;

  @override
  State<PartyPickerSheet> createState() => _PartyPickerSheetState();
}

class _PartyPickerSheetState extends State<PartyPickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Timer? _searchDebounce;
  static const Duration _searchDebounceDuration = Duration(milliseconds: 400);
  String? _lastSearchRequest;

  static const double _sheetHeightFraction = 0.92;

  List<String> _tabRoles = const [];
  bool _rolesReady = false;
  int _activeTabIndex = 0;
  PartyItem? _pendingSelection;
  List<PartyItem> _allParties = const [];

  String _activePartyRole() {
    if (_tabRoles.isEmpty) {
      if (widget.supplierOnly) return 'supplier';
      if (widget.customerOnly) return 'customer';
      return widget.role;
    }
    return _tabRoles[_activeTabIndex.clamp(0, _tabRoles.length - 1)];
  }

  @override
  void initState() {
    super.initState();
    _loadRoleTabs();
  }

  Future<void> _loadRoleTabs() async {
    var dbRoles = <RoleItem>[];
    if (getIt.isRegistered<RolesRepository>()) {
      final result = await getIt<RolesRepository>().getRoles();
      result.fold((_) {}, (list) => dbRoles = list);
    }
    final tabs = PartyPickerRoleHelper.tabLabelsForPicker(
      dbRoles: dbRoles,
      customerOnly: widget.customerOnly,
      supplierOnly: widget.supplierOnly,
      roomAndCabinOnly: widget.roomAndCabinOnly,
      supplierIncludeEmployeeTab: widget.supplierIncludeEmployeeTab,
    );
    final initialIndex = PartyPickerRoleHelper.initialTabIndex(
      tabs: tabs,
      role: widget.role,
    );
    if (!mounted) return;
    setState(() {
      _tabRoles = tabs;
      _activeTabIndex = initialIndex.clamp(0, tabs.length - 1);
      _rolesReady = true;
    });
    _fetchParties(search: null);
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_searchDebounceDuration, () {
      if (!mounted) return;
      final search = value.trim();
      if (search == (_lastSearchRequest ?? '')) return;
      _lastSearchRequest = search.isEmpty ? null : search;
      _fetchParties(search: _lastSearchRequest);
    });
  }

  void _clearSearch() {
    _searchDebounce?.cancel();
    _searchController.clear();
    _lastSearchRequest = null;
    _fetchParties(search: null);
    setState(() {});
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

  (String, String?) _partyTitleSubtitle(BuildContext context, PartyItem party) {
    final raw = party.name?.trim() ?? '';
    if (raw.isEmpty) return ('', null);

    String title = raw;
    final open = raw.indexOf('(');
    final close = raw.lastIndexOf(')');
    if (open > 0 && close > open) {
      final main = raw.substring(0, open).trim();
      if (main.isNotEmpty) title = main;
    }

    final phone = party.phone?.trim();
    if (phone != null && phone.isNotEmpty) {
      return (title, phone);
    }

    if (open > 0 && close > open) {
      final sub = raw.substring(open + 1, close).trim();
      if (sub.isNotEmpty) return (title, sub);
    }

    final role = party.role?.trim();
    if (role != null && role.isNotEmpty) {
      return (title, context.l10n.localizedPartyRoleName(role));
    }
    return (title, null);
  }

  String? _displayNameForParty(PartyItem? party) {
    if (party == null) return null;
    return _partyTitleSubtitle(context, party).$1;
  }

  bool _isSameParty(PartyItem? a, PartyItem? b) {
    if (a == null || b == null) return false;
    if (a.id != null && b.id != null) return a.id == b.id;
    return (a.name?.trim() ?? '') == (b.name?.trim() ?? '');
  }

  bool _isActiveEmployeeParty(PartyItem party) {
    final ed = party.employeeDetails;
    if (ed == null) return true;
    final byFlag = ed.isActive;
    if (byFlag != null) return byFlag;
    final status = ed.employmentStatus?.trim().toLowerCase();
    return status == 'active';
  }

  List<PartyItem> _filterPartiesForTab(List<PartyItem> raw, String tab) {
    var filtered = raw
        .where((p) => PartyPickerRoleHelper.partyMatchesTab(p.role, tab))
        .toList();
    if (tab.toLowerCase() == 'employee') {
      filtered = filtered.where(_isActiveEmployeeParty).toList();
    }
    return filtered;
  }

  int _countForTab(String tab) => _filterPartiesForTab(_allParties, tab).length;

  void _syncPendingSelectionFromLoadedParties() {
    final sel = widget.selectedPartyName?.trim();
    if (sel == null || sel.isEmpty || _pendingSelection != null) return;
    for (final party in _allParties) {
      if ((party.name?.trim() ?? '') == sel) {
        _pendingSelection = party;
        return;
      }
    }
  }

  void _syncPartiesCacheFromCubit(PartyState state) {
    state.maybeWhen(
      success: (response) {
        _allParties = response.data.data ?? const [];
        _syncPendingSelectionFromLoadedParties();
      },
      orElse: () {},
    );
  }

  Future<void> _openAddPartyEditorAndRefresh() async {
    final tabRole = _activePartyRole();
    if (!await gateFreemiumFeature(
      context,
      PartyPickerFreemium.featureForTab(tabRole),
      partyRole: PartyPickerFreemium.partyRoleForTab(tabRole),
    )) {
      return;
    }
    if (!mounted) return;

    final result = await context.router.push(
      PartyEditRoute(
        isEditing: false,
        presetRole: _activePartyRole().trim().toLowerCase(),
      ),
    );
    if (result == true && mounted) {
      _fetchParties(search: _lastSearchRequest);
    }
  }

  void _fetchParties({String? search}) {
    final effectiveSearch = search ??
        (_searchController.text.trim().isEmpty ? null : _searchController.text.trim());

    context.read<PartyCubit>().getParties(
          params: PartyRequestParams(
            page: 1,
            perPage: 500,
            search: (effectiveSearch == null || effectiveSearch.isEmpty) ? null : effectiveSearch,
            sortBy: 'name',
            sortOrder: 'asc',
          ),
        );
  }

  void _onTabSelected(int index) {
    if (index == _activeTabIndex) return;
    setState(() {
      _activeTabIndex = index;
      _pendingSelection = null;
    });
  }

  bool _isPartyLocked(PartyItem party, String tabRole) {
    final scope = FreemiumAccessScope.maybeOf(context);
    if (scope == null) return false;
    final key = PartyPickerFreemium.recordKeyForParty(party, tabRole);
    if (key.isEmpty) return false;
    return scope.isLocked(key);
  }

  void _onPartyTapped(PartyItem party) {
    final tabRole = _activePartyRole();
    if (_isPartyLocked(party, tabRole)) {
      unawaited(
        gateFreemiumFeature(
          context,
          PartyPickerFreemium.featureForTab(tabRole),
          partyRole: PartyPickerFreemium.partyRoleForTab(tabRole),
        ),
      );
      return;
    }
    setState(() => _pendingSelection = party);
  }

  void _onConfirm() {
    final party = _pendingSelection;
    if (party == null) return;
    final tabRole = _activePartyRole();
    if (_isPartyLocked(party, tabRole)) {
      unawaited(
        gateFreemiumFeature(
          context,
          PartyPickerFreemium.featureForTab(tabRole),
          partyRole: PartyPickerFreemium.partyRoleForTab(tabRole),
        ),
      );
      return;
    }
    widget.onSelect(party);
  }

  String _addNewLabel(BuildContext context) {
    final role = context.l10n.localizedPartyRoleName(_activePartyRole());
    return context.l10n.partyPickerAddNewRole(role.toLowerCase());
  }

  String _searchHint(BuildContext context) {
    final role = context.l10n.localizedPartyRoleName(_activePartyRole());
    return context.l10n.partyPickerSearchHint(role.toLowerCase());
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isTablet = PartyPickerLayout.isTablet(context);
    final screenH = MediaQuery.sizeOf(context).height;
    final sheetH = isTablet
        ? (screenH * 0.82).clamp(420.0, 680.0)
        : screenH * _sheetHeightFraction;
    final partyState = context.watch<PartyCubit>().state;
    _syncPartiesCacheFromCubit(partyState);

    final sheet = SizedBox(
      height: sheetH,
      child: _buildSheetBody(context, theme),
    );

    if (!isTablet) return sheet;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: PartyPickerLayout.tabletSheetMaxWidth,
          ),
          child: sheet,
        ),
      ),
    );
  }

  Widget _buildSheetBody(BuildContext context, ThemeData theme) {
    final scheme = theme.colorScheme;

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(PartyPickerLayout.sheetRadiusFor(context)),
      ),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: PartyPickerLayout.sz(context, 10, 10)),
            Center(
              child: Container(
                width: PartyPickerLayout.sz(context, 36, 36),
                height: PartyPickerLayout.sz(context, 4, 4),
                decoration: BoxDecoration(
                  color: scheme.outlineVariant.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(
                    PartyPickerLayout.sz(context, 999, 999),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                PartyPickerLayout.pageHorizontal(context),
                PartyPickerLayout.sz(context, 14, 14),
                PartyPickerLayout.pageHorizontal(context),
                0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.checkoutSelectParty,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: PartyPickerLayout.sp(context, 20, 20),
                            color: scheme.onSurface,
                          ),
                        ),
                        SizedBox(height: PartyPickerLayout.sz(context, 4, 4)),
                        Text(
                          context.l10n.partyPickerSubtitle,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: PartyPickerLayout.sp(context, 14, 14),
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: PartyPickerLayout.sz(context, 8, 8)),
                  Material(
                    color: scheme.surfaceContainerHighest,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        width: PartyPickerLayout.sz(context, 36, 36),
                        height: PartyPickerLayout.sz(context, 36, 36),
                        child: Icon(
                          Icons.close_rounded,
                          size: PartyPickerLayout.sp(context, 20, 20),
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PartyPickerSearchField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              hintText: _searchHint(context),
              onChanged: _onSearchChanged,
              onClear: _clearSearch,
            ),
            if (_rolesReady && _tabRoles.length > 1)
              SizedBox(
                height: PartyPickerLayout.chipRowHeight(context),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: PartyPickerLayout.pageHorizontal(context),
                  ),
                  itemCount: _tabRoles.length,
                  itemBuilder: (context, index) {
                    final role = _tabRoles[index];
                    return PartyPickerFilterChip(
                      label: context.l10n.localizedPartyRoleName(role),
                      count: _countForTab(role),
                      selected: index == _activeTabIndex,
                      onTap: () => _onTabSelected(index),
                    );
                  },
                ),
              ),
            if (_rolesReady && _tabRoles.length > 1)
              SizedBox(height: PartyPickerLayout.sectionGap(context)),
            Expanded(
              child: ColoredBox(
                color: PartyPickerLayout.pageBackground(scheme),
                child: !_rolesReady
                    ? const Center(child: CircularProgressIndicator())
                    : FreemiumAccessHost(
                        key: ValueKey(_activePartyRole()),
                        feature: PartyPickerFreemium.featureForTab(
                          _activePartyRole(),
                        ),
                        partyRole: PartyPickerFreemium.partyRoleForTab(
                          _activePartyRole(),
                        ),
                        child: BlocBuilder<PartyCubit, PartyState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            loading: () => const Center(child: CircularProgressIndicator()),
                            success: (response) {
                              final parties = response.data.data ?? <PartyItem>[];
                              final activeTab = _activePartyRole();
                              final list = _filterPartiesForTab(parties, activeTab);

                              if (list.isEmpty) {
                                final isSearch = _searchController.text.trim().isNotEmpty;
                                return ListView(
                                  children: [
                                    PartyPickerAddNewCard(
                                      label: _addNewLabel(context),
                                      onTap: _openAddPartyEditorAndRefresh,
                                    ),
                                    ListEmptyState(
                                      illustrationPath: AppEmptyStateAssets.party,
                                      title: isSearch
                                          ? context.l10n.partyPickerNoResultsFor(
                                              _searchController.text.trim(),
                                            )
                                          : context.l10n.partyPickerNoPartiesForRole(
                                              context.l10n
                                                  .localizedPartyRoleName(activeTab)
                                                  .toLowerCase(),
                                            ),
                                      padding: EdgeInsets.fromLTRB(
                                        PartyPickerLayout.sz(context, 24, 24),
                                        PartyPickerLayout.sz(context, 16, 16),
                                        PartyPickerLayout.sz(context, 24, 24),
                                        PartyPickerLayout.sz(context, 32, 32),
                                      ),
                                    ),
                                  ],
                                );
                              }

                              return ListView.builder(
                                padding: EdgeInsets.only(
                                  bottom: PartyPickerLayout.sz(context, 16, 16),
                                ),
                                itemCount: list.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return PartyPickerAddNewCard(
                                      label: _addNewLabel(context),
                                      onTap: _openAddPartyEditorAndRefresh,
                                    );
                                  }
                                  final party = list[index - 1];
                                  final (titleLine, subLine) = _partyTitleSubtitle(context, party);
                                  final initials = _partyAvatarInitials(party.name);
                                  final (bg, fg) = PartyPickerAvatarColors.forName(titleLine);
                                  final balance = party.outstandingAmount;
                                  final settled = (balance ?? 0).abs() < 0.01;
                                  final selected = _isSameParty(_pendingSelection, party);

                                  return FreemiumRecordGate(
                                    recordKey: PartyPickerFreemium.recordKeyForParty(
                                      party,
                                      activeTab,
                                    ),
                                    child: PartyPickerPartyTile(
                                    title: titleLine,
                                    subtitle: subLine,
                                    initials: initials,
                                    avatarBackground: bg,
                                    avatarForeground: fg,
                                    balanceLabel: partyPickerFormatBalance(
                                      context,
                                      balance,
                                      currencyCode: party.currency,
                                    ),
                                    balanceSettled: settled,
                                    selected: selected,
                                    onTap: () => _onPartyTapped(party),
                                  ),
                                  );
                                },
                              );
                            },
                            orElse: () => Center(
                              child: Text(
                                context.l10n.partyPickerLoadParties,
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              ),
            ),
            PartyPickerFooter(
              selectedName: _displayNameForParty(
                _pendingSelection != null &&
                        _isPartyLocked(_pendingSelection!, _activePartyRole())
                    ? null
                    : _pendingSelection,
              ),
              confirmLabel: context.l10n.confirm,
              enabled: _pendingSelection != null &&
                  !_isPartyLocked(_pendingSelection!, _activePartyRole()),
              onConfirm: _onConfirm,
            ),
          ],
        ),
      ),
    );
  }
}
