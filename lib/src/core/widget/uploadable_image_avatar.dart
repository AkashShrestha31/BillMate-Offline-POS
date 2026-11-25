import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotel/src/core/helpers/item_image_helper.dart';

/// Tap-to-upload avatar with optional clear control.
class UploadableImageAvatar extends StatelessWidget {
  const UploadableImageAvatar({
    super.key,
    required this.localPathNotifier,
    required this.userRemovedNotifier,
    required this.storedImage,
    required this.onPick,
    this.onChanged,
    this.size = 88,
    this.borderRadius = 44,
    this.circular = false,
    this.placeholderIcon = Icons.person_outline,
    this.placeholderLabel,
  });

  final ValueNotifier<String?> localPathNotifier;
  final ValueNotifier<bool> userRemovedNotifier;
  final String? storedImage;
  final VoidCallback onPick;
  final VoidCallback? onChanged;
  final double size;
  final double borderRadius;
  final bool circular;
  final IconData placeholderIcon;
  final String? placeholderLabel;

  double get _radius => circular ? size / 2 : borderRadius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ValueListenableBuilder<String?>(
      valueListenable: localPathNotifier,
      builder: (context, localPath, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: userRemovedNotifier,
          builder: (context, removed, __) {
            final hasLocal = localPath != null && localPath.isNotEmpty;
            final hasStored =
                !removed && ItemImageHelper.hasDisplayableImage(storedImage);
            final hasDisplay = hasLocal || hasStored;

            return Column(
              children: [
                GestureDetector(
                  onTap: onPick,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      if (!hasDisplay)
                        CustomPaint(
                          size: Size.square(size),
                          painter: _DottedAvatarPainter(
                            color: scheme.outline,
                            radius: _radius,
                          ),
                          child: SizedBox(
                            width: size,
                            height: size,
                            child: Center(
                              child: Icon(
                                placeholderIcon,
                                size: size * 0.36,
                                color: scheme.onSurfaceVariant
                                    .withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            color: scheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(_radius),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: hasLocal
                              ? Image.file(
                                  File(localPath),
                                  fit: BoxFit.cover,
                                  width: size,
                                  height: size,
                                )
                              : ItemImageHelper.buildImage(
                                  storedImage,
                                  fit: BoxFit.cover,
                                  width: size,
                                  height: size,
                                ),
                        ),
                      if (hasDisplay)
                        Positioned(
                          top: -2,
                          left: -2,
                          child: GestureDetector(
                            onTap: () {
                              localPathNotifier.value = null;
                              userRemovedNotifier.value = true;
                              onChanged?.call();
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 1.5),
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: scheme.surface, width: 2),
                          ),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            size: size * 0.18,
                            color: scheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (placeholderLabel != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    placeholderLabel!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            );
          },
        );
      },
    );
  }
}

class _DottedAvatarPainter extends CustomPainter {
  const _DottedAvatarPainter({
    required this.color,
    required this.radius,
  });

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    const dash = 4.0;
    const gap = 3.5;
    final inset = paint.strokeWidth / 2;
    final rect = Rect.fromLTWH(
      inset,
      inset,
      size.width - paint.strokeWidth,
      size.height - paint.strokeWidth,
    );
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = (distance + dash).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DottedAvatarPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
