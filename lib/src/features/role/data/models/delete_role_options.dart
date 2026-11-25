/// Options when deleting a role that still has parties assigned.
class DeleteRoleOptions {
  const DeleteRoleOptions({
    this.transferPartiesToRole,
    this.deleteAssociatedParties = false,
  }) : assert(
          transferPartiesToRole == null || !deleteAssociatedParties,
          'Use either transfer or hard delete, not both',
        );

  /// Move all parties on [name] to this role, then delete [name].
  final String? transferPartiesToRole;

  /// Delete all parties on [name], then delete [name]. Irreversible.
  final bool deleteAssociatedParties;
}
