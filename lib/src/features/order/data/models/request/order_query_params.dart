/// Query params for `GET /api/order/orders/` (hotel-royal-backend `OrderListCreateView`).
class OrderQueryParams {
  const OrderQueryParams({
    this.page,
    this.perPage,
    this.orderStatus,
    this.orderType,
    this.assignedEmployee,
    this.tableNumber,
    this.dateFrom,
    this.dateTo,
    this.search,
  });

  final int? page;
  final int? perPage;

  /// `Created` | `Accepted` | `Processing` | `Completed` | `Cancelled`
  final String? orderStatus;

  /// `qot` (kitchen) | `bot` (bar)
  final String? orderType;

  final String? assignedEmployee;
  final String? tableNumber;
  final String? dateFrom;
  final String? dateTo;
  final String? search;

  Map<String, String> toQueryParams() {
    final m = <String, String>{};
    if (page != null) m['page'] = '${page!}';
    if (perPage != null) m['per_page'] = '${perPage!}';
    if (orderStatus != null && orderStatus!.trim().isNotEmpty) {
      m['order_status'] = orderStatus!.trim();
    }
    if (orderType != null && orderType!.trim().isNotEmpty) {
      m['order_type'] = orderType!.trim();
    }
    if (assignedEmployee != null && assignedEmployee!.trim().isNotEmpty) {
      m['assigned_to'] = assignedEmployee!.trim();
    }
    if (tableNumber != null && tableNumber!.trim().isNotEmpty) {
      m['tableNumber'] = tableNumber!.trim();
    }
    if (dateFrom != null && dateFrom!.trim().isNotEmpty) {
      m['date_from'] = dateFrom!.trim();
    }
    if (dateTo != null && dateTo!.trim().isNotEmpty) {
      m['date_to'] = dateTo!.trim();
    }
    if (search != null && search!.trim().isNotEmpty) {
      m['search'] = search!.trim();
    }
    return m;
  }
}
