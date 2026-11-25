/// Models aligned with `hotel-royal-backend` `order/views.py` — list & detail JSON.

double? _doubleFromJson(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString());
}

int? _intFromJson(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toInt();
  return int.tryParse(v.toString());
}

class OrderItemModel {
  const OrderItemModel({
    this.name,
    this.item,
    this.description,
    this.unit,
    this.quantity,
    this.amount,
    this.idx,
    this.parent,
    this.remarks,
    this.itemStatus,
    this.imageUrl,
    this.parentSchemaName,
    this.parentFieldname,
  });

  /// Order line row id for API paths, e.g. `PATCH .../items/ab12cd-ef345678/status/`.
  /// This is **not** the menu label — see [item].
  final String? name;
  final String? item;
  final String? description;
  final String? unit;
  final double? quantity;
  final double? amount;
  final int? idx;
  final String? parent;

  /// Per-line remarks (API / DB column `remarks`).
  final String? remarks;

  /// `Pending` | `Preparing` | `Ready` | `Served` (`item_status` in JSON).
  final String? itemStatus;

  /// Optional item photo URL when the API includes it (`image` / `imageUrl`).
  final String? imageUrl;
  final String? parentSchemaName;
  final String? parentFieldname;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final rawImg = json['imageUrl'] ?? json['image'];
    final img = rawImg == null ? null : rawImg.toString().trim();
    return OrderItemModel(
      name: json['name'] as String? ?? json['item_name'] as String?,
      item: json['item'] as String?,
      description: json['description'] as String?,
      unit: json['unit'] as String?,
      quantity: _doubleFromJson(json['quantity']),
      amount: _doubleFromJson(json['amount']),
      idx: _intFromJson(json['idx']),
      parent: json['parent'] as String?,
      remarks: json['remarks'] as String?,
      itemStatus: json['item_status'] as String?,
      imageUrl: img == null || img.isEmpty ? null : img,
      parentSchemaName: json['parentSchemaName'] as String?,
      parentFieldname: json['parentFieldname'] as String?,
    );
  }

  /// Path segment for `PATCH /api/order/orders/{ord}/items/{this}/status/`.
  /// Example: `"name": "febcac-570cde1a"` — use that value, **never** `"item": "Bhatmas Sadeko"`.
  String? get orderLineIdForItemStatusPatch => name;
}

/// Combines [item_status] when merging lines for the same dish name.
String? _mergeOrderItemStatuses(String? a, String? b) {
  final x = a?.trim();
  final y = b?.trim();
  if (x == null || x.isEmpty) return y;
  if (y == null || y.isEmpty) return x;
  if (x == 'Mixed' || y == 'Mixed') return 'Mixed';
  if (x == y) return x;
  return 'Mixed';
}

/// Merges rows with the same menu name ([OrderItemModel.item], trimmed, case-insensitive).
/// Sums [quantity] and [amount]; keeps the first line’s spelling and fills missing image from later lines.
List<OrderItemModel> mergeOrderItemsByProductName(List<OrderItemModel> lines) {
  if (lines.isEmpty) return const [];
  final orderKeys = <String>[];
  final byKey = <String, OrderItemModel>{};
  for (final line in lines) {
    final rawName = (line.item ?? '').trim();
    if (rawName.isEmpty) continue;
    final key = rawName.toLowerCase();
    final prev = byKey[key];
    if (prev == null) {
      byKey[key] = line;
      orderKeys.add(key);
      continue;
    }
    byKey[key] = OrderItemModel(
      name: prev.name,
      item: prev.item ?? line.item,
      description: prev.description,
      unit: prev.unit ?? line.unit,
      quantity: (prev.quantity ?? 0) + (line.quantity ?? 0),
      amount: (prev.amount ?? 0) + (line.amount ?? 0),
      idx: prev.idx,
      parent: prev.parent,
      remarks: prev.remarks,
      itemStatus: _mergeOrderItemStatuses(prev.itemStatus, line.itemStatus),
      imageUrl: prev.imageUrl ?? line.imageUrl,
      parentSchemaName: prev.parentSchemaName,
      parentFieldname: prev.parentFieldname,
    );
  }
  return orderKeys.map((k) => byKey[k]!).toList();
}

/// One kitchen quote / ticket (`qots[]` from list API, or synthesized from flat [items]).
class OrderQotModel {
  const OrderQotModel({
    this.name,
    this.qotNo,
    this.qotStatus,
    this.assignedTo,
    this.netTotal,
    this.grandTotal,
    this.parent,
    this.items,
  });

  final String? name;
  final int? qotNo;

  /// `Created` | `Accepted` | `Processing` | `Completed` | `Cancelled`
  final String? qotStatus;

  /// Kitchen staff assignment for this QOT (`assigned_to` in JSON).
  final String? assignedTo;
  final double? netTotal;
  final double? grandTotal;
  final String? parent;
  final List<OrderItemModel>? items;

  factory OrderQotModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'];
    final at = json['assigned_to'] ?? json['assignedEmployee'];
    return OrderQotModel(
      name: json['name'] as String?,
      qotNo: _intFromJson(json['qot_no']),
      qotStatus: json['qot_status'] as String?,
      assignedTo: at is String ? at : at?.toString(),
      netTotal: _doubleFromJson(json['netTotal']),
      grandTotal: _doubleFromJson(json['grandTotal']),
      parent: json['parent'] as String?,
      items: rawItems is List
          ? rawItems
              .map((e) => OrderItemModel.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList()
          : null,
    );
  }

  double get displaySubtotal =>
      grandTotal ??
      netTotal ??
      (items?.fold<double>(0, (a, b) => a + (b.amount ?? 0)) ?? 0);

  int get dishCount => items?.length ?? 0;
}

List<OrderQotModel> _syntheticQotsFromFlatItems(
  List<OrderItemModel> items, {
  String? orderName,
}) {
  if (items.isEmpty) return [];
  final orderKey = (orderName ?? '').trim();
  final byParent = <String, List<OrderItemModel>>{};
  for (final line in items) {
    var p = (line.parent ?? '').trim();
    if (p.isEmpty || p == orderKey) {
      p = '__single__';
    }
    byParent.putIfAbsent(p, () => []).add(line);
  }
  final keys = byParent.keys.toList();
  keys.sort((a, b) {
    if (a == '__single__') return -1;
    if (b == '__single__') return 1;
    return a.compareTo(b);
  });
  var seq = 0;
  return keys.map((key) {
    final lines = byParent[key]!;
    seq += 1;
    final qotName = key == '__single__' ? null : key;
    return OrderQotModel(
      name: qotName,
      qotNo: seq,
      qotStatus: null,
      assignedTo: null,
      netTotal: null,
      grandTotal: lines.fold<double>(0, (a, b) => a + (b.amount ?? 0)),
      parent: orderName,
      items: lines,
    );
  }).toList();
}

/// One order header + items (`GET /api/order/orders/` row).
class OrderModel {
  const OrderModel({
    this.name,
    this.orderType,
    this.orderStatus,
    this.tableNumber,
    this.party,
    this.assignedEmployee,
    this.date,
    this.created,
    this.modified,
    this.notes,
    this.remarks,
    this.guestCount,
    this.netTotal,
    this.grandTotal,
    this.items,
    this.qots,
    this.totalItems,
    this.totalQuantity,
    this.totalAmount,
    this.salesInvoiceName,
    this.numberSeries,
    this.currency,
    this.exchangeRate,
    this.outstandingAmount,
    this.terms,
    this.submitted,
    this.cancelledFlag,
    this.createdBy,
    this.modifiedBy,
  });

  final String? name;

  /// `qot` | `bot`
  final String? orderType;

  /// `Created` | `Accepted` | `Processing` | `Completed` | `Cancelled`
  final String? orderStatus;

  /// Physical table / cabin Party identifier.
  final String? tableNumber;

  /// Billing party for SalesInvoice (optional on API; may duplicate table when omitted server-side).
  final String? party;
  final String? assignedEmployee;
  final String? date;
  final String? created;
  final String? modified;
  final String? notes;

  /// Order-level remarks (distinct from [notes] per API doc).
  final String? remarks;
  final int? guestCount;
  final double? netTotal;
  final double? grandTotal;
  final List<OrderItemModel>? items;

  /// Nested kitchen tickets when API sends `qots[]` (list/detail).
  final List<OrderQotModel>? qots;

  /// Present on list response only (computed server-side).
  final int? totalItems;
  final double? totalQuantity;
  final double? totalAmount;

  final String? salesInvoiceName;
  final String? numberSeries;
  final String? currency;
  final double? exchangeRate;
  final double? outstandingAmount;
  final String? terms;
  final int? submitted;
  final int? cancelledFlag;
  final String? createdBy;
  final String? modifiedBy;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<OrderQotModel>? qots;
    final rawQots = json['qots'];
    if (rawQots is List && rawQots.isNotEmpty) {
      qots = rawQots
          .map((e) => OrderQotModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    }

    List<OrderItemModel>? items;
    final rawItems = json['items'];
    if (rawItems is List) {
      if (rawItems.isNotEmpty) {
        items = rawItems
            .map((e) => OrderItemModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      } else if (qots != null && qots.isNotEmpty) {
        items = qots.expand((q) => q.items ?? const <OrderItemModel>[]).toList();
      } else {
        items = [];
      }
    } else if (qots != null && qots.isNotEmpty) {
      items = qots.expand((q) => q.items ?? const <OrderItemModel>[]).toList();
    }

    final assignedRaw = json['assigned_to'] ?? json['assignedEmployee'];
    final assignedStr = assignedRaw is String ? assignedRaw : assignedRaw?.toString();

    return OrderModel(
      name: json['name'] as String?,
      orderType: json['order_type'] as String?,
      orderStatus: json['order_status'] as String?,
      tableNumber: json['tableNumber'] as String?,
      party: json['party'] as String?,
      assignedEmployee: assignedStr,
      date: json['date'] as String?,
      created: json['created'] as String?,
      modified: json['modified'] as String?,
      notes: json['notes'] as String?,
      remarks: json['remarks'] as String?,
      guestCount: _intFromJson(json['guest_count']),
      netTotal: _doubleFromJson(json['netTotal']),
      grandTotal: _doubleFromJson(json['grandTotal']),
      items: items,
      qots: qots,
      totalItems: _intFromJson(json['total_items']),
      totalQuantity: _doubleFromJson(json['total_quantity']),
      totalAmount: _doubleFromJson(json['total_amount']),
      salesInvoiceName: json['sales_invoice_name'] as String?,
      numberSeries: json['numberSeries'] as String?,
      currency: json['currency'] as String?,
      exchangeRate: _doubleFromJson(json['exchangeRate']),
      outstandingAmount: _doubleFromJson(json['outstandingAmount']),
      terms: json['terms'] as String?,
      submitted: _intFromJson(json['submitted']),
      cancelledFlag: _intFromJson(json['cancelled_flag']),
      createdBy: json['createdBy'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
    );
  }

  /// Dish lines — prefers server `total_items`, else counts lines.
  int get dishLineCount => totalItems ?? (items?.length ?? 0);

  /// Total qty — prefers server aggregate.
  double get quantitySum =>
      totalQuantity ??
      (items?.fold<double>(0, (a, b) => a + (b.quantity ?? 0)) ?? 0);

  /// Amount — prefers list aggregate `total_amount`, else `grandTotal`.
  double get displayTotal => totalAmount ?? grandTotal ?? netTotal ?? 0;

  /// First non-empty per-QOT [OrderQotModel.assignedTo], else header [assignedEmployee] (list row / legacy).
  String? get primaryAssignedForList {
    final qs = qots;
    if (qs != null) {
      for (final q in qs) {
        final a = q.assignedTo?.trim();
        if (a != null && a.isNotEmpty) return a;
      }
    }
    final h = assignedEmployee?.trim();
    return (h != null && h.isNotEmpty) ? h : null;
  }

  /// Lines for Dishes / summaries — uses [items] when non-empty, otherwise merges [qots] lines.
  List<OrderItemModel> get allOrderLines {
    final i = items;
    if (i != null && i.isNotEmpty) return i;
    if (qots != null && qots!.isNotEmpty) {
      return qots!.expand((q) => q.items ?? const <OrderItemModel>[]).toList();
    }
    return i ?? const [];
  }

  /// Same dishes combined into one row with total qty/amount (for list + Dishes UI).
  List<OrderItemModel> get mergedOrderLinesByProduct =>
      mergeOrderItemsByProductName(allOrderLines);

  /// Tickets for the KOT tab: API `qots` when present, else one group per distinct line `parent`.
  List<OrderQotModel> get kitchenQotTickets {
    if (qots != null && qots!.isNotEmpty) {
      final list = [...qots!];
      list.sort((a, b) {
        final an = a.qotNo ?? 999999;
        final bn = b.qotNo ?? 999999;
        if (an != bn) return an.compareTo(bn);
        return (a.name ?? '').compareTo(b.name ?? '');
      });
      return list;
    }
    return _syntheticQotsFromFlatItems(items ?? [], orderName: name);
  }
}

class OrderPaginationModel {
  const OrderPaginationModel({
    this.currentPage,
    this.perPage,
    this.totalPages,
    this.totalRows,
    this.totalTables,
  });

  final int? currentPage;
  final int? perPage;
  final int? totalPages;
  final int? totalRows;

  /// List API: pagination by distinct tables (`total_tables` in JSON).
  final int? totalTables;

  factory OrderPaginationModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const OrderPaginationModel();
    return OrderPaginationModel(
      currentPage: _intFromJson(json['current_page']),
      perPage: _intFromJson(json['per_page']),
      totalPages: _intFromJson(json['total_pages']),
      totalRows: _intFromJson(json['total_rows']),
      totalTables: _intFromJson(json['total_tables']),
    );
  }
}

class OrderListResponse {
  const OrderListResponse({
    this.data,
    this.pagination,
    this.message,
  });

  final List<OrderModel>? data;
  final OrderPaginationModel? pagination;
  final String? message;

  factory OrderListResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('message') && json['data'] == null) {
      return OrderListResponse(message: json['message'] as String?);
    }
    final raw = json['data'];
    final list = _parseOrdersListPayload(raw);
    return OrderListResponse(
      data: list,
      pagination: OrderPaginationModel.fromJson(
        json['pagination'] as Map<String, dynamic>?,
      ),
    );
  }

  int get totalOrders =>
      pagination?.totalRows ?? pagination?.totalTables ?? data?.length ?? 0;
}

/// `GET /api/order/orders/` — each row is an order with optional nested `qots[] → items[]`.
/// Also supports legacy `{ "orders": [ … ] }` table-grouped payloads.
List<OrderModel> _parseOrdersListPayload(dynamic raw) {
  if (raw is! List || raw.isEmpty) return <OrderModel>[];

  final first = raw.first;
  if (first is Map && first['orders'] is List) {
    return _flattenTableGroupedOrderList(raw);
  }

  return raw
      .map((e) => OrderModel.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList();
}

List<OrderModel> _flattenTableGroupedOrderList(List<dynamic> tableGroups) {
  final out = <OrderModel>[];
  for (final group in tableGroups) {
    if (group is! Map) continue;
    final g = Map<String, dynamic>.from(group);
    final tableNum = g['tableNumber'] as String?;
    final ordersRaw = g['orders'];
    if (ordersRaw is! List) continue;

    for (final o in ordersRaw) {
      if (o is! Map) continue;
      final orderMap = Map<String, dynamic>.from(o);
      if (tableNum != null && tableNum.trim().isNotEmpty) {
        final existing = orderMap['tableNumber'] as String?;
        if (existing == null || existing.trim().isEmpty) {
          orderMap['tableNumber'] = tableNum;
        }
      }
      out.add(OrderModel.fromJson(orderMap));
    }
  }
  return out;
}

/// Derived row for the Table tab (no dedicated `/tables/` API — built from orders).
class OrderTableTileModel {
  const OrderTableTileModel({
    required this.name,
    required this.occupied,
    this.category,
  });

  final String name;
  final bool occupied;
  final String? category;
}
