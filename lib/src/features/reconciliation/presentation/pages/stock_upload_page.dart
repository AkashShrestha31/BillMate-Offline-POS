import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:hotel/constants.dart';

import 'package:auto_route/annotations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/action/presentation/cubit/item_cubit.dart';
import 'package:hotel/src/features/employee_management/presentation/bloc/employee_cubit.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_upload_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/reconciliation_upload_response.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/reconciliation_upload_cubit.dart';
import 'package:hotel/src/features/action/data/models/request/item_request_params.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:excel/excel.dart' hide Border, BorderStyle;
import 'package:path_provider/path_provider.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';

Color _stockShellColor(ColorScheme scheme) => scheme.surfaceContainerLowest;

Color _stockSheetColor(ColorScheme scheme) => scheme.surface;

Color _stockCardColor(ColorScheme scheme) => scheme.surface;

@RoutePage()
class StockUploadPage extends StatefulWidget {
  const StockUploadPage({super.key});

  @override
  State<StockUploadPage> createState() => _StockUploadPageState();
}

class _StockUploadPageState extends State<StockUploadPage> {
  final _formKey = GlobalKey<FormState>();
  final _uploadedByController = TextEditingController(text: "hotelroyalrestro@gmail.com");
  late final TextEditingController _reportingDateController;

  final ValueNotifier<String?> _selectedFileNameNotifier = ValueNotifier(null);
  final ValueNotifier<Uint8List?> _selectedFileBytesNotifier = ValueNotifier(null);
  final ValueNotifier<File?> _selectedFileNotifier = ValueNotifier(null);
  final ValueNotifier<DateTime> _reportingDateNotifier = ValueNotifier(DateTime.now());
  final ValueNotifier<bool> _replaceExistingNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _createMissingItemsNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _reportingDateController = TextEditingController(
      text: _formatReportingDate(_reportingDateNotifier.value),
    );
    _reportingDateNotifier.addListener(_onReportingDateChanged);
  }

  void _onReportingDateChanged() {
    _reportingDateController.text = _formatReportingDate(_reportingDateNotifier.value);
  }

  String _formatReportingDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _reportingDateNotifier.removeListener(_onReportingDateChanged);
    _reportingDateController.dispose();
    _uploadedByController.dispose();
    _selectedFileNameNotifier.dispose();
    _selectedFileBytesNotifier.dispose();
    _selectedFileNotifier.dispose();
    _reportingDateNotifier.dispose();
    _replaceExistingNotifier.dispose();
    _createMissingItemsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: _stockShellColor(scheme),
      appBar: AppBar(
        leading: AppBarIosBackButton(color: scheme.onSurface),
        title: Text(context.l10n.stockUploadPageTitle),
        backgroundColor: _stockShellColor(scheme),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showUploadHelp(context),
            icon: Icon(Icons.help_outline_rounded, color: scheme.onSurfaceVariant),
            tooltip: 'Upload Help',
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ReconciliationUploadCubit, ReconciliationUploadState>(
            listener: (context, state) {
              state.when(
                initial: () {},
                loading: () {
                  AppLoadingOverlay.of(context).show();
                },
                noInternet: () {
                  _showSnackbar('No internet connection. Please check your network.', Colors.orange);
                },
                error: (message) {
                  AppLoadingOverlay.of(context).hide();
                  _showSnackbar('Upload failed: $message', Colors.red);
                },
                success: (response) {
                  Navigator.of(context).pop();
                  AppLoadingOverlay.of(context).hide();

                  // final result = response.data;
                  // _showSnackbar('Stock data uploaded successfully!', Colors.green);
                  // _showUploadSuccessDialog(result);
                },
              );
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPageIntro(),
                const SizedBox(height: 28),
                _buildEntryOptions(),
                const SizedBox(height: 32),
                _buildFileStatus(),
                const SizedBox(height: 32),
                _buildDateField(),
                const SizedBox(height: 20),
                _buildUploadedByField(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildPageIntro() {
    final theme = Theme.of(context);
    return Text(
      context.l10n.stockCountsPageHint,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        height: 1.45,
      ),
    );
  }

  Widget _buildEntryOptions() {
    return _EntryOptionTile(
      icon: Icons.edit_note_rounded,
      title: context.l10n.stockEnterQuantitiesOption,
      subtitle: context.l10n.stockEnterQuantitiesOptionSubtitle,
      emphasized: true,
      onTap: _createNewExcelFile,
    );
  }

  Widget _buildFileStatus() {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your file',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<String?>(
          valueListenable: _selectedFileNameNotifier,
          builder: (context, fileName, _) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              child: fileName == null
                  ? _buildEmptyFileZone(key: const ValueKey('empty_file'))
                  : _buildSelectedFileZone(fileName, key: ValueKey('file_$fileName')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEmptyFileZone({required Key key}) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Material(
      key: key,
      color: scheme.surfaceContainerHighest.withOpacity(0.35),
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _createNewExcelFile,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          child: Column(
            children: [
              Icon(Icons.insert_drive_file_outlined, size: 36, color: scheme.primary.withOpacity(0.75)),
              const SizedBox(height: 10),
              Text(
                'No file yet',
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                'Tap to enter quantities',
                style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedFileZone(String fileName, {required Key key}) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final primary = scheme.primary;

    return Material(
      key: key,
      color: Color.alphaBlend(primary.withValues(alpha: 0.08), scheme.surface),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.check_circle_rounded, color: primary, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurface,
                        ),
                      ),
                      Text(
                        'Ready to upload',
                        style: theme.textTheme.bodySmall?.copyWith(color: primary),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Remove file',
                  onPressed: () {
                    _selectedFileNameNotifier.value = null;
                    _selectedFileNotifier.value = null;
                    _selectedFileBytesNotifier.value = null;
                  },
                  icon: Icon(Icons.close_rounded, color: scheme.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _viewExcelData,
                  child: Text('Preview'),
                ),
                ValueListenableBuilder<Uint8List?>(
                  valueListenable: _selectedFileBytesNotifier,
                  builder: (context, bytes, _) {
                    return TextButton(
                      onPressed: () => _createNewExcelFile(existingBytes: bytes),
                      child: Text('Edit'),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ValueListenableBuilder2<File?, Uint8List?>(
      first: _selectedFileNotifier,
      second: _selectedFileBytesNotifier,
      builder: (context, file, bytes, _) {
        final canUpload = file != null || bytes != null;

        return DecoratedBox(
          decoration: BoxDecoration(
            color: _stockShellColor(scheme),
            border: Border(top: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.35))),
          ),
          child: SafeArea(
            minimum: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: CustomButtonWidget(
                    onPressed: canUpload ? _uploadFile : null,
                    title: context.l10n.stockUploadSubmit,
                    borderRadius: 14,
                    height: 52,
                    elevation: 0,
                    buttonState: canUpload ? CustomButtonState.primary : CustomButtonState.disabled,
                  ),
                ),
                if (!canUpload) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Add or generate a file to enable upload',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.cloud_upload,
                  color: Colors.blue.shade600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Upload Current Stock Data',
                  style: AppFonts.interStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Upload your current stock data in Excel format to generate a comprehensive stock reconciliation report.',
            style: AppFonts.interStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.orange.shade600, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Enter stock quantities directly or upload your existing Excel file',
                    style: AppFonts.interStyle(
                      fontSize: 12,
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField() {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reporting Date *',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          onTap: _selectDate,
          suffixIcon: Icon(Icons.calendar_month_rounded, color: scheme.onSurfaceVariant, size: 22),
          prefixIcon: Icon(Icons.event_rounded, color: scheme.primary, size: 20),
          readOnly: true,
          controller: _reportingDateController,
        ),
        const SizedBox(height: 6),
        Text(
          'Last day of the reporting period',
          style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildUploadedByField() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Uploaded By *',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<EmployeeCubit, EmployeeState>(
          builder: (context, state) {
            final employee = state.maybeWhen(
              employeeDetail: (e) => e,
              orElse: () => null,
            );
            _uploadedByController.text = employee!.email.toString();
            return CustomTextFormField(
              controller: _uploadedByController,
              enabled: false,
              hint: 'Enter your name',
              validating: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.text,
            );
          },
        )
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload Settings',
              style: AppFonts.interStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<bool>(
              valueListenable: _replaceExistingNotifier,
              builder: (context, replaceExisting, child) {
                return _buildSettingSwitch(
                  title: 'Replace Existing Data',
                  subtitle: 'Replace existing data for the same reporting date',
                  value: replaceExisting,
                  onChanged: (value) => _replaceExistingNotifier.value = value,
                  icon: Icons.refresh,
                  color: Colors.orange.shade600,
                );
              },
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<bool>(
              valueListenable: _createMissingItemsNotifier,
              builder: (context, createMissingItems, child) {
                return _buildSettingSwitch(
                  title: 'Create Missing Items',
                  subtitle: 'Automatically create items that don\'t exist in database',
                  value: createMissingItems,
                  onChanged: (value) => _createMissingItemsNotifier.value = value,
                  icon: Icons.add_circle_outline,
                  color: Colors.green.shade600,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: value ? color.withValues(alpha: 0.05) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? color.withValues(alpha: 0.3) : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: value ? color.withValues(alpha: 0.1) : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: value ? color : Colors.grey.shade600,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.interStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppFonts.interStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: color,
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _reportingDateNotifier.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _reportingDateNotifier.value) {
      _reportingDateNotifier.value = picked;
    }
  }

  Future<void> _saveToTempFile(Uint8List bytes, String fileName) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(bytes);
      _selectedFileNotifier.value = file;
    } catch (e) {
      debugPrint('Error saving temp file: $e');
    }
  }

  Future<void> _createNewExcelFile({Uint8List? existingBytes}) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => ExcelEditorPage(existingBytes: existingBytes),
      ),
    );

    if (result != null) {
      final bytes = result['bytes'] as Uint8List;
      final fileName = result['fileName'] as String;

      _selectedFileBytesNotifier.value = bytes;
      _selectedFileNameNotifier.value = fileName;

      // Save to temp file for Android
      await _saveToTempFile(bytes, fileName);

      _showSnackbar('Stock data file created successfully!', Colors.green);
    }
  }

  Future<void> _viewExcelData() async {
    if (_selectedFileBytesNotifier.value == null) return;

    try {
      final excel = Excel.decodeBytes(_selectedFileBytesNotifier.value!);

      if (!mounted) return;

      final sheetName = excel.tables.keys.first;
      final sheet = excel.tables[sheetName];

      if (sheet == null) {
        _showSnackbar('No data found in Excel file', Colors.orange);
        return;
      }

      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.85,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.table_chart, color: Colors.blue.shade600, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ValueListenableBuilder<String?>(
                        valueListenable: _selectedFileNameNotifier,
                        builder: (context, selectedFileName, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Excel Data Preview',
                                style: AppFonts.interStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                selectedFileName ?? 'Stock Data',
                                style: AppFonts.interStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade600, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Total rows: ${sheet.maxRows} • Total columns: ${sheet.maxColumns} • Scroll to see all',
                          style: AppFonts.interStyle(
                            fontSize: 12,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Row
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.shade600,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  for (int i = 0; i < sheet.maxColumns; i++)
                                    Container(
                                      width: 150,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: i < sheet.maxColumns - 1
                                              ? BorderSide(color: Colors.blue.shade400, width: 1)
                                              : BorderSide.none,
                                        ),
                                      ),
                                      child: Text(
                                        sheet
                                                .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
                                                .value
                                                ?.toString() ??
                                            'Column ${i + 1}',
                                        style: AppFonts.interStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            // Data Rows
                            for (int rowIndex = 1; rowIndex < sheet.maxRows; rowIndex++)
                              Container(
                                decoration: BoxDecoration(
                                  color: rowIndex % 2 == 0 ? Colors.grey.shade50 : Colors.white,
                                  border: Border(
                                    bottom: rowIndex < sheet.maxRows - 1
                                        ? BorderSide(color: Colors.grey.shade200, width: 1)
                                        : BorderSide.none,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    for (int colIndex = 0; colIndex < sheet.maxColumns; colIndex++)
                                      Container(
                                        width: 150,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: colIndex < sheet.maxColumns - 1
                                                ? BorderSide(color: Colors.grey.shade200, width: 1)
                                                : BorderSide.none,
                                          ),
                                        ),
                                        child: Text(
                                          sheet
                                                  .cell(CellIndex.indexByColumnRow(
                                                    columnIndex: colIndex,
                                                    rowIndex: rowIndex,
                                                  ))
                                                  .value
                                                  ?.toString() ??
                                              '',
                                          style: AppFonts.interStyle(fontSize: 12),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      _showSnackbar('Error reading Excel file: ${e.toString()}', Colors.red);
    }
  }

  Future<void> _ensureUploadFileOnDisk() async {
    final file = _selectedFileNotifier.value;
    if (file != null && file.existsSync()) return;

    final bytes = _selectedFileBytesNotifier.value;
    final name = _selectedFileNameNotifier.value;
    if (bytes == null || bytes.isEmpty || name == null) return;

    await _saveToTempFile(bytes, name);
  }

  Future<void> _uploadFile() async {
    await _ensureUploadFileOnDisk();

    final uploadFile = _selectedFileNotifier.value;
    if (uploadFile == null || !uploadFile.existsSync()) {
      _showSnackbar('No file ready to upload. Please select or create a file.', Colors.red);
      return;
    }

    // Format reporting date as YYYY-MM-DD
    final reportingDate = _reportingDateNotifier.value;
    final formattedDate =
        '${reportingDate.year}-${reportingDate.month.toString().padLeft(2, '0')}-${reportingDate.day.toString().padLeft(2, '0')}';

    // Create request object
    final request = ReconciliationUploadRequest(
      reportingDate: formattedDate,
      uploadedBy: _uploadedByController.text.trim(),
      replaceExisting: _replaceExistingNotifier.value,
      createMissingItems: _createMissingItemsNotifier.value,
      file: uploadFile,
    );

    // Trigger upload via cubit
    context.read<ReconciliationUploadCubit>().uploadReconciliationData(request: request);
  }

  void _showUploadSuccessDialog(ReconciliationUploadResponse result) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 12),
            Text('Upload Successful!'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSuccessRow('Upload Batch', result.uploadBatch),
              _buildSuccessRow('Reporting Date', result.reportingDate),
              _buildSuccessRow('Upload Type', result.uploadType),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSuccessStatCard(
                    'Successful',
                    result.successfulUploads.toString(),
                    Colors.green,
                  ),
                  _buildSuccessStatCard(
                    'Failed',
                    result.failedUploads.toString(),
                    Colors.red,
                  ),
                ],
              ),
              if (result.note.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade600, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          result.note,
                          style: AppFonts.interStyle(
                            fontSize: 12,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (result.failedRecords.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Failed Records:',
                  style: AppFonts.interStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(height: 8),
                ...result.failedRecords.map((record) => Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text('• $record', style: AppFonts.interStyle(fontSize: 12)),
                    )),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<ReconciliationUploadCubit>().resetToInitial();

              // Reset form using ValueNotifiers
              _selectedFileNotifier.value = null;
              _selectedFileNameNotifier.value = null;
              _selectedFileBytesNotifier.value = null;
              _uploadedByController.clear();
              _reportingDateNotifier.value = DateTime.now();
              _replaceExistingNotifier.value = false;
              _createMissingItemsNotifier.value = false;
            },
            child: Text('Upload Another File'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('View Dashboard'),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: AppFonts.interStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppFonts.interStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppFonts.interStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: AppFonts.interStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showUploadHelp(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final primary = scheme.primary;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.75,
            ),
            decoration: BoxDecoration(
              color: _stockSheetColor(scheme),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: scheme.outlineVariant.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 12, 0),
                  child: Row(
                    children: [
                      Icon(Icons.help_outline_rounded, color: primary, size: 26),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Upload help',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurface,
                          ),
                        ),
                      ),
                      Material(
                        color: scheme.surfaceContainerHighest.withOpacity(0.8),
                        shape: const CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => Navigator.pop(sheetContext),
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(Icons.close_rounded, size: 22, color: scheme.onSurfaceVariant),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How it works',
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10),
                        _helpStep(theme, '1', 'Tap Enter stock quantities'),
                        _helpStep(theme, '2', 'Add items from your inventory'),
                        _helpStep(theme, '3', 'Enter quantity for each item and save the file'),
                        _helpStep(theme, '4', 'Choose reporting date and tap Upload stock data'),
                        const SizedBox(height: 20),
                        Text(
                          'Auto-filled per item',
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10),
                        _helpBullet(theme, 'Location (Stores)'),
                        _helpBullet(theme, 'Batch number'),
                        _helpBullet(theme, 'Expiry date'),
                        _helpBullet(theme, 'Rate, when available'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _helpStep(ThemeData theme, String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number.',
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }

  Widget _helpBullet(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: theme.textTheme.bodyMedium),
          Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// Excel Editor Page Widget
class ExcelEditorPage extends StatefulWidget {
  final Uint8List? existingBytes;

  const ExcelEditorPage({super.key, this.existingBytes});

  @override
  State<ExcelEditorPage> createState() => _ExcelEditorPageState();
}

class _ExcelEditorPageState extends State<ExcelEditorPage> {
  final _fileNameController = TextEditingController();
  final _searchController = TextEditingController();
  final ValueNotifier<List<StockItem>> _itemsNotifier = ValueNotifier([]);
  final ValueNotifier<List<StockItem>> _filteredItemsNotifier = ValueNotifier([]);
  final Random _random = Random();
  late final String _uniqueBatchNumber;

  @override
  void initState() {
    super.initState();
    _uniqueBatchNumber = _generateUniqueBatchNumber();
    _fileNameController.text = 'stock_data_${DateTime.now().millisecondsSinceEpoch}';
    _searchController.addListener(_filterItems);
    _loadItems();
  }

  String _generateUniqueBatchNumber() {
    final now = DateTime.now();
    final timestamp = now.millisecondsSinceEpoch.toString().substring(7);
    final dateStr = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    return 'BATCH-$dateStr-$timestamp';
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase().trim();

    if (query.isEmpty) {
      _filteredItemsNotifier.value = _itemsNotifier.value;
    } else {
      _filteredItemsNotifier.value = _itemsNotifier.value.where((item) {
        final itemName = item.itemNameController.text.toLowerCase();
        final location = item.location.toLowerCase();
        final batch = item.batchNumber.toLowerCase();

        return itemName.contains(query) || location.contains(query) || batch.contains(query);
      }).toList();
    }
  }

  Future<void> _loadItems() async {
    if (widget.existingBytes != null) {
      await _loadExistingFileData();
    } else {
      _itemsNotifier.value = [];
      _filteredItemsNotifier.value = [];
    }
  }

  Future<void> _loadExistingFileData() async {
    try {
      final excel = Excel.decodeBytes(widget.existingBytes!);
      final sheetName = excel.tables.keys.first;
      final sheet = excel.tables[sheetName];

      if (sheet == null) return;

      final items = <StockItem>[];

      for (int rowIndex = 1; rowIndex < sheet.maxRows; rowIndex++) {
        final itemName =
            sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex)).value?.toString() ?? '';
        final location =
            sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex)).value?.toString() ?? 'Stores';
        final previousQty =
            sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex)).value?.toString() ?? '';
        final batch =
            sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex)).value?.toString() ?? '';
        final expiry =
            sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex)).value?.toString() ?? '';
        final rate = double.tryParse(
                sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex)).value?.toString() ?? '0') ??
            0.0;
        final notes =
            sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: rowIndex)).value?.toString() ?? '';

        items.add(StockItem(
          itemName: itemName,
          location: location,
          batchNumber: batch,
          expiryDate: expiry,
          rate: rate,
          notes: notes,
          currentStock: previousQty,
        ));
      }

      _itemsNotifier.value = items;
      _filteredItemsNotifier.value = items;
      _fileNameController.text = 'stock_data_${DateTime.now().millisecondsSinceEpoch}';
    } catch (e) {
      _itemsNotifier.value = [];
      _filteredItemsNotifier.value = [];
    }
  }

  @override
  void dispose() {
    _fileNameController.dispose();
    _searchController.dispose();
    for (var item in _itemsNotifier.value) {
      item.dispose();
    }
    _itemsNotifier.dispose();
    _filteredItemsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final primary = scheme.primary;

    return Scaffold(
      backgroundColor: _stockShellColor(scheme),
      appBar: AppBar(
        leading: AppBarIosBackButton(color: scheme.onSurface),
        title: Text(context.l10n.stockEnterQuantitiesTitle),
        backgroundColor: _stockShellColor(scheme),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          ValueListenableBuilder<List<StockItem>>(
            valueListenable: _itemsNotifier,
            builder: (context, items, _) {
              if (items.isEmpty) return const SizedBox.shrink();
              return IconButton(
                onPressed: _clearAllQuantities,
                tooltip: 'Clear quantities',
                icon: Icon(Icons.restart_alt_rounded, color: scheme.onSurfaceVariant),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRow,
        backgroundColor: primary,
        foregroundColor: scheme.onPrimary,
        shape: const CircleBorder(),
        tooltip: 'Add items',
        child: Icon(Icons.add_rounded),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Row(
              children: [
                Text(
                  'Batch ',
                  style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                ),
                Flexible(
                  child: Text(
                    '$_uniqueBatchNumber · ${_fileNameController.text}.xlsx',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: CustomTextFormField(
              controller: _searchController,
              hint: 'Search added items',
              prefixIcon: AppSearchIcon.inputDecoration(),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<StockItem>>(
              valueListenable: _filteredItemsNotifier,
              builder: (context, filteredItems, _) {
                return ValueListenableBuilder<List<StockItem>>(
                  valueListenable: _itemsNotifier,
                  builder: (context, allItems, __) {
                    if (filteredItems.isEmpty) {
                      return _buildEditorEmptyState(
                        theme: theme,
                        scheme: scheme,
                        primary: primary,
                        searchActive: _searchController.text.trim().isNotEmpty,
                        hasAnyItems: allItems.isNotEmpty,
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        final actualIndex = allItems.indexOf(item);
                        return _buildStockRow(
                          theme: theme,
                          scheme: scheme,
                          primary: primary,
                          item: item,
                          rowNumber: actualIndex + 1,
                          onRemove: () => _removeRow(actualIndex),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: _stockShellColor(scheme),
          border: Border(top: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.35))),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: CustomButtonWidget(
                  onPressed: () => Navigator.pop(context),
                  title: 'Cancel',
                  buttonState: CustomButtonState.outlined,
                  borderRadius: 12,
                  elevation: 0,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: CustomButtonWidget(
                  onPressed: _saveExcelFile,
                  title: 'Save file',
                  borderRadius: 12,
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditorEmptyState({
    required ThemeData theme,
    required ColorScheme scheme,
    required Color primary,
    required bool searchActive,
    required bool hasAnyItems,
  }) {
    final isSearchEmpty = searchActive && hasAnyItems;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSearchEmpty ? Icons.search_off_rounded : Icons.inventory_2_outlined,
              size: 56,
              color: primary.withOpacity(0.45),
            ),
            const SizedBox(height: 16),
            Text(
              isSearchEmpty ? 'No matching items' : 'No items added yet',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isSearchEmpty
                  ? 'Try another search term'
                  : 'Tap + to pick items from your inventory',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockRow({
    required ThemeData theme,
    required ColorScheme scheme,
    required Color primary,
    required StockItem item,
    required int rowNumber,
    required VoidCallback onRemove,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: scheme.outlineVariant.withOpacity(0.6)),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: primary, width: 1.5),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '$rowNumber',
              textAlign: TextAlign.center,
              style: theme.textTheme.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              item.itemNameController.text,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 88,
            child: TextField(
              controller: item.currentStockController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Qty',
                hintText: '0',
                isDense: true,
                filled: true,
                fillColor: scheme.surfaceContainerHighest.withOpacity(0.35),
                enabledBorder: border,
                focusedBorder: focusedBorder,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: onRemove,
            icon: AppDeleteIcon(color: scheme.error.withOpacity(0.85)),
            tooltip: 'Remove',
          ),
        ],
      ),
    );
  }

  void _addRow() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (sheetContext) {
        final sheetHeight = MediaQuery.sizeOf(sheetContext).height * 0.88;
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(sheetContext).bottom),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: _stockSheetColor(Theme.of(sheetContext).colorScheme),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: sheetHeight,
                child: _AddItemDialog(
                  uniqueBatchNumber: _uniqueBatchNumber,
                  onItemsAdded: (List<StockItem> newItems) {
                    final existingNames = _itemsNotifier.value
                        .map((e) => e.itemNameController.text.trim().toLowerCase())
                        .where((n) => n.isNotEmpty)
                        .toSet();
                    final uniqueNew = newItems
                        .where((item) =>
                            !existingNames.contains(item.itemNameController.text.trim().toLowerCase()))
                        .toList();
                    if (uniqueNew.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Selected items are already in the list')),
                      );
                      return;
                    }
                    _itemsNotifier.value = [..._itemsNotifier.value, ...uniqueNew];
                    _filterItems();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _removeRow(int index) {
    final items = List<StockItem>.from(_itemsNotifier.value);
    items[index].dispose();
    items.removeAt(index);
    _itemsNotifier.value = items;
    _filterItems();
  }

  void _clearAllQuantities() {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final primary = scheme.primary;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: _stockSheetColor(scheme),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: scheme.outlineVariant.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Clear all quantities?',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurface,
                          ),
                        ),
                      ),
                      Material(
                        color: scheme.surfaceContainerHighest.withOpacity(0.8),
                        shape: const CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => Navigator.pop(sheetContext),
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(Icons.close_rounded, size: 22, color: scheme.onSurfaceVariant),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This will clear all entered quantities. Your item list stays the same.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      for (final item in _itemsNotifier.value) {
                        item.currentStockController.clear();
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: scheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Clear all'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveExcelFile() async {
    try {
      final items = _itemsNotifier.value.where((item) => item.itemNameController.text.trim().isNotEmpty).toList();
      if (items.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Add at least one item before saving')),
        );
        return;
      }

      String fileName = _fileNameController.text.trim();
      if (fileName.isEmpty) fileName = 'stock_data_${DateTime.now().millisecondsSinceEpoch}';
      if (fileName.endsWith('.xlsx')) fileName = fileName.substring(0, fileName.length - 5);

      final excel = Excel.createExcel();
      final sheet = excel['Stock Data'];
      excel.delete('Sheet1');

      sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue('item_name');
      sheet.cell(CellIndex.indexByString('B1')).value = TextCellValue('location');
      sheet.cell(CellIndex.indexByString('C1')).value = TextCellValue('previous_quantity');
      sheet.cell(CellIndex.indexByString('D1')).value = TextCellValue('batch_number');
      sheet.cell(CellIndex.indexByString('E1')).value = TextCellValue('expiry_date');
      sheet.cell(CellIndex.indexByString('F1')).value = TextCellValue('rate');
      sheet.cell(CellIndex.indexByString('G1')).value = TextCellValue('notes');

      final headerStyle = CellStyle(backgroundColorHex: ExcelColor.blue, fontColorHex: ExcelColor.white, bold: true);
      for (int i = 0; i < 7; i++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).cellStyle = headerStyle;
      }

      final currentDate = DateTime.now().toString().substring(0, 10);

      for (int i = 0; i < items.length; i++) {
        final item = items[i];
        final rowIndex = i + 1;
        final itemName = item.itemNameController.text.trim();
        final currentStock = item.currentStockController.text.trim();
        final stockValue = currentStock.isNotEmpty ? (int.tryParse(currentStock) ?? 0) : 0;

        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex)).value = TextCellValue(itemName);
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex)).value = TextCellValue(item.location);
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex)).value = IntCellValue(stockValue);
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex)).value =
            TextCellValue(_uniqueBatchNumber);
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex)).value = TextCellValue(currentDate);
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex)).value = DoubleCellValue(item.rate);
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: rowIndex)).value = TextCellValue(item.notes);
      }

      final bytes = excel.encode();
      if (bytes == null) throw Exception('Failed to encode Excel file');

      if (mounted) {
        Navigator.pop(context, {'bytes': Uint8List.fromList(bytes), 'fileName': '$fileName.xlsx'});
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error saving file: ${e.toString()}'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating));
    }
  }
}

// Add Item Dialog Widget with Multi-Select
class _AddItemDialog extends StatefulWidget {
  final String uniqueBatchNumber;
  final Function(List<StockItem>) onItemsAdded;

  const _AddItemDialog({required this.uniqueBatchNumber, required this.onItemsAdded});

  @override
  State<_AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<_AddItemDialog> {
  final _searchController = TextEditingController();
  final _customNameController = TextEditingController();
  final _customRateController = TextEditingController();

  final ValueNotifier<bool> _showCustomInputNotifier = ValueNotifier(false);
  final ValueNotifier<List<ItemModel>> _selectedItemsNotifier = ValueNotifier([]);
  final ValueNotifier<List<ItemModel>> _filteredItemsNotifier = ValueNotifier([]);
  final ValueNotifier<List<ItemModel>> _allItemsNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _loadItems();
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _customNameController.dispose();
    _customRateController.dispose();
    _showCustomInputNotifier.dispose();
    _selectedItemsNotifier.dispose();
    _filteredItemsNotifier.dispose();
    _allItemsNotifier.dispose();
    super.dispose();
  }

  void _loadItems() {
    context.read<ItemCubit>().getItems(params: ItemRequestParams(page: 1, perPage: 1000));
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) {
      _filteredItemsNotifier.value = _allItemsNotifier.value;
    } else {
      _filteredItemsNotifier.value =
          _allItemsNotifier.value.where((item) => item.name.toLowerCase().contains(query)).toList();
    }
  }

  void _toggleItemSelection(ItemModel item) {
    final currentSelected = List<ItemModel>.from(_selectedItemsNotifier.value);
    final index = currentSelected.indexWhere((i) => i.name == item.name);
    if (index >= 0) {
      currentSelected.removeAt(index);
    } else {
      currentSelected.add(item);
    }
    _selectedItemsNotifier.value = currentSelected;
  }

  void _selectAll() {
    _selectedItemsNotifier.value = List.from(_filteredItemsNotifier.value);
  }

  void _clearSelection() {
    _selectedItemsNotifier.value = [];
  }

  void _addItems() {
    if (_showCustomInputNotifier.value == true) {
      if (_customNameController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Please enter item name'), backgroundColor: Colors.red));
        return;
      }

      final rate = double.tryParse(_customRateController.text.trim()) ?? 0.0;
      final newItem = StockItem(
        itemName: _customNameController.text.trim(),
        location: 'Stores',
        batchNumber: widget.uniqueBatchNumber,
        expiryDate: DateTime.now().add(const Duration(days: 30)).toString().substring(0, 10),
        rate: rate,
        notes: 'Current stock count for ${_customNameController.text.trim()} at Stores',
      );

      widget.onItemsAdded([newItem]);
      Navigator.pop(context);
    } else {
      final selectedItems = _selectedItemsNotifier.value;

      if (selectedItems.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select at least one item'), backgroundColor: Colors.red));
        return;
      }

      final newItems = selectedItems
          .map((item) => StockItem(
                itemName: item.name,
                location: 'Stores',
                batchNumber: widget.uniqueBatchNumber,
                expiryDate: DateTime.now().add(const Duration(days: 30)).toString().substring(0, 10),
                rate: item.rate,
                notes: 'Current stock count for ${item.name} at Stores',
              ))
          .toList();

      widget.onItemsAdded(newItems);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final primary = scheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: scheme.outlineVariant.withOpacity(0.55),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 8, 0),
          child: Row(
            children: [
              Icon(Icons.add_circle_outline, color: primary, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: ValueListenableBuilder<List<ItemModel>>(
                  valueListenable: _selectedItemsNotifier,
                  builder: (context, selectedItems, child) {
                    final items = selectedItems;
                    final count = items.length;
                    final hasItems = count > 0;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Items',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: scheme.onSurface,
                          ),
                        ),
                        if (hasItems)
                          Text(
                            '$count item(s) selected',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close_rounded, color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: ValueListenableBuilder<bool>(
            valueListenable: _showCustomInputNotifier,
            builder: (context, showCustomInput, child) {
              final isCustom = showCustomInput;

              return Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showCustomInputNotifier.value = false,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !isCustom ? scheme.surface : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Select from List',
                            textAlign: TextAlign.center,
                            style: AppFonts.interStyle(
                              fontWeight: !isCustom ? FontWeight.w600 : FontWeight.normal,
                              color: !isCustom ? primary : scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showCustomInputNotifier.value = true,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isCustom ? scheme.surface : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Custom Item',
                            textAlign: TextAlign.center,
                            style: AppFonts.interStyle(
                              fontWeight: isCustom ? FontWeight.w600 : FontWeight.normal,
                              color: isCustom ? primary : scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ValueListenableBuilder<bool>(
              valueListenable: _showCustomInputNotifier,
              builder: (context, showCustomInput, child) {
                return showCustomInput ? _buildCustomInput() : _buildItemList();
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: ValueListenableBuilder2(
            first: _showCustomInputNotifier,
            second: _selectedItemsNotifier,
            builder: (context, showCustomInput, selectedItems, child) {
              final itemCount = selectedItems.length;
              final isEmpty = itemCount == 0;

              return SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _addItems,
                  icon: Icon(Icons.add_rounded),
                  label: Text(
                    showCustomInput
                        ? 'Add Custom Item'
                        : isEmpty
                            ? 'Add Selected Items'
                            : 'Add $itemCount Item(s)',
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: scheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCustomInput() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
              controller: _customNameController,
              labelText: 'Item Name *',
              hint: 'Enter item name',
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words),
          const SizedBox(height: 16),
          CustomTextFormField(
              controller: _customRateController,
              labelText: 'Rate (Optional)',
              hint: 'Enter item rate',
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.words),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.15)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Batch and expiry are filled automatically',
                    style: AppFonts.interStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemList() {
    return BlocConsumer<ItemCubit, ItemState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (response, hasMore) {
            _allItemsNotifier.value = response.data;
            _filteredItemsNotifier.value = response.data;
          },
          error: (message) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error loading items: $message'), backgroundColor: Colors.red)),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => Center(child: CircularProgressIndicator()),
          success: (response, hasMore) {
            final scheme = Theme.of(context).colorScheme;
            return Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Items',
                    hintText: 'Search by item name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    prefixIcon: AppSearchIcon.inputDecoration(),
                    suffixIcon: _searchController.text.isNotEmpty == true
                        ? IconButton(icon: Icon(Icons.clear), onPressed: () => _searchController.clear())
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder2(
                  first: _selectedItemsNotifier,
                  second: _filteredItemsNotifier,
                  builder: (context, selectedItems, filteredItems, child) {
                    final selectedCount = selectedItems?.length ?? 0;
                    final filteredCount = filteredItems?.length ?? 0;
                    final hasFilteredItems = filteredCount > 0;

                    if (hasFilteredItems) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '$selectedCount / $filteredCount selected',
                              style: AppFonts.interStyle(
                                fontSize: 13,
                                color: scheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            TextButton.icon(
                                onPressed: _selectAll,
                                icon: Icon(Icons.check_box, size: 16),
                                label: Text('All', style: AppFonts.interStyle(fontSize: 12)),
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    minimumSize: const Size(0, 32))),
                            const SizedBox(width: 4),
                            TextButton.icon(
                                onPressed: _clearSelection,
                                icon: Icon(Icons.clear, size: 16),
                                label: Text('Clear', style: AppFonts.interStyle(fontSize: 12)),
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    minimumSize: const Size(0, 32))),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ValueListenableBuilder<List<ItemModel>>(
                    valueListenable: _filteredItemsNotifier,
                    builder: (context, filteredItems, child) {
                      final itemsList = filteredItems ?? [];

                      if (itemsList.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off, size: 48, color: scheme.onSurfaceVariant),
                              const SizedBox(height: 12),
                              Text(
                                'No items found',
                                style: AppFonts.interStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ValueListenableBuilder<List<ItemModel>>(
                        valueListenable: _selectedItemsNotifier,
                        builder: (context, selectedItems, child) {
                          final selected = selectedItems ?? [];

                          return ListView.builder(
                            itemCount: itemsList.length,
                            itemBuilder: (context, index) {
                              final item = itemsList[index];
                              final isSelected = selected.any((i) => i.name == item.name);

                              final primary = Theme.of(context).colorScheme.primary;
                              final rowScheme = Theme.of(context).colorScheme;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected ? primary : rowScheme.outlineVariant,
                                    width: isSelected ? 1.5 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: isSelected
                                      ? Color.alphaBlend(primary.withValues(alpha: 0.08), rowScheme.surface)
                                      : rowScheme.surface,
                                ),
                                child: ListTile(
                                  onTap: () => _toggleItemSelection(item),
                                  leading: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isSelected ? primary : rowScheme.surfaceContainerHighest,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isSelected ? Icons.check_rounded : Icons.inventory_2_outlined,
                                      color: isSelected ? rowScheme.onPrimary : rowScheme.onSurfaceVariant,
                                      size: 20,
                                    ),
                                  ),
                                  title: Text(
                                    item.name,
                                    style: AppFonts.interStyle(
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                      fontSize: 14,
                                      color: rowScheme.onSurface,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Rate: $currencySymbol ${item.rate.toStringAsFixed(2)} • ${item.unit}',
                                    style: AppFonts.interStyle(
                                      fontSize: 12,
                                      color: rowScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  trailing: Checkbox(
                                    value: isSelected,
                                    onChanged: (_) => _toggleItemSelection(item),
                                    activeColor: primary,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
          noInternet: () {
            final scheme = Theme.of(context).colorScheme;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 48, color: scheme.onSurfaceVariant),
                  const SizedBox(height: 12),
                  Text(
                    'No Internet Connection',
                    style: AppFonts.interStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                const SizedBox(height: 8),
                ElevatedButton.icon(onPressed: _loadItems, icon: Icon(Icons.refresh), label: Text('Retry')),
              ],
            ),
          );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

// ValueListenableBuilder2 - Helper for listening to two ValueNotifiers
class ValueListenableBuilder2<A, B> extends StatelessWidget {
  const ValueListenableBuilder2(
      {super.key, required this.first, required this.second, required this.builder, this.child});

  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final Widget? child;
  final Widget Function(BuildContext context, A a, B b, Widget? child) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (context, a, _) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (context, b, _) {
            return builder(context, a, b, child);
          },
        );
      },
    );
  }
}

class _EntryOptionTile extends StatelessWidget {
  const _EntryOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.emphasized = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final primary = scheme.primary;

    final bg = emphasized ? primary : _stockCardColor(scheme);
    final titleColor = emphasized ? scheme.onPrimary : scheme.onSurface;
    final subtitleColor = emphasized ? scheme.onPrimary.withOpacity(0.85) : scheme.onSurfaceVariant;
    final iconColor = emphasized ? scheme.onPrimary : primary;
    final chevronColor = emphasized ? scheme.onPrimary.withOpacity(0.9) : scheme.onSurfaceVariant;

    return Material(
      color: bg,
      elevation: emphasized ? 0 : 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: emphasized
            ? BorderSide.none
            : BorderSide(color: scheme.outlineVariant.withOpacity(0.55)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 26),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: subtitleColor,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: chevronColor),
            ],
          ),
        ),
      ),
    );
  }
}

// StockItem Data Model
class StockItem {
  final String location;
  final String batchNumber;
  final String expiryDate;
  final double rate;
  final String notes;
  final TextEditingController itemNameController;
  final TextEditingController currentStockController;

  StockItem(
      {String? itemName,
      required this.location,
      required this.batchNumber,
      required this.expiryDate,
      required this.rate,
      required this.notes,
      String? currentStock})
      : itemNameController = TextEditingController(text: itemName),
        currentStockController = TextEditingController(text: currentStock);

  void dispose() {
    itemNameController.dispose();
    currentStockController.dispose();
  }
}
