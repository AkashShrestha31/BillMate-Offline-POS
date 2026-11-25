import 'package:flutter/material.dart';
import 'package:hotel/l10n/app_localizations.dart';

/// Stable codes stored in `SingleValue` (`parent = Organization`, `fieldname = businessType`).
abstract final class OrganizationBusinessType {
  static const hotel = 'HOTEL';
  static const restaurant = 'RESTAURANT';
  static const hotelRestaurant = 'HOTEL_RESTAURANT';
  static const retail = 'RETAIL';
  static const cafe = 'CAFE';
  static const bar = 'BAR';
  static const other = 'OTHER';

  static const defaultCode = hotel;

  static const all = <String>[
    hotel,
    restaurant,
    hotelRestaurant,
    retail,
    cafe,
    bar,
    other,
  ];

  static String normalize(String? raw) {
    final key = raw?.trim().toUpperCase() ?? '';
    if (key.isEmpty) return defaultCode;
    return all.contains(key) ? key : other;
  }

  /// Liquor price calculator for hospitality and bar/pub businesses.
  static bool supportsLiquorCalculator(String? code) {
    final normalized = normalize(code);
    return normalized == hotel ||
        normalized == restaurant ||
        normalized == hotelRestaurant ||
        normalized == bar;
  }

  static IconData iconFor(String? code) {
    switch (normalize(code)) {
      case hotel:
        return Icons.hotel_rounded;
      case restaurant:
        return Icons.restaurant_rounded;
      case hotelRestaurant:
        return Icons.nightlife_rounded;
      case retail:
        return Icons.storefront_rounded;
      case cafe:
        return Icons.local_cafe_rounded;
      case bar:
        return Icons.local_bar_rounded;
      case other:
        return Icons.business_rounded;
      default:
        return Icons.business_rounded;
    }
  }
}

extension OrganizationBusinessTypeL10n on AppLocalizations {
  String businessTypeLabel(String? code) {
    switch (OrganizationBusinessType.normalize(code)) {
      case OrganizationBusinessType.hotel:
        return businessTypeHotel;
      case OrganizationBusinessType.restaurant:
        return businessTypeRestaurant;
      case OrganizationBusinessType.hotelRestaurant:
        return businessTypeHotelRestaurant;
      case OrganizationBusinessType.retail:
        return businessTypeRetail;
      case OrganizationBusinessType.cafe:
        return businessTypeCafe;
      case OrganizationBusinessType.bar:
        return businessTypeBar;
      case OrganizationBusinessType.other:
        return businessTypeOther;
      default:
        return businessTypeOther;
    }
  }

  String businessTypeSubtitle(String? code) {
    switch (OrganizationBusinessType.normalize(code)) {
      case OrganizationBusinessType.hotel:
        return businessTypeHotelSubtitle;
      case OrganizationBusinessType.restaurant:
        return businessTypeRestaurantSubtitle;
      case OrganizationBusinessType.hotelRestaurant:
        return businessTypeHotelRestaurantSubtitle;
      case OrganizationBusinessType.retail:
        return businessTypeRetailSubtitle;
      case OrganizationBusinessType.cafe:
        return businessTypeCafeSubtitle;
      case OrganizationBusinessType.bar:
        return businessTypeBarSubtitle;
      case OrganizationBusinessType.other:
        return businessTypeOtherSubtitle;
      default:
        return businessTypeOtherSubtitle;
    }
  }
}
