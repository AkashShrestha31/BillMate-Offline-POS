import 'package:flutter/material.dart';
import 'package:hotel/src/core/config/app_platform_config.dart';

/// Splash illustration shared by iOS and Android.
class AppSplashImage extends StatelessWidget {
  const AppSplashImage({
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  final double? height;
  final double? width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final splashAsset = AppPlatformConfig.splashAsset;
    if (splashAsset == null) {
      return const SizedBox.shrink();
    }

    return Image.asset(
      splashAsset,
      height: height,
      width: width,
      fit: fit,
      errorBuilder: (_, __, ___) => Icon(
        Icons.image_not_supported_outlined,
        size: height ?? width ?? 64,
        color: Colors.grey[400],
      ),
    );
  }
}
