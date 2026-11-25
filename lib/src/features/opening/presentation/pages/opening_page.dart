import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/features/closing/data/models/request/hotel_summary_request_params.dart';
import 'package:hotel/src/features/closing/data/models/response/hotel_summary_response_model.dart';
import 'package:hotel/src/features/closing/domain/repositories/hotel_summary_repository.dart';
import 'package:hotel/src/features/closing/presentation/bloc/hotel_summary_cubit.dart';
import 'package:intl/intl.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/widget/app_delete_icon.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/features/opening/data/models/request/cash_register_query_params.dart';
import 'package:hotel/src/features/opening/domain/repositories/opening_repository.dart';
import 'package:hotel/src/features/opening/data/models/response/cash_register_model.dart';
import 'package:hotel/src/features/opening/presentation/cubit/opening_cubit.dart';
import 'package:hotel/src/features/opening/presentation/widgets/opening_control_sheet.dart';
import 'package:hotel/src/features/opening/presentation/widgets/register_details_sheet.dart';
import 'package:hotel/constants.dart';

@RoutePage()
class OpeningPage extends StatelessWidget {
  const OpeningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OpeningCubit>()..getRegisters(),
      child: const _OpeningView(),
    );
  }
}

class _OpeningView extends StatefulWidget {
  const _OpeningView();

  @override
  State<_OpeningView> createState() => _OpeningViewState();
}

class _OpeningViewState extends State<_OpeningView> {
  bool _pendingShowCloseForAlreadyOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarIosBackButton(),
        title: Text('Opening'),
        centerTitle: false,
      ),
      body: BlocConsumer<OpeningCubit, OpeningState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              if (message.toLowerCase().contains('already open')) {
                _showAlreadyOpenDialog(context, message);
              } else if (message.toLowerCase().contains('already exists')) {
                _showAlreadyExistsForDateDialog(context, message);
              } else {
                context.showKiiSnackBarError(message);
              }
            },
            noInternet: () => context.showKiiSnackBarError('No internet connection'),
            openSuccess: (_) {
              context.showKiiSnackBarSuccess('Register opened successfully');
              context.read<OpeningCubit>().getRegisters();
            },
            closeSuccess: (_) {
              context.showKiiSnackBarSuccess('Register closed successfully');
              context.read<OpeningCubit>().getRegisters();
            },
            deleteSuccess: () {
              context.showKiiSnackBarSuccess('Register deleted');
              context.read<OpeningCubit>().getRegisters();
            },
            migrateSuccess: (message) {
              context.showKiiSnackBarSuccess(message);
              context.read<OpeningCubit>().getRegisters();
            },
            registersLoaded: (registers) {
              if (!_pendingShowCloseForAlreadyOpen) return;
              final openRegisters = registers.where((r) => r.status == 'open').toList();
              if (openRegisters.isNotEmpty) {
                setState(() => _pendingShowCloseForAlreadyOpen = false);
                if (context.mounted) {
                  OpeningControlSheet.showClose(
                    context: context,
                    register: openRegisters.first,
                    onClose: (request) => context.read<OpeningCubit>().closeRegister(request),
                    closedBy: context.employeeData?.email ?? '',
                  );
                }
              }
            },
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: Text('Tap Open Register to start')),
            loading: () => Center(child: CircularProgressIndicator()),
            registersLoaded: (registers) => _RegisterList(registers: registers),
            openSuccess: (_) => Center(child: CircularProgressIndicator()),
            closeSuccess: (_) => Center(child: CircularProgressIndicator()),
            deleteSuccess: () => Center(child: CircularProgressIndicator()),
            migrateSuccess: (_) => Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text(message)),
            noInternet: () => Center(child: Text('No internet connection')),
          );
        },
      ),
      floatingActionButton: Tooltip(
        message: 'Open Register',
        child: FloatingActionButton(
          onPressed: () => _showOpeningControl(context),
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 4,
          shape: const CircleBorder(),
          child: Icon(Icons.add, size: 28),
        ),
      ),
    );
  }

  void _showAlreadyOpenDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Shift already open'),
        content: Text(
          '$message\n\nWould you like to close the current shift first?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _pendingShowCloseForAlreadyOpen = true);
              context.read<OpeningCubit>().getRegisters(
                    params: const CashRegisterQueryParams(status: 'open'),
                  );
            },
            child: Text('Close current shift'),
          ),
        ],
      ),
    );
  }

  void _showOpeningControl(BuildContext context) {
    final repo = getIt<OpeningRepository>();
    OpeningControlSheet.show(
      context: context,
      onOpen: (request) => context.read<OpeningCubit>().openRegister(request),
      openedBy: context.employeeData?.email ?? '',
      closedBy: context.employeeData?.email ?? '',
      getCounterForDate: (shiftDate) async {
        final result = await repo.getCounterForDate(shiftDate);
        return result.fold((_) => null, (r) => r);
      },
      onRequestCloseRegister: (existing) {
        OpeningControlSheet.showClose(
          context: context,
          register: existing,
          onClose: (request) => context.read<OpeningCubit>().closeRegister(request),
          closedBy: context.employeeData?.email ?? '',
        );
      },
    );
  }
}

void _showAlreadyExistsForDateDialog(BuildContext context, String message) {
  showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Counter already exists'),
      content: Text(
        '$message\n\nOnly ONE counter is allowed per date. '
        'Re-open the form and choose a different date, or close the existing counter from the list.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text('OK'),
        ),
      ],
    ),
  );
}

class _RegisterList extends StatefulWidget {
  const _RegisterList({required this.registers});

  final List<CashRegisterModel> registers;

  @override
  State<_RegisterList> createState() => _RegisterListState();
}

class _RegisterListState extends State<_RegisterList> {
  final Map<String, SalesSummary> _summaryByDate = {};
  bool _loadingSummaries = true;

  @override
  void initState() {
    super.initState();
    _loadSummaries();
  }

  @override
  void didUpdateWidget(_RegisterList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.registers != widget.registers) {
      _loadSummaries();
    }
  }

  String _resolveShiftDate(CashRegisterModel r) {
    if (r.shiftDate != null && r.shiftDate!.trim().isNotEmpty) {
      return r.shiftDate!.trim();
    }
    final opening = r.openingTime ?? '';
    if (opening.contains('T')) return opening.split('T').first;
    return opening;
  }

  Future<void> _loadSummaries() async {
    setState(() => _loadingSummaries = true);
    final dates = widget.registers
        .map(_resolveShiftDate)
        .where((d) => d.isNotEmpty)
        .toSet();

    final repo = getIt<HotelSummaryRepository>();
    final results = await Future.wait(
      dates.map((date) async {
        final result = await repo.getHotelSummaries(
          params: HotelSummaryRequestParams(
            date: date,
            openingAmount: '0',
            totalAvailableAmount: '0',
            payCashGetQrExchange: '0',
            payQrGetCashExchange: '0',
          ),
        );
        return MapEntry(date, result);
      }),
    );

    final next = <String, SalesSummary>{};
    for (final entry in results) {
      entry.value.fold((_) {}, (api) {
        next[entry.key] = api.data.summary;
      });
    }

    if (!mounted) return;
    setState(() {
      _summaryByDate
        ..clear()
        ..addAll(next);
      _loadingSummaries = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (widget.registers.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.point_of_sale_outlined,
                  size: 56, color: theme.colorScheme.outline),
              const SizedBox(height: 16),
              Text(
                'No counters yet',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap + to open today\'s register',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<OpeningCubit>().getRegisters();
        await _loadSummaries();
      },
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
        itemCount: widget.registers.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final register = widget.registers[index];
          final shiftDate = _resolveShiftDate(register);
          final summary = shiftDate.isNotEmpty ? _summaryByDate[shiftDate] : null;
          return _RegisterCard(
            register: register,
            shiftDate: shiftDate,
            summary: summary,
            loadingSummary: _loadingSummaries && shiftDate.isNotEmpty,
            onTap: () => _openDetails(context, register, shiftDate),
            onClose: register.status == 'open'
                ? () => _showCloseRegister(context, register)
                : null,
            onDelete: register.status != 'open'
                ? () => _confirmDelete(context, register.id)
                : null,
          );
        },
      ),
    );
  }

  void _openDetails(BuildContext context, CashRegisterModel register, String shiftDate) {
    if (shiftDate.isNotEmpty) {
      context.read<HotelSummaryCubit>().getHotelSummaries(
            params: HotelSummaryRequestParams(
              date: shiftDate,
              openingAmount: register.openingAmount?.toString() ?? '0',
              totalAvailableAmount: '0',
              payQrGetCashExchange: '0',
              payCashGetQrExchange: '0',
            ),
          );
    }
    RegisterDetailsSheet.show(context: context, register: register);
  }

  void _showCloseRegister(BuildContext context, CashRegisterModel register) {
    OpeningControlSheet.showClose(
      context: context,
      register: register,
      onClose: (request) => context.read<OpeningCubit>().closeRegister(request),
      closedBy: context.employeeData?.email ?? '',
    );
  }

  void _confirmDelete(BuildContext context, int id) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            decoration: BoxDecoration(
              color: Theme.of(ctx).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Delete register?',
                  style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Text('This closed register will be permanently removed.'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomButtonWidget.outlined(
                        onPressed: () => Navigator.pop(ctx),
                        title: 'Cancel',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButtonWidget(
                        onPressed: () {
                          Navigator.pop(ctx);
                          context.read<OpeningCubit>().deleteRegister(id);
                        },
                        title: 'Delete',
                      ),
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
}

class _RegisterCard extends StatelessWidget {
  const _RegisterCard({
    required this.register,
    required this.shiftDate,
    required this.summary,
    required this.loadingSummary,
    required this.onTap,
    this.onClose,
    this.onDelete,
  });

  final CashRegisterModel register;
  final String shiftDate;
  final SalesSummary? summary;
  final bool loadingSummary;
  final VoidCallback onTap;
  final VoidCallback? onClose;
  final VoidCallback? onDelete;

  static String _formatShiftDate(String shiftDate) {
    try {
      return DateFormat('d MMM yyyy').format(DateTime.parse(shiftDate));
    } catch (_) {
      return shiftDate;
    }
  }

  String _formatMoney(num value) {
    return NumberFormat('#,##0').format(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOpen = register.status == 'open';
    final statusColor = isOpen ? Colors.green.shade700 : Colors.blueGrey.shade700;
    final statusBg = isOpen ? Colors.green.shade50 : Colors.grey.shade100;
    final dateLabel = shiftDate.isNotEmpty ? _formatShiftDate(shiftDate) : '—';

    return Material(
      color: theme.colorScheme.surface,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      isOpen ? Icons.lock_open_rounded : Icons.lock_outline_rounded,
                      color: statusColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                register.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusBg,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                isOpen ? 'OPEN' : 'CLOSED',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: statusColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          dateLabel,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onClose != null || onDelete != null) ...[
                    const SizedBox(width: 8),
                    Material(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: onClose ?? onDelete,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: onClose != null
                              ? Icon(
                                  Icons.close_rounded,
                                  size: 20,
                                  color: Colors.green.shade700,
                                )
                              : AppDeleteIcon(
                                  size: 20,
                                  color: theme.colorScheme.error,
                                ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              if (loadingSummary) ...[
                const SizedBox(height: 10),
                const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ] else ...[
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        _MetricChip(
                          label: 'Opening',
                          value: '$currencySymbol ${_formatMoney(register.openingAmount ?? 0)}',
                        ),
                        if (summary != null) ...[
                          const SizedBox(width: 8),
                          _MetricChip(
                            label: 'Sales',
                            value: '$currencySymbol ${_formatMoney(summary!.totalSales)}',
                          ),
                          const SizedBox(width: 8),
                          _MetricChip(
                            label: 'Expenses',
                            value: '$currencySymbol ${_formatMoney(summary!.totalExpenses)}',
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        '$label: $value',
        style: AppFonts.interStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }
}
