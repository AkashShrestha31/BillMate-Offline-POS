import 'package:flutter/foundation.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/services/display_precision/app_money_format.dart';
import 'package:hotel/src/features/org/domain/system_settings_service.dart';
import 'package:injectable/injectable.dart';

/// Loads and caches display precision from local books DB ([SystemSettings]).
@lazySingleton
class AppDisplayPrecisionService extends ChangeNotifier {
  AppDisplayPrecisionService(this._settings);

  final SystemSettingsService _settings;

  int _precision = SystemSettingsService.defaultDisplayPrecision;

  int get precision => _precision;

  Future<void> load() async {
    _precision = await _settings.loadDisplayPrecision();
    AppMoneyFormat.apply(_precision);
    notifyListeners();
  }
}

Future<void> refreshAppDisplayPrecision() =>
    getIt<AppDisplayPrecisionService>().load();
