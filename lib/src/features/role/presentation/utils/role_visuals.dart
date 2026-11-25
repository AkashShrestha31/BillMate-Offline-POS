import 'package:flutter/material.dart';

class RoleVisual {
  const RoleVisual({required this.icon, required this.color});

  final IconData icon;
  final Color color;
}

RoleVisual roleVisual(String name) {
  switch (name.toLowerCase()) {
    case 'customer':
      return const RoleVisual(icon: Icons.person_outline, color: Color(0xFF2E7D32));
    case 'supplier':
      return const RoleVisual(
        icon: Icons.local_shipping_outlined,
        color: Color(0xFF1565C0),
      );
    case 'both':
      return const RoleVisual(icon: Icons.swap_horiz, color: Color(0xFF6A1B9A));
    case 'employee':
      return const RoleVisual(icon: Icons.badge_outlined, color: Color(0xFFEF6C00));
    case 'room':
      return const RoleVisual(icon: Icons.hotel_outlined, color: Color(0xFF00838F));
    case 'cabin':
      return const RoleVisual(icon: Icons.cabin_outlined, color: Color(0xFF5D4037));
    default:
      return const RoleVisual(icon: Icons.label_outline, color: Color(0xFF616161));
  }
}
