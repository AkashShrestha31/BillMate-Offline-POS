import 'package:flutter/widgets.dart';
import 'package:hotel/l10n/app_localizations.dart';

/// English localizations for services without a [BuildContext] (PDF, splash, etc.).
AppLocalizations get defaultL10n => lookupAppLocalizations(const Locale('en'));
