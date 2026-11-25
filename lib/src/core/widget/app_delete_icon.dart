import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel/src/core/constants/app_icons_string.dart';

/// App-wide delete/trash glyph from the Figma Lets Icons pack
/// (replaces [Icons.delete] / [Icons.delete_outline]).
class AppDeleteIcon extends StatelessWidget {
  const AppDeleteIcon({
    super.key,
    this.size = 22,
    this.color,
  });

  static const String assetPath = AppIconsString.delete;

  final double size;
  final Color? color;

  Color _resolveColor(BuildContext context) {
    return color ??
        IconTheme.of(context).color ??
        Theme.of(context).colorScheme.onSurfaceVariant;
  }

  @override
  Widget build(BuildContext context) {
    final resolvedColor = _resolveColor(context);
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        assetPath,
        width: size,
        height: size,
        fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(resolvedColor, BlendMode.srcIn),
        semanticsLabel: 'Delete',
        placeholderBuilder: (_) => _fallback(resolvedColor),
        errorBuilder: (_, __, ___) => _fallback(resolvedColor),
      ),
    );
  }

  Widget _fallback(Color resolvedColor) {
    return Icon(Icons.delete_outline_rounded, size: size, color: resolvedColor);
  }
}
