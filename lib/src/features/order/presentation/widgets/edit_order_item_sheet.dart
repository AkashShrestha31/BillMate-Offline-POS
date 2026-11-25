import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/features/order/data/models/response/order_model.dart';
import 'package:hotel/src/features/order/presentation/cubit/order_detail_cubit.dart';
import 'package:hotel/src/features/order/presentation/utils/order_ui_helpers.dart';

/// Bottom sheet: edit quantity, unit (variants), description, remarks → PATCH order item.
class EditOrderItemSheet extends StatefulWidget {
  const EditOrderItemSheet({
    super.key,
    required this.orderName,
    required this.line,
    required this.productTitle,
    required this.onSaved,
  });

  final String orderName;
  final OrderItemModel line;
  final String productTitle;
  final VoidCallback onSaved;

  @override
  State<EditOrderItemSheet> createState() => _EditOrderItemSheetState();
}

class _EditOrderItemSheetState extends State<EditOrderItemSheet> {
  static const _unitPresets = ['Small', 'Medium', 'Large'];

  late double _quantity;
  late String _unit;
  late final TextEditingController _descriptionController;
  late final TextEditingController _remarksController;
  bool _saving = false;

  String? get _lineId => widget.line.orderLineIdForItemStatusPatch?.trim();

  @override
  void initState() {
    super.initState();
    _quantity = (widget.line.quantity ?? 1).clamp(0.25, 9999.0);
    final u = (widget.line.unit ?? '').trim();
    final isGenericUnit = u.isEmpty || u.toLowerCase() == 'unit';
    _unit = isGenericUnit ? _unitPresets.first : u;
    _descriptionController = TextEditingController(text: widget.line.description?.trim() ?? '');
    _remarksController = TextEditingController(text: widget.line.remarks?.trim() ?? '');
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _bumpQuantity(double delta) {
    final next = (_quantity + delta).clamp(0.25, 9999.0);
    if (next == _quantity) return;
    setState(() => _quantity = next);
  }

  Iterable<String> get _unitChips {
    if (_unit.isNotEmpty && !_unitPresets.contains(_unit)) {
      return [..._unitPresets, _unit];
    }
    return _unitPresets;
  }

  Future<void> _save() async {
    final id = _lineId;
    if (id == null || id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Missing line id — cannot save.')),
      );
      return;
    }
    setState(() => _saving = true);
    final err = await context.read<OrderDetailCubit>().updateOrderItemFields(
          forOrderName: widget.orderName,
          itemLineName: id,
          quantity: _quantity,
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          unit: _unit,
          remarks:
              _remarksController.text.trim().isEmpty ? null : _remarksController.text.trim(),
          modifiedBy: context.employeeData?.email ?? 'system',
        );
    if (!mounted) return;
    setState(() => _saving = false);
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      return;
    }
    widget.onSaved();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final imgUrl = resolveOrderItemImageUrl(widget.line.imageUrl);
    final subtitle = (widget.line.description ?? '').trim().isNotEmpty
        ? widget.line.description!.trim()
        : (widget.line.unit ?? '').trim();

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h + bottomInset),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Edit Order Item',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: scheme.onSurfaceVariant),
                    onPressed: _saving ? null : () => Navigator.of(context).pop(),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: SizedBox(
                          width: 56.w,
                          height: 56.w,
                          child: imgUrl != null &&
                                  (imgUrl.startsWith('http://') || imgUrl.startsWith('https://'))
                              ? Image.network(
                                  imgUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => ColoredBox(
                                    color: scheme.surfaceContainerHighest,
                                    child: Icon(Icons.restaurant_menu, color: scheme.onSurfaceVariant),
                                  ),
                                )
                              : ColoredBox(
                                  color: scheme.surfaceContainerHighest,
                                  child: Icon(Icons.restaurant_menu, color: scheme.onSurfaceVariant),
                                ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.productTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            if (subtitle.isNotEmpty) ...[
                              SizedBox(height: 4.h),
                              Text(
                                subtitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: scheme.onSurfaceVariant),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Quantity',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _qtyButton(
                                scheme,
                                icon: Icons.remove,
                                onTap: _saving ? null : () => _bumpQuantity(-1),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Text(
                                  _quantity == _quantity.roundToDouble()
                                      ? '${_quantity.round()}'
                                      : _quantity.toStringAsFixed(2),
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              _qtyButton(
                                scheme,
                                icon: Icons.add,
                                onTap: _saving ? null : () => _bumpQuantity(1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Description',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _descriptionController,
                enabled: !_saving,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'e.g. Lunch, Extra cheese',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                  filled: true,
                  fillColor: scheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: scheme.primary),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Remarks',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _remarksController,
                enabled: !_saving,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Enter Remarks',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                  filled: true,
                  fillColor: scheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: scheme.primary),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                ),
              ),
              SizedBox(height: 24.h),
              FilledButton(
                onPressed: _saving ? null : _save,
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                ),
                child: _saving
                    ? SizedBox(
                        height: 22.h,
                        width: 22.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: scheme.onPrimary,
                        ),
                      )
                    : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _qtyButton(
    ColorScheme scheme, {
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: SizedBox(
          width: 36.w,
          height: 36.w,
          child: Icon(icon, size: 20.sp),
        ),
      ),
    );
  }
}
