// http://192.168.1.11:8000/api/hotel/parties/search/?party_role=all&search_term=employee
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/routes/app_router.gr.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_outstanding_response.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_outstanding_result.dart';
import 'package:hotel/src/features/employee/data/models/response/employee_party_outstanding_response.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:hotel/src/features/invoice/presentation/widgets/transaction_details_bottom_sheet.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';
import 'package:intl/intl.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

class EmployeeOutstandingPage extends StatefulWidget {
  const EmployeeOutstandingPage({
    super.key,
    required this.result,
  });

  final EmployeeOutstandingResult result;

  @override
  State<EmployeeOutstandingPage> createState() => _EmployeeOutstandingPageState();
}

class _EmployeeOutstandingPageState extends State<EmployeeOutstandingPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildOutstandingTab();
  }

  Widget _buildOutstandingTab() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.result.when(
        search: (response) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: _buildPartiesListFromResponse(response),
        ),
        employeePartyLookup: (lookup) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: _buildEmployeeLookupContent(lookup),
        ),
      ),
    );
  }

  Widget _buildEmployeeLookupContent(EmployeePartyOutstandingResponse lookup) {
    final scheme = Theme.of(context).colorScheme;
    final currencyFmt = AppMoneyFormat.currency(lookup.partyDetails.currency ?? currencySymbol);
    final dateFmt = DateFormat('MMM dd, yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (lookup.mode != null)
        //   Padding(
        //     padding: const EdgeInsets.only(bottom: 12),
        //     child: Chip(
        //       label: Text(lookup.mode!),
        //       backgroundColor: scheme.secondaryContainer.withOpacity(0.6),
        //       side: BorderSide(color: scheme.outlineVariant.withOpacity(0.5)),
        //     ),
        //   ),
        // Text(
        //   lookup.employeeDetails.fullName ?? '${lookup.employeeDetails.firstName ?? ''} ${lookup.employeeDetails.lastName ?? ''}'.trim(),
        //   style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        // ),
        // if (lookup.employeeDetails.department != null)
        //   Text(
        //     '${lookup.employeeDetails.position ?? ''} · ${lookup.employeeDetails.department}',
        //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        //   ),
        // const SizedBox(height: 16),
        // _buildSummaryTiles(lookup, currencyFmt),
        // const SizedBox(height: 20),
        // Text('Linked party', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        // const SizedBox(height: 8),
        if (lookup.salesInvoices.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text(
                'No sales invoices',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ),
          )
        else ...[
          Text('Sales invoices', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ...lookup.salesInvoices.map(
            (inv) => _buildOutstandingInvoiceTile(
              inv,
              currencyFmt,
              dateFmt,
              scheme,
              onTap: () => _pushSalesInvoiceDetails(context, inv),
            ),
          ),
        ],
      ],
    );
  }

  void _pushSalesInvoiceDetails(BuildContext context, EmployeePartyOutstandingInvoiceRow inv) {
    showTransactionDetailsBottomSheet(
      context: context,
      invoice: _invoiceItemFromOutstandingRow(inv),
      invoiceType: InvoiceType.sales,
    );
  }

  InvoiceItem _invoiceItemFromOutstandingRow(EmployeePartyOutstandingInvoiceRow inv) {
    return InvoiceItem(
      invoiceName: inv.invoiceName,
      party: inv.party,
      grandTotal: inv.grandTotal,
      date: inv.date,
      status: inv.status,
      outstandingAmount: inv.outstandingAmount,
      invoiceType: InvoiceType.sales,
      items: inv.items
          .map(
            (e) => ItemDetails(
              item: e.item,
              quantity: e.quantity,
              amount: e.amount,
            ),
          )
          .toList(),
    );
  }

  Widget _buildOutstandingInvoiceTile(
    EmployeePartyOutstandingInvoiceRow inv,
    NumberFormat currencyFmt,
    DateFormat dateFmt,
    ColorScheme scheme, {
    VoidCallback? onTap,
  }) {
    final unpaid = inv.status.toLowerCase() != 'paid';
    final card = Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  inv.invoiceName,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: unpaid ? scheme.errorContainer.withOpacity(0.5) : scheme.primaryContainer.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  inv.status,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${dateFmt.format(DateTime.tryParse(inv.date) ?? DateTime.now())} · ${currencyFmt.format(inv.grandTotal)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
          if (inv.outstandingAmount > 0)
            Text(
              'Due ${currencyFmt.format(inv.outstandingAmount)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.error,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          // if (inv.items.isNotEmpty) ...[
          //   const SizedBox(height: 8),
          //   ...inv.items.map(
          //     (line) => Padding(
          //       padding: const EdgeInsets.only(top: 4),
          //       child: Text(
          //         '· ${line.item} × ${line.quantity} — ${currencyFmt.format(line.amount)}',
          //         style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          //       ),
          //     ),
          //   ),
          // ],
        ],
      ),
    );
    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: card,
      ),
    );
  }

  Widget _buildPartiesListFromResponse(EmployeeOutstandingResponse response) {
    final scheme = Theme.of(context).colorScheme;
    final allParties = [
      ...response.partiesByRole.customerParties,
      ...response.partiesByRole.supplierParties,
      ...response.partiesByRole.employeeParties,
      ...response.partiesByRole.otherParties,
    ];

    if (allParties.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.search_off, size: 48, color: scheme.onSurfaceVariant),
              const SizedBox(height: 16),
              Text(
                'No parties found',
                style: AppFonts.interStyle(
                  fontSize: 16,
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...allParties.asMap().entries.map((entry) {
          final index = entry.key;
          final party = entry.value;
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 200 + (index * 100)),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 10 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: _buildPartyCard(party),
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildPartyCard(Party party, {VoidCallback? onPartyTap}) {
    final scheme = Theme.of(context).colorScheme;
    final formatter =
        AppMoneyFormat.currency(party.currency ?? currencySymbol);

    Color roleColor;
    IconData roleIcon;

    switch (party.role.toLowerCase()) {
      case 'customer':
        roleColor = const Color(0xFF059669);
        roleIcon = Icons.person;
        break;
      case 'supplier':
        roleColor = const Color(0xFFdc2626);
        roleIcon = Icons.business;
        break;
      case 'employee':
        roleColor = const Color(0xFF7c3aed);
        roleIcon = Icons.badge;
        break;
      default:
        roleColor = const Color(0xFF0891b2);
        roleIcon = Icons.group;
    }

    return GestureDetector(
      onTap: onPartyTap ??
          () {
            if (party.role.toLowerCase() == 'employee') {
              context.router.push(PartyInvoiceTabbedRoute(
                partyName: party.name.toString(),
              ));
            } else {
              context.router.push(PartyInvoiceRoute(
                partyName: party.name.toString(),
                invoiceType: InvoiceType.sales,
              ));
            }
          },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: roleColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(roleIcon, color: roleColor, size: 17),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        party.name.split('-')[0],
                        style: AppFonts.interStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatter.format(party.outstandingAmount),
                      style: AppFonts.interStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: party.outstandingAmount > 0
                            ? scheme.error
                            : scheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (party.email != null || party.phone != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    if (party.email != null) ...[
                      Icon(Icons.email, size: 16, color: scheme.onSurfaceVariant),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          party.email!,
                          style: AppFonts.interStyle(
                            fontSize: 14,
                            color: scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                    if (party.phone != null) ...[
                      if (party.email != null) const SizedBox(width: 16),
                      Icon(Icons.phone, size: 16, color: scheme.onSurfaceVariant),
                      const SizedBox(width: 8),
                      Text(
                        party.phone!,
                        style: AppFonts.interStyle(
                          fontSize: 14,
                          color: scheme.onSurfaceVariant,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
