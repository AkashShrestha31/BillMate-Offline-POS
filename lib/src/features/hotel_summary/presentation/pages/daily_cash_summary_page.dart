import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/features/hotel_summary/data/models/request/daily_cash_summary_query_params.dart';
import 'package:hotel/src/features/hotel_summary/data/models/response/daily_cash_summary_response_model.dart';
import 'package:hotel/src/features/hotel_summary/presentation/cubit/daily_cash_summary_cubit.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/invoice_list_chrome.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/l10n/app_localizations.dart';

@RoutePage()
class DailyCashSummaryPage extends StatefulWidget implements AutoRouteWrapper {
  const DailyCashSummaryPage({super.key});

  @override
  State<DailyCashSummaryPage> createState() => _DailyCashSummaryPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<DailyCashSummaryCubit>(),
      child: this,
    );
  }
}

class _DailyCashSummaryPageState extends State<DailyCashSummaryPage> {
  late DailyCashSummaryCubit _cubit;

  // Date range state with ValueNotifiers
  final ValueNotifier<DateTime?> _startDate = ValueNotifier<DateTime?>(null);
  final ValueNotifier<DateTime?> _endDate = ValueNotifier<DateTime?>(null);
  final ValueNotifier<bool> _userAppliedFilter = ValueNotifier<bool>(false);

  // Current summaries for export
  final ValueNotifier<List<DailyCashSummaryModel>> _currentSummaries = ValueNotifier<List<DailyCashSummaryModel>>([]);

  @override
  void initState() {
    super.initState();
    _cubit = context.read<DailyCashSummaryCubit>();
    _loadCurrentMonthToToday();
  }

  @override
  void dispose() {
    _startDate.dispose();
    _endDate.dispose();
    _userAppliedFilter.dispose();
    _currentSummaries.dispose();
    super.dispose();
  }

  void _loadCurrentMonthToToday() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);

    _startDate.value = firstDayOfMonth;
    _endDate.value = now;
    _userAppliedFilter.value = false; // Reset filter flag

    _loadSummaries(
      startDate: firstDayOfMonth.toIso8601String().substring(0, 10),
      endDate: now.toIso8601String().substring(0, 10),
    );
  }

  void _loadSummaries({String? startDate, String? endDate}) {
    _cubit.getDailySummaries(
      params: DailyCashSummaryQueryParams(
        startDate: startDate,
        endDate: endDate,
        limit: 50,
        offset: 0,
      ),
    );
  }

  BoxDecoration _panelDecoration(BuildContext context) {
    return InvoiceListChrome.cardDecoration(
      context,
      borderRadius: BorderRadius.circular(12),
    );
  }

  Widget _datePickerTile({
    required BuildContext context,
    required String label,
    required String? valueText,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppFonts.interStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  valueText ?? context.l10n.closeSelectDate,
                  style: AppFonts.interStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: valueText != null ? scheme.onSurface : scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            Icon(Icons.calendar_today, color: scheme.primary),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    // Refresh summaries with current date range
    if (_startDate.value != null && _endDate.value != null) {
      _loadSummaries(
        startDate: _startDate.value!.toIso8601String().substring(0, 10),
        endDate: _endDate.value!.toIso8601String().substring(0, 10),
      );
    } else {
      // If no date range is set, load current month to today
      _loadCurrentMonthToToday();
    }

    // Wait a bit to ensure the refresh indicator shows
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void _showDateRangeDialog() async {
    DateTime? tempStartDate = _startDate.value;
    DateTime? tempEndDate = _endDate.value;

    final result = await showDialog<Map<String, DateTime?>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                context.l10n.closeSelectDateRange,
                style: AppFonts.interStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _datePickerTile(
                    context: context,
                    label: context.l10n.closeStartDate,
                    valueText: tempStartDate != null ? _formatDate(tempStartDate!) : null,
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: tempStartDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: tempEndDate ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setDialogState(() {
                          tempStartDate = pickedDate;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  _datePickerTile(
                    context: context,
                    label: context.l10n.closeEndDate,
                    valueText: tempEndDate != null ? _formatDate(tempEndDate!) : null,
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: tempEndDate ?? DateTime.now(),
                        firstDate: tempStartDate ?? DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setDialogState(() {
                          tempEndDate = pickedDate;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(context.l10n.cancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (tempStartDate != null && tempEndDate != null) {
                      Navigator.of(context).pop({
                        'startDate': tempStartDate,
                        'endDate': tempEndDate,
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.l10n.closeSelectBothDates),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(context.l10n.ok),
                ),
              ],
            );
          },
        );
      },
    );

    // If user clicked OK and we have dates, call API
    if (result != null) {
      _startDate.value = result['startDate'];
      _endDate.value = result['endDate'];
      _userAppliedFilter.value = true; // User manually applied filter

      if (_startDate.value != null && _endDate.value != null) {
        _loadSummaries(
          startDate: _startDate.value!.toIso8601String().substring(0, 10),
          endDate: _endDate.value!.toIso8601String().substring(0, 10),
        );
      }
    }
  }

  void _clearSearch() {
    _startDate.value = null;
    _endDate.value = null;
    _userAppliedFilter.value = false;
    _loadCurrentMonthToToday();
  }

  void _createDailySummary() {
    context.router.push(CreateDailyCashSummaryRoute());
  }

  void _updateDailySummary(DailyCashSummaryModel summary) {
    context.router.push(CreateDailyCashSummaryRoute(summary: summary));
  }

  void _deleteDailySummary(int id) {
    final scheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.closeDeleteSummary),
        content: Text(context.l10n.closeDeleteSummaryConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _cubit.deleteDailySummary(id: id);
            },
            style: TextButton.styleFrom(foregroundColor: scheme.error),
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );
  }

  String _getFilterDisplayText() {
    if (_startDate.value != null && _endDate.value != null) {
      return '${_formatDate(_startDate.value!)} to ${_formatDate(_endDate.value!)}';
    }
    return '';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  // PDF Generation Methods
  Future<pw.Document> _generatePdf() async {
    final l10n = context.l10n;
    final pdf = pw.Document();

    // Calculate totals
    double totalOpeningBalance = 0;
    double totalSalesAmount = 0;
    double totalCashAmount = 0;
    double totalQrAmount = 0;
    double totalDiscount = 0;
    double totalExpenses = 0;
    double totalClosingBalance = 0;
    double totalLostMoney = 0;
    double totalExtraAmount = 0;

    for (var summary in _currentSummaries.value) {
      totalOpeningBalance += summary.openingBalance ?? 0;
      totalSalesAmount += summary.salesAmount ?? 0;
      totalCashAmount += summary.cashAmount ?? 0;
      totalQrAmount += summary.qrAmount ?? 0;
      totalDiscount += summary.discount ?? 0;
      totalExpenses += summary.expenses ?? 0;
      totalClosingBalance += summary.closingBalance ?? 0;
      totalLostMoney += summary.lostMoney ?? 0;
      totalExtraAmount += summary.extraMoney ?? 0;
    }

    // Cover Page - Compact version
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  l10n.closeDailyCashSummaryReport,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 12),
                pw.Text(
                  _getReportPeriodText(),
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 6),
                pw.Text(
                  l10n.closeGeneratedAt(_formatDate(DateTime.now())),
                  style: pw.TextStyle(
                    fontSize: 11,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  padding: const pw.EdgeInsets.all(15),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.blue, width: 1.5),
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Text(
                        l10n.closeTotalRecords,
                        style: pw.TextStyle(
                          fontSize: 13,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        '${_currentSummaries.value.length}',
                        style: pw.TextStyle(
                          fontSize: 36,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Summary Page - More compact
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                l10n.closeSummaryOverview,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 12),
              _buildPdfSummaryRow(l10n.closeTotalOpeningBalance, totalOpeningBalance),
              _buildPdfSummaryRow(l10n.closeTotalSalesAmount, totalSalesAmount),
              _buildPdfSummaryRow(l10n.closeTotalCashAmount, totalCashAmount),
              _buildPdfSummaryRow(l10n.closeTotalQrAmount, totalQrAmount),
              _buildPdfSummaryRow(l10n.closeTotalDiscount, totalDiscount),
              _buildPdfSummaryRow(l10n.closeTotalExpenses, totalExpenses),
              pw.Divider(thickness: 1.5),
              _buildPdfSummaryRow(l10n.closeTotalClosingBalance, totalClosingBalance, isBold: true),
              if (totalLostMoney > 0) _buildPdfSummaryRow(l10n.closeTotalLostMoney, totalLostMoney, isWarning: true),
              if (totalExtraAmount != 0)
                _buildPdfSummaryRow(l10n.closeTotalExtraAmount, totalExtraAmount, isWarning: totalExtraAmount < 0),
            ],
          );
        },
      ),
    );

    // Detail Pages - Increased items per page from 3 to 6
    final itemsPerPage = 6;
    for (var i = 0; i < _currentSummaries.value.length; i += itemsPerPage) {
      final endIndex =
          (i + itemsPerPage < _currentSummaries.value.length) ? i + itemsPerPage : _currentSummaries.value.length;
      final pageItems = _currentSummaries.value.sublist(i, endIndex);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      l10n.closeDetails,
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      l10n.closePageN((i ~/ itemsPerPage) + 1),
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey600,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                ...pageItems.map((summary) => _buildPdfSummaryCard(summary, l10n)),
              ],
            );
          },
        ),
      );
    }

    return pdf;
  }

  pw.Widget _buildPdfSummaryRow(String label, double value, {bool isBold = false, bool isWarning = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const pw.EdgeInsets.only(bottom: 3),
      decoration: pw.BoxDecoration(
        color: isWarning ? PdfColors.red50 : PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(3),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
              color: isWarning ? PdfColors.red700 : PdfColors.black,
            ),
          ),
          pw.Text(
            'Rs.${value.toStringAsFixed(2)}',
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
              color: isWarning ? PdfColors.red700 : PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPdfSummaryCard(DailyCashSummaryModel summary, AppLocalizations l10n) {
    // Get extra amount from the response model
    double? extraAmount = summary.extraMoney;

    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 8),
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                summary.date,
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: pw.BoxDecoration(
                  color: PdfColors.green50,
                  borderRadius: pw.BorderRadius.circular(3),
                  border: pw.Border.all(color: PdfColors.green200),
                ),
                child: pw.Text(
                  'Rs.${summary.closingBalance?.toStringAsFixed(2) ?? '0.00'}',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green700,
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 6),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            children: [
              _buildPdfTableRow(l10n.closeOpeningBalance, summary.openingBalance),
              _buildPdfTableRow(l10n.closeSalesAmount, summary.salesAmount),
              _buildPdfTableRow(l10n.closeClosingBalance, summary.closingBalance, isBold: true),
              if (summary.lostMoney != null && summary.lostMoney! != 0)
                _buildPdfTableRow(l10n.closeLostMoney, summary.lostMoney, isWarning: true),
              if (extraAmount != null && extraAmount != 0)
                _buildPdfTableRow(l10n.closeExtraAmount, extraAmount, isWarning: extraAmount < 0, isPositive: extraAmount > 0),
            ],
          ),
        ],
      ),
    );
  }

  pw.TableRow _buildPdfTableRow(
    String label,
    double? value, {
    bool isWarning = false,
    bool isBold = false,
    bool isPositive = false,
  }) {
    return pw.TableRow(
      decoration: pw.BoxDecoration(
        color: isWarning
            ? PdfColors.red50
            : isPositive
                ? PdfColors.green50
                : null,
      ),
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
              color: isWarning
                  ? PdfColors.red700
                  : isPositive
                      ? PdfColors.green700
                      : PdfColors.black,
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            'Rs.${value?.toStringAsFixed(2) ?? '0.00'}',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: isWarning
                  ? PdfColors.red700
                  : isPositive
                      ? PdfColors.green700
                      : PdfColors.black,
            ),
            textAlign: pw.TextAlign.right,
          ),
        ),
      ],
    );
  }

  String _getReportPeriodText() {
    final l10n = context.l10n;
    if (_startDate.value != null && _endDate.value != null) {
      return l10n.closePeriodRange(
        _formatDate(_startDate.value!),
        _formatDate(_endDate.value!),
      );
    }
    return l10n.closeAllRecords;
  }

  Future<void> _exportAsPdf() async {
    if (_currentSummaries.value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.closeNoDataToExport)),
      );
      return;
    }

    try {
      final pdf = await _generatePdf();
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.closePdfGenerateError('$e'))),
      );
    }
  }

  Future<void> _sharePdf() async {
    if (_currentSummaries.value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.closeNoDataToShare)),
      );
      return;
    }

    try {
      final pdf = await _generatePdf();
      final bytes = await pdf.save();

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/daily_cash_summary_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(bytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        subject: context.l10n.closeDailyCashSummaryReport,
        text: '${context.l10n.closeDailyCashSummaryReport} - ${_getReportPeriodText()}',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.closePdfShareError('$e'))),
      );
    }
  }

  Future<void> _printPdf() async {
    if (_currentSummaries.value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.closeNoDataToPrint)),
      );
      return;
    }

    try {
      final pdf = await _generatePdf();
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.closePdfPrintError('$e'))),
      );
    }
  }

  void _showExportOptions() {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: scheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: scheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.closeExportOptions,
              style: AppFonts.interStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),
            _buildExportOption(
              icon: Icons.picture_as_pdf,
              title: l10n.closeExportPdf,
              subtitle: l10n.closeExportPdfSubtitle,
              color: scheme.primary,
              onTap: () {
                Navigator.pop(context);
                _exportAsPdf();
              },
            ),
            const SizedBox(height: 12),
            _buildExportOption(
              icon: Icons.share,
              title: l10n.closeSharePdf,
              subtitle: l10n.closeSharePdfSubtitle,
              color: context.theme.colorScheme.primary,
              onTap: () {
                Navigator.pop(context);
                _sharePdf();
              },
            ),
            const SizedBox(height: 12),
            _buildExportOption(
              icon: Icons.print,
              title: l10n.closePrint,
              subtitle: l10n.closePrintSubtitle,
              color: Colors.green,
              onTap: () {
                Navigator.pop(context);
                _printPdf();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildExportOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFonts.interStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppFonts.interStyle(
                      fontSize: 13,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: scheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLow,
      appBar: AppBar(
        leading: AppBarIosBackButton(color: scheme.onSurface),
        backgroundColor: scheme.surface,
        elevation: 0,
        foregroundColor: scheme.onSurface,
        title: Text(
          context.l10n.closeDailyCashSummaryTitle,
          style: AppFonts.interStyle(
            color: scheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          ValueListenableBuilder<List<DailyCashSummaryModel>>(
            valueListenable: _currentSummaries,
            builder: (context, summaries, _) {
              return Row(
                children: [
                  if (summaries.isNotEmpty)
                    IconButton(
                      onPressed: _showExportOptions,
                      icon: Icon(Icons.file_download, color: scheme.onSurfaceVariant),
                      tooltip: context.l10n.closeExportData,
                    ),
                  IconButton(
                    onPressed: _createDailySummary,
                    icon: Icon(Icons.add, color: scheme.onSurfaceVariant),
                    tooltip: context.l10n.closeAddSummary,
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Date Range Filter Section
          ValueListenableBuilder<bool>(
            valueListenable: _userAppliedFilter,
            builder: (context, userAppliedFilter, _) {
              return ValueListenableBuilder<DateTime?>(
                valueListenable: _startDate,
                builder: (context, startDate, _) {
                  return ValueListenableBuilder<DateTime?>(
                    valueListenable: _endDate,
                    builder: (context, endDate, _) {
                      return Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: _panelDecoration(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Select Date Range Button
                            InkWell(
                              onTap: _showDateRangeDialog,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/date_range.svg',
                                        width: context.theme.appTheme.spacing18,
                                        color: context.theme.colorScheme.primary,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        startDate != null && endDate != null
                                            ? _getFilterDisplayText()
                                            : context.l10n.closeSelectDateRange,
                                        style: context.theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Active Filter Display with Clear - Only show if user applied filter
                            if (userAppliedFilter && startDate != null && endDate != null) ...[
                              const SizedBox(height: 12),
                              Builder(
                                builder: (context) {
                                  final scheme = Theme.of(context).colorScheme;
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: scheme.primaryContainer.withValues(alpha: 0.45),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.check_circle, size: 16, color: scheme.primary),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  context.l10n.closeFilteredWithRange(_getFilterDisplayText()),
                                                  style: AppFonts.interStyle(
                                                    fontSize: 13,
                                                    color: scheme.onPrimaryContainer,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton.icon(
                                        onPressed: _clearSearch,
                                        icon: Icon(Icons.clear, color: scheme.error, size: 18),
                                        label: Text(
                                          context.l10n.clear,
                                          style: AppFonts.interStyle(
                                            color: scheme.error,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        style: TextButton.styleFrom(
                                          backgroundColor: scheme.errorContainer.withValues(alpha: 0.35),
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),

          // Results Section
          Expanded(
            child: BlocConsumer<DailyCashSummaryCubit, DailyCashSummaryState>(
              listener: (context, state) {
                state.when(
                  initial: () {},
                  loading: () {},
                  noInternet: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(context.l10n.noInternetConnection)),
                    );
                  },
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $message')),
                    );
                  },
                  summaryCreated: (response) {},
                  summariesLoaded: (response) {
                    _currentSummaries.value = response.summaries ?? [];
                  },
                  summaryUpdated: (response) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(response.message ?? context.l10n.closeSummaryUpdatedSuccess)),
                    );
                    // Reload with current date range
                    if (_startDate.value != null && _endDate.value != null) {
                      _loadSummaries(
                        startDate: _startDate.value!.toIso8601String().substring(0, 10),
                        endDate: _endDate.value!.toIso8601String().substring(0, 10),
                      );
                    }
                  },
                  summaryDeleted: (response) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(response.message ?? context.l10n.closeSummaryDeletedSuccess)),
                    );
                    // Reload with current date range
                    if (_startDate.value != null && _endDate.value != null) {
                      _loadSummaries(
                        startDate: _startDate.value!.toIso8601String().substring(0, 10),
                        endDate: _endDate.value!.toIso8601String().substring(0, 10),
                      );
                    }
                  },
                );
              },
              builder: (context, state) {
                final scheme = Theme.of(context).colorScheme;
                return state.when(
                  initial: () => _buildLoadingOrEmpty(),
                  loading: () => Center(
                    child: CircularProgressIndicator(color: scheme.primary),
                  ),
                  noInternet: () => Center(
                    child: Text(
                      context.l10n.noInternetConnection,
                      style: AppFonts.interStyle(color: scheme.onSurfaceVariant),
                    ),
                  ),
                  error: (message) => Center(
                    child: Text(
                      context.l10n.closeErrorPrefix(message),
                      style: AppFonts.interStyle(color: scheme.error),
                    ),
                  ),
                  summaryCreated: (response) => _buildSummariesList(response),
                  summariesLoaded: (response) => _buildSummariesList(response),
                  summaryUpdated: (response) => _buildSummariesList(response),
                  summaryDeleted: (response) => _buildSummariesList(response),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingOrEmpty() {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 80,
            color: scheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.closeDailyCashSummaryTitle,
            style: AppFonts.interStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.closeShowingCurrentMonth,
            style: AppFonts.interStyle(
              fontSize: 16,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummariesList(DailyCashSummaryResponseModel response) {
    List<DailyCashSummaryModel> summaries = response.summaries ?? [];

    if (summaries.isEmpty) {
      final scheme = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 80, color: scheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              _userAppliedFilter.value
                  ? context.l10n.closeNoSummariesFound
                  : context.l10n.closeNoSummariesAvailable,
              style: AppFonts.interStyle(
                fontSize: 18,
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _userAppliedFilter.value
                  ? context.l10n.closeTryAdjustingDateRange
                  : context.l10n.closeCreateFirstSummary,
              style: AppFonts.interStyle(color: scheme.onSurfaceVariant, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            if (_userAppliedFilter.value) ...[
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: _clearSearch,
                icon: Icon(Icons.clear, size: 18),
                label: Text(context.l10n.closeClearFilter),
                style: OutlinedButton.styleFrom(
                  foregroundColor: scheme.primary,
                  side: BorderSide(color: scheme.outlineVariant),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ],
        ),
      );
    }

    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: _panelDecoration(context),
          child: Row(
            children: [
              Icon(Icons.receipt, color: scheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                '${summaries.length} ${summaries.length == 1 ? context.l10n.closeSummarySingular : context.l10n.closeSummariesPlural}',
                style: AppFonts.interStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
              if (_userAppliedFilter.value) ...[
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
                  ),
                  child: Text(
                    context.l10n.closeFiltered,
                    style: AppFonts.interStyle(
                      fontSize: 12,
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),

        // List
        Expanded(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: summaries.length,
              itemBuilder: (context, index) {
                DailyCashSummaryModel summary = summaries[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: _panelDecoration(context),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              summary.date,
                              style: AppFonts.interStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: scheme.onSurface,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: scheme.primaryContainer.withValues(alpha: 0.45),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
                              ),
                              child: Text(
                                'Rs.${summary.closingBalance?.toStringAsFixed(2) ?? '0.00'}',
                                style: AppFonts.interStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: scheme.onPrimaryContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(context.l10n.closeOpeningBalance, summary.openingBalance),
                            _buildDetailRow(context.l10n.closeSalesAmount, summary.salesAmount),
                            _buildDetailRow(context.l10n.closeCashAmount, summary.cashAmount),
                            _buildDetailRow(context.l10n.closeQrAmount, summary.qrAmount),
                            _buildDetailRow(context.l10n.closeDiscount, summary.discount),
                            _buildDetailRow(context.l10n.closeExpenses, summary.expenses),
                            _buildDetailRow(context.l10n.closeUnpaid, summary.unPaid),
                            _buildDetailRow(context.l10n.closeCreditCash, summary.creditPaidCash),
                            _buildDetailRow(context.l10n.closeCreditQr, summary.creditQr),
                            if (summary.lostMoney != null && summary.lostMoney! > 0)
                              _buildDetailRow(context.l10n.closeLostMoney, summary.lostMoney, isWarning: true),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Footer - Edit and Delete buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => _updateDailySummary(summary),
                              icon:  Icon(Icons.edit, color: context.theme.colorScheme.primary),
                              iconSize: 20,
                            ),
                            IconButton(
                              onPressed: () => _deleteDailySummary(summary.id),
                              icon: AppDeleteIcon(color: scheme.error, size: 20),
                              iconSize: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, double? value, {bool isWarning = false}) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isWarning
            ? scheme.errorContainer.withValues(alpha: 0.35)
            : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: isWarning ? Border.all(color: scheme.error.withValues(alpha: 0.35)) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppFonts.interStyle(
              fontSize: 14,
              color: isWarning ? scheme.error : scheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Rs.${value?.toStringAsFixed(2) ?? '0.00'}',
            style: AppFonts.interStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isWarning ? scheme.error : scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
