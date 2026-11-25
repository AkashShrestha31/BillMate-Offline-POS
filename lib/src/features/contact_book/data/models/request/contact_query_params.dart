import 'package:hotel/src/core/extensions/extensions/string_extension.dart';

class ContactQueryParams {
  final int? contactId;
  final String? category;
  final bool? isFavorite;
  final String? search;

  const ContactQueryParams({
    this.contactId,
    this.category,
    this.isFavorite,
    this.search,
  });

  Map<String, String> toQueryParams() {
    final queryParams = <String, String>{};
    if (contactId != null) queryParams['contact_id'] = contactId.toString();
    if (category.isNotNullNotEmpty) queryParams['category'] = category!;
    if (isFavorite != null) queryParams['is_favorite'] = isFavorite.toString();
    if (search.isNotNullNotEmpty) queryParams['search'] = search!;
    return queryParams;
  }
}
