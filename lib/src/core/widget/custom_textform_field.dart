import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel/src/core/layout/device_layout.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

import '../themes/app_colors.dart';
import 'input_prefix_icon_scope.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.inputDecoration,
    this.prefixIcon,
    this.errorText,
    this.controller,
    this.onSaved,
    this.validating,
    this.onChanged,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.initialValue,
    this.hint,
    this.hintStyle,
    this.helperText,
    this.obscureText,
    this.obscurable = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.inputFormatter,
    this.onFieldSubmitted,
    this.onTap,
    this.showErrorBorder = false,
    this.borderRadius = 10.0,
    this.suffixIcon,
    this.readOnly = false,
    this.contentPadding,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
    this.textCapitalization = TextCapitalization.none,
    this.height = 50,
    this.style,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.showCounter = false,
    this.hintMaxLines,
    this.borderColor,
    this.fillColor,
    this.prefixIconConstraints,
    this.labelText,
    this.prefixText,
    this.prefixStyle,
    this.suffixText,
    this.suffixStyle,
    this.scrollPadding = const EdgeInsets.only(bottom: 8.0),
    this.errorBottomPadding = 2,
    this.useFixedSizes = false,
    this.floatingLabelBehavior,
  });

  final InputDecoration? inputDecoration;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validating;
  final AutovalidateMode autoValidateMode;
  final String? initialValue;
  final String? hint;
  final TextStyle? hintStyle;
  final String? helperText;
  final String? errorText;
  final bool? obscureText;
  /// When true, field starts hidden and shows a visibility toggle (local state).
  final bool obscurable;
  final bool enabled;
  final TextInputAction? textInputAction;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final void Function(String)? onFieldSubmitted;
  final bool showErrorBorder;
  final double borderRadius;
  final Widget? suffixIcon;
  final bool readOnly;
  final EdgeInsets? contentPadding;
  final EdgeInsets padding;
  final TextCapitalization textCapitalization;
  final double? height;
  final TextStyle? style;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool showCounter;
  final int? hintMaxLines;
  final Color? borderColor;
  final Color? fillColor;
  final BoxConstraints? prefixIconConstraints;
  final String? labelText;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final String? suffixText;
  final TextStyle? suffixStyle;
  final EdgeInsets scrollPadding;
  final double errorBottomPadding;

  /// Use logical pixels for padding (tablet / iPad). Also enabled on tablet
  /// automatically when this is false.
  final bool useFixedSizes;

  /// When set to [FloatingLabelBehavior.always], labels stay above the field
  /// for consistent form layouts (e.g. tax settings).
  final FloatingLabelBehavior? floatingLabelBehavior;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final _fieldKey = GlobalKey<FormFieldState<String>>();
  late bool _textHidden;
  FocusNode? _ownedFocusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_ownedFocusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _textHidden = widget.obscurable || (widget.obscureText ?? false);
    _effectiveFocusNode.addListener(_onFocusChange);
    widget.controller?.addListener(_syncControllerToField);
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncControllerToField());
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusChange);
    _ownedFocusNode?.dispose();
    widget.controller?.removeListener(_syncControllerToField);
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      oldWidget.focusNode?.removeListener(_onFocusChange);
      _ownedFocusNode?.removeListener(_onFocusChange);
      _effectiveFocusNode.addListener(_onFocusChange);
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_syncControllerToField);
      widget.controller?.addListener(_syncControllerToField);
      _syncControllerToField();
    }
    if (!widget.obscurable &&
        widget.obscureText != null &&
        widget.obscureText != oldWidget.obscureText) {
      _textHidden = widget.obscureText!;
    }
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
  }

  Color _prefixIconColor(BuildContext context, {required bool focused}) {
    final scheme = context.theme.colorScheme;
    if (!widget.enabled) {
      return scheme.onSurface.withValues(alpha: 0.38);
    }
    return focused ? scheme.primary : scheme.onSurfaceVariant;
  }

  Widget? _buildPrefixIcon(BuildContext context, {required bool focused}) {
    final icon = widget.prefixIcon;
    if (icon == null) return null;

    final color = _prefixIconColor(context, focused: focused);
    return InputPrefixIconScope(
      color: color,
      child: IconTheme(
        data: IconThemeData(color: color),
        child: icon,
      ),
    );
  }

  void _syncControllerToField() {
    if (!mounted) return;
    final controller = widget.controller;
    if (controller == null) return;
    _fieldKey.currentState?.didChange(controller.text);
  }

  String? _validate(String? value) {
    if (widget.validating == null) return null;
    final effective = widget.controller?.text ?? value ?? '';
    return widget.validating!(effective);
  }

  bool get _isObscured =>
      widget.obscurable ? _textHidden : (widget.obscureText ?? false);

  Widget? get _effectiveSuffix {
    if (widget.obscurable) {
      return IconButton(
        tooltip: _textHidden ? 'Show password' : 'Hide password',
        icon: Icon(
          _textHidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
        onPressed: () => setState(() => _textHidden = !_textHidden),
      );
    }
    return widget.suffixIcon;
  }

  bool _useFixedSizes(BuildContext context) =>
      widget.useFixedSizes || DeviceLayout.isTablet(context);

  EdgeInsets _contentPadding(BuildContext context) {
    if (widget.contentPadding != null) return widget.contentPadding!;
    final alwaysFloating =
        widget.floatingLabelBehavior == FloatingLabelBehavior.always;
    if (_useFixedSizes(context)) {
      return alwaysFloating
          ? const EdgeInsets.fromLTRB(16, 12, 16, 14)
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 14);
    }
    return alwaysFloating
        ? EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 14.h)
        : EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h);
  }

  bool get _alwaysFloatingLabel =>
      widget.floatingLabelBehavior == FloatingLabelBehavior.always;

  double _fieldHeight(BuildContext context) {
    final height = widget.height ?? 50;
    if (_useFixedSizes(context) && widget.height == 50) return 52;
    return height;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      key: _fieldKey,
      onSaved: (value) {
        widget.onSaved?.call(widget.controller?.text ?? value);
      },
      validator: _validate,
      autovalidateMode: widget.autoValidateMode,
      initialValue: widget.controller == null ? widget.initialValue : null,
      enabled: widget.enabled,
      builder: (FormFieldState<String> state) {
        final scheme = context.theme.colorScheme;
        final focused = _effectiveFocusNode.hasFocus;
        final validationMessage = state.errorText ?? widget.errorText;
        final hasError =
            validationMessage != null && validationMessage.isNotEmpty;
        final multiline = !widget.obscurable &&
            widget.height == null &&
            ((widget.maxLines ?? 1) > 1 || (widget.minLines ?? 1) > 1);
        final resolvedMinLines =
            multiline ? (widget.minLines ?? widget.maxLines ?? 5) : 1;
        final resolvedMaxLines =
            widget.obscurable ? 1 : (widget.maxLines ?? (multiline ? null : 1));
        final resolvedBorderColor = hasError
            ? AppColors.errorInputBorderColor
            : (widget.borderColor ??
                scheme.outlineVariant.withValues(alpha: 0.6));
        final borderSide = BorderSide(color: resolvedBorderColor);
        final fieldDecoration = (widget.inputDecoration ??
                InputDecoration(
                  errorMaxLines: 3,
                  alignLabelWithHint: false,
                  counterText:
                      widget.showCounter || widget.maxLength == null ? null : '',
                  hintMaxLines: widget.hintMaxLines,
                  hintText: widget.hint,
                  hintStyle: widget.hintStyle ??
                      context.theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant.withValues(alpha: 0.75),
                        fontWeight: FontWeight.w500
                      ),
                  contentPadding: _contentPadding(context),
                  filled: true,
                  fillColor: widget.fillColor ?? scheme.surfaceContainerHighest,
                  labelText: widget.labelText,
                  labelStyle: context.theme.textTheme.bodyLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                  floatingLabelStyle: context.theme.textTheme.bodySmall?.copyWith(
                    color: focused
                        ? scheme.primary
                        : scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                  floatingLabelBehavior:
                      widget.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                    borderSide: borderSide,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    gapPadding: widget.labelText != null ? 8 : 0,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: borderSide,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    gapPadding: widget.labelText != null ? 8 : 0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: hasError
                          ? AppColors.errorInputBorderColor
                          : (widget.borderColor ?? scheme.primary),
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    gapPadding: widget.labelText != null ? 8 : 0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: borderSide,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    gapPadding: widget.labelText != null ? 8 : 0,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: borderSide,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    gapPadding: widget.labelText != null ? 8 : 0,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: borderSide,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    gapPadding: widget.labelText != null ? 8 : 0,
                  ),
                  isDense: true,
                  prefixIcon: widget.prefixText == null
                      ? _buildPrefixIcon(context, focused: focused)
                      : null,
                  prefixIconConstraints: widget.prefixIconConstraints,
                  prefixIconColor: WidgetStateColor.resolveWith((states) {
                    if (states.contains(WidgetState.disabled)) {
                      return context.theme.colorScheme.onSurface
                          .withValues(alpha: 0.38);
                    }
                    if (states.contains(WidgetState.focused)) {
                      return context.theme.colorScheme.primary;
                    }
                    return context.theme.colorScheme.onSurfaceVariant;
                  }),
                  prefixText: widget.prefixText,
                  prefixStyle: widget.prefixStyle ??
                      context.theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                  suffixText: widget.suffixText,
                  suffixStyle: widget.suffixStyle ??
                      context.theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  suffixIcon: _effectiveSuffix,
                ))
            .copyWith(
              errorStyle: AppFonts.interStyle(height: 0, fontSize: 0),
              alignLabelWithHint: multiline ? true : null,
            );

        final textField = TextFormField(
          scrollPadding: widget.scrollPadding,
          textAlignVertical:
              multiline ? TextAlignVertical.top : TextAlignVertical.center,
          obscureText: _isObscured,
          minLines: resolvedMinLines,
          maxLines: resolvedMaxLines,
          textCapitalization: widget.textCapitalization,
          onChanged: (value) {
            state.didChange(value);
            widget.onChanged?.call(value);
          },
          readOnly: widget.readOnly,
          cursorColor: scheme.primary,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          focusNode: _effectiveFocusNode,
          inputFormatters: widget.inputFormatter,
          enabled: widget.enabled,
          initialValue: widget.controller == null ? widget.initialValue : null,
          controller: widget.controller,
          onTap: widget.onTap,
          scrollPhysics: const BouncingScrollPhysics(),
          onFieldSubmitted: widget.onFieldSubmitted,
          maxLength: widget.maxLength,
          style: () {
            final base = context.theme.textTheme.bodyMedium?.copyWith(
              overflow: multiline ? null : TextOverflow.ellipsis,
              color: scheme.onSurface,
            );
            return widget.style != null ? base?.merge(widget.style) : base;
          }(),
          decoration: fieldDecoration,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (multiline)
              textField
            else if (widget.labelText != null && widget.labelText!.isNotEmpty)
              _alwaysFloatingLabel
                  ? textField
                  : Padding(
                      // Fixed height clips floating labels into the top border.
                      padding: const EdgeInsets.only(top: 6),
                      child: textField,
                    )
            else
              Container(
                height: _fieldHeight(context),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                child: textField,
              ),
            if (hasError)
              Padding(
                padding: EdgeInsets.only(top: widget.errorBottomPadding),
                child: Text(
                  validationMessage,
                  style: context.theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.errorInputBorderColor,
                    height: 1.2,
                  ),
                ),
              )
            else if (widget.helperText != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  widget.helperText!,
                  style: context.theme.textTheme.bodyMedium,
                ),
              ),
          ],
        );
      },
    );
  }

}
