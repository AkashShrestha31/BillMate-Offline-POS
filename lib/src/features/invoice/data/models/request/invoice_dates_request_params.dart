import 'package:hotel/src/core/extensions/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice_dates_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InvoiceDatesRequestParams {
  final String? startDate;
  final String? endDate;
  final String? invoiceType;
  final String? month;

  InvoiceDatesRequestParams({
    this.startDate,
    this.endDate,
    required this.invoiceType,
    this.month,
  });

  factory InvoiceDatesRequestParams.forMonth({
    required String invoiceType,
    required DateTime month,
  }) {
    return InvoiceDatesRequestParams(
      invoiceType: invoiceType,
      month: monthQueryValue(month),
    );
  }

  static String monthQueryValue(DateTime date) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[date.month - 1];
  }

  factory InvoiceDatesRequestParams.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDatesRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDatesRequestParamsToJson(this);

  Map<String, String> toQueryParams() {
    final queryParams = <String, String>{};
    if (startDate.isNotNullNotEmpty) queryParams['start_date'] = startDate!;
    if (endDate.isNotNullNotEmpty) queryParams['end_date'] = endDate!;
    if (invoiceType.isNotNullNotEmpty) {
      queryParams['invoice_type'] = invoiceType!;
    }
    if (month.isNotNullNotEmpty) queryParams['month'] = month!;
    return queryParams;
  }
}
