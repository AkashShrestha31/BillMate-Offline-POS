import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/l10n/localized_digits_x.dart';

extension AppLocalizationsX on AppLocalizations {
  /// Short month labels for charts (localized).
  List<String> get shortMonthLabels => [
        monthJan,
        monthFeb,
        monthMar,
        monthApr,
        monthMay,
        monthJun,
        monthJul,
        monthAug,
        monthSep,
        monthOct,
        monthNov,
        monthDec,
      ];

  String statisticsGreetingForHour(int hour) {
    if (hour < 12) return statisticsGoodMorning;
    if (hour < 17) return statisticsGoodAfternoon;
    return statisticsGoodEvening;
  }

  String statisticsPeriodLabel(String key) {
    switch (key) {
      case 'Day':
        return statisticsPeriodDay;
      case 'Month':
        return statisticsPeriodMonth;
      case 'Year':
        return statisticsPeriodYear;
      default:
        return key;
    }
  }

  String statisticsCashflowRangeLabel(String key) {
    switch (key) {
      case 'Daily':
        return statisticsDaily;
      case 'Monthly':
        return statisticsMonthly;
      case 'Overall':
        return statisticsOverall;
      default:
        return key;
    }
  }

  /// Localized month revenue card title (API key or default English fallback).
  String statisticsMonthRevenueTitle(String title) {
    if (title == 'Month Revenue') return statisticsMonthRevenue;
    return localizeDigits(title);
  }

  /// Localized month expenses card title (API key or default English fallback).
  String statisticsMonthExpenseTitle(String title) {
    if (title == 'Month Expenses') return statisticsMonthExpenses;
    return localizeDigits(title);
  }

  String localizedDefaultAccountName(String account) {
    switch (account.trim().toLowerCase()) {
      case 'debtors':
        return partyAccountDebtors;
      case 'creditors':
        return partyAccountCreditors;
      default:
        return account;
    }
  }

  String localizedPartyRoleName(String role) {
    switch (role.trim().toLowerCase()) {
      case 'customer':
        return partyRoleCustomer;
      case 'supplier':
        return partyRoleSupplier;
      case 'room':
        return partyRoleRoom;
      case 'cabin':
        return partyRoleCabin;
      case 'employee':
        return partyRoleEmployee;
      case 'both':
        return partyRoleBoth;
      default:
        return role;
    }
  }

  String partySortLabel(String sortKey) {
    switch (sortKey) {
      case 'latest':
        return partySortLatest;
      case 'amount_high_low':
        return partySortAmountHighLow;
      case 'amount_low_high':
        return partySortAmountLowHigh;
      case 'name_az':
        return partySortNameAZ;
      case 'name_za':
        return partySortNameZA;
      default:
        return sortKey;
    }
  }
}
