import 'dart:ui';

/// Picks a suggested UI language from the device country and supported app languages.
abstract final class AppLanguageSuggestion {
  static const defaultLanguageCode = 'en';
  /// ISO 3166-1 alpha-2 country code → app language code.
  static const _countryToLanguage = <String, String>{
    'NP': 'ne',
    'IN': 'hi',
    'BD': 'bn',
    'PK': 'ur',
    'IR': 'fa',
    'AF': 'fa',
    'SA': 'ar',
    'AE': 'ar',
    'EG': 'ar',
    'IQ': 'ar',
    'JO': 'ar',
    'KW': 'ar',
    'LB': 'ar',
    'LY': 'ar',
    'MA': 'ar',
    'OM': 'ar',
    'QA': 'ar',
    'SY': 'ar',
    'TN': 'ar',
    'YE': 'ar',
    'BH': 'ar',
    'DZ': 'ar',
    'SD': 'ar',
    'CN': 'zh',
    'TW': 'zh',
    'HK': 'zh',
    'MO': 'zh',
    'JP': 'ja',
    'KR': 'ko',
    'KP': 'ko',
    'TH': 'th',
    'VN': 'vi',
    'ID': 'id',
    'MY': 'ms',
    'BN': 'ms',
    'PH': 'fil',
    'FR': 'fr',
    'DE': 'de',
    'AT': 'de',
    'IT': 'it',
    'NL': 'nl',
    'PL': 'pl',
    'TR': 'tr',
    'RU': 'ru',
    'BY': 'ru',
    'KZ': 'ru',
    'KG': 'ru',
    'BR': 'pt',
    'PT': 'pt',
    'AO': 'pt',
    'MZ': 'pt',
    'ES': 'es',
    'MX': 'es',
    'AR': 'es',
    'CO': 'es',
    'CL': 'es',
    'PE': 'es',
    'VE': 'es',
    'EC': 'es',
    'GT': 'es',
    'CU': 'es',
    'BO': 'es',
    'DO': 'es',
    'HN': 'es',
    'PY': 'es',
    'SV': 'es',
    'NI': 'es',
    'CR': 'es',
    'PA': 'es',
    'UY': 'es',
    'KE': 'sw',
    'TZ': 'sw',
    'UG': 'sw',
    'US': 'en',
    'GB': 'en',
    'AU': 'en',
    'CA': 'en',
    'NZ': 'en',
    'IE': 'en',
    'ZA': 'en',
    'SG': 'en',
    'NG': 'en',
    'GH': 'en',
    'JM': 'en',
  };

  static String resolve({
    required Locale deviceLocale,
    required Iterable<String> supportedLanguageCodes,
  }) {
    final supported = supportedLanguageCodes
        .map((code) => code.trim().toLowerCase())
        .where((code) => code.isNotEmpty)
        .toSet();
    if (supported.isEmpty) return defaultLanguageCode;

    final country = deviceLocale.countryCode?.toUpperCase();
    if (country != null) {
      final fromCountry = _countryToLanguage[country];
      if (fromCountry != null && supported.contains(fromCountry)) {
        return fromCountry;
      }
    }

    // Unknown country or that country's language is not in the app → English.
    return defaultLanguageCode;
  }

  static Locale deviceLocale() =>
      PlatformDispatcher.instance.locale;
}
