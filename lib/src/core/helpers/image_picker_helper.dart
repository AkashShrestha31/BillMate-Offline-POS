import 'package:flutter/material.dart';
import 'package:hotel/src/core/extensions/extensions/localization_extension.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  ImagePickerHelper._();

  static final ImagePicker _picker = ImagePicker();

  static Future<ImageSource?> showSourceSheet(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(context.l10n.takePhoto),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(context.l10n.chooseFromGallery),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  static Future<String?> pickImagePath(
    BuildContext context, {
    ImageSource? source,
    int maxWidth = 512,
    int maxHeight = 512,
    int imageQuality = 85,
  }) async {
    final pickedSource = source ?? await showSourceSheet(context);
    if (pickedSource == null || !context.mounted) return null;

    try {
      final file = await _picker.pickImage(
        source: pickedSource,
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: imageQuality,
      );
      return file?.path;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.couldNotPickImage(e.toString())),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return null;
    }
  }
}
