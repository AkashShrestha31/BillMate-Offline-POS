import 'package:hotel/src/core/config/app_platform_config.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// PDF app wordmark: prefix in black, suffix in [trackColor].
abstract final class AppBrandNamePdf {
  static String get prefix => AppPlatformConfig.brandPrefix;

  static String get suffix => AppPlatformConfig.brandSuffix;

  static String get fullName => AppPlatformConfig.appName;

  static pw.Widget text({
    required pw.TextStyle style,
    PdfColor prefixColor = PdfColors.black,
    required PdfColor trackColor,
  }) {
    return pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: prefix,
            style: style.copyWith(color: prefixColor),
          ),
          pw.TextSpan(
            text: suffix,
            style: style.copyWith(color: trackColor),
          ),
        ],
      ),
    );
  }

  static pw.Widget replaceInText({
    required String text,
    required String brandName,
    required pw.TextStyle style,
    PdfColor prefixColor = PdfColors.black,
    required PdfColor trackColor,
  }) {
    if (brandName != fullName) {
      return pw.Text(text, style: style);
    }

    final index = text.indexOf(brandName);
    if (index < 0) {
      return pw.Text(text, style: style);
    }

    final before = text.substring(0, index);
    final after = text.substring(index + brandName.length);

    return pw.RichText(
      text: pw.TextSpan(
        style: style,
        children: [
          if (before.isNotEmpty) pw.TextSpan(text: before),
          pw.TextSpan(
            text: prefix,
            style: style.copyWith(color: prefixColor),
          ),
          pw.TextSpan(
            text: suffix,
            style: style.copyWith(color: trackColor),
          ),
          if (after.isNotEmpty) pw.TextSpan(text: after),
        ],
      ),
    );
  }
}
