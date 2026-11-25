import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/features/org/presentation/org_navigation.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

/// Compact workspace indicator used on the login screen.
class OrganizationBadge extends StatefulWidget {
  const OrganizationBadge({
    super.key,
    this.onChangePressed,
    this.onOrganizationChanged,
  });

  final VoidCallback? onChangePressed;

  /// Called after the user picks a different workspace on the login screen.
  final VoidCallback? onOrganizationChanged;

  @override
  State<OrganizationBadge> createState() => _OrganizationBadgeState();
}

class _OrganizationBadgeState extends State<OrganizationBadge> {
  int _loadGeneration = 0;

  Future<(String?, String?, String?)> _loadOrganization() async {
    final name = await OrgStorage.getOrgName();
    final slug = await OrgStorage.getOrgSlug();
    final code = await OrgStorage.getOrgCode();
    return (name, slug, code);
  }

  Future<void> _handleChangePressed() async {
    if (widget.onChangePressed != null) {
      widget.onChangePressed!();
      return;
    }

    final changed = await changeOrganization(context);
    if (!mounted || !changed) return;

    setState(() => _loadGeneration++);
    widget.onOrganizationChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final primary = scheme.primary;
    final cardBorder = scheme.outlineVariant.withValues(alpha: 0.6);

    return FutureBuilder<(String?, String?, String?)>(
      key: ValueKey(_loadGeneration),
      future: _loadOrganization(),
      builder: (context, snapshot) {
        final slug = snapshot.data?.$2;
        if (slug == null || slug.isEmpty) {
          return const SizedBox.shrink();
        }

        final label = snapshot.data?.$1 ?? slug;
        final enteredCode = snapshot.data?.$3;
        final subtitle = enteredCode != null &&
                enteredCode.isNotEmpty &&
                enteredCode != label
            ? enteredCode
            : (label != slug ? slug : null);

        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cardBorder),
              boxShadow: [
                BoxShadow(
                  color: scheme.shadow.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.business, color: primary, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.workspace.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.interStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurface,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                        ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: _handleChangePressed,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    context.l10n.change,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: primary,
                          fontWeight: FontWeight.w600,
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
}
