import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/l10n/app_language_flag.dart';
import 'package:hotel/src/core/l10n/app_language_option.dart';
import 'package:hotel/src/core/widget/app_search_icon.dart';
import 'package:hotel/src/core/widget/custom_textform_field.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

/// List card with rounded corners and a soft bottom shadow.
class LanguagePickerListCard extends StatelessWidget {
  const LanguagePickerListCard({
    super.key,
    required this.child,
    this.useFixedSizes = false,
  });

  final Widget child;

  /// Use logical pixels instead of [ScreenUtil] (tablet / iPad).
  final bool useFixedSizes;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = useFixedSizes ? 16.0 : 16.r;
    final blur = useFixedSizes ? 24.0 : 24.r;
    final offsetY = useFixedSizes ? 8.0 : 8.h;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.1),
            blurRadius: blur,
            spreadRadius: 0,
            offset: Offset(0, offsetY),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: child,
      ),
    );
  }
}

class LanguagePickerSearchField extends StatefulWidget {
  const LanguagePickerSearchField({
    super.key,
    required this.controller,
    required this.hint,
    this.onChanged,
    this.useFixedSizes = false,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;

  /// Use logical pixels instead of [ScreenUtil] (tablet / iPad).
  final bool useFixedSizes;

  @override
  State<LanguagePickerSearchField> createState() => _LanguagePickerSearchFieldState();
}

class _LanguagePickerSearchFieldState extends State<LanguagePickerSearchField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fixed = widget.useFixedSizes;

    return CustomTextFormField(
      controller: widget.controller,
      hint: widget.hint,
      height: fixed ? 48 : 48.h,
      textInputAction: TextInputAction.search,
      onChanged: widget.onChanged,
      contentPadding: fixed
          ? const EdgeInsets.symmetric(horizontal: 18, vertical: 12)
          : EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
      prefixIcon: AppSearchIcon.inputDecoration(
        color: scheme.onSurfaceVariant,
      ),
      suffixIcon: widget.controller.text.isEmpty
          ? null
          : IconButton(
              icon: Icon(
                Icons.cancel,
                color: scheme.onSurfaceVariant,
                size: fixed ? 20 : 20.sp,
              ),
              onPressed: () {
                widget.controller.clear();
                widget.onChanged?.call('');
              },
            ),
    );
  }
}

class LanguagePickerList extends StatelessWidget {
  const LanguagePickerList({
    super.key,
    required this.languages,
    required this.selectedCode,
    required this.onSelect,
    this.suggestedCode = 'en',
    this.suggestedBadgeLabel = 'SUGGESTED',
    this.emptyLabel = 'No matches',
    this.searchQuery,
    this.noMatchesForQueryLabel,
    this.centerEmptyMessage = false,
    this.wrapContent = false,
    this.maxHeight,
  });

  final List<AppLanguageOption> languages;
  final String selectedCode;
  final ValueChanged<AppLanguageOption> onSelect;
  final String suggestedCode;
  final String suggestedBadgeLabel;
  final String emptyLabel;

  /// When set and non-empty, shown in the empty state (e.g. active search text).
  final String? searchQuery;

  /// Localized message when [searchQuery] is non-empty and [languages] is empty.
  final String Function(String query)? noMatchesForQueryLabel;

  /// Vertically centers the empty message (e.g. full-height bottom sheet list).
  final bool centerEmptyMessage;

  /// When true, the list sizes to its items (for search / few results).
  final bool wrapContent;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    if (languages.isEmpty) {
      final query = searchQuery?.trim() ?? '';
      final message = query.isNotEmpty && noMatchesForQueryLabel != null
          ? noMatchesForQueryLabel!(query)
          : emptyLabel;

      final emptyContent = Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Text(
          message,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      );

      if (centerEmptyMessage) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(child: emptyContent),
        );
      }

      return SizedBox(
        width: double.infinity,
        child: emptyContent,
      );
    }

    final list = ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: wrapContent,
      physics: wrapContent ? const ClampingScrollPhysics() : const AlwaysScrollableScrollPhysics(),
      itemCount: languages.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        indent: 72.w,
        endIndent: 16.w,
        color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.6),
      ),
      itemBuilder: (context, index) {
        final option = languages[index];
        return LanguagePickerListTile(
          option: option,
          selected: option.code == selectedCode,
          showSuggestedBadge: option.code == suggestedCode,
          suggestedBadgeLabel: suggestedBadgeLabel,
          onTap: () => onSelect(option),
        );
      },
    );

    if (wrapContent && maxHeight != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight!),
        child: list,
      );
    }

    return list;
  }
}

class LanguagePickerListTile extends StatelessWidget {
  const LanguagePickerListTile({
    super.key,
    required this.option,
    required this.selected,
    required this.onTap,
    this.showSuggestedBadge = false,
    this.suggestedBadgeLabel = 'SUGGESTED',
  });

  final AppLanguageOption option;
  final bool selected;
  final VoidCallback onTap;
  final bool showSuggestedBadge;
  final String suggestedBadgeLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Material(
      color: selected ? scheme.primary.withValues(alpha: 0.08) : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              _LanguageFlagAvatar(
                languageCode: option.code,
                selected: selected,
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            option.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: scheme.onSurface,
                            ),
                          ),
                        ),
                        if (showSuggestedBadge) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: scheme.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              suggestedBadgeLabel,
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: scheme.primary,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      option.nativeName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              _LanguageSelectionIndicator(selected: selected),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageFlagAvatar extends StatelessWidget {
  const _LanguageFlagAvatar({
    required this.languageCode,
    required this.selected,
  });

  final String languageCode;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: selected
            ? scheme.primary.withValues(alpha: 0.14)
            : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10.r),
      ),
      alignment: Alignment.center,
      child: Text(
        AppLanguageFlag.emoji(languageCode),
        style: AppFonts.interStyle(fontSize: 22.sp),
      ),
    );
  }
}

class _LanguageSelectionIndicator extends StatelessWidget {
  const _LanguageSelectionIndicator({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? scheme.primary : Colors.transparent,
        border: Border.all(
          color: selected ? scheme.primary : scheme.outlineVariant,
          width: 1.5,
        ),
      ),
      child: selected
          ? Icon(
              Icons.check_rounded,
              size: 14.sp,
              color: scheme.onPrimary,
            )
          : null,
    );
  }
}
