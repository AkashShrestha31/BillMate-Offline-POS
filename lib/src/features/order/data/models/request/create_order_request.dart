/// POST `/api/order/orders/` — hotel-royal-backend `OrderListCreateView.post`.

class CreateOrderLineRequest {
  const CreateOrderLineRequest({
    required this.item,
    this.quantity,
    this.unit,
    this.description,
    this.remarks,
    this.itemStatus,
    this.parent,
  });

  final String item;
  final double? quantity;
  final String? unit;
  final String? description;

  /// Per-item special instructions (`order_api_documentation` / backend `_ITEM_SCHEMA.remarks`).
  final String? remarks;

  /// `Pending` | `Preparing` | `Ready` | `Served` (optional on create).
  final String? itemStatus;

  /// Parent QOT name when attaching to an existing ticket (`orderqot.name`).
  final String? parent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'item': item};
    if (quantity != null) map['quantity'] = quantity;
    if (unit != null && unit!.isNotEmpty) map['unit'] = unit;
    if (description != null && description!.isNotEmpty) map['description'] = description;
    if (remarks != null && remarks!.isNotEmpty) map['remarks'] = remarks;
    if (itemStatus != null && itemStatus!.trim().isNotEmpty) {
      map['item_status'] = itemStatus!.trim();
    }
    if (parent != null && parent!.trim().isNotEmpty) map['parent'] = parent!.trim();
    return map;
  }
}

class CreateOrderRequest {
  const CreateOrderRequest({
    required this.tableNumber,
    required this.items,
    this.orderType = 'qot',
    this.party,
    this.assignedEmployee,
    this.date,
    this.notes,
    this.remarks,
    this.guestCount,
    this.numberSeries,
    this.createdBy,
    this.modifiedBy,
  });

  final String tableNumber;
  final List<CreateOrderLineRequest> items;

  /// `qot` | `bot`
  final String orderType;

  /// Billing party name on SalesInvoice; must exist in Party table. Server falls back to [tableNumber] if omitted.
  final String? party;

  final String? assignedEmployee;
  final String? date;

  /// Free-text notes (optional).
  final String? notes;

  /// Order-level remarks / special instructions (optional; separate from [notes] per API doc).
  final String? remarks;

  /// Sent as `guest_count` (default 0 on server if omitted).
  final int? guestCount;
  final String? numberSeries;
  final String? createdBy;
  final String? modifiedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'tableNumber': tableNumber,
      'order_type': orderType,
      'items': items.map((e) => e.toJson()).toList(),
    };
    if (party != null && party!.trim().isNotEmpty) {
      map['party'] = party!.trim();
    }
    if (assignedEmployee != null && assignedEmployee!.trim().isNotEmpty) {
      map['assigned_to'] = assignedEmployee!.trim();
    }
    if (date != null) map['date'] = date;
    if (notes != null && notes!.trim().isNotEmpty) map['notes'] = notes!.trim();
    if (remarks != null && remarks!.trim().isNotEmpty) map['remarks'] = remarks!.trim();
    if (guestCount != null) map['guest_count'] = guestCount;
    if (numberSeries != null) map['numberSeries'] = numberSeries;
    if (createdBy != null) map['createdBy'] = createdBy;
    if (modifiedBy != null) map['modifiedBy'] = modifiedBy;
    return map;
  }
}
