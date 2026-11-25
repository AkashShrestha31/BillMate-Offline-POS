/// Body for `PATCH /api/order/orders/{order}/qots/{qot_name}/` — optional [notes] and [assigned_to].
class UpdateQotRequestParams {
  const UpdateQotRequestParams({
    required this.orderName,
    required this.qotName,
    this.notes,
    this.assignedTo,
  });

  final String orderName;
  final String qotName;

  /// Maps to JSON `notes`.
  final String? notes;

  /// Free-text kitchen staff name on this QOT; maps to JSON `assigned_to`.
  final String? assignedTo;

  Map<String, dynamic> toJson() {
    final m = <String, dynamic>{};
    final n = notes?.trim();
    if (n != null && n.isNotEmpty) m['notes'] = n;
    if (assignedTo != null) m['assigned_to'] = assignedTo!.trim();
    return m;
  }
}
