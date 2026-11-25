import 'package:hotel/src/features/role/data/models/role_item.dart';

/// Maps [Role] master data to party picker tabs and party list filters.
class PartyPickerRoleHelper {
  PartyPickerRoleHelper._();

  static const bothRoleName = 'Both';

  static bool isBothRole(String role) =>
      role.trim().toLowerCase() == bothRoleName.toLowerCase();

  /// DB/API filter for the active tab (includes [Both] on customer & supplier tabs).
  static List<String> queryRolesForTab(String tabRole) {
    final lower = tabRole.trim().toLowerCase();
    if (lower == 'customer') return ['customer', 'both'];
    if (lower == 'supplier') return ['supplier', 'both'];
    return [lower];
  }

  static bool partyMatchesTab(String? partyRole, String tabRole) {
    final p = (partyRole ?? '').trim().toLowerCase();
    final t = tabRole.trim().toLowerCase();
    if (p.isEmpty) return false;
    if (p == t) return true;
    if (p == 'both') return t == 'customer' || t == 'supplier';
    return false;
  }

  /// Tab labels for the Parties list screen (all configured roles, scrollable).
  static List<String> tabLabelsForPartyList({required List<RoleItem> dbRoles}) {
    return tabLabelsForPicker(
      dbRoles: dbRoles,
      customerOnly: false,
      supplierOnly: false,
      roomAndCabinOnly: false,
      supplierIncludeEmployeeTab: false,
    );
  }

  /// Tab labels for [PartyPickerSheet] from configured roles.
  static List<String> tabLabelsForPicker({
    required List<RoleItem> dbRoles,
    required bool customerOnly,
    required bool supplierOnly,
    required bool roomAndCabinOnly,
    required bool supplierIncludeEmployeeTab,
  }) {
    final ordered = List<RoleItem>.from(dbRoles)
      ..sort((a, b) {
        final c = a.sortOrder.compareTo(b.sortOrder);
        return c != 0 ? c : a.name.compareTo(b.name);
      });
    final names = ordered.map((r) => r.name).toList();

    if (customerOnly) {
      return names.where(_isCustomerSideRoleName).toList();
    }
    if (supplierOnly) {
      return names.where(_isSupplierSideRoleName).toList();
    }
    if (supplierIncludeEmployeeTab) {
      final tabs = <String>[];
      for (final n in names) {
        if (_isSupplierSideRoleName(n) && n.toLowerCase() != 'both') {
          tabs.add(n);
        }
      }
      if (!tabs.any((n) => n.toLowerCase() == 'supplier')) {
        tabs.insert(0, 'Supplier');
      }
      final employee = names.where((n) => n.toLowerCase() == 'employee').toList();
      if (employee.isNotEmpty) {
        tabs.add(employee.first);
      } else {
        tabs.add('Employee');
      }
      return tabs;
    }
    if (roomAndCabinOnly) {
      final roomCabin = names
          .where((n) {
            final l = n.toLowerCase();
            return l == 'room' || l == 'cabin' || l == 'employee';
          })
          .toList();
      if (roomCabin.isNotEmpty) return roomCabin;
      return const ['Employee'];
    }
    if (names.isNotEmpty) {
      return _tabsWithoutRedundantBoth(names);
    }
    return const ['Customer', 'Supplier', 'Employee'];
  }

  /// [Both] is not its own tab when Customer and Supplier exist — those parties
  /// appear on both of those tabs instead.
  static List<String> _tabsWithoutRedundantBoth(List<String> names) {
    final hasCustomer = names.any((n) => n.toLowerCase() == 'customer');
    final hasSupplier = names.any((n) => n.toLowerCase() == 'supplier');
    if (hasCustomer && hasSupplier) {
      return names.where((n) => !isBothRole(n)).toList();
    }
    return names;
  }

  static bool _isCustomerSideRoleName(String name) {
    final l = name.toLowerCase();
    return l != 'supplier';
  }

  static bool _isSupplierSideRoleName(String name) {
    final l = name.toLowerCase();
    return l == 'supplier' || l == 'both';
  }

  static int initialTabIndex({
    required List<String> tabs,
    required String role,
  }) {
    if (tabs.isEmpty) return 0;
    final want = role.trim().toLowerCase();
    final idx = tabs.indexWhere((t) => t.toLowerCase() == want);
    return idx >= 0 ? idx : 0;
  }
}
