import 'package:json_annotation/json_annotation.dart';

part 'update_contact_request.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class UpdateContactRequest {
  final int contactId;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final String? category;
  final String? company;
  final String? notes;
  final bool? isFavorite;
  final String? photoUrl;

  const UpdateContactRequest({
    required this.contactId,
    this.name,
    this.phone,
    this.email,
    this.address,
    this.category,
    this.company,
    this.notes,
    this.isFavorite,
    this.photoUrl,
  });

  factory UpdateContactRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateContactRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateContactRequestToJson(this);
}
