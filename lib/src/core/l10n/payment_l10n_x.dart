import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/l10n/localized_digits_x.dart';

extension PaymentL10nX on AppLocalizations {
  String localizedPaymentMethod(String method) {
    final normalized = method.trim().toLowerCase();
    switch (normalized) {
      case 'cash':
        return cash;
      case 'card':
        return paymentCard;
      case 'qr':
        return paymentQr;
      case 'bank':
        return paymentBank;
      case 'transfer':
        return paymentTransfer;
      case 'bank transfer':
        return paymentBankTransfer;
      case 'settlement':
        return paymentSettlement;
      case 'cheque':
      case 'check':
        return paymentCheque;
      case 'digital':
        return paymentDigital;
      case 'digital (qr)':
        return paymentDigitalQr;
      default:
        return localizeDigits(method);
    }
  }
}
