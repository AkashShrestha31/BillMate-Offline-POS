int? _intFromJson(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}

class OrderActivityResponse {
  const OrderActivityResponse({
    this.orderName,
    this.data = const [],
    this.pagination,
  });

  final String? orderName;
  final List<OrderActivityEntry> data;
  final OrderActivityPagination? pagination;

  factory OrderActivityResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    return OrderActivityResponse(
      orderName: json['order_name'] as String?,
      data: rawData is List
          ? rawData
              .whereType<Map>()
              .map((e) => OrderActivityEntry.fromJson(Map<String, dynamic>.from(e)))
              .toList()
          : const [],
      pagination: json['pagination'] is Map
          ? OrderActivityPagination.fromJson(Map<String, dynamic>.from(json['pagination'] as Map))
          : null,
    );
  }
}

class OrderActivityEntry {
  const OrderActivityEntry({
    this.id,
    this.orderName,
    this.action,
    this.field,
    this.oldValue,
    this.newValue,
    this.performedBy,
    this.timestamp,
  });

  final int? id;
  final String? orderName;
  final String? action;
  final String? field;
  final String? oldValue;
  final String? newValue;
  final String? performedBy;
  final String? timestamp;

  factory OrderActivityEntry.fromJson(Map<String, dynamic> json) {
    return OrderActivityEntry(
      id: _intFromJson(json['id']),
      orderName: json['order_name'] as String?,
      action: json['action'] as String?,
      field: json['field'] as String?,
      oldValue: json['old_value']?.toString(),
      newValue: json['new_value']?.toString(),
      performedBy: json['performed_by'] as String?,
      timestamp: json['timestamp'] as String?,
    );
  }
}

class OrderActivityPagination {
  const OrderActivityPagination({
    this.currentPage,
    this.perPage,
    this.totalPages,
    this.totalRows,
  });

  final int? currentPage;
  final int? perPage;
  final int? totalPages;
  final int? totalRows;

  factory OrderActivityPagination.fromJson(Map<String, dynamic> json) {
    return OrderActivityPagination(
      currentPage: _intFromJson(json['current_page']),
      perPage: _intFromJson(json['per_page']),
      totalPages: _intFromJson(json['total_pages']),
      totalRows: _intFromJson(json['total_rows']),
    );
  }
}
