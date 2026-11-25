import 'package:hotel/src/core/extensions/extensions/string_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice_request_params.g.dart';

enum InvoiceType { sales, purchase }

@JsonSerializable()
class InvoiceRequestParams {
  final int? page;
  final int? perPage;
  final String? party;
  final String? startDate;
  final String? endDate;
  final String? itemName;
  final String? paymentStatus;
  final String? sortOrder;
  final InvoiceType? invoiceType;

  InvoiceRequestParams(
      {this.page = 1,
      this.perPage = 100,
      this.party,
      this.startDate,
      this.endDate,
      this.paymentStatus,
      this.itemName,
      this.invoiceType,
      this.sortOrder = "desc"});

  /// Factory method to create an instance from a JSON map
  factory InvoiceRequestParams.fromJson(Map<String, dynamic> json) =>
      _$InvoiceRequestParamsFromJson(json);

  /// Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$InvoiceRequestParamsToJson(this);

  /// Creates a copy of this object with the given fields replaced with new values
  InvoiceRequestParams copyWith({
    int? page,
    int? perPage,
    String? party,
    String? startDate,
    String? endDate,
    String? itemName,
    String? paymentStatus,
    String? sortOrder,
    InvoiceType? invoiceType,
  }) {
    return InvoiceRequestParams(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      party: party ?? this.party,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      itemName: itemName ?? this.itemName,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      sortOrder: sortOrder ?? this.sortOrder,
      invoiceType: invoiceType ?? this.invoiceType,
    );
  }

  /// Convert the object into query parameters, including only non-null values
  Map<String, String> toQueryParams() {
    final queryParams = <String, String>{};
    if (page != null) queryParams['page'] = page.toString();
    if (perPage != null) queryParams['per_page'] = perPage.toString();
    if (party.isNotNullNotEmpty) queryParams['party'] = party!;
    if (startDate.isNotNullNotEmpty) queryParams['start_date'] = startDate!;
    if (paymentStatus.isNotNullNotEmpty && paymentStatus != 'All') {
      if (paymentStatus == 'Paid') {
        queryParams['status'] = 'paid';
      } else if (paymentStatus == 'Un-Paid') {
        queryParams['status'] = 'unpaid';
      }
    }
    if (endDate.isNotNullNotEmpty) queryParams['end_date'] = endDate!;
    if (itemName.isNotNullNotEmpty) queryParams['item_name'] = itemName!;
    if (sortOrder != null) queryParams['sort_order'] = sortOrder!;
    return queryParams;
  }
}
