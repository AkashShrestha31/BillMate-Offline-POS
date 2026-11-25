/// Fiscal year start dates from Country_TaxID_Currency_TaxRates_FiscalYear.pdf
/// (Sep 2026). Default is calendar year (1 Jan – 31 Dec).
class CountryFiscalYearProfile {
  const CountryFiscalYearProfile({
    required this.startMonth,
    required this.startDay,
  });

  /// Calendar year: 1 Jan – 31 Dec.
  static const calendar = CountryFiscalYearProfile(startMonth: 1, startDay: 1);

  /// Common Apr–Mar year (India, UK gov, Singapore, …).
  static const april = CountryFiscalYearProfile(startMonth: 4, startDay: 1);

  /// Jul–Jun year (Australia, Pakistan, …).
  static const july = CountryFiscalYearProfile(startMonth: 7, startDay: 1);

  /// Oct–Sep federal year (US, Thailand, …).
  static const october = CountryFiscalYearProfile(startMonth: 10, startDay: 1);

  /// Nepal Bikram Sambat ≈ mid-Jul – mid-Jul.
  static const nepal = CountryFiscalYearProfile(startMonth: 7, startDay: 16);

  /// Afghanistan solar ≈ 21 Mar – 20 Mar.
  static const afghanistan = CountryFiscalYearProfile(startMonth: 3, startDay: 21);

  /// Ethiopia ≈ 8 Jul – 7 Jul.
  static const ethiopia = CountryFiscalYearProfile(startMonth: 7, startDay: 8);

  final int startMonth;
  final int startDay;

  /// Current fiscal period containing [asOf] (defaults to now).
  (DateTime start, DateTime end) periodFor([DateTime? asOf]) {
    final now = asOf ?? DateTime.now();
    var start = DateTime(now.year, startMonth, startDay);
    if (now.isBefore(start)) {
      start = DateTime(now.year - 1, startMonth, startDay);
    }
    final nextStart = DateTime(start.year + 1, startMonth, startDay);
    final end = nextStart.subtract(const Duration(days: 1));
    return (start, end);
  }
}

abstract final class CountryFiscalYears {
  CountryFiscalYears._();

  /// Non–calendar-year countries from the reference PDF key notes + table.
  static const _overrides = <String, CountryFiscalYearProfile>{
    // 1 Apr – 31 Mar
    'India': CountryFiscalYearProfile.april,
    'Japan': CountryFiscalYearProfile.april,
    'Canada': CountryFiscalYearProfile.april,
    'Singapore': CountryFiscalYearProfile.april,
    'Hong Kong': CountryFiscalYearProfile.april,
    'South Africa': CountryFiscalYearProfile.april,
    'United Kingdom': CountryFiscalYearProfile.april,
    'Barbados': CountryFiscalYearProfile.april,
    'Botswana': CountryFiscalYearProfile.april,
    'Jamaica': CountryFiscalYearProfile.april,
    'Kuwait': CountryFiscalYearProfile.april,
    'Namibia': CountryFiscalYearProfile.april,
    'Qatar': CountryFiscalYearProfile.april,
    'Brunei': CountryFiscalYearProfile.april,
    'Belize': CountryFiscalYearProfile.april,
    'Bermuda': CountryFiscalYearProfile.april,
    'New Zealand': CountryFiscalYearProfile.april,

    // 1 Jul – 30 Jun
    'Australia': CountryFiscalYearProfile.july,
    'Pakistan': CountryFiscalYearProfile.july,
    'Bangladesh': CountryFiscalYearProfile.july,
    'Egypt': CountryFiscalYearProfile.july,
    'Kenya': CountryFiscalYearProfile.july,
    'Uganda': CountryFiscalYearProfile.july,
    'Tanzania': CountryFiscalYearProfile.july,
    'Rwanda': CountryFiscalYearProfile.july,
    'Cameroon': CountryFiscalYearProfile.july,
    'Mauritius': CountryFiscalYearProfile.july,
    'Bahamas': CountryFiscalYearProfile.july,

    // 1 Oct – 30 Sep
    'United States': CountryFiscalYearProfile.october,
    'Thailand': CountryFiscalYearProfile.october,
    'Trinidad and Tobago': CountryFiscalYearProfile.october,
    'Trinidad & Tobago': CountryFiscalYearProfile.october,
    'Haiti': CountryFiscalYearProfile.october,

    // Special
    'Afghanistan': CountryFiscalYearProfile.afghanistan,
    'Ethiopia': CountryFiscalYearProfile.ethiopia,
    'Nepal': CountryFiscalYearProfile.nepal,
    'Iran': CountryFiscalYearProfile.afghanistan,
  };

  static CountryFiscalYearProfile of(String country) {
    final key = country.trim();
    if (key.isEmpty) return CountryFiscalYearProfile.calendar;
    return _overrides[key] ??
        _overrides[_aliases[key] ?? ''] ??
        CountryFiscalYearProfile.calendar;
  }

  static const _aliases = <String, String>{
    'USA': 'United States',
    'US': 'United States',
    'UK': 'United Kingdom',
    'Great Britain': 'United Kingdom',
    'Korea, South': 'South Korea',
    'South Korea': 'South Korea',
  };

  /// Fiscal start/end dates for [country] relative to [asOf].
  static (DateTime start, DateTime end) datesFor(
    String country, [
    DateTime? asOf,
  ]) =>
      of(country).periodFor(asOf);
}
