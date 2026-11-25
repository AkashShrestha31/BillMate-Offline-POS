import 'package:json_annotation/json_annotation.dart';

part 'create_contact_request.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class CreateContactRequest {
  final String name;
  final String? phone;
  final String? email;
  final String? address;
  final String? category;
  final String? company;
  final String? notes;
  final bool? isFavorite;
  final String? photoUrl;

  const CreateContactRequest({
    required this.name,
    this.phone,
    this.email,
    this.address,
    this.category,
    this.company,
    this.notes,
    this.isFavorite,
    this.photoUrl,
  });

  factory CreateContactRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateContactRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateContactRequestToJson(this);
}
