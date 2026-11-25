import 'package:hotel/src/core/enums/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart';
import 'package:intl/intl.dart';

class Utility {
  const Utility._();
  static double calculateLetterSpacing(double value) => value * 16;
  static DeviceScreenType getDeviceScreenType(MediaQueryData mediaQueryData) {
    final double deviceWidth = mediaQueryData.size.width;
    if (deviceWidth < 650) {
      return DeviceScreenType.mobile;
    } else if (deviceWidth < 1250 && deviceWidth >= 650) {
      return DeviceScreenType.tablet;
    }
    return DeviceScreenType.desktop;
  }

  static bool _matchesDateRange(InvoiceItem invoice, DateTimeRange? selectedDateRange) {
    if (selectedDateRange == null) return true;
    final date = DateTime.parse(invoice.date ?? '');
    return date.isAfter(selectedDateRange.start) && date.isBefore(selectedDateRange.end.add(const Duration(days: 1)));
  }

  static bool _matchesItemSearch(InvoiceItem invoice, String searchQuery) {
    if (searchQuery.isEmpty) return true;
    return ((invoice.items ?? []).any((item) {
          final itemName = item.item ?? '';
          return itemName.toLowerCase().contains(searchQuery.toLowerCase());
        })) ||
        (invoice.party.toString().toLowerCase().contains(searchQuery.toLowerCase()));
  }

  static List<InvoiceItem> filteredInvoices(
      InvoiceSalesResponseModel response, DateTimeRange? selectedDateRange, String searchQuery) {
    return (response.data ?? []).where((invoice) {
      return _matchesDateRange(invoice, selectedDateRange) && _matchesItemSearch(invoice, searchQuery);
    }).toList();
  }

  static String formatIndianNumber(int number) {
    final isNegative = number < 0;
    final str = number.abs().toString().trim();

    // Handle numbers with 3 or fewer digits
    if (str.length <= 3) {
      return isNegative ? '-$str' : str;
    }

    final lastThree = str.substring(str.length - 3);
    final remaining = str.substring(0, str.length - 3);

    final buffer = StringBuffer();
    for (int i = 0; i < remaining.length; i++) {
      if (i != 0 && (remaining.length - i) % 2 == 0) {
        buffer.write(',');
      }
      buffer.write(remaining[i]);
    }

    final formatted = '${buffer.toString()},$lastThree';
    return isNegative ? '-$formatted' : formatted;
  }

  // Add this function to your Utility class
  static String formatDateToCustom(String isoDateString) {
    try {
      // Remove timezone offset to preserve the original time
      final withoutTimezone = isoDateString.replaceAll(RegExp(r'[+-]\d{2}:\d{2}$'), '');
      DateTime dateTime = DateTime.parse(withoutTimezone);

      DateFormat monthDayFormatter = DateFormat('MMM d');
      DateFormat timeFormatter = DateFormat('h:mm a');

      String monthDay = monthDayFormatter.format(dateTime);
      String time = timeFormatter.format(dateTime);

      return '$monthDay - $time';
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
