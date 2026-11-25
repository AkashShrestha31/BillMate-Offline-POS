import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/employee_advanc_Pdf_export_service.dart';
import 'package:hotel/src/core/widget/action_bottom_sheet.dart';
import 'package:hotel/src/features/employee/data/models/response/advance_analysis_response.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';

class AdvanceInvoicePage extends StatefulWidget {
  final AdvanceAnalysisResponse response;

  const AdvanceInvoicePage({
    super.key,
    required this.response,
  });

  @override
  State<AdvanceInvoicePage> createState() => _AdvanceInvoicePageState();
}

class _AdvanceInvoicePageState extends State<AdvanceInvoicePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Set to track which employees are expanded
  final Set<String> _expandedEmployees = <String>{};

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward();
  }

  // Toggle employee expansion
  void _toggleEmployeeExpansion(String employeeName) {
    setState(() {
      if (_expandedEmployees.contains(employeeName)) {
        _expandedEmployees.remove(employeeName);
      } else {
        _expandedEmployees.add(employeeName);
      }
    });
  }

  void _showExportOptions(AdvanceAnalysisData employeeData, Color rankColor) {
    ActionBottomSheet.show(
      context,
      title: 'Export PDF',
      items: [
        ActionSheetItem(
          icon: Icons.download,
          title: 'Download',
          color: Theme.of(context).colorScheme.primary,
          onTap: () => _downloadEmployeePdf(employeeData),
        ),
        ActionSheetItem(
          icon: Icons.share,
          title: 'Share',
          color: Theme.of(context).colorScheme.secondary,
          onTap: () => _shareEmployeePdf(employeeData),
        ),
      ],
    );
  }

  // Download PDF for a specific employee
  Future<void> _downloadEmployeePdf(AdvanceAnalysisData employeeData) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Generating PDF...',
                style: AppFonts.interStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      // Generate PDF
      final pdfFile = await EmployeeAdvancePdfExportService.generateRecipientAdvancePdf(
        recipientData: employeeData,
        startDate: widget.response.filtersApplied.startDate ?? '',
        endDate: widget.response.filtersApplied.endDate ?? '',
      );

      // Move to Downloads directory
      final directory =
      Platform.isAndroid ? Directory('/storage/emulated/0/Download') : await getApplicationDocumentsDirectory();

      final fileName = pdfFile.path.split('/').last;
      final newFile = File('${directory.path}/$fileName');

      await pdfFile.copy(newFile.path);

      // Close loading dialog
      Navigator.pop(context);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('PDF downloaded successfully'),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      print('PDF Download Error: $e');
      print('Stack Trace: $stackTrace');

      // Close loading dialog
      Navigator.pop(context);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Failed to download PDF: ${e.toString()}'),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  // Share PDF for a specific employee
  Future<void> _shareEmployeePdf(AdvanceAnalysisData employeeData) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Preparing PDF...',
                style: AppFonts.interStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      // Generate PDF
      final pdfFile = await EmployeeAdvancePdfExportService.generateRecipientAdvancePdf(
        recipientData: employeeData,
        startDate: widget.response.filtersApplied.startDate ?? '',
        endDate: widget.response.filtersApplied.endDate ?? '',
      );

      // Close loading dialog
      Navigator.pop(context);

      // Share the PDF
      await Share.shareXFiles(
        [XFile(pdfFile.path)],
        text: 'Advance Report - ${employeeData.employeeName}',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('PDF shared successfully'),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      print('PDF Share Error: $e');
      print('Stack Trace: $stackTrace');

      // Close loading dialog
      Navigator.pop(context);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Failed to share PDF: ${e.toString()}'),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildSummaryCards(),
            // const SizedBox(height: 24),
            // widget.response.summary.earliestPurchase != null && widget.response.summary.latestPurchase != null
            //     ? _buildDateRangeInfo()
            //     : const SizedBox.shrink(),
            // const SizedBox(height: 24),
            _buildTopEmployeesSection(),
          ],
        ),
      ),
    );
  }

  // Widget _buildSummaryCards() {
  //   final formatter = NumberFormat.currency(symbol: '$currencySymbol ', decimalDigits: 0);
  //
  //   return Column(
  //     children: [
  //       // Main Total Card
  //       Container(
  //         padding: const EdgeInsets.all(24),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(20),
  //           border: Border.all(
  //             color: const Color(0xFF059669).withOpacity(0.1),
  //             width: 1,
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //               color: const Color(0xFF059669).withOpacity(0.08),
  //               blurRadius: 20,
  //               offset: const Offset(0, 8),
  //             ),
  //           ],
  //         ),
  //         child: Row(
  //           children: [
  //             Container(
  //               padding: const EdgeInsets.all(16),
  //               decoration: BoxDecoration(
  //                 gradient: const LinearGradient(
  //                   colors: [Color(0xFF059669), Color(0xFF10b981)],
  //                   begin: Alignment.topLeft,
  //                   end: Alignment.bottomRight,
  //                 ),
  //                 borderRadius: BorderRadius.circular(16),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: const Color(0xFF059669).withOpacity(0.3),
  //                     blurRadius: 12,
  //                     offset: const Offset(0, 4),
  //                   ),
  //                 ],
  //               ),
  //               child: Icon(
  //                 Icons.monetization_on_rounded,
  //                 color: Colors.white,
  //                 size: 28,
  //               ),
  //             ),
  //             const SizedBox(width: 20),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Total Advance Amount',
  //                     style: AppFonts.interStyle(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w600,
  //                       color: Colors.black87,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 4),
  //                   TweenAnimationBuilder<double>(
  //                     duration: const Duration(milliseconds: 1200),
  //                     tween: Tween<double>(begin: 0, end: widget.response.summary.grandTotalAmount),
  //                     builder: (context, value, child) {
  //                       return Text(
  //                         formatter.format(value),
  //                         style: AppFonts.interStyle(
  //                           fontSize: 24,
  //                           fontWeight: FontWeight.w800,
  //                           color: Color(0xFF059669),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //
  //       // Summary Statistics Row
  //       Row(
  //         children: [
  //           Expanded(
  //             child: _buildStatCard(
  //               'Total Invoices',
  //               widget.response.summary.totalInvoices.toString(),
  //               Icons.receipt_long,
  //               const Color(0xFF3b82f6),
  //             ),
  //           ),
  //           const SizedBox(width: 12),
  //           Expanded(
  //             child: _buildStatCard(
  //               'Employees',
  //               widget.response.summary.totalEmployees.toString(),
  //               Icons.people,
  //               const Color(0xFF7c3aed),
  //             ),
  //           ),
  //           const SizedBox(width: 12),
  //           Expanded(
  //             child: _buildStatCard(
  //               'Avg Amount',
  //               NumberFormat.compact().format(widget.response.summary.overallAverageAmount),
  //               Icons.trending_up,
  //               const Color(0xFFf59e0b),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, animValue, child) {
              return Text(
                value,
                style: AppFonts.interStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              );
            },
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppFonts.interStyle(
              fontSize: 11,
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Widget _buildDateRangeInfo() {
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(16),
  //       border: Border.all(
  //         color: Colors.grey[200]!,
  //         width: 1,
  //       ),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 10,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Icon(Icons.date_range, color: Colors.grey[600], size: 24),
  //         const SizedBox(width: 16),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 'Analysis Period',
  //                 style: AppFonts.interStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w600,
  //                   color: Colors.black87,
  //                 ),
  //               ),
  //               const SizedBox(height: 4),
  //               Text(
  //                 '${widget.response.filtersApplied.startDate} To ${widget.response.filtersApplied.endDate}',
  //                 style: AppFonts.interStyle(
  //                   fontSize: 13,
  //                   color: Colors.grey[600],
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildTopEmployeesSection() {
    final scheme = Theme.of(context).colorScheme;
    final formatter = AppMoneyFormat.currency(currencySymbol);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Top Advance Recipients',
        //   style: AppFonts.interStyle(
        //     fontSize: 20,
        //     fontWeight: FontWeight.w600,
        //     color: Colors.black87,
        //   ),
        // ),
        // const SizedBox(height: 16),
        ...widget.response.analysisData.asMap().entries.map((entry) {
          final index = entry.key;
          final employee = entry.value;
          final isExpanded = _expandedEmployees.contains(employee.employeeName);

          return GestureDetector(
            onLongPress: () {
              _showExportOptions(employee, _getRankColor(index));
            },
            onTap: () => _toggleEmployeeExpansion(employee.employeeName),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _getRankColor(index).withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  // Main employee card content
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _getRankColor(index),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              '#${index + 1}',
                              style: AppFonts.interStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                employee.employeeName,
                                style: AppFonts.interStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: scheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    '${employee.invoiceCount} advances',
                                    style: AppFonts.interStyle(
                                      fontSize: 12,
                                      color: scheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          formatter.format(employee.totalAmount),
                          style: AppFonts.interStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: _getRankColor(index),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // // Single export button
                        // IconButton(
                        //   onPressed: () => _showExportOptions(employee, _getRankColor(index)),
                        //   icon: Icon(
                        //     Icons.more_vert,
                        //     color: _getRankColor(index),
                        //     size: 24,
                        //   ),
                        //   tooltip: 'Export options',
                        //   style: IconButton.styleFrom(
                        //     backgroundColor: _getRankColor(index).withOpacity(0.1),
                        //     padding: const EdgeInsets.all(8),
                        //   ),
                        // ),
                        // const SizedBox(width: 8),

                        // Dropdown arrow
                        AnimatedRotation(
                          duration: const Duration(milliseconds: 200),
                          turns: isExpanded ? 0.5 : 0,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: scheme.onSurfaceVariant,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Expandable invoice list
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: isExpanded ? _buildAdvanceInvoiceList(employee) : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildAdvanceInvoiceList(AdvanceAnalysisData employeeData) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.receipt_long, size: 20, color: scheme.onSurfaceVariant),
                const SizedBox(width: 8),
                Text(
                  'Advance History (${employeeData.invoices.length})',
                  style: AppFonts.interStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          if (employeeData.invoices.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.receipt_outlined, size: 32, color: scheme.onSurfaceVariant),
                    const SizedBox(height: 8),
                    Text(
                      'No advance invoices found',
                      style: AppFonts.interStyle(
                        fontSize: 14,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...employeeData.invoices.map((invoice) => _buildAdvanceInvoiceItem(invoice)).toList(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildAdvanceInvoiceItem(Invoice invoice) {
    final scheme = Theme.of(context).colorScheme;
    final formatter = AppMoneyFormat.currency(currencySymbol);
    final dateFormatter = DateFormat('MMM dd, yyyy');

    final grandTotal = double.tryParse(invoice.grandTotal) ?? 0.0;
    final outstandingAmount = double.tryParse(invoice.outstandingAmount) ?? 0.0;

    final status = outstandingAmount == 0 ? 'Paid' : 'Unpaid';
    final statusColor = status == 'Paid' ? scheme.primary : scheme.tertiary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.description,
                  size: 16,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice.invoiceName,
                      style: AppFonts.interStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      dateFormatter.format(invoice.invoiceDate),
                      style: AppFonts.interStyle(
                        fontSize: 12,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatter.format(grandTotal),
                    style: AppFonts.interStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: scheme.primary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: AppFonts.interStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (outstandingAmount > 0) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scheme.errorContainer.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: scheme.error.withValues(alpha: 0.25)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, size: 16, color: scheme.error),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${context.l10n.unpaidAmount}: ${formatter.format(outstandingAmount)}',
                      style: AppFonts.interStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: scheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.badge, size: 14, color: scheme.onSurfaceVariant),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${invoice.employeeName} (${invoice.employeeCode})',
                  style: AppFonts.interStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                invoice.currency,
                style: AppFonts.interStyle(
                  fontSize: 12,
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getRankColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFf59e0b); // Gold
      case 1:
        return const Color(0xFF6b7280); // Silver
      case 2:
        return const Color(0xFFdc2626); // Bronze
      default:
        return const Color(0xFF059669); // Default green
    }
  }
}