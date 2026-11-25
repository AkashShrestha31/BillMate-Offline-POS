class RoleItem {
  const RoleItem({
    required this.name,
    this.description,
    this.sortOrder = 0,
    this.isSystem = false,
    this.partyCount = 0,
  });

  final String name;
  final String? description;
  final int sortOrder;
  final bool isSystem;
  final int partyCount;
}
