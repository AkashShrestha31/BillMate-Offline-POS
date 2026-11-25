import 'package:country_code_picker/country_code_picker.dart';

/// Normalizes a local phone input to digits only (strips spaces, dashes, etc.).
/// Removes a single leading 0 often used before the country code.
String normalizeLocalPhoneDigits(String input) {
  var digits = input.replaceAll(RegExp(r'\D'), '');
  if (digits.startsWith('0') && digits.length > 1) {
    digits = digits.substring(1);
  }
  return digits;
}

/// Validates [localPhone] for the selected [country]. Empty input is allowed.
String? validateLocalPhoneForCountry(String? localPhone, CountryCode country) {
  final raw = localPhone?.trim() ?? '';
  if (raw.isEmpty) return null;

  final digits = normalizeLocalPhoneDigits(raw);
  if (digits.isEmpty) {
    return 'Enter a valid mobile number';
  }

  final iso = (country.code ?? '').toUpperCase();
  final expectedLength = _expectedLocalLength(iso);

  if (expectedLength != null) {
    if (digits.length != expectedLength) {
      return 'Enter a ${_countryPhoneLabel(iso)} number ($expectedLength digits)';
    }
    return _validateCountryPrefix(iso, digits);
  }

  if (digits.length < 4 || digits.length > 14) {
    return 'Enter a valid mobile number (4–14 digits)';
  }
  return null;
}

int? _expectedLocalLength(String isoCode) {
  switch (isoCode) {
    case 'NP':
    case 'IN':
    case 'US':
    case 'CA':
    case 'GB':
    case 'AU':
    case 'NZ':
    case 'DE':
    case 'FR':
    case 'IT':
    case 'ES':
    case 'NL':
    case 'PL':
    case 'TR':
    case 'PH':
    case 'MY':
    case 'ID':
    case 'TH':
    case 'VN':
    case 'KR':
    case 'JP':
    case 'CN':
    case 'PK':
    case 'BD':
      return 10;
    case 'AE':
    case 'SA':
    case 'QA':
    case 'KW':
    case 'BH':
    case 'OM':
      return 9;
    case 'SG':
      return 8;
    default:
      return null;
  }
}

String _countryPhoneLabel(String isoCode) {
  switch (isoCode) {
    case 'NP':
      return 'Nepal mobile';
    case 'IN':
      return 'Indian mobile';
    case 'US':
    case 'CA':
      return '10-digit';
    case 'GB':
      return 'UK mobile';
    case 'AE':
      return 'UAE mobile';
    case 'SA':
      return 'Saudi mobile';
    default:
      return 'valid mobile';
  }
}

String? _validateCountryPrefix(String isoCode, String digits) {
  switch (isoCode) {
    case 'NP':
      if (!digits.startsWith('97') && !digits.startsWith('98')) {
        return 'Nepal mobile numbers usually start with 97 or 98';
      }
      return null;
    case 'IN':
      if (!RegExp(r'^[6-9]').hasMatch(digits)) {
        return 'Indian mobile numbers start with 6, 7, 8, or 9';
      }
      return null;
    case 'US':
    case 'CA':
      if (digits.startsWith('0') || digits.startsWith('1')) {
        return 'Enter the 10-digit number without country code';
      }
      return null;
    case 'AE':
      if (!digits.startsWith('5')) {
        return 'UAE mobile numbers usually start with 5';
      }
      return null;
    case 'SA':
      if (!digits.startsWith('5')) {
        return 'Saudi mobile numbers usually start with 5';
      }
      return null;
    default:
      return null;
  }
}

/// Builds the stored phone value: dial code + normalized local digits.
String? composePhoneWithCountryCode(String? localPhone, CountryCode country) {
  final digits = normalizeLocalPhoneDigits(localPhone ?? '');
  if (digits.isEmpty) return null;
  final dial = country.dialCode ?? '';
  return '$dial$digits';
}
