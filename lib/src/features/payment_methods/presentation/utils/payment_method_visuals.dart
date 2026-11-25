import 'package:flutter/material.dart';

/// Icon + color for a payment method (from name and type).
class PaymentMethodVisual {
  const PaymentMethodVisual({
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final Color color;
}

enum _PaymentKind { cash, bank, qr, transfer, cheque, card, other }

_PaymentKind _resolveKind({required String name, required String type}) {
  final n = name.trim().toLowerCase();
  final t = type.trim().toLowerCase();
  bool has(String s) => n.contains(s) || t.contains(s);

  if (has('cash')) return _PaymentKind.cash;
  if (has('qr') || has('fonepay') || has('esewa') || has('khalti')) return _PaymentKind.qr;
  if (has('transfer') || has('wire')) return _PaymentKind.transfer;
  if (has('cheque') || has('check')) return _PaymentKind.cheque;
  if (has('bank')) return _PaymentKind.bank;
  if (has('card')) return _PaymentKind.card;
  return _PaymentKind.other;
}

PaymentMethodVisual paymentMethodVisual({
  required String name,
  required String type,
}) {
  switch (_resolveKind(name: name, type: type)) {
    case _PaymentKind.cash:
      return const PaymentMethodVisual(
        icon: Icons.payments_outlined,
        color: Color(0xFF2E7D32),
      );
    case _PaymentKind.bank:
      return const PaymentMethodVisual(
        icon: Icons.account_balance_outlined,
        color: Color(0xFF1565C0),
      );
    case _PaymentKind.qr:
      return const PaymentMethodVisual(
        icon: Icons.qr_code_2_outlined,
        color: Color(0xFF6A1B9A),
      );
    case _PaymentKind.transfer:
      return const PaymentMethodVisual(
        icon: Icons.swap_horiz_outlined,
        color: Color(0xFFEF6C00),
      );
    case _PaymentKind.cheque:
      return const PaymentMethodVisual(
        icon: Icons.receipt_long_outlined,
        color: Color(0xFF5D4037),
      );
    case _PaymentKind.card:
      return const PaymentMethodVisual(
        icon: Icons.credit_card_outlined,
        color: Color(0xFF00838F),
      );
    case _PaymentKind.other:
      return const PaymentMethodVisual(
        icon: Icons.account_balance_wallet_outlined,
        color: Color(0xFF607D8B),
      );
  }
}
