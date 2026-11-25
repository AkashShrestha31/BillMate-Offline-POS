// dashboard_summary_page_request_params.dart
import 'package:hotel/src/core/extensions/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_summary_page_request_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DashboardSummaryPageRequestParams {
  final String? acceptLanguage;
  final String? dailyMonth;

  DashboardSummaryPageRequestParams({
    this.acceptLanguage = 'en',
    String? dailyMonth,
  }) : dailyMonth = dailyMonth ?? _getCurrentMonthYear();

  /// Factory method to create an instance from a JSON map
  factory DashboardSummaryPageRequestParams.fromJson(
          Map<String, dynamic> json) =>
      _$DashboardSummaryPageRequestParamsFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() =>
      _$DashboardSummaryPageRequestParamsToJson(this);

  /// Convert the object into query parameters, including only non-null values
  Map<String, String> toQueryParams() {
    final queryParams = <String, String>{};

    if (acceptLanguage.isNotNullNotEmpty)
      queryParams['accept-language'] = acceptLanguage!;
    if (dailyMonth.isNotNullNotEmpty) queryParams['daily_month'] = dailyMonth!;

    return queryParams;
  }

  /// Helper method to get current month and year in YYYY-MM format
  static String _getCurrentMonthYear() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}';
  }
}
