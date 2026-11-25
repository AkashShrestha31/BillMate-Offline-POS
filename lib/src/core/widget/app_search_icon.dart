import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel/src/core/constants/app_icons_string.dart';
import 'package:hotel/src/core/widget/input_prefix_icon_scope.dart';

/// App-wide search glyph from [AppIconsString.search] (replaces [Icons.search]).
class AppSearchIcon extends StatelessWidget {
  const AppSearchIcon({
    super.key,
    this.size = 22,
    this.color,
  });

  static const String assetPath = AppIconsString.search;

  final double size;
  final Color? color;

  Color _resolveColor(BuildContext context) {
    return InputPrefixIconScope.maybeColorOf(context) ??
        color ??
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
        semanticsLabel: 'Search',
        placeholderBuilder: (_) => _fallback(resolvedColor),
        errorBuilder: (_, __, ___) => _fallback(resolvedColor),
      ),
    );
  }

  Widget _fallback(Color resolvedColor) {
    return Icon(Icons.search_rounded, size: size, color: resolvedColor);
  }

  /// Use for [InputDecoration.prefixIcon] / [InputDecoration.suffixIcon].
  static Widget inputDecoration({
    Key? key,
    double size = 20,
    Color? color,
  }) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Center(
        child: AppSearchIcon(key: key, size: size, color: color),
      ),
    );
  }
}
