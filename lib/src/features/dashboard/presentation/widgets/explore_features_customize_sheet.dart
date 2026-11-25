import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/widget/custom_button_widget.dart';
import 'package:hotel/src/features/dashboard/domain/explore_feature_entry.dart';

Future<void> showExploreFeaturesCustomizeSheet({
  required BuildContext context,
  required List<ExploreFeatureToggleItem> entries,
  required Set<String> hiddenIds,
  required ValueChanged<Set<String>> onChanged,
}) {
  final isTablet = DeviceLayout.isTablet(context);

  Widget sheetContent(BuildContext ctx) {
    final theme = Theme.of(ctx);
    var localHidden = Set<String>.from(hiddenIds);
    final maxSheetHeight = MediaQuery.sizeOf(ctx).height * (isTablet ? 0.75 : 0.7);

    return StatefulBuilder(
      builder: (context, setSheetState) {
        Future<void> persist() async {
          onChanged(Set<String>.from(localHidden));
        }

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(ctx).bottom,
          ),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 32 : 16,
                  vertical: isTablet ? 24 : 0,
                ).copyWith(bottom: isTablet ? 24 : 16),
                child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isTablet ? 520 : double.infinity,
                  maxHeight: maxSheetHeight,
                ),
                child: SizedBox(
                  height: maxSheetHeight,
                  child: Material(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                        padding: EdgeInsets.fromLTRB(
                          isTablet ? 24 : 20,
                          isTablet ? 20 : 16,
                          isTablet ? 12 : 8,
                          isTablet ? 12 : 8,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ctx.l10n.exploreCustomizeTitle,
                                    style:
                                        theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    ctx.l10n.exploreCustomizeSubtitle,
                                    style:
                                        theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(ctx),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: entries.length,
                          separatorBuilder: (_, __) => Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                            color: theme.colorScheme.outlineVariant
                                .withValues(alpha: 0.5),
                          ),
                          itemBuilder: (context, index) {
                            final entry = entries[index];
                            final isShown = !localHidden.contains(entry.id);

                            return ListTile(
                              leading: Icon(
                                entry.icon,
                                color: theme.colorScheme.primary,
                              ),
                              title: Text(entry.label),
                              subtitle: Text(
                                isShown
                                    ? ctx.l10n.exploreVisibleOnDashboard
                                    : ctx.l10n.exploreHiddenOnDashboard,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              trailing: Transform.scale(
                                scale: 0.75,
                                alignment: Alignment.centerRight,
                                child: Switch.adaptive(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: isShown,
                                  onChanged: (show) {
                                    setSheetState(() {
                                      if (show) {
                                        localHidden.remove(entry.id);
                                      } else {
                                        localHidden.add(entry.id);
                                      }
                                    });
                                    persist();
                                  },
                                ),
                              ),
                              onTap: () {
                                setSheetState(() {
                                  if (isShown) {
                                    localHidden.add(entry.id);
                                  } else {
                                    localHidden.remove(entry.id);
                                  }
                                });
                                persist();
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          isTablet ? 24 : 16,
                          8,
                          isTablet ? 24 : 16,
                          isTablet ? 24 : 16,
                        ),
                        child: CustomButtonWidget.primary(
                          onPressed: () => Navigator.pop(ctx),
                          title: ctx.l10n.done,
                          useFixedSizes: isTablet,
                          height: isTablet ? 52 : 48,
                          borderRadius: isTablet ? 12 : 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        ),
        );
      },
    );
  }

  if (isTablet) {
    return showDialog<void>(
      context: context,
      builder: sheetContent,
    );
  }

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: sheetContent,
  );
}
