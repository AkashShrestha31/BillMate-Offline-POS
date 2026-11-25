import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/constants/constants.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/services/app_loading_overlay.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/action/data/models/request/item_request_params.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:hotel/src/features/action/presentation/cubit/item_cubit.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/previous_stock_request_params.dart';
import 'package:hotel/src/features/reconciliation/data/models/request/reconciliation_report_request.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/previous_stock_response_model.dart';
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_cubit.dart';
import 'package:hotel/src/features/reconciliation/presentation/pages/reconciliation_details_page.dart';
import 'package:hotel/src/features/reconciliation/presentation/pages/reconciliation_report_screen.dart';

import '../bloc/reconciliation_report_cubit.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';

class StandardReconciliationPage extends StatefulWidget {
  const StandardReconciliationPage({super.key});

  @override
  _StandardReconciliationPageState createState() => _StandardReconciliationPageState();
}

class _StandardReconciliationPageState extends State<StandardReconciliationPage> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();

  // Form values
  DateTime? fromDate;
  DateTime? toDate;
  String? selectedCurrentStock;
  String? selectedPreviousStock;
  bool saveReport = true;

  // Selected items and locations
  List<String> selectedItems = [];
  List<String> selectedLocations = [];

  // Available stock options
  List<Map<String, String>> availableStocks = [];
  List<String> availableItems = [];

  final List<String> availableLocations = [
    "Stores",
    "Warehouse",
    "Main Office",
    "Branch Office",
    "Distribution Center",
  ];

  // Simple boolean flags to track loading status
  bool isPreviousStockLoaded = false;
  bool isItemsLoaded = false;

  // Check if both APIs have loaded successfully
  bool get isDataReady => isPreviousStockLoaded && isItemsLoaded;

  ColorScheme get _scheme => Theme.of(context).colorScheme;

  bool get _isButtonEnabled {
    // Match UX expectation: disable until the user selects required inputs.
    return fromDate != null &&
        toDate != null &&
        selectedCurrentStock != null &&
        selectedPreviousStock != null &&
        selectedItems.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    fromDate = today;
    toDate = today;
    _fromDateController.text = _formatDate(fromDate!);
    _toDateController.text = _formatDate(toDate!);

    // Load data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PreviousStockCubit>().getPreviousStock(params: PreviousStockRequestParams());
    });
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  /// Converts PreviousStockResponseModel to availableStocks format
  static List<Map<String, String>> mapToAvailableStocks(
    PreviousStockResponseModel response,
  ) {
    return response.uniqueReportingDates.asMap().entries.map((entry) {
      final index = entry.key;
      final reportingDate = entry.value;

      return {
        "id": "stock_${(index + 1).toString().padLeft(3, '0')}", // stock_001, stock_002, etc.
        "name": _generateStockName(reportingDate),
        "date": reportingDate.reportingDate.toString(),
      };
    }).toList();
  }

  static List<String> mapToAvailableItems(
    ItemResponseModel response,
  ) {
    return response.data.asMap().entries.map((entry) {
      final index = entry.key;
      final itemData = entry.value;
      return itemData.name;
    }).toList();
  }

  /// Generates a meaningful name for the stock based on reporting data
  static String _generateStockName(ReportingDateModel reportingDate) {
    final date = DateTime.parse(reportingDate.reportingDate);
    final formattedDate = "${_getMonthName(date.month)} ${date.day}, ${date.year}";

    return "Stock Report - $formattedDate";
  }

  /// Helper method to get month name
  static String _getMonthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<ReconciliationReportCubit, ReconciliationReportState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              error: (message) {
                AppLoadingOverlay.of(context).hide();
              },
              success: (response) {
                AppLoadingOverlay.of(context).hide();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReconciliationDetailsPage(
                            data: response.data,
                          )),
                );
              },
              loading: () {
                AppLoadingOverlay.of(context).show();
                // No action needed
              },
            );
          },
        ),
        BlocListener<ItemCubit, ItemState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error loading items: $message'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              success: (response, hasMore) {
                setState(() {
                  availableItems = mapToAvailableItems(response);
                  isItemsLoaded = true;
                });
              },
              loading: () {
                // No action needed
              },
            );
          },
        ),
        BlocListener<PreviousStockCubit, PreviousStockState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => null,
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error loading previous stock: $message'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              success: (response) {
                setState(() {
                  availableStocks = mapToAvailableStocks(response.data);
                  isPreviousStockLoaded = true;
                });
                // Load items after previous stock is loaded
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<ItemCubit>().getItems(params: ItemRequestParams(perPage: 1000, forFilter: "Sales"));
                });
              },
              loading: () {
                // No action needed
              },
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: AppBarIosBackButton(
            color: Theme.of(context).colorScheme.onSurface,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Start Reconciliation',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        body: isDataReady ? _buildMainContent() : _buildNoDataState(),
      ),
    );
  }

  Widget _buildNoDataState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator()
          // Container(
          //   padding: EdgeInsets.all(32),
          //   decoration: BoxDecoration(
          //     color: theme.colorScheme.surfaceContainerHigh,
          //     borderRadius: BorderRadius.circular(16),
          //     boxShadow: [
          //       BoxShadow(
          //         color: theme.colorScheme.shadow.withValues(alpha: 0.12),
          //         blurRadius: 10,
          //         spreadRadius: 2,
          //       ),
          //     ],
          //   ),
          //   child: Column(
          //     children: [
          //       Icon(
          //         Icons.inventory_2_outlined,
          //         size: 64,
          //         color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          //       ),
          //       SizedBox(height: 24),
          //       Text(
          //         'No Data Found',
          //         style: AppFonts.interStyle(
          //           fontSize: 20,
          //           fontWeight: FontWeight.w600,
          //           color: theme.colorScheme.onSurface,
          //         ),
          //       ),
          //       SizedBox(height: 12),
          //       Text(
          //         'Loading required information...',
          //         style: AppFonts.interStyle(
          //           fontSize: 14,
          //           color: theme.colorScheme.onSurfaceVariant,
          //         ),
          //         textAlign: TextAlign.center,
          //       ),
          //       SizedBox(height: 24),
          //       SizedBox(
          //         width: 32,
          //         height: 32,
          //         child: CircularProgressIndicator(
          //           strokeWidth: 3,
          //           valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[600]!),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SectionCard(
                    title: 'Date Range',
                    icon: Icons.date_range_rounded,
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildDateField(
                            'From Date',
                            _fromDateController,
                            (date) => setState(() => fromDate = date),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDateField(
                            'To Date',
                            _toDateController,
                            (date) => setState(() => toDate = date),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: 'Current Stock',
                    icon: Icons.inventory_2_rounded,
                    onTap: () => _showStockBottomSheet('current'),
                    child: _buildStockSelectorBody('current'),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: 'Previous Stock',
                    icon: Icons.history_rounded,
                    onTap: () => _showStockBottomSheet('previous'),
                    child: _buildStockSelectorBody('previous'),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: 'Items',
                    icon: Icons.shopping_bag_outlined,
                    trailing: _buildItemsHeaderActions(),
                    child: _buildMultiSelectBody(
                      availableItems,
                      selectedItems,
                      'No items selected',
                      onCustom: () => _showMultiSelectDialog(
                        'Select Items',
                        availableItems,
                        selectedItems,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: 'Locations',
                    icon: Icons.location_on_outlined,
                    trailing: _buildLocationsHeaderActions(),
                    child: _buildMultiSelectBody(
                      availableLocations,
                      selectedLocations,
                      'No locations selected',
                      onCustom: () => _showMultiSelectDialog(
                        'Select Locations',
                        availableLocations,
                        selectedLocations,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: scheme.surface,
            elevation: 0,
            child: SafeArea(
              top: false,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: scheme.outlineVariant.withValues(alpha: 0.45),
                    ),
                  ),
                ),
                child: CustomButtonWidget(
                  title: 'Start Reconciliation',
                  onPressed: _isButtonEnabled ? _submitForm : null,
                  buttonState: _isButtonEnabled
                      ? CustomButtonState.primary
                      : CustomButtonState.disabled,
                  borderRadius: 12,
                  height: 52,
                  elevation: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsHeaderActions() {
    final scheme = _scheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (selectedItems.isNotEmpty)
          TextButton(
            onPressed: () => setState(selectedItems.clear),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              foregroundColor: scheme.error,
            ),
            child: const Text('Clear'),
          ),
        TextButton(
          onPressed: () => setState(() {
            selectedItems
              ..clear()
              ..addAll(availableItems);
          }),
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            foregroundColor: scheme.primary,
          ),
          child: const Text('Select All'),
        ),
        TextButton(
          onPressed: () => _showMultiSelectDialog(
            'Select Items',
            availableItems,
            selectedItems,
          ),
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            foregroundColor: scheme.primary,
          ),
          child: const Text('Custom'),
        ),
      ],
    );
  }

  Widget _buildLocationsHeaderActions() {
    final scheme = _scheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (selectedLocations.isNotEmpty)
          TextButton(
            onPressed: () => setState(selectedLocations.clear),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              foregroundColor: scheme.error,
            ),
            child: const Text('Clear'),
          ),
        TextButton(
          onPressed: () => setState(() {
            selectedLocations
              ..clear()
              ..addAll(availableLocations);
          }),
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            foregroundColor: scheme.primary,
          ),
          child: const Text('Select All'),
        ),
        TextButton(
          onPressed: () => _showMultiSelectDialog(
            'Select Locations',
            availableLocations,
            selectedLocations,
          ),
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            foregroundColor: scheme.primary,
          ),
          child: const Text('Custom'),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final scheme = _scheme;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: scheme.onSurfaceVariant, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppFonts.interStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            height: 1,
            color: scheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(String label, TextEditingController controller, Function(DateTime) onDateChanged) {
    final scheme = _scheme;
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.tryParse(controller.text) ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (date != null) {
          controller.text = _formatDate(date);
          onDateChanged(date);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: scheme.primary, width: 1.5),
            ),
            contentPadding: const EdgeInsets.fromLTRB(14, 14, 8, 14),
            labelStyle: AppFonts.interStyle(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: Icon(
              Icons.calendar_today_rounded,
              color: scheme.onSurfaceVariant,
              size: 18,
            ),
            filled: true,
            fillColor: scheme.surfaceContainerHighest,
          ),
          style: AppFonts.interStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildStockSelectorBody(String stockType) {
    final scheme = _scheme;
    final isCurrentStock = stockType == 'current';
    final selectedStock =
        isCurrentStock ? selectedCurrentStock : selectedPreviousStock;
    final emptyText = isCurrentStock
        ? 'Tap to select current stock'
        : 'Tap to select previous stock';

    String? name;
    String? date;
    if (selectedStock != null) {
      for (final stock in availableStocks) {
        if (stock['id'] == selectedStock) {
          name = stock['name'];
          date = stock['date'];
          break;
        }
      }
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name ?? emptyText,
                style: AppFonts.interStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: name != null
                      ? scheme.onSurface
                      : scheme.onSurfaceVariant,
                ),
              ),
              if (date != null && date.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  date,
                  style: AppFonts.interStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        Icon(
          Icons.keyboard_arrow_down_rounded,
          color: scheme.onSurfaceVariant,
          size: 24,
        ),
      ],
    );
  }

  Widget _buildMultiSelectBody(
    List<String> availableOptions,
    List<String> selectedOptions,
    String emptyText, {
    required VoidCallback onCustom,
  }) {
    final scheme = _scheme;
    if (selectedOptions.isEmpty) {
      return GestureDetector(
        onTap: onCustom,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            emptyText,
            style: AppFonts.interStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${selectedOptions.length} of ${availableOptions.length} selected',
          style: AppFonts.interStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: selectedOptions
              .map(
                (option) => InputChip(
                  label: Text(option),
                  onDeleted: () => setState(() => selectedOptions.remove(option)),
                  deleteIconColor: scheme.onSurfaceVariant,
                  backgroundColor: scheme.surfaceContainerHighest,
                  side: BorderSide(
                    color: scheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                  labelStyle: AppFonts.interStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: scheme.onSurface,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  void _showStockBottomSheet(String stockType) {
    final pageContext = context;
    final theme = Theme.of(context);
    final isCurrentStock = stockType == 'current';
    final title = isCurrentStock ? 'Select Current Stock' : 'Select Previous Stock';
    final selectedStock = isCurrentStock ? selectedCurrentStock : selectedPreviousStock;

    final TextEditingController searchController = TextEditingController();
    List<Map<String, String>> filteredStocks = List.from(availableStocks);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.88,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: StatefulBuilder(
                builder: (ctx, setModalState) {
                  void filterStocks(String query) {
                    setModalState(() {
                      if (query.isEmpty) {
                        filteredStocks = List.from(availableStocks);
                      } else {
                        filteredStocks = availableStocks.where((stock) {
                          return stock['name']!.toLowerCase().contains(query.toLowerCase()) ||
                              stock['date']!.contains(query);
                        }).toList();
                      }
                    });
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 8, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.pop(sheetContext),
                                  icon: Icon(Icons.close),
                                ),
                              ],
                            ),
                            verticalMarginSmall,
                            Text(
                              '${filteredStocks.length} available',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            verticalMarginMedium,
                            const Divider(),
                            verticalMarginMedium,
                          ],
                        ),
                      ),

                      // Search Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                        child: TextField(
                          controller: searchController,
                          onChanged: filterStocks,
                          decoration: InputDecoration(
                            hintText: 'Search stocks by name or date...',
                            hintStyle: AppFonts.interStyle(color: theme.colorScheme.onSurfaceVariant),
                            prefixIcon: AppSearchIcon.inputDecoration(color: theme.colorScheme.onSurfaceVariant),
                            suffixIcon: searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear_rounded, color: theme.colorScheme.onSurfaceVariant),
                                    onPressed: () {
                                      searchController.clear();
                                      filterStocks('');
                                    },
                                  )
                                : null,
                            filled: true,
                            fillColor: theme.colorScheme.surfaceContainerHighest,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),

                      // Stock List
                      Expanded(
                        child: filteredStocks.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_off_rounded,
                                      size: 64,
                                      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No stocks found',
                                      style: AppFonts.interStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Try adjusting your search terms',
                                      style: AppFonts.interStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.75),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                itemCount: filteredStocks.length,
                                itemBuilder: (context, index) {
                                  final stock = filteredStocks[index];
                                  final isSelected = selectedStock == stock['id'];
                                  final primary = theme.colorScheme.primary;

                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? primary.withValues(alpha: 0.12)
                                          : theme.colorScheme.surfaceContainerHigh,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: isSelected
                                            ? primary.withValues(alpha: 0.45)
                                            : theme.colorScheme.outlineVariant,
                                        width: isSelected ? 2 : 1,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: primary.withValues(alpha: 0.12),
                                                blurRadius: 8,
                                                spreadRadius: 2,
                                              ),
                                            ]
                                          : [
                                              BoxShadow(
                                                color: theme.colorScheme.shadow.withValues(alpha: 0.12),
                                                blurRadius: 4,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(16),
                                        onTap: () {
                                          setState(() {
                                            if (isCurrentStock) {
                                              selectedCurrentStock = stock['id'];
                                            } else {
                                              selectedPreviousStock = stock['id'];
                                            }
                                          });

                                          // Add haptic feedback
                                          HapticFeedback.lightImpact();

                                          // Show success feedback
                                          ScaffoldMessenger.of(pageContext).showSnackBar(
                                            SnackBar(
                                              content: Row(
                                                children: [
                                                  Icon(Icons.check_circle, color: Colors.white),
                                                  const SizedBox(width: 8),
                                                  Text('${stock['name']} selected'),
                                                ],
                                              ),
                                              backgroundColor: Colors.green,
                                              duration: const Duration(seconds: 2),
                                              behavior: SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),
                                          );

                                          Navigator.pop(sheetContext);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              // Leading Icon
                                              Container(
                                                padding: const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? primary
                                                      : theme.colorScheme.surfaceContainerHighest,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Icon(
                                                  Icons.inventory_outlined,
                                                  color: isSelected
                                                      ? theme.colorScheme.onPrimary
                                                      : theme.colorScheme.onSurfaceVariant,
                                                  size: 24,
                                                ),
                                              ),
                                              const SizedBox(width: 16),

                                              // Content
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      stock['name']!,
                                                      style: AppFonts.interStyle(
                                                        fontWeight: FontWeight.w600,
                                                        color: isSelected
                                                            ? primary
                                                            : theme.colorScheme.onSurface,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.calendar_today_rounded,
                                                          size: 14,
                                                          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.75),
                                                        ),
                                                        const SizedBox(width: 4),
                                                        Text(
                                                          'Date: ${stock['date']}',
                                                          style: AppFonts.interStyle(
                                                            color: theme.colorScheme.onSurfaceVariant,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    if (stock['description'] != null) ...[
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        stock['description']!,
                                                        style: AppFonts.interStyle(
                                                          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.75),
                                                          fontSize: 12,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ),

                                              // Trailing
                                              AnimatedContainer(
                                                duration: const Duration(milliseconds: 200),
                                                child: isSelected
                                                    ? Container(
                                                        padding: const EdgeInsets.all(6),
                                                        decoration: BoxDecoration(
                                                          color: primary,
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                        child: Icon(
                                                          Icons.check_rounded,
                                                          color: theme.colorScheme.onPrimary,
                                                          size: 16,
                                                        ),
                                                      )
                                                    : Container(
                                                        padding: const EdgeInsets.all(6),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: theme.colorScheme.outlineVariant,
                                                            width: 2,
                                                          ),
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                        child: const SizedBox(
                                                          width: 16,
                                                          height: 16,
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),

                      // Bottom Actions (Optional)
                      if (selectedStock != null)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerLow,
                            border: Border(
                              top: BorderSide(color: theme.colorScheme.outlineVariant),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isCurrentStock) {
                                        selectedCurrentStock = null;
                                      } else {
                                        selectedPreviousStock = null;
                                      }
                                    });
                                    Navigator.pop(sheetContext);
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    'Clear Selection',
                                    style: AppFonts.interStyle(
                                      color: theme.colorScheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(sheetContext);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.primary,
                                    foregroundColor: theme.colorScheme.onPrimary,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'Confirm Selection',
                                    style: AppFonts.interStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Bottom Safe Area
                      SizedBox(height: MediaQuery.paddingOf(sheetContext).bottom),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMultiSelectSection(
      String title, List<String> availableOptions, List<String> selectedOptions, String emptyText) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Row(
                children: [
                  if (selectedOptions.isNotEmpty)
                    TextButton(
                      onPressed: () => setState(() => selectedOptions.clear()),
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Clear',
                        style: AppFonts.interStyle(
                          color: Colors.red[600],
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  TextButton(
                    onPressed: () => setState(() {
                      selectedOptions.clear();
                      selectedOptions.addAll(availableOptions);
                    }),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Select All',
                      style: AppFonts.interStyle(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _showMultiSelectDialog(title, availableOptions, selectedOptions),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Custom',
                      style: AppFonts.interStyle(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (selectedOptions.isEmpty)
            Text(emptyText, style: AppFonts.interStyle(color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.75), fontSize: 14))
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${selectedOptions.length} of ${availableOptions.length} selected',
                    style: AppFonts.interStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: selectedOptions
                      .map((option) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                                color: theme.colorScheme.surfaceContainerHigh,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6))),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(option,
                                    style:
                                        AppFonts.interStyle(fontSize: 13, fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface)),
                                SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () => setState(() => selectedOptions.remove(option)),
                                  child: Icon(Icons.close_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    final scheme = _scheme;
    return CheckboxListTile(
      title: Text(
        title,
        style: AppFonts.interStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: scheme.onSurface,
        ),
      ),
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: scheme.primary,
      checkColor: scheme.onPrimary,
    );
  }

  void _showMultiSelectDialog(String title, List<String> availableOptions, List<String> selectedOptions) {
    String searchQuery = '';
    List<String> filteredOptions = List.from(availableOptions);
    final theme = Theme.of(context);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.88,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: StatefulBuilder(
                builder: (ctx, setModalState) {
                  void updateFilteredOptions() {
                    if (searchQuery.isEmpty) {
                      filteredOptions = List.from(availableOptions);
                    } else {
                      filteredOptions = availableOptions.where((option) {
                        return option.toLowerCase().contains(searchQuery.toLowerCase());
                      }).toList();
                    }
                  }

                  updateFilteredOptions();

                  final allSelected =
                      filteredOptions.isNotEmpty && filteredOptions.every((o) => selectedOptions.contains(o));

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 8, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.pop(sheetContext),
                                  icon: Icon(Icons.close),
                                ),
                              ],
                            ),
                            verticalMarginSmall,
                            Text(
                              '${selectedOptions.length} of ${availableOptions.length} selected',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            verticalMarginMedium,
                            const Divider(),
                            verticalMarginMedium,
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                        child: TextField(
                          onChanged: (value) {
                            setModalState(() {
                              searchQuery = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search ${title.toLowerCase()}...',
                            hintStyle: AppFonts.interStyle(color: theme.colorScheme.onSurfaceVariant),
                            prefixIcon: AppSearchIcon.inputDecoration(color: theme.colorScheme.onSurfaceVariant),
                            suffixIcon: searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear_rounded, color: theme.colorScheme.onSurfaceVariant),
                                    onPressed: () {
                                      setModalState(() {
                                        searchQuery = '';
                                      });
                                    },
                                  )
                                : null,
                            filled: true,
                            fillColor: theme.colorScheme.surfaceContainerHighest,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CheckboxListTile(
                          title: Text(
                            searchQuery.isEmpty ? 'Select All' : 'Select All Filtered (${filteredOptions.length})',
                            style: AppFonts.interStyle(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          subtitle: searchQuery.isNotEmpty
                              ? Text(
                                  '${selectedOptions.length} of ${availableOptions.length} total selected',
                                  style: AppFonts.interStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                )
                              : null,
                          value: allSelected && filteredOptions.isNotEmpty,
                          onChanged: filteredOptions.isNotEmpty
                              ? (value) {
                                  setModalState(() {
                                    if (value == true) {
                                      for (final option in filteredOptions) {
                                        if (!selectedOptions.contains(option)) {
                                          selectedOptions.add(option);
                                        }
                                      }
                                    } else {
                                      selectedOptions.removeWhere(
                                        (o) => filteredOptions.contains(o),
                                      );
                                    }
                                  });
                                  setState(() {});
                                }
                              : null,
                          activeColor: theme.colorScheme.primary,
                          checkColor: theme.colorScheme.onPrimary,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Expanded(
                        child: filteredOptions.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_off_rounded,
                                      size: 48,
                                      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'No matches found',
                                      style: AppFonts.interStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Try adjusting your search',
                                      style: AppFonts.interStyle(
                                        fontSize: 12,
                                        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.75),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                itemCount: filteredOptions.length,
                                itemBuilder: (context, index) {
                                  final option = filteredOptions[index];
                                  final isSelected = selectedOptions.contains(option);

                                  return CheckboxListTile(
                                    title: Text(option),
                                    value: isSelected,
                                    onChanged: (value) {
                                      setModalState(() {
                                        if (value == true) {
                                          selectedOptions.add(option);
                                        } else {
                                          selectedOptions.remove(option);
                                        }
                                      });
                                      setState(() {});
                                    },
                                    activeColor: theme.colorScheme.primary,
                                    controlAffinity: ListTileControlAffinity.leading,
                                  );
                                },
                              ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                          24,
                          12,
                          24,
                          12 + MediaQuery.paddingOf(sheetContext).bottom,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: theme.dividerColor.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setModalState(() => selectedOptions.clear());
                                setState(() {});
                              },
                              child: Text(
                                'Clear All',
                                style: AppFonts.interStyle(color: Colors.red[600]),
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () => Navigator.pop(sheetContext),
                              child: Text(
                                'Done',
                                style: AppFonts.interStyle(
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String? currentStockDate;
      String? previousStockDate;

      if (selectedCurrentStock != null) {
        currentStockDate = availableStocks.firstWhere((stock) => stock['id'] == selectedCurrentStock)['date'];
      }

      if (selectedPreviousStock != null) {
        previousStockDate = availableStocks.firstWhere((stock) => stock['id'] == selectedPreviousStock)['date'];
      }

      context.read<ReconciliationReportCubit>().generateReconciliationReport(
              request: ReconciliationReportRequest(
            fromDate: _formatDate(fromDate!),
            toDate: _formatDate(toDate!),
            currentStockDate: currentStockDate!,
            previousStockDate: previousStockDate!,
            items: selectedItems,
            locations: selectedLocations,
            saveReport: saveReport,
          ));
    }
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
    this.trailing,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final Widget child;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final content = Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: scheme.primary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );

    return Material(
      color: scheme.surface,
      elevation: 0,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.45),
            ),
          ),
          child: content,
        ),
      ),
    );
  }
}
