import 'dart:io';
import 'dart:ui' as ui;

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel/src/core/extensions/extensions/extensions.dart';
import 'package:hotel/src/core/helpers/item_search_helper.dart';
import 'package:hotel/src/core/widget/above_sheet_snack.dart';
import 'package:hotel/src/core/widget/app_bottom_sheet_shell.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

/// Text encoded in the item QR and barcode.
///
/// The SKU is used when it is set. Otherwise the item name is used, which the
/// checkout scanner also matches.
String itemScannableCode(ItemModel item) {
  final sku = itemSku(item);
  if (sku != null) return sku;
  return item.name.trim();
}

Future<void> showItemCodeSheet(
  BuildContext context, {
  required String itemName,
  required String code,
  required bool usesSku,
}) {
  final value = code.trim();
  if (value.isEmpty) return Future<void>.value();
  return showAppBottomSheet<void>(
    context: context,
    title: context.l10n.itemBarcodeLabel,
    shrinkWrap: true,
    child: _ItemCodeSheet(
      itemName: itemName,
      code: value,
      usesSku: usesSku,
    ),
  );
}

class _ItemCodeSheet extends StatefulWidget {
  const _ItemCodeSheet({
    required this.itemName,
    required this.code,
    required this.usesSku,
  });

  final String itemName;
  final String code;
  final bool usesSku;

  @override
  State<_ItemCodeSheet> createState() => _ItemCodeSheetState();
}

class _ItemCodeSheetState extends State<_ItemCodeSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  String? _saving;

  String? get _bars {
    final code = widget.code;
    if (!RegExp(r'^[\x20-\x7E]+$').hasMatch(code) || code.length > 48) {
      return null;
    }
    try {
      return Barcode.code128().toSvg(
        code,
        width: 320,
        height: 96,
        drawText: false,
      );
    } catch (_) {
      return null;
    }
  }

  bool get _hasBarcode => _bars != null;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: _hasBarcode ? 2 : 1, vsync: this);
    _tabs.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _download({
    required String svg,
    required String kind,
    required String label,
    required int width,
    required int height,
  }) async {
    if (_saving != null) return;
    setState(() => _saving = kind);
    try {
      final bytes = await _svgToPng(svg, width: width, height: height);
      final file = await _writeDownload(
        bytes,
        '${_fileStem(widget.itemName)}_$kind.png',
      );
      if (!mounted) return;
      AboveSheetSnack.showSuccess(
        context,
        Platform.isIOS
            ? '$label saved. Open Files, then On My iPhone, BillMate.'
            : '$label saved: ${file.path}',
      );
      if (!Platform.isIOS) {
        await OpenFile.open(file.path);
      }
    } catch (e) {
      if (!mounted) return;
      AboveSheetSnack.showError(context, 'Could not save $label: $e');
    } finally {
      if (mounted) setState(() => _saving = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final qr = Barcode.qrCode().toSvg(widget.code, width: 240, height: 240);
    final bars = _bars;
    final showingBarcode = _hasBarcode && _tabs.index == 1;
    final kind = showingBarcode ? 'barcode' : 'qr';
    final label = showingBarcode ? 'Barcode' : 'QR';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.itemName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        if (_hasBarcode) ...[
          const SizedBox(height: 16),
          _CodeTabs(controller: _tabs),
        ],
        const SizedBox(height: 20),
        SizedBox(
          height: 220,
          child: Center(
            child: showingBarcode
                ? _CodePlate(
                    svg: bars!,
                    width: double.infinity,
                    height: 112,
                  )
                : _CodePlate(svg: qr, width: 200, height: 200),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.code,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.usesSku
              ? context.l10n.itemSkuField
              : context.l10n.itemNameLabel,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 20.h),
        FilledButton(
          onPressed: _saving != null
              ? null
              : () => _download(
                    svg: showingBarcode ? bars! : qr,
                    kind: kind,
                    label: label,
                    width: showingBarcode ? 1200 : 1024,
                    height: showingBarcode ? 420 : 1024,
                  ),
          style: FilledButton.styleFrom(
            minimumSize: Size.fromHeight(48.h),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: _saving == kind
              ? SizedBox(
                  height: 22.h,
                  width: 22.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: scheme.onPrimary,
                  ),
                )
              : Text('${context.l10n.download} $label'),
        ),
      ],
    );
  }
}

class _CodeTabs extends StatelessWidget {
  const _CodeTabs({required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Container(
          height: 48,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _CodeTab(
                label: 'QR',
                selected: controller.index == 0,
                onTap: () => controller.animateTo(0),
              ),
              _CodeTab(
                label: 'Barcode',
                selected: controller.index == 1,
                onTap: () => controller.animateTo(1),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CodeTab extends StatelessWidget {
  const _CodeTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Material(
        color: selected ? scheme.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CodePlate extends StatelessWidget {
  const _CodePlate({
    required this.svg,
    required this.width,
    required this.height,
  });

  final String svg;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SvgPicture.string(svg, fit: BoxFit.contain),
    );
  }
}

Future<ui.Image> _svgToPngImage(
  String svg, {
  required int width,
  required int height,
}) async {
  final info = await vg.loadPicture(SvgStringLoader(svg), null);
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawRect(
    Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    Paint()..color = Colors.white,
  );
  final sourceWidth = info.size.width <= 0 ? width.toDouble() : info.size.width;
  final sourceHeight =
      info.size.height <= 0 ? height.toDouble() : info.size.height;
  final scale = (width / sourceWidth) < (height / sourceHeight)
      ? width / sourceWidth
      : height / sourceHeight;
  canvas.save();
  canvas.translate(
    (width - sourceWidth * scale) / 2,
    (height - sourceHeight * scale) / 2,
  );
  canvas.scale(scale);
  canvas.drawPicture(info.picture);
  canvas.restore();
  final picture = recorder.endRecording();
  final image = await picture.toImage(width, height);
  info.picture.dispose();
  picture.dispose();
  return image;
}

Future<List<int>> _svgToPng(
  String svg, {
  required int width,
  required int height,
}) async {
  final image = await _svgToPngImage(svg, width: width, height: height);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  if (data == null) {
    throw StateError('Could not encode the image');
  }
  return data.buffer.asUint8List();
}

Future<File> _writeDownload(List<int> bytes, String fileName) async {
  Directory targetDir;
  if (Platform.isAndroid) {
    final primary = Directory('/storage/emulated/0/Download');
    final secondary = Directory('/storage/emulated/0/Downloads');
    if (await primary.exists()) {
      targetDir = primary;
    } else if (await secondary.exists()) {
      targetDir = secondary;
    } else {
      targetDir = (await getExternalStorageDirectory()) ??
          await getApplicationDocumentsDirectory();
    }
  } else {
    targetDir = await getApplicationDocumentsDirectory();
  }
  if (!await targetDir.exists()) {
    await targetDir.create(recursive: true);
  }
  final file = File('${targetDir.path}/$fileName');
  return file.writeAsBytes(bytes, flush: true);
}

String _fileStem(String name) {
  final cleaned = name
      .trim()
      .replaceAll(RegExp(r'[^\w\-]+'), '_')
      .replaceAll(RegExp(r'_+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');
  if (cleaned.isEmpty) return 'item';
  return cleaned.length > 40 ? cleaned.substring(0, 40) : cleaned;
}
