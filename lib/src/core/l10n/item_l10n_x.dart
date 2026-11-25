import 'package:hotel/l10n/app_localizations.dart';
import 'package:hotel/src/core/l10n/localized_digits_x.dart';

extension ItemL10nX on AppLocalizations {
  String localizedItemType(String type) {
    switch (type.trim().toLowerCase()) {
      case 'product':
        return itemTypeProduct;
      case 'service':
        return itemTypeService;
      case 'inventory':
        return itemTypeInventory;
      default:
        return type;
    }
  }

  String localizedItemPurpose(String purpose) {
    switch (purpose.trim().toLowerCase()) {
      case 'sales':
        return sales;
      case 'purchases':
      case 'purchase':
        return itemPurposePurchases;
      case 'both':
        return itemPurposeBoth;
      default:
        return purpose;
    }
  }

  String localizedItemPickerOption(String value) {
    final type = localizedItemType(value);
    if (type != value) return type;
    final purpose = localizedItemPurpose(value);
    if (purpose != value) return purpose;
    return localizeDigits(value);
  }

  String localizedItemTabLabel(String tab) => localizedItemPurpose(tab);
}
