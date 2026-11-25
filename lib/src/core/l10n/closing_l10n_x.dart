import 'package:hotel/l10n/app_localizations.dart';

/// Internal stat keys for closing summary cards (stable across locales).
abstract final class ClosingStatKey {
  static const openingBalance = 'opening_balance';
  static const totalSales = 'total_sales';
  static const qrAmount = 'qr_amount';
  static const cashAmount = 'cash_amount';
  static const cashExpenses = 'cash_expenses';
  static const salesDiscount = 'sales_discount';
  static const unpaid = 'unpaid';
  static const creditQr = 'credit_qr';
  static const creditCash = 'credit_cash';
  static const creditDiscount = 'credit_discount';
  static const payCashGetQr = 'pay_cash_get_qr';
  static const payQrGetCash = 'pay_qr_get_cash';
}

extension ClosingL10nX on AppLocalizations {
  String closingStatTitle(String key) {
    switch (key) {
      case ClosingStatKey.openingBalance:
        return closeOpeningBalance;
      case ClosingStatKey.totalSales:
        return closeTotalSales;
      case ClosingStatKey.qrAmount:
        return closeQrAmount;
      case ClosingStatKey.cashAmount:
        return closeCashAmount;
      case ClosingStatKey.cashExpenses:
        return closeCashExpenses;
      case ClosingStatKey.salesDiscount:
        return closeSalesDiscount;
      case ClosingStatKey.unpaid:
        return unpaid;
      case ClosingStatKey.creditQr:
        return closeCreditQr;
      case ClosingStatKey.creditCash:
        return closeCreditCash;
      case ClosingStatKey.creditDiscount:
        return closeCreditDiscount;
      case ClosingStatKey.payCashGetQr:
        return closePayCashGetQr;
      case ClosingStatKey.payQrGetCash:
        return closePayQrGetCash;
      default:
        return key;
    }
  }

  String? closingStatHint(String key) {
    switch (key) {
      case ClosingStatKey.openingBalance:
        return closeHintOpeningBalance;
      case ClosingStatKey.totalSales:
        return closeHintTotalSales;
      case ClosingStatKey.qrAmount:
        return closeHintQrAmount;
      case ClosingStatKey.cashAmount:
        return closeHintCashAmount;
      case ClosingStatKey.cashExpenses:
        return closeHintCashExpenses;
      case ClosingStatKey.salesDiscount:
        return closeHintSalesDiscount;
      case ClosingStatKey.unpaid:
        return unpaidAmountNotYetCollected;
      case ClosingStatKey.creditQr:
        return closeHintCreditQr;
      case ClosingStatKey.creditCash:
        return closeHintCreditCash;
      case ClosingStatKey.creditDiscount:
        return closeHintCreditDiscount;
      case ClosingStatKey.payCashGetQr:
        return closeHintPayCashGetQr;
      case ClosingStatKey.payQrGetCash:
        return closeHintPayQrGetCash;
      default:
        return null;
    }
  }

  String closeSalesShareDescription(String label, String percent) =>
      closeSalesShareDesc(label, percent);
}
