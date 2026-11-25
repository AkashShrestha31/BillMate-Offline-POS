/// Orders tables for restore import (parents before children when possible).
class TableImportOrder {
  TableImportOrder._();

  static const _priority = [
    'Currency',
    'Tax',
    'NumberSeries',
    'Role',
    'Category',
    'Batch',
    'Color',
    'Address',
    'Account',
    'ItemGroup',
    'Location',
    'Party',
    'Item',
    'Employee',
    'LeaveType',
    'LiquorCategory',
    'LiquorItem',
    'LiquorPricing',
    'SalesInvoice',
    'PurchaseInvoice',
    'Payment',
    'JournalEntry',
    'SingleValue',
  ];

  static List<String> sort(Iterable<String> tables) {
    final remaining = tables.map((t) => t.trim()).where((t) => t.isNotEmpty).toSet();
    final ordered = <String>[];
    for (final table in _priority) {
      if (remaining.remove(table)) ordered.add(table);
    }
    final tail = remaining.toList()..sort();
    ordered.addAll(tail);
    return ordered;
  }
}
