class RoleRequest {
  const RoleRequest({
    required this.name,
    this.description,
    this.sortOrder,
  });

  final String name;
  final String? description;
  final int? sortOrder;
}
