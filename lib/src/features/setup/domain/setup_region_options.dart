import 'package:hotel/src/core/utils/searchable_country_code_picker_list.dart';

/// Setup region step: countries and default ISO 4217 currency per territory.
class SetupCountryOption {
  const SetupCountryOption({
    required this.name,
    required this.alpha2,
    required this.currencyCode,
  });

  final String name;
  final String alpha2;
  final String currencyCode;

  String pickerLabel(String symbol) {
    final sym = symbol.trim();
    if (sym.isEmpty) return '$name · $currencyCode';
    return '$name · $sym ($currencyCode)';
  }
}

abstract final class SetupRegionOptions {
  SetupRegionOptions._();

  static List<SetupCountryOption>? _countries;


  static const _alpha2ToCurrency = <String, String>{
    'AD': 'EUR',
    'AE': 'AED',
    'AF': 'AFN',
    'AG': 'XCD',
    'AL': 'ALL',
    'AM': 'AMD',
    'AO': 'AOA',
    'AQ': 'USD',
    'AR': 'ARS',
    'AT': 'EUR',
    'AU': 'AUD',
    'AW': 'AWG',
    'AX': 'EUR',
    'AZ': 'AZN',
    'BA': 'BAM',
    'BB': 'BBD',
    'BD': 'BDT',
    'BE': 'EUR',
    'BF': 'XOF',
    'BG': 'BGN',
    'BH': 'BHD',
    'BI': 'BIF',
    'BJ': 'XOF',
    'BL': 'EUR',
    'BM': 'BMD',
    'BN': 'BND',
    'BO': 'BOB',
    'BR': 'BRL',
    'BS': 'BSD',
    'BT': 'BTN',
    'BV': 'NOK',
    'BW': 'BWP',
    'BY': 'BYN',
    'BZ': 'BZD',
    'CA': 'CAD',
    'CC': 'AUD',
    'CD': 'CDF',
    'CF': 'XAF',
    'CG': 'XAF',
    'CH': 'CHF',
    'CI': 'XOF',
    'CL': 'CLP',
    'CM': 'XAF',
    'CN': 'CNY',
    'CO': 'COP',
    'CR': 'CRC',
    'CU': 'CUP',
    'CV': 'CVE',
    'CX': 'AUD',
    'CY': 'EUR',
    'CZ': 'CZK',
    'DE': 'EUR',
    'DJ': 'DJF',
    'DK': 'DKK',
    'DM': 'XCD',
    'DO': 'DOP',
    'DZ': 'DZD',
    'EC': 'USD',
    'EE': 'EUR',
    'EG': 'EGP',
    'EH': 'MAD',
    'ER': 'ERN',
    'ES': 'EUR',
    'ET': 'ETB',
    'FI': 'EUR',
    'FJ': 'FJD',
    'FK': 'FKP',
    'FM': 'USD',
    'FO': 'DKK',
    'FR': 'EUR',
    'GA': 'XAF',
    'GB': 'GBP',
    'GD': 'XCD',
    'GE': 'GEL',
    'GF': 'EUR',
    'GG': 'GBP',
    'GH': 'GHS',
    'GI': 'GIP',
    'GL': 'DKK',
    'GM': 'GMD',
    'GN': 'GNF',
    'GP': 'EUR',
    'GQ': 'XAF',
    'GR': 'EUR',
    'GS': 'GBP',
    'GT': 'GTQ',
    'GU': 'USD',
    'GW': 'XOF',
    'GY': 'GYD',
    'HK': 'HKD',
    'HM': 'AUD',
    'HN': 'HNL',
    'HR': 'EUR',
    'HT': 'HTG',
    'HU': 'HUF',
    'ID': 'IDR',
    'IE': 'EUR',
    'IL': 'ILS',
    'IM': 'GBP',
    'IN': 'INR',
    'IO': 'USD',
    'IQ': 'IQD',
    'IR': 'IRR',
    'IS': 'ISK',
    'IT': 'EUR',
    'JE': 'GBP',
    'JM': 'JMD',
    'JO': 'JOD',
    'JP': 'JPY',
    'KE': 'KES',
    'KG': 'KGS',
    'KH': 'KHR',
    'KI': 'AUD',
    'KM': 'KMF',
    'KN': 'XCD',
    'KR': 'KRW',
    'KW': 'KWD',
    'KY': 'KYD',
    'KZ': 'KZT',
    'LA': 'LAK',
    'LB': 'LBP',
    'LC': 'XCD',
    'LI': 'CHF',
    'LK': 'LKR',
    'LR': 'LRD',
    'LS': 'LSL',
    'LT': 'EUR',
    'LU': 'EUR',
    'LV': 'EUR',
    'LY': 'LYD',
    'MA': 'MAD',
    'MC': 'EUR',
    'MD': 'MDL',
    'ME': 'EUR',
    'MF': 'EUR',
    'MG': 'MGA',
    'MH': 'USD',
    'MK': 'MKD',
    'ML': 'XOF',
    'MM': 'MMK',
    'MN': 'MNT',
    'MO': 'MOP',
    'MP': 'USD',
    'MQ': 'EUR',
    'MR': 'MRU',
    'MS': 'XCD',
    'MT': 'EUR',
    'MU': 'MUR',
    'MV': 'MVR',
    'MW': 'MWK',
    'MX': 'MXN',
    'MY': 'MYR',
    'MZ': 'MZN',
    'NA': 'NAD',
    'NC': 'XPF',
    'NE': 'XOF',
    'NF': 'AUD',
    'NG': 'NGN',
    'NI': 'NIO',
    'NL': 'EUR',
    'NO': 'NOK',
    'NP': 'NPR',
    'NR': 'AUD',
    'NU': 'NZD',
    'NZ': 'NZD',
    'OM': 'OMR',
    'PA': 'USD',
    'PE': 'PEN',
    'PF': 'XPF',
    'PG': 'PGK',
    'PH': 'PHP',
    'PK': 'PKR',
    'PL': 'PLN',
    'PM': 'EUR',
    'PN': 'NZD',
    'PR': 'USD',
    'PS': 'ILS',
    'PT': 'EUR',
    'PW': 'USD',
    'PY': 'PYG',
    'QA': 'QAR',
    'RE': 'EUR',
    'RO': 'RON',
    'RS': 'RSD',
    'RU': 'RUB',
    'RW': 'RWF',
    'SA': 'SAR',
    'SB': 'SBD',
    'SC': 'SCR',
    'SD': 'SDG',
    'SE': 'SEK',
    'SG': 'SGD',
    'SH': 'SHP',
    'SI': 'EUR',
    'SJ': 'NOK',
    'SK': 'EUR',
    'SL': 'SLE',
    'SM': 'EUR',
    'SN': 'XOF',
    'SO': 'SOS',
    'SR': 'SRD',
    'SS': 'SSP',
    'ST': 'STN',
    'SV': 'USD',
    'SX': 'ANG',
    'SY': 'SYP',
    'SZ': 'SZL',
    'TC': 'USD',
    'TD': 'XAF',
    'TF': 'EUR',
    'TG': 'XOF',
    'TH': 'THB',
    'TJ': 'TJS',
    'TK': 'NZD',
    'TL': 'USD',
    'TM': 'TMT',
    'TN': 'TND',
    'TO': 'TOP',
    'TR': 'TRY',
    'TT': 'TTD',
    'TW': 'TWD',
    'TZ': 'TZS',
    'UA': 'UAH',
    'UG': 'UGX',
    'UM': 'USD',
    'US': 'USD',
    'UY': 'UYU',
    'UZ': 'UZS',
    'VC': 'XCD',
    'VE': 'VES',
    'VG': 'USD',
    'VI': 'USD',
    'VN': 'VND',
    'VU': 'VUV',
    'WS': 'WST',
    'XK': 'EUR',
    'YE': 'YER',
    'YT': 'EUR',
    'ZA': 'ZAR',
    'ZM': 'ZMW',
    'ZW': 'ZWL',
  };

  static List<SetupCountryOption> countries() {
    return _countries ??= _buildCountries();
  }

  static List<SetupCountryOption> _buildCountries() {
    final names = iso3166EnglishCountryNamesByAlpha2();
    final list = <SetupCountryOption>[];
    for (final entry in names.entries) {
      final currency = _alpha2ToCurrency[entry.key];
      if (currency == null) continue;
      list.add(
        SetupCountryOption(
          name: entry.value,
          alpha2: entry.key,
          currencyCode: currency,
        ),
      );
    }
    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }

  static String? currencyCodeForCountry(String countryName) {
    final normalized = countryName.trim().toLowerCase();
    for (final c in countries()) {
      if (c.name.trim().toLowerCase() == normalized) return c.currencyCode;
    }
    return null;
  }

  static SetupCountryOption? countryNamed(String countryName) {
    final normalized = countryName.trim().toLowerCase();
    for (final c in countries()) {
      if (c.name.trim().toLowerCase() == normalized) return c;
    }
    return null;
  }

  /// First country using [currencyCode] (for syncing country when currency changes).
  static String? firstCountryForCurrency(String currencyCode) {
    final code = currencyCode.trim().toUpperCase();
    for (final c in countries()) {
      if (c.currencyCode == code) return c.name;
    }
    return null;
  }

  static const defaultCountryName = 'Nepal';
  static const defaultCurrencyCode = 'NPR';

  /// Books DB locale + country code for [SystemSettings].
  static (String countryCode, String locale) localeForCountry(String countryName) {
    final option = countryNamed(countryName);
    if (option == null) return ('np', 'ne-NP');

    final a2 = option.alpha2.toLowerCase();
    return switch (a2) {
      'np' => ('np', 'ne-NP'),
      'in' => ('in', 'en-IN'),
      'us' => ('us', 'en-US'),
      'gb' => ('gb', 'en-GB'),
      'au' => ('au', 'en-AU'),
      'ca' => ('ca', 'en-CA'),
      _ => (a2, 'en-${a2.toUpperCase()}'),
    };
  }
}

