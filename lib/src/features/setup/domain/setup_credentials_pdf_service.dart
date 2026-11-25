import 'dart:io';
import 'dart:typed_data';

import 'package:hotel/src/core/config/app_platform_config.dart';
import 'package:hotel/src/core/helpers/app_brand_name_pdf.dart';
import 'package:hotel/src/core/l10n/default_l10n.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/setup/data/models/setup_complete_request.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// PDF with organization and admin login details after first-time setup.
class SetupCredentialsPdfService {
  SetupCredentialsPdfService._();

  static Future<Uint8List> buildPdfBytes(SetupCompleteRequest request) async {
    final generated = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              AppBrandNamePdf.text(
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
                trackColor: PdfColors.green800,
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Organization login credentials',
                style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                'Generated: $generated',
                style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
              ),
              pw.SizedBox(height: 24),
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey400),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  children: [
                    _row('Organization name', request.organizationName),
                    _divider(),
                    _row('Organization code', request.organizationCode),
                    _divider(),
                    _row('Company name', request.companyName),
                    _divider(),
                    _row(
                      'Business type',
                      defaultL10n.businessTypeLabel(request.businessType),
                    ),
                    _divider(),
                    _row('Admin name', request.fullName),
                    _divider(),
                    _row('Login email', request.email),
                    _divider(),
                    _row('Password', request.password),
                  ],
                ),
              ),
              pw.SizedBox(height: 24),
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                color: PdfColors.amber50,
                child: pw.Text(
                  'Keep this document confidential. Store it offline in a secure location. '
                  'Do not share by email or messaging apps unless encrypted.',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.amber900,
                    lineSpacing: 1.4,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  static pw.Widget _row(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 8),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 2,
            child: pw.Text(
              label,
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.grey800,
              ),
            ),
          ),
          pw.Expanded(
            flex: 3,
            child: pw.Text(
              value,
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _divider() => pw.Divider(color: PdfColors.grey300, height: 1);

  static Future<File> saveToFile(SetupCompleteRequest request) async {
    final bytes = await buildPdfBytes(request);
    final safeCode = request.organizationCode.replaceAll(RegExp(r'[^\w\-]+'), '_');
    final fileName =
        '${AppPlatformConfig.credentialsFilePrefix}_${safeCode}_login_credentials.pdf';
    final targetDir = await _downloadDirectory();
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }
    final file = File('${targetDir.path}/$fileName');
    if (await file.exists()) {
      await file.delete();
    }
    await file.writeAsBytes(bytes);
    return file;
  }

  /// Saves login credentials PDF to Downloads/Documents without opening share UI.
  static Future<File> downloadCredentials(SetupCompleteRequest request) async {
    return saveToFile(request);
  }

  static Future<Directory> _downloadDirectory() async {
    if (Platform.isAndroid) {
      final primary = Directory('/storage/emulated/0/Download');
      final secondary = Directory('/storage/emulated/0/Downloads');
      if (await primary.exists()) return primary;
      if (await secondary.exists()) return secondary;
      return (await getExternalStorageDirectory()) ??
          await getApplicationDocumentsDirectory();
    }
    return getApplicationDocumentsDirectory();
  }
}
