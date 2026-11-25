import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hotel/src/core/config/app_platform_config.dart';
import 'package:hotel/src/core/constants/app_constants.dart';
import 'package:hotel/src/core/helpers/app_version_compare.dart';
import 'package:hotel/src/core/services/app_rating/app_rating_service.dart';
import 'package:hotel/src/core/services/firebase_bootstrap.dart';
import 'package:hotel/src/core/services/force_update/force_update_config_loader.dart';
import 'package:hotel/src/core/services/force_update/force_update_policy.dart';
import 'package:hotel/src/core/services/force_update/force_update_result.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@lazySingleton
class ForceUpdateService {
  static const _defaultPlayStoreUrl =
      'https://play.google.com/store/apps/details?id=ai.biztrack';
  static const _defaultAppStoreUrl = AppRatingService.appStoreListingUrl;

  /// [fastStart] uses cached Remote Config with a short fetch timeout so app
  /// launch is not blocked on slow networks.
  Future<ForceUpdateResult> check({bool fastStart = false}) async {
    final currentVersion = await _readCurrentVersion();

    try {
      if (!FirebaseBootstrap.hasFirebaseApp) {
        await FirebaseBootstrap.ensureInitialized();
      }
      if (!FirebaseBootstrap.hasFirebaseApp) {
        log('ForceUpdateService: skipped (Firebase not initialized)');
        return ForceUpdateResult.notRequired(currentVersion: currentVersion);
      }

      final loaded = await ForceUpdateConfigLoader.load(fastStart: fastStart);
      final policy = loaded.policy;

      log(
        'ForceUpdateService: source=${loaded.source} enabled=${policy.enabled} '
        'current=$currentVersion '
        'minAndroid=${policy.minRequiredVersionAndroid} '
        'minIos=${policy.minRequiredVersionIos}',
      );

      if (!policy.enabled) {
        log('ForceUpdateService: skipped (force_update_enabled=false)');
        return ForceUpdateResult.notRequired(currentVersion: currentVersion);
      }

      final minimumVersion = _minimumVersionForPlatform(policy);
      if (minimumVersion.isEmpty) {
        log('ForceUpdateService: skipped (no minimum version set)');
        return ForceUpdateResult.notRequired(currentVersion: currentVersion);
      }

      if (!AppVersionCompare.isLessThan(currentVersion, minimumVersion)) {
        log(
          'ForceUpdateService: skipped (current=$currentVersion '
          '>= minimum=$minimumVersion)',
        );
        return ForceUpdateResult.notRequired(currentVersion: currentVersion);
      }

      log(
        'ForceUpdateService: update required '
        '(current=$currentVersion, minimum=$minimumVersion, '
        'source=${loaded.source})',
      );

      final storeUrl = Platform.isIOS
          ? (policy.iosStoreUrl.isNotEmpty
              ? policy.iosStoreUrl
              : _defaultAppStoreUrl)
          : (policy.androidStoreUrl.isNotEmpty
              ? policy.androidStoreUrl
              : _defaultPlayStoreUrl);

      return ForceUpdateResult.required(
        currentVersion: currentVersion,
        minimumVersion: minimumVersion,
        title: policy.title.isNotEmpty ? policy.title : 'Update required',
        message: policy.message.isNotEmpty
            ? policy.message
            : 'A new version of ${AppPlatformConfig.appName} is available. Please update to continue.',
        storeUrl: storeUrl,
      );
    } catch (e, st) {
      log('ForceUpdateService: check skipped ($e)', stackTrace: st);
      return ForceUpdateResult.notRequired(currentVersion: currentVersion);
    }
  }

  String _minimumVersionForPlatform(ForceUpdatePolicy policy) {
    if (Platform.isAndroid && policy.minRequiredVersionAndroid.isNotEmpty) {
      return policy.minRequiredVersionAndroid;
    }
    if (Platform.isIOS && policy.minRequiredVersionIos.isNotEmpty) {
      return policy.minRequiredVersionIos;
    }
    return policy.minRequiredVersion;
  }

  Future<String> _readCurrentVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final version = packageInfo.version.trim();
      final build = packageInfo.buildNumber.trim();
      if (version.isNotEmpty) {
        if (build.isNotEmpty) {
          return '$version+$build';
        }
        return version;
      }
    } on MissingPluginException {
      if (kDebugMode) {
        debugPrint(
          'ForceUpdateService: package_info unavailable — '
          'using ${AppConstants.appVersionWithBuild}. Stop app and run again.',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ForceUpdateService: package_info error: $e');
      }
    }
    return AppConstants.appVersionWithBuild;
  }
}
