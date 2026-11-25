import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/themes/app_colors.dart';
import 'package:intl/intl.dart';

/// Item image from list/detail API — absolute URL or path relative to [dotenv] `BASE_URL`.
String? resolveOrderItemImageUrl(String? raw) {
  final t = raw?.trim();
  if (t == null || t.isEmpty) return null;
  final lower = t.toLowerCase();
  if (lower.startsWith('http://') || lower.startsWith('https://')) return t;
  if (t.startsWith('//')) {
    try {
      final base = dotenv.env['BASE_URL']?.trim();
      if (base != null && base.isNotEmpty) {
        final schemeName = Uri.parse(base).scheme;
        if (schemeName.isNotEmpty) return '$schemeName:$t';
      }
    } catch (_) {}
    return 'https:$t';
  }
  final base = dotenv.env['BASE_URL']?.trim();
  if (base == null || base.isEmpty) return null;
  try {
    return Uri.parse(base).resolve(t).toString();
  } catch (_) {
    return null;
  }
}

/// Semantic color for `order_status` from the order API.
Color orderStatusColor(String? status, ColorScheme scheme) {
  switch (status) {
    case 'Created':
      return scheme.primary;
    case 'Accepted':
      return scheme.success;
    case 'Processing':
      return const Color(0xFF00838F);
    case 'Completed':
      return const Color(0xFF2E7D32);
    case 'Cancelled':
      return scheme.outline;
    default:
      return scheme.onSurfaceVariant;
  }
}

/// Verbose relative time, e.g. `9 hours 4 minutes ago`.
String? orderRelativeTimeVerbose(String? iso) {
  if (iso == null || iso.isEmpty) return null;
  final dt = DateTime.tryParse(iso);
  if (dt == null) return null;
  final diff = DateTime.now().difference(dt);
  final totalMinutes = diff.inMinutes;
  if (totalMinutes < 1) return 'Just now';
  final h = totalMinutes ~/ 60;
  final m = totalMinutes % 60;
  if (h > 0) return '$h hours $m minutes ago';
  return '$m minutes ago';
}

/// Backend ISO like `2026-05-04T08:23:12.123Z`
String? orderRelativeTime(String? iso) {
  if (iso == null || iso.isEmpty) return null;
  final dt = DateTime.tryParse(iso);
  if (dt == null) return null;
  final diff = DateTime.now().difference(dt);
  if (diff.inDays > 365) return '${(diff.inDays / 365).floor()} yrs ago';
  if (diff.inDays > 30) return '${(diff.inDays / 30).floor()} mo ago';
  if (diff.inDays > 0) return '${diff.inDays} d ago';
  if (diff.inHours > 0) return '${diff.inHours} hrs ago';
  if (diff.inMinutes > 0) return '${diff.inMinutes} min ago';
  return 'Just now';
}

String orderTypeLabel(String? orderType) {
  switch (orderType?.toLowerCase()) {
    case 'qot':
      return 'Kitchen (QOT)';
    case 'bot':
      return 'Bar (BOT)';
    default:
      return orderType ?? 'Order';
  }
}

String? formatOrderTimestamp(String? iso) {
  if (iso == null || iso.isEmpty) return null;
  final dt = DateTime.tryParse(iso);
  if (dt == null) return iso;
  return DateFormat('dd MMM yyyy hh:mm a').format(dt.toLocal());
}

/// Compact pill for list cards (no [ScreenUtil] so it is safe in tooltips / tests).
/// Uses `item_status` when present (`Pending` | `Preparing` | `Ready` | `Served`), else header `order_status`.
String dishLineStatusLabel(String? orderStatus) {
  switch (orderStatus) {
    case 'Completed':
      return 'Done';
    case 'Cancelled':
      return 'Cancelled';
    default:
      return 'Pending';
  }
}

String _dishLineDisplayLabel({String? lineItemStatus, String? orderStatus}) {
  final s = lineItemStatus?.trim();
  if (s != null && s.isNotEmpty) return s;
  return dishLineStatusLabel(orderStatus);
}

Color dishLineStatusColor(String? orderStatus) {
  switch (orderStatus) {
    case 'Completed':
      return const Color(0xFF2E7D32);
    case 'Cancelled':
      return const Color(0xFFB71C1C);
    default:
      return const Color(0xFFFFA000);
  }
}

Color _dishLineDisplayColor({String? lineItemStatus, String? orderStatus}) {
  switch (lineItemStatus?.trim()) {
    case 'Mixed':
      return const Color(0xFF6A1B9A);
    case 'Served':
      return const Color(0xFF2E7D32);
    case 'Ready':
      return const Color(0xFF1565C0);
    case 'Preparing':
      return const Color(0xFF00838F);
    case 'Pending':
      return const Color(0xFFFFA000);
    case '':
    case null:
      break;
    default:
      return dishLineStatusColor(orderStatus);
  }
  return dishLineStatusColor(orderStatus);
}

Widget dishLineStatusBadge(
  BuildContext context,
  String? orderStatus, {
  String? lineItemStatus,
}) {
  final label = _dishLineDisplayLabel(lineItemStatus: lineItemStatus, orderStatus: orderStatus);
  final c = _dishLineDisplayColor(lineItemStatus: lineItemStatus, orderStatus: orderStatus);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.sp),
      color: c.withOpacity(0.1),
      border: Border.all(color: c, width: 1.2),
    ),
    child: Text(
      label,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: c,
            fontWeight: FontWeight.w600,
          ),
    ),
  );
}

Widget orderStatusChip(BuildContext context, String? orderStatus) {
  final scheme = Theme.of(context).colorScheme;
  final c = orderStatusColor(orderStatus, scheme);
  final label = (orderStatus != null && orderStatus.isNotEmpty) ? orderStatus : '—';
  return Material(
    color: c.withValues(alpha: 0.12),
    borderRadius: BorderRadius.circular(4.sp),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: c,
              fontWeight: FontWeight.w600,
            ),
      ),
    ),
  );
}
