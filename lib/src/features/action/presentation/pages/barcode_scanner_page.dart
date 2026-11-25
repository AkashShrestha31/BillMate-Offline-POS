import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';

class BarcodeScanFeedback {
  const BarcodeScanFeedback({
    required this.message,
    this.isError = false,
    this.silent = false,
  });

  final String message;
  final bool isError;

  /// Quantity prompt was cancelled. Leave the scanner banner unchanged.
  final bool silent;
}

/// Full-screen barcode / QR scanner.
///
/// Default: pops with the first decoded string (item create/edit).
/// [continuous]: stays open, looks up each code, and asks for a quantity.
class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({
    super.key,
    this.continuous = false,
    this.lookupItem,
    this.onConfirmed,
  });

  final bool continuous;

  /// Resolves a scanned code to an item name. Null means no match.
  final Future<String?> Function(String code)? lookupItem;

  /// Adds [quantity] after the user confirms on the scanner.
  final Future<BarcodeScanFeedback> Function(String code, int quantity)?
      onConfirmed;

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  late final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: widget.continuous
        ? DetectionSpeed.unrestricted
        : DetectionSpeed.noDuplicates,
    returnImage: false,
  );

  bool _handled = false;
  bool _busy = false;
  bool _torchOn = false;
  bool _promptVisible = false;
  bool _promptSaving = false;
  String? _promptCode;
  String? _promptName;
  String? _matchedCode;
  int _promptGen = 0;
  String? _lastCode;
  DateTime? _lastAt;
  BarcodeScanFeedback? _feedback;

  static const Duration _sameCodeCooldown = Duration(milliseconds: 900);

  bool get _continuous =>
      widget.continuous &&
      widget.lookupItem != null &&
      widget.onConfirmed != null;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _toggleTorch() async {
    try {
      await _controller.toggleTorch();
      if (mounted) setState(() => _torchOn = !_torchOn);
    } catch (_) {}
  }

  void _cancelPrompt() {
    _promptGen++;
    setState(() {
      _promptVisible = false;
      _promptSaving = false;
      _promptName = null;
      _matchedCode = null;
      _busy = false;
    });
  }

  Future<void> _confirmPrompt(int quantity) async {
    final code = _matchedCode;
    final gen = _promptGen;
    if (code == null || quantity <= 0 || _promptSaving) return;
    setState(() => _promptSaving = true);
    BarcodeScanFeedback feedback;
    try {
      feedback = await widget.onConfirmed!(code, quantity);
    } catch (_) {
      if (!mounted || gen != _promptGen) return;
      feedback = BarcodeScanFeedback(
        message: context.l10n.posScanItemNotFound,
        isError: true,
      );
    }
    if (!mounted || gen != _promptGen) return;
    setState(() {
      _promptVisible = false;
      _promptSaving = false;
      _promptName = null;
      _matchedCode = null;
      _busy = false;
      _lastAt = DateTime.now();
      if (!feedback.silent) _feedback = feedback;
    });
    if (feedback.isError) HapticFeedback.heavyImpact();
  }

  Future<void> _resolvePrompt(List<String> candidates, int gen) async {
    String? name;
    String? matched;
    try {
      for (final code in candidates) {
        if (!mounted || gen != _promptGen) return;
        final found = await widget.lookupItem!(code);
        if (found != null && found.trim().isNotEmpty) {
          name = found.trim();
          matched = code;
          break;
        }
      }
    } catch (_) {
      name = null;
    }
    if (!mounted || gen != _promptGen) return;
    if (name == null) {
      final primary = candidates.first;
      final shown =
          primary.length > 48 ? '${primary.substring(0, 48)}…' : primary;
      setState(() {
        _promptVisible = false;
        _busy = false;
        _feedback = BarcodeScanFeedback(
          message: '${context.l10n.posScanItemNotFound}: $shown',
          isError: true,
        );
      });
      HapticFeedback.heavyImpact();
      return;
    }
    setState(() {
      _promptName = name;
      _matchedCode = matched;
    });
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_busy || _promptVisible) return;
    if (!_continuous && _handled) return;

    final candidates = <String>[];
    void addCandidate(String? value) {
      final trimmed = value?.trim();
      if (trimmed == null || trimmed.isEmpty) return;
      if (!candidates.contains(trimmed)) candidates.add(trimmed);
    }

    for (final barcode in capture.barcodes) {
      addCandidate(barcode.rawValue);
      addCandidate(barcode.displayValue);
    }
    if (candidates.isEmpty) return;
    final primary = candidates.first;

    if (_continuous) {
      final now = DateTime.now();
      if (_lastCode == primary &&
          _lastAt != null &&
          now.difference(_lastAt!) < _sameCodeCooldown) {
        return;
      }
      _lastCode = primary;
      _lastAt = now;
      _busy = true;
      _promptGen++;
      final gen = _promptGen;
      HapticFeedback.mediumImpact();
      setState(() {
        _promptVisible = true;
        _promptSaving = false;
        _promptCode = primary;
        _promptName = null;
        _matchedCode = null;
        _feedback = null;
      });
      _resolvePrompt(candidates, gen);
      return;
    }

    _handled = true;
    HapticFeedback.mediumImpact();
    if (mounted) Navigator.of(context).pop<String>(primary);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cs = Theme.of(context).colorScheme;
    return PopScope(
      canPop: !_promptVisible,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _promptVisible) _cancelPrompt();
      },
      child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(l10n.itemScanBarcode),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop<String>(),
        ),
        actions: [
          IconButton(
            tooltip: l10n.posScanTorch,
            icon: Icon(_torchOn ? Icons.flash_on : Icons.flash_off_outlined),
            onPressed: _toggleTorch,
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),
          Center(
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          if (_busy && !_promptVisible)
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 300),
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (!_promptVisible)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_feedback != null) ...[
                  Material(
                    color: _feedback!.isError
                        ? cs.error
                        : const Color(0xFF2E7D32),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _feedback!.isError
                                ? Icons.error_outline
                                : Icons.check_circle_outline,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _feedback!.message,
                              style: AppFonts.interStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                Text(
                  _continuous ? l10n.posScanKeepScanning : l10n.posScanAlignHint,
                  textAlign: TextAlign.center,
                  style: AppFonts.interStyle(
                    color: Colors.white,
                    fontSize: 15,
                    shadows: const [Shadow(blurRadius: 8, color: Colors.black)],
                  ),
                ),
                if (_continuous) ...[
                  const SizedBox(height: 8),
                  Text(
                    l10n.posScanAlignHint,
                    textAlign: TextAlign.center,
                    style: AppFonts.interStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      shadows: const [Shadow(blurRadius: 8, color: Colors.black)],
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop<String>(),
                    style: FilledButton.styleFrom(
                      minimumSize: Size.fromHeight(48.h),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(l10n.posScanDone),
                  ),
                ],
              ],
            ),
              ),
            ),
          ),
          if (_promptVisible)
            Align(
              alignment: Alignment.bottomCenter,
              child: _ScanQuantityPanel(
                itemName: _promptName,
                code: _promptCode ?? '',
                saving: _promptSaving,
                onCancel: _cancelPrompt,
                onAdd: _promptName == null ? null : _confirmPrompt,
              ),
            ),
        ],
      ),
    ),
    );
  }
}

class _ScanQuantityPanel extends StatefulWidget {
  const _ScanQuantityPanel({
    required this.itemName,
    required this.code,
    required this.saving,
    required this.onCancel,
    required this.onAdd,
  });

  final String? itemName;
  final String code;
  final bool saving;
  final VoidCallback onCancel;
  final Future<void> Function(int quantity)? onAdd;

  @override
  State<_ScanQuantityPanel> createState() => _ScanQuantityPanelState();
}

class _ScanQuantityPanelState extends State<_ScanQuantityPanel>
    with WidgetsBindingObserver {
  late final TextEditingController _controller =
      TextEditingController(text: '1');
  late final FocusNode _focus = FocusNode();
  double _rawInset = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _focus.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focus.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final view = View.of(context);
      final inset = view.viewInsets.bottom / view.devicePixelRatio;
      if (inset == _rawInset) return;
      setState(() => _rawInset = inset);
    });
  }

  /// Camera preview often leaves [MediaQuery.viewInsets] at 0, so a focused
  /// field still has to clear a typical phone keyboard.
  double _lift(BuildContext context) {
    final media = MediaQuery.viewInsetsOf(context).bottom;
    final inset = media > _rawInset ? media : _rawInset;
    if (inset > 0) return inset;
    if (!_focus.hasFocus) return 0;
    return MediaQuery.sizeOf(context).height * 0.42;
  }

  int get _qty => int.tryParse(_controller.text.trim()) ?? 1;

  void _setQty(int next) {
    final value = next < 1 ? 1 : next;
    _controller.value = TextEditingValue(
      text: '$value',
      selection: TextSelection.collapsed(offset: '$value'.length),
    );
    setState(() {});
  }

  void _submit() {
    final qty = int.tryParse(_controller.text.trim()) ?? 0;
    if (qty <= 0 || widget.onAdd == null || widget.saving) return;
    widget.onAdd!(qty);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final ready = widget.itemName != null && !widget.saving;
    final lift = _lift(context);
    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: lift),
      child: SafeArea(
      top: false,
      bottom: lift == 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: DecoratedBox(
          decoration: AppBottomSheetTheme.sheetDecoration(context),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: AppBottomSheetTheme.dragHandle(context)),
                const SizedBox(height: 12),
                Text(
                  widget.itemName ?? widget.code,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  context.l10n.quantity,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    _QtyButton(
                      icon: Icons.remove,
                      onPressed: ready && _qty > 1 ? () => _setQty(_qty - 1) : null,
                    ),
                    6.horizontalSpace,
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focus,
                        enabled: ready,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        onChanged: (_) => setState(() {}),
                        onSubmitted: (_) => _submit(),
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    6.horizontalSpace,
                    _QtyButton(
                      icon: Icons.add,
                      onPressed: ready ? () => _setQty(_qty + 1) : null,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                FilledButton(
                  onPressed: ready ? _submit : null,
                  style: FilledButton.styleFrom(
                    minimumSize: Size.fromHeight(48.h),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: widget.itemName == null || widget.saving
                      ? SizedBox(
                          height: 22.h,
                          width: 22.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: scheme.onPrimary,
                          ),
                        )
                      : Text(context.l10n.add),
                ),
                TextButton(
                  onPressed: widget.saving ? null : widget.onCancel,
                  child: Text(context.l10n.cancel),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerHighest,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: 48.r,
          height: 48.r,
          child: Icon(
            icon,
            color: onPressed == null
                ? scheme.onSurface.withValues(alpha: 0.3)
                : scheme.onSurface,
          ),
        ),
      ),
    );
  }
}
