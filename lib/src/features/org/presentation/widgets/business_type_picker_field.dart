import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/org/presentation/widgets/business_type_picker_bottom_sheet.dart';

/// Read-only [CustomTextFormField] that opens [showBusinessTypePickerBottomSheet].
class BusinessTypePickerField extends StatelessWidget {
  const BusinessTypePickerField({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final bool enabled;

  Future<void> _openPicker(BuildContext context) async {
    if (!enabled) return;
    final picked = await showBusinessTypePickerBottomSheet(
      context,
      currentCode: value,
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final subtitle = l10n.businessTypeSubtitle(value);
    final isTablet = DeviceLayout.isTablet(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.setupBusinessType,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: scheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: isTablet ? 8 : 6),
        CustomTextFormField(
          key: ValueKey(
            '${value}_${Localizations.localeOf(context).languageCode}',
          ),
          initialValue: l10n.businessTypeLabel(value),
          readOnly: true,
          enabled: enabled,
          onTap: enabled ? () => _openPicker(context) : null,
          height: isTablet ? 52 : 50,
          contentPadding: isTablet
              ? const EdgeInsets.symmetric(horizontal: 16, vertical: 14)
              : null,
          prefixIcon: Icon(
            OrganizationBusinessType.iconFor(value),
            color: enabled ? scheme.primary : scheme.onSurfaceVariant,
          ),
          suffixIcon: enabled
              ? Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: scheme.onSurfaceVariant,
                )
              : null,
        ),
        if (!enabled) ...[
          const SizedBox(height: 6),
          Text(
            l10n.businessTypeReadOnly,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
        ],
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: scheme.primaryContainer.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: scheme.primary.withValues(alpha: 0.18),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  OrganizationBusinessType.iconFor(value),
                  color: scheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.businessTypeLabel(value),
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
