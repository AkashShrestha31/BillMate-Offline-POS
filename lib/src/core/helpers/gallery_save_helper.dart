import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gal/gal.dart';

/// Saves an image file to the device photo library (requires user permission).
///
/// Uses [Gal.hasAccess] / [Gal.requestAccess] without `toAlbum: true` so iOS uses
/// add-only / limited APIs appropriate for "save to Photos" (see gal README).
/// Prefer [Gal.putImageBytes] to avoid iOS temp-path edge cases with [Gal.putImage].
Future<void> saveImageFileToGallery(BuildContext context, String filePath) async {
  final messenger = ScaffoldMessenger.maybeOf(context);
  void showError(String message) {
    messenger?.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  try {
    if (!await Gal.hasAccess()) {
      final granted = await Gal.requestAccess();
      if (!granted) {
        showError('Photo library access is required to save to gallery');
        return;
      }
    }

    final file = File(filePath);
    if (!await file.exists()) {
      showError('Image file not found');
      return;
    }
    final bytes = await file.readAsBytes();
    final name = 'receipt_${DateTime.now().millisecondsSinceEpoch}';
    await Gal.putImageBytes(bytes, name: name);

    messenger?.showSnackBar(
      const SnackBar(
        content: Text('Saved to gallery'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  } on GalException catch (e) {
    showError(e.type.message);
  } catch (e) {
    showError('Could not save to gallery: $e');
  }
}
