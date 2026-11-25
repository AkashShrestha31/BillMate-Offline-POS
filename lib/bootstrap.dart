import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/l10n/app_locale_service.dart';
import 'package:hotel/src/core/themes/app_theme_mode_service.dart';
import 'package:hotel/src/features/settings/domain/live_stock_tracking_service.dart';
import 'package:hotel/src/core/services/currency/app_currency_service.dart';
import 'package:hotel/src/core/services/display_precision/app_display_precision_service.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/local/single_value_table_debug.dart';
import 'package:hotel/src/core/services/firebase_bootstrap.dart';
import 'package:hotel/src/features/org/domain/organization_database_service.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Inter/Poppins are bundled in assets/fonts — do not download at runtime (offline).
  GoogleFonts.config.allowRuntimeFetching = false;

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Keep the native launch screen visible until StartupSplashPage finishes bootstrap.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Init DI and warm Firebase while other local prefs load in parallel.
  await Future.wait([
    configureInjection(),
    FirebaseBootstrap.ensureInitialized(),
  ]);

  await OrganizationDatabaseService.ensureMigrated();

  await Future.wait([
    getIt<AppLocaleService>().load(),
    getIt<AppThemeModeService>().load(),
    getIt<LiveStockTrackingService>().load(),
    if (await LocalDb.databaseFileExists()) ...[
      getIt<AppCurrencyService>().load(),
      getIt<AppDisplayPrecisionService>().load(),
    ],
  ]);

  if (kDebugMode && await LocalDb.databaseFileExists()) {
    unawaited(SingleValueTableDebug.printAll(getIt<LocalDb>()));
  }

  Zone.current.runGuarded(() async {
    runApp(await builder());
  });
}
