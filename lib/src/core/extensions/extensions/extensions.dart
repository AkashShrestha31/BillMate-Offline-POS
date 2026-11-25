import 'package:hotel/src/core/extensions/extensions/num_extensions.dart';
import 'package:intl/intl.dart';
export 'app_theme_extension.dart';
export 'context_extension.dart';
export 'date_validator.dart';
export 'guid_extension.dart';
export 'localization_extension.dart';
export 'num_extensions.dart';
export 'string_extension.dart';
export 'text_style_extensions.dart';
export 'theme_extensions.dart';
export 'theme_getter_extension.dart';
export 'widget_extensions.dart';

extension TimerToMinutes on int {
  String timerToMinutesAndSeconds() {
    final Duration clockTimer = Duration(seconds: this);
    return this == 0
        ? '00:00'
        : '${clockTimer.inMinutes.remainder(60).toInt().doubleDigitOnTimer()}:${clockTimer.inSeconds.remainder(60).toInt().doubleDigitOnTimer()}';
  }
}

extension MoneyFormatter on double {
  String toMoneyFormatter() {
    final numberFormatter = NumberFormat('#,##0.00');

    return numberFormatter.format(this);
  }
}
