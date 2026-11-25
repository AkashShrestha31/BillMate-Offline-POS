import 'dart:io' show Platform;

import 'package:permission_handler/permission_handler.dart';

/// A Collection of Permission accross the app for checking the status of permission
///
/// have platform checks
/// ```dart
///
/// await PermissionHelper.galleryPermission
///
/// ```
class PermissionHelper {
  const PermissionHelper._();

  /// getter for checking gallery permission
  /// return `Future<bool>`
  /// ```dart
  /// if (await PermissionHelper.galleryPermission){
  /// // run some code
  /// }else {
  ///
  /// }
  /// ```
  /// On Android 13+, [ImagePicker] uses the system photo picker (no storage permission).
  static Future<bool> galleryPermission() async {
    if (Platform.isAndroid) return true;
    final galleryPermissionStatus = await Permission.photos.request();
    return _checkStatus(galleryPermissionStatus, galleryPermission);
  }

  /// Returns true when the barcode scanner should open.
  ///
  /// On iOS the scanner asks with the system camera dialog
  /// (`AVCaptureDevice.requestAccess`).
  static Future<bool> cameraPermission() async {
    if (Platform.isIOS) return true;

    final status = await Permission.camera.status;
    if (status.isGranted || status.isLimited) return true;
    final requested = await Permission.camera.request();
    return requested.isGranted || requested.isLimited;
  }

  static Future<bool> appTrackingPermission() async {
    final appTrackingPermissionStatus =
        await Permission.appTrackingTransparency.request();
    return _checkStatus(appTrackingPermissionStatus, appTrackingPermission);
  }

  static Future<bool> _checkStatus(
      PermissionStatus status, Future<bool> Function() func) async {
    switch (status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.denied:
        late bool isEnabled = false;
        func.call().then((value) {
          isEnabled = value;
        });
        return isEnabled;
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
        return false;
      default:
        return false;
    }
  }
}
