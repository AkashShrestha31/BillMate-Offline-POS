/// Built-in party roles that cannot be edited or deleted.
class ProtectedPartyRoles {
  ProtectedPartyRoles._();

  static const names = {
    'customer',
    'supplier',
    'both',
    'employee',
  };

  static bool isProtected(String roleName) =>
      names.contains(roleName.trim().toLowerCase());
}
