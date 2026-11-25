import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// iOS-style chevron for [AppBar.leading] — use app-wide for a consistent back control.
class AppBarIosBackButton extends StatelessWidget {
  const AppBarIosBackButton({
    super.key,
    this.onPressed,
    this.color,
    this.iconSize = 18,
  });

  final VoidCallback? onPressed;
  final Color? color;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final resolvedColor =
        color ?? IconTheme.of(context).color ?? Theme.of(context).colorScheme.onSurface;

    return IconButton(
      padding:  EdgeInsets.only(left: 10.sp),
      constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
      icon: Icon(Icons.arrow_back_ios, color: resolvedColor, size: iconSize),
      onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
    );
  }
}
