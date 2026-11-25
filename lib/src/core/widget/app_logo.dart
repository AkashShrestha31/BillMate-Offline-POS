import 'package:flutter/material.dart';
import 'package:hotel/src/core/config/app_platform_config.dart';

/// Shared BillMate logo (same artwork as the iOS home-screen icon).
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.errorIconSize = 64,
  });

  final double? height;
  final double? width;
  final BoxFit fit;
  final double errorIconSize;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppPlatformConfig.logoAsset,
      height: height,
      width: width,
      fit: fit,
      errorBuilder: (_, __, ___) => Icon(
        Icons.image_not_supported_outlined,
        size: errorIconSize,
        color: Colors.grey[400],
      ),
    );
  }
}
