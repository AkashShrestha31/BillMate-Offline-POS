/// Query for `GET /api/analytics/payment-methods/`.
class PaymentMethodsQuery {
  const PaymentMethodsQuery({
    this.q,
    this.type,
  });

  final String? q;
  final String? type;

  Map<String, String> toQueryParameters() {
    final m = <String, String>{};
    final qq = q?.trim();
    if (qq != null && qq.isNotEmpty) m['q'] = qq;
    final tt = type?.trim();
    if (tt != null && tt.isNotEmpty) m['type'] = tt;
    return m;
  }
}
