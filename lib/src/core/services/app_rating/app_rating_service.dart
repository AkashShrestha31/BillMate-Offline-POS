import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens the store listing for user-initiated rating prompts.
class AppRatingService {
  static const playStorePackageId = 'ai.biztrack';

  /// Production Play Store listing (always `ai.biztrack`, not dev/staging suffix).
  static const playStoreListingUrl =
      'https://play.google.com/store/apps/details?id=$playStorePackageId&hl=en';

  /// BillMate on the App Store — direct listing URL (no generic redirect).
  static const appStoreListingUrl =
      'https://apps.apple.com/us/app/offline-pos-billmate-billing/id6807730783';

  final InAppReview _inAppReview = InAppReview.instance;

  /// "Rate us" menu action — opens Google Play / App Store listing directly.
  Future<bool> openRateUsListing() async {
    if (Platform.isAndroid) {
      return _openAndroidPlayStore();
    }
    if (Platform.isIOS || Platform.isMacOS) {
      return _openAppStoreListing();
    }
    return _openHttpsPlayStore();
  }

  /// Tries the platform in-app review sheet (for automatic prompts only).
  Future<bool> requestReview() async {
    try {
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
        return true;
      }
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('AppRatingService: in-app review failed: $e\n$st');
      }
    }

    return openRateUsListing();
  }

  Future<bool> _openAppStoreListing() async {
    final uri = Uri.parse(appStoreListingUrl);
    try {
      if (await canLaunchUrl(uri)) {
        return launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('AppRatingService: App Store URL failed: $e\n$st');
      }
    }
    return false;
  }

  Future<bool> _openAndroidPlayStore() async {
    final marketUri = Uri.parse('market://details?id=$playStorePackageId');
    try {
      if (await canLaunchUrl(marketUri)) {
        final opened = await launchUrl(
          marketUri,
          mode: LaunchMode.externalApplication,
        );
        if (opened) return true;
      }
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('AppRatingService: market:// failed: $e\n$st');
      }
    }
    return _openHttpsPlayStore();
  }

  Future<bool> _openHttpsPlayStore() async {
    final uri = Uri.parse(playStoreListingUrl);
    if (!await canLaunchUrl(uri)) return false;
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
