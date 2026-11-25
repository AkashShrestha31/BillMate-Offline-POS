/// Body for `POST` / `PUT` `/api/analytics/payment-methods/`.
class PaymentMethodRequest {
  const PaymentMethodRequest({
    required this.name,
    required this.type,
    this.account,
  });

  final String name;
  final String type;
  final String? account;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'name': name.trim(),
      'type': type.trim(),
    };
    final acct = account?.trim();
    if (acct != null && acct.isNotEmpty) {
      map['account'] = acct;
    }
    return map;
  }
}
