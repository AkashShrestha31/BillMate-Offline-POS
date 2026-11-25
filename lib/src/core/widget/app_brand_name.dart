import 'package:flutter/material.dart';
import 'package:hotel/src/core/config/app_platform_config.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

/// Styled app wordmark: prefix in black, suffix in primary.
class AppBrandName extends StatelessWidget {
  const AppBrandName({
    super.key,
    this.style,
    this.prefixColor,
    this.suffixColor,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final TextStyle? style;
  final Color? prefixColor;
  final Color? suffixColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  static String get brandPrefix => AppPlatformConfig.brandPrefix;

  static String get brandSuffix => AppPlatformConfig.brandSuffix;

  static String get brandFullName => AppPlatformConfig.appName;

  static Color defaultPrefixColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).colorScheme.onSurface
        : Colors.black;
  }

  static List<InlineSpan> spans(
    BuildContext context, {
    TextStyle? style,
    Color? prefixColor,
    Color? suffixColor,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final base = style ?? AppFonts.interStyle();

    return [
      TextSpan(
        text: brandPrefix,
        style: base.copyWith(
          color: prefixColor ?? defaultPrefixColor(context),
        ),
      ),
      TextSpan(
        text: brandSuffix,
        style: base.copyWith(color: suffixColor ?? scheme.primary),
      ),
    ];
  }

  static Widget rich(
    BuildContext context, {
    TextStyle? style,
    Color? prefixColor,
    Color? suffixColor,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text.rich(
      TextSpan(
        children: spans(
          context,
          style: style,
          prefixColor: prefixColor,
          suffixColor: suffixColor,
        ),
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// Replaces the first [brandName] occurrence in [text] with styled spans.
  static Widget replaceInText(
    BuildContext context, {
    required String text,
    required String brandName,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    if (brandName != brandFullName) {
      return Text(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    final index = text.indexOf(brandName);
    if (index < 0) {
      return Text(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    final before = text.substring(0, index);
    final after = text.substring(index + brandName.length);

    return Text.rich(
      TextSpan(
        style: style,
        children: [
          if (before.isNotEmpty) TextSpan(text: before),
          ...spans(context, style: style),
          if (after.isNotEmpty) TextSpan(text: after),
        ],
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return rich(
      context,
      style: style,
      prefixColor: prefixColor,
      suffixColor: suffixColor,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
