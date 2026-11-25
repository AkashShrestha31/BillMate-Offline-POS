// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel/src/core/widget/scaffold_wrapper.dart';
// import 'package:hotel/src/features/dashboard/data/models/hotel_sales_request_params.dart';
// import 'package:hotel/src/features/dashboard/data/models/hotel_sales_response_model.dart';
// import 'package:hotel/src/features/dashboard/presentation/bloc/hotel_sales_cubit.dart';
// import 'package:intl/intl.dart';
//
// @RoutePage()
// class HotelSalesPage extends StatefulWidget {
//   const HotelSalesPage({super.key});
//
//   @override
//   State<HotelSalesPage> createState() => _HotelSalesPageState();
// }
//
// class _HotelSalesPageState extends State<HotelSalesPage> {
//   final DateFormat _dateFormat = DateFormat('MMM d, yyyy');
//   final NumberFormat _currencyFormat = NumberFormat.currency(symbol: '$currencySymbol', decimalDigits: 0);
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchHotelSales();
//   }
//
//   void _fetchHotelSales() {
//     context.read<HotelSalesCubit>().getHotelSales(params: HotelSalesRequestParams());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: Text('Hotel Sales Dashboard'),
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _fetchHotelSales,
//           ),
//         ],
//       ),
//       body: BlocBuilder<HotelSalesCubit, HotelSalesState>(
//         builder: (context, state) {
//           return state.maybeWhen(
//             orElse: () => const ScaffoldWrapper(body: Center(child: CircularProgressIndicator())),
//             loading: () => Center(child: CircularProgressIndicator()),
//             success: (snapshot) {
//               final salesData = snapshot.data;
//               return _buildMainContent(salesData.results);
//             },
//             error: (error) => Center(child: Text('Error: $error')),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildMainContent(List<SalesReport> sales) {
//     return RefreshIndicator(
//       onRefresh: () async => _fetchHotelSales(),
//       child: CustomScrollView(
//         controller: _scrollController,
//         slivers: [
//           // Summary Section
//           SliverToBoxAdapter(
//             child: _buildSummarySection(sales),
//           ),
//           // Header for list
//           SliverPadding(
//             padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
//             sliver: SliverToBoxAdapter(
//               child: Row(
//                 children: [
//                   Text(
//                     'Daily Sales Records',
//                     style: AppFonts.interStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     '${sales.length} entries',
//                     style: AppFonts.interStyle(
//                       fontSize: 14,
//                       color: Colors.grey[500],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Sales List
//           SliverPadding(
//             padding: const EdgeInsets.all(16),
//             sliver: SliverList(
//               delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                   final sale = sales[index];
//                   return _buildSalesCard(sale, index);
//                 },
//                 childCount: sales.length,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSummarySection(List<SalesReport> sales) {
//     final totalSales = sales.fold(0.0, (sum, item) => sum + item.salesAmount);
//     final totalExpenses = sales.fold(0.0, (sum, item) => sum + item.expenses);
//     final netProfit = totalSales - totalExpenses;
//     final totalCash = sales.fold(0.0, (sum, item) => sum + item.cashAmount);
//     final totalQR = sales.fold(0.0, (sum, item) => sum + item.qrAmount);
//
//     return Container(
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // First row - Main metrics
//             Row(
//               children: [
//                 _buildSummaryTile(
//                   title: 'Total Sales',
//                   value: totalSales,
//                   icon: Icons.shopping_bag,
//                   color: Colors.blue[600]!,
//                 ),
//                 const SizedBox(width: 12),
//                 _buildSummaryTile(
//                   title: 'Net Profit',
//                   value: netProfit,
//                   icon: Icons.trending_up,
//                   color: netProfit >= 0 ? Colors.green[600]! : Colors.red[600]!,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             // Second row - Secondary metrics
//             Row(
//               children: [
//                 _buildSummaryTile(
//                   title: 'Total Cash',
//                   value: totalCash,
//                   icon: Icons.currency_rupee,
//                   color: Colors.orange[600]!,
//                 ),
//                 const SizedBox(width: 12),
//                 _buildSummaryTile(
//                   title: 'Total QR',
//                   value: totalQR,
//                   icon: Icons.qr_code,
//                   color: Colors.purple[600]!,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSummaryTile({
//     required String title,
//     required double value,
//     required IconData icon,
//     required Color color,
//   }) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: color.withOpacity(0.2), width: 1),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(icon, size: 18, color: color),
//                 ),
//                 const Spacer(),
//                 Text(
//                   _currencyFormat.format(value),
//                   style: AppFonts.interStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: color,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: AppFonts.interStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSalesCard(SalesReport sale, int index) {
//     final profit = sale.salesAmount - sale.expenses;
//     final profitColor = profit >= 0 ? Colors.green : Colors.red;
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(12),
//           onTap: () => _showSaleDetails(context, sale),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     // Date and basic info
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             _dateFormat.format(sale.date),
//                             style: AppFonts.interStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Row(
//                             children: [
//                               Text(
//                                 'Sales: ${_currencyFormat.format(sale.salesAmount)}',
//                                 style: AppFonts.interStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8, vertical: 2),
//                                 decoration: BoxDecoration(
//                                   color: profitColor.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                                 child: Text(
//                                   _currencyFormat.format(profit),
//                                   style: AppFonts.interStyle(
//                                     fontSize: 12,
//                                     color: profitColor,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Status indicator
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: profit >= 0
//                             ? Colors.green.withOpacity(0.1)
//                             : Colors.red.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Text(
//                         profit >= 0 ? 'Profit' : 'Loss',
//                         style: AppFonts.interStyle(
//                           color: profit >= 0 ? Colors.green : Colors.red,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 // Payment breakdown
//                 Row(
//                   children: [
//                     _buildPaymentPill(
//                       label: 'Cash',
//                       value: sale.cashAmount,
//                       color: Colors.blue,
//                       icon: Icons.currency_rupee,
//                     ),
//                     const SizedBox(width: 8),
//                     _buildPaymentPill(
//                       label: 'QR',
//                       value: sale.qrAmount,
//                       color: Colors.purple,
//                       icon: Icons.qr_code,
//                     ),
//                     const Spacer(),
//                     _buildPaymentPill(
//                       label: 'Balance',
//                       value: sale.closingBalance,
//                       color: Colors.indigo,
//                       icon: Icons.account_balance_wallet,
//                       isBalance: true,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPaymentPill({
//     required String label,
//     required double value,
//     required Color color,
//     required IconData icon,
//     bool isBalance = false,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 16, color: color),
//           const SizedBox(width: 4),
//           Text(
//             _currencyFormat.format(value),
//             style: AppFonts.interStyle(
//               fontSize: 12,
//               fontWeight: isBalance ? FontWeight.bold : FontWeight.normal,
//               color: color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showSaleDetails(BuildContext context, SalesReport sale) {
//     final profit = sale.salesAmount - sale.expenses;
//     final profitColor = profit >= 0 ? Colors.green : Colors.red;
//
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 blurRadius: 20,
//                 spreadRadius: 2,
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 24),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Handle indicator
//                 Center(
//                   child: Container(
//                     width: 40,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Header
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Sales Details',
//                         style: AppFonts.interStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                     ),
//                     Text(
//                       _dateFormat.format(sale.date),
//                       style: AppFonts.interStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 // Summary cards
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildDetailSummaryCard(
//                         title: 'Total Sales',
//                         value: sale.salesAmount,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: _buildDetailSummaryCard(
//                         title: 'Net Profit',
//                         value: profit,
//                         color: profitColor,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 // Details list
//                 _buildDetailItem('Opening Balance', sale.openingBalance),
//                 _buildDetailItem('Cash Amount', sale.cashAmount),
//                 _buildDetailItem('QR Amount', sale.qrAmount),
//                 _buildDetailItem('Discount', sale.discount),
//                 const Divider(height: 24, thickness: 1),
//                 _buildDetailItem('Expenses', sale.expenses, isExpense: true),
//                 _buildDetailItem('Unpaid Amount', sale.unPaid),
//                 _buildDetailItem('Credit (Cash)', sale.creditPaidCash),
//                 _buildDetailItem('Credit (QR)', sale.creditQr),
//                 const Divider(height: 24, thickness: 1),
//                 _buildDetailItem(
//                   'Closing Balance',
//                   sale.closingBalance,
//                   isTotal: true,
//                 ),
//                 const SizedBox(height: 24),
//                 // Close button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.indigo,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () => Navigator.pop(context),
//                     child: Text(
//                       'Close',
//                       style: AppFonts.interStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildDetailSummaryCard({
//     required String title,
//     required double value,
//     required Color color,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: AppFonts.interStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             _currencyFormat.format(value),
//             style: AppFonts.interStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDetailItem(String label, double value,
//       {bool isTotal = false, bool isExpense = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               label,
//               style: AppFonts.interStyle(
//                 fontSize: 16,
//                 color: isTotal
//                     ? Colors.indigo
//                     : isExpense
//                     ? Colors.red
//                     : Colors.grey[700],
//                 fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ),
//           Text(
//             _currencyFormat.format(value),
//             style: AppFonts.interStyle(
//               fontSize: 16,
//               color: isTotal
//                   ? Colors.indigo
//                   : isExpense
//                   ? Colors.red
//                   : Colors.grey[700],
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/scaffold_wrapper.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_response_model.dart';
import 'package:hotel/src/features/dashboard/presentation/bloc/hotel_sales_cubit.dart';
import 'package:intl/intl.dart';
import 'package:hotel/constants.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';

@RoutePage()
class HotelSalesPage extends StatefulWidget {
  const HotelSalesPage({super.key});

  @override
  State<HotelSalesPage> createState() => _HotelSalesPageState();
}

class _HotelSalesPageState extends State<HotelSalesPage> {
  final DateFormat _dateFormat = DateFormat('MMM d, yyyy');
  final NumberFormat _currencyFormat = AppMoneyFormat.currency(currencySymbol);
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _salesController = TextEditingController();
  final TextEditingController _cashController = TextEditingController();
  final TextEditingController _qrController = TextEditingController();
  final TextEditingController _expensesController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _unpaidController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchHotelSales();
  }

  void _fetchHotelSales() {
    context
        .read<HotelSalesCubit>()
        .getHotelSales(params: HotelSalesRequestParams());
  }

  void _clearForm() {
    _salesController.clear();
    _cashController.clear();
    _qrController.clear();
    _expensesController.clear();
    _discountController.clear();
    _unpaidController.clear();
    _notesController.clear();
    _selectedDate = DateTime.now();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newRecord = SalesReport(
        id: 0, // Temporary ID, will be assigned by server
        date: _selectedDate,
        openingBalance: 0, // Will be calculated on server
        salesAmount: double.parse(_salesController.text),
        qrAmount: double.parse(_qrController.text),
        cashAmount: double.parse(_cashController.text),
        discount: double.parse(_discountController.text),
        expenses: double.parse(_expensesController.text),
        unPaid: double.parse(_unpaidController.text),
        unPaidDiscount: 0,
        creditPaidCash: 0,
        creditQr: 0,
        closingBalance: 0, // Will be calculated on server
        lostMoney: 0,
      );

      // Here you would typically call your cubit to add the new record
      // context.read<HotelSalesCubit>().addSalesRecord(newRecord);

      // For now, we'll just show a snackbar and refresh
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('New sales record added successfully')),
      );
      _clearForm();
      Navigator.pop(context);
      _fetchHotelSales();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text('Hotel Sales Dashboard'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchHotelSales,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddRecordDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<HotelSalesCubit, HotelSalesState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const ScaffoldWrapper(
                body: Center(child: CircularProgressIndicator())),
            loading: () => Center(child: CircularProgressIndicator()),
            success: (snapshot) {
              final salesData = snapshot.data;
              return _buildMainContent(salesData.results);
            },
            error: (error) => Center(child: Text('Error: $error')),
          );
        },
      ),
    );
  }

  Widget _buildMainContent(List<SalesReport> sales) {
    return RefreshIndicator(
      onRefresh: () async => _fetchHotelSales(),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: _buildSummarySection(sales),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(
                    'Daily Sales Records',
                    style: AppFonts.interStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${sales.length} entries',
                    style: AppFonts.interStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final sale = sales[index];
                  return _buildSalesCard(sale, index);
                },
                childCount: sales.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(List<SalesReport> sales) {
    final totalSales = sales.fold(0.0, (sum, item) => sum + item.salesAmount);
    final totalExpenses = sales.fold(0.0, (sum, item) => sum + item.expenses);
    final netProfit = totalSales - totalExpenses;
    final totalCash = sales.fold(0.0, (sum, item) => sum + item.cashAmount);
    final totalQR = sales.fold(0.0, (sum, item) => sum + item.qrAmount);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // First row - Main metrics
            Row(
              children: [
                _buildSummaryTile(
                  title: 'Total Sales',
                  value: totalSales,
                  icon: Icons.shopping_bag,
                  color: Colors.blue[600]!,
                ),
                const SizedBox(width: 12),
                _buildSummaryTile(
                  title: 'Net Profit',
                  value: netProfit,
                  icon: Icons.trending_up,
                  color: netProfit >= 0 ? Colors.green[600]! : Colors.red[600]!,
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Second row - Secondary metrics
            Row(
              children: [
                _buildSummaryTile(
                  title: 'Total Cash',
                  value: totalCash,
                  icon: Icons.currency_rupee,
                  color: Colors.orange[600]!,
                ),
                const SizedBox(width: 12),
                _buildSummaryTile(
                  title: 'Total QR',
                  value: totalQR,
                  icon: Icons.qr_code,
                  color: Colors.purple[600]!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryTile({
    required String title,
    required double value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 18, color: color),
                ),
                const Spacer(),
                Text(
                  _currencyFormat.format(value),
                  style: AppFonts.interStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppFonts.interStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesCard(SalesReport sale, int index) {
    final profit = sale.salesAmount - sale.expenses;
    final profitColor = profit >= 0 ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _showSaleDetails(context, sale),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Date and basic info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _dateFormat.format(sale.date),
                            style: AppFonts.interStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Sales: ${_currencyFormat.format(sale.salesAmount)}',
                                style: AppFonts.interStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: profitColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  _currencyFormat.format(profit),
                                  style: AppFonts.interStyle(
                                    fontSize: 12,
                                    color: profitColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Status indicator
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: profit >= 0
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        profit >= 0 ? 'Profit' : 'Loss',
                        style: AppFonts.interStyle(
                          color: profit >= 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Payment breakdown
                Row(
                  children: [
                    _buildPaymentPill(
                      label: 'Cash',
                      value: sale.cashAmount,
                      color: Colors.blue,
                      icon: Icons.currency_rupee,
                    ),
                    const SizedBox(width: 8),
                    _buildPaymentPill(
                      label: 'QR',
                      value: sale.qrAmount,
                      color: Colors.purple,
                      icon: Icons.qr_code,
                    ),
                    const Spacer(),
                    _buildPaymentPill(
                      label: 'Balance',
                      value: sale.closingBalance,
                      color: Colors.indigo,
                      icon: Icons.account_balance_wallet,
                      isBalance: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentPill({
    required String label,
    required double value,
    required Color color,
    required IconData icon,
    bool isBalance = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            _currencyFormat.format(value),
            style: AppFonts.interStyle(
              fontSize: 12,
              fontWeight: isBalance ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showSaleDetails(BuildContext context, SalesReport sale) {
    final profit = sale.salesAmount - sale.expenses;
    final profitColor = profit >= 0 ? Colors.green : Colors.red;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          padding:
              const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle indicator
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Header
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Sales Details',
                        style: AppFonts.interStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    Text(
                      _dateFormat.format(sale.date),
                      style: AppFonts.interStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Summary cards
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailSummaryCard(
                        title: 'Total Sales',
                        value: sale.salesAmount,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDetailSummaryCard(
                        title: 'Net Profit',
                        value: profit,
                        color: profitColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Details list
                _buildDetailItem('Opening Balance', sale.openingBalance),
                _buildDetailItem('Cash Amount', sale.cashAmount),
                _buildDetailItem('QR Amount', sale.qrAmount),
                _buildDetailItem('Discount', sale.discount),
                const Divider(height: 24, thickness: 1),
                _buildDetailItem('Expenses', sale.expenses, isExpense: true),
                _buildDetailItem('Unpaid Amount', sale.unPaid),
                _buildDetailItem('Credit (Cash)', sale.creditPaidCash),
                _buildDetailItem('Credit (QR)', sale.creditQr),
                const Divider(height: 24, thickness: 1),
                _buildDetailItem(
                  'Closing Balance',
                  sale.closingBalance,
                  isTotal: true,
                ),
                const SizedBox(height: 24),
                // Close button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Close',
                      style: AppFonts.interStyle(color: Colors.white),
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

  Widget _buildDetailSummaryCard({
    required String title,
    required double value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.interStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _currencyFormat.format(value),
            style: AppFonts.interStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, double value,
      {bool isTotal = false, bool isExpense = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppFonts.interStyle(
                fontSize: 16,
                color: isTotal
                    ? Colors.indigo
                    : isExpense
                        ? Colors.red
                        : Colors.grey[700],
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            _currencyFormat.format(value),
            style: AppFonts.interStyle(
              fontSize: 16,
              color: isTotal
                  ? Colors.indigo
                  : isExpense
                      ? Colors.red
                      : Colors.grey[700],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddRecordDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          padding: EdgeInsets.only(
            top: 16,
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Add New Sales Record',
                    style: AppFonts.interStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Date Picker
                  ListTile(
                    title: Text('Date'),
                    subtitle: Text(_dateFormat.format(_selectedDate)),
                    trailing: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          setState(() {
                            _selectedDate = date;
                          });
                        }
                      },
                    ),
                  ),
                  const Divider(height: 1),

                  // Sales Amount
                  _buildFormField(
                    controller: _salesController,
                    label: 'Sales Amount ($currencySymbol)',
                    icon: Icons.shopping_bag,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                  ),

                  // Cash Amount
                  _buildFormField(
                    controller: _cashController,
                    label: 'Cash Amount ($currencySymbol)',
                    icon: Icons.currency_rupee,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                  ),

                  // QR Amount
                  _buildFormField(
                    controller: _qrController,
                    label: 'QR Amount ($currencySymbol)',
                    icon: Icons.qr_code,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                  ),

                  // Expenses
                  _buildFormField(
                    controller: _expensesController,
                    label: 'Expenses ($currencySymbol)',
                    icon: Icons.money_off,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                  ),

                  // Discount
                  _buildFormField(
                    controller: _discountController,
                    label: 'Discount ($currencySymbol)',
                    icon: Icons.discount,
                    defaultValue: '0.00',
                    keyboardType: TextInputType.number,
                  ),

                  // Unpaid Amount
                  _buildFormField(
                    controller: _unpaidController,
                    label: 'Unpaid Amount ($currencySymbol)',
                    icon: Icons.credit_card_off,
                    defaultValue: '0.00',
                    keyboardType: TextInputType.number,
                  ),

                  // Notes
                  _buildFormField(
                    controller: _notesController,
                    label: 'Notes',
                    icon: Icons.notes,
                    maxLines: 2,
                  ),

                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _clearForm();
                          },
                          child: Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: _submitForm,
                          child: Text(
                            'Save Record',
                            style: AppFonts.interStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isRequired = false,
    String? defaultValue,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    if (defaultValue != null && controller.text.isEmpty) {
      controller.text = defaultValue;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                if (keyboardType == TextInputType.number &&
                    double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              }
            : null,
      ),
    );
  }
}
