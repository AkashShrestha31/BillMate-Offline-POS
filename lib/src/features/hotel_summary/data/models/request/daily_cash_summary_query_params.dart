import 'package:json_annotation/json_annotation.dart';

part 'daily_cash_summary_query_params.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DailyCashSummaryQueryParams {
  final String? date;
  final String? startDate;
  final String? endDate;
  final int? limit;
  final int? offset;

  DailyCashSummaryQueryParams({
    this.date,
    this.startDate,
    this.endDate,
    this.limit = 50,
    this.offset = 0,
  });

  factory DailyCashSummaryQueryParams.fromJson(Map<String, dynamic> json) =>
      _$DailyCashSummaryQueryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$DailyCashSummaryQueryParamsToJson(this);

  Map<String, String> toQueryParams() {
    final queryParams = <String, String>{};
    if (date?.isNotEmpty == true) queryParams['date'] = date!;
    if (startDate?.isNotEmpty == true) queryParams['start_date'] = startDate!;
    if (endDate?.isNotEmpty == true) queryParams['end_date'] = endDate!;
    if (limit != null) queryParams['limit'] = limit.toString();
    if (offset != null) queryParams['offset'] = offset.toString();
    return queryParams;
  }
}
