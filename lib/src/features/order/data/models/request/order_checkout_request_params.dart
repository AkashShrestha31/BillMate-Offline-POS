import 'package:intl/intl.dart';

/// `POST /api/order/orders/{name}/checkout/` — hotel-royal-backend order checkout.
class OrderCheckoutPaymentLine {
  const OrderCheckoutPaymentLine({
    required this.amount,
    required this.paymentMethod,
    this.paymentDate,
    this.referenceId,
    this.clearanceDate,
  });

  final double amount;
  final String paymentMethod;
  final String? paymentDate;
  final String? referenceId;
  final String? clearanceDate;

  Map<String, dynamic> toJson() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final d = paymentDate?.trim();
    final m = <String, dynamic>{
      'amount': amount,
      'payment_method': paymentMethod,
      'payment_date': (d != null && d.isNotEmpty) ? d : today,
    };
    final r = referenceId?.trim();
    if (r != null && r.isNotEmpty) m['reference_id'] = r;
    final c = clearanceDate?.trim();
    if (c != null && c.isNotEmpty) m['clearance_date'] = c;
    return m;
  }
}

class OrderCheckoutRequestParams {
  const OrderCheckoutRequestParams({
    required this.orderName,
    this.party,
    this.partyId,
    this.account = 'Debtors',
    this.modifiedBy,
    this.paymentMode = true,
    this.discountAmount,
    this.discountPercent,
    this.paymentSingle,
    this.paymentMultiple,
  });

  final String orderName;
  /// Billing party **name** (e.g. employee or legacy). Omit when [partyId] is set.
  final String? party;
  /// Party master id — sent as JSON `party` (integer) when non-null.
  final int? partyId;
  /// Ledger / receivable account label (default `Debtors`).
  final String account;
  final String? modifiedBy;
  final bool paymentMode;
  final double? discountAmount;
  final double? discountPercent;
  final OrderCheckoutPaymentLine? paymentSingle;
  final List<OrderCheckoutPaymentLine>? paymentMultiple;

  Map<String, dynamic> toJson() {
    final m = <String, dynamic>{
      'payment_mode': paymentMode,
      'account': account.trim().isNotEmpty ? account.trim() : 'Debtors',
    };
    final id = partyId;
    if (id != null) {
      m['party'] = id;
    } else {
      final p = party?.trim();
      if (p != null && p.isNotEmpty) m['party'] = p;
    }
    final mb = modifiedBy?.trim();
    if (mb != null && mb.isNotEmpty) m['modifiedBy'] = mb;
    final da = discountAmount;
    if (da != null && da > 0) {
      m['discountAmount'] = da;
    } else {
      final dp = discountPercent;
      if (dp != null && dp > 0) m['discountPercent'] = dp;
    }
    if (!paymentMode) {
      m['payment'] = null;
    } else if (paymentMultiple != null && paymentMultiple!.isNotEmpty) {
      m['payment'] = paymentMultiple!.map((e) => e.toJson()).toList();
    } else if (paymentSingle != null) {
      m['payment'] = paymentSingle!.toJson();
    } else {
      m['payment'] = null;
    }
    return m;
  }
}
