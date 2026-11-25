import 'package:flutter/material.dart';
import 'package:hotel/src/core/helpers/item_image_helper.dart';

/// Displays an employee profile photo from SQLite (base64 data URI, local path,
/// or http URL) with an initials fallback.
class EmployeeProfileAvatar extends StatelessWidget {
  const EmployeeProfileAvatar({
    super.key,
    required this.profileImage,
    required this.initial,
    this.radius = 24,
    this.backgroundColor,
    this.initialStyle,
  });

  final String? profileImage;
  final String initial;
  final double radius;
  final Color? backgroundColor;
  final TextStyle? initialStyle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = backgroundColor ?? scheme.surfaceContainerHighest;
    final hasImage = ItemImageHelper.hasDisplayableImage(profileImage);
    final provider = ItemImageHelper.imageProvider(profileImage);

    return CircleAvatar(
      radius: radius,
      backgroundColor: hasImage ? Colors.transparent : bg,
      backgroundImage: provider,
      child: hasImage
          ? null
          : Text(
              initial.isNotEmpty ? initial[0].toUpperCase() : '?',
              style: initialStyle ??
                  Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
            ),
    );
  }
}
