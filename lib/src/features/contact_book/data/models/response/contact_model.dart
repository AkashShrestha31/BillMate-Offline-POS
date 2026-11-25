import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_model.freezed.dart';
part 'contact_model.g.dart';

@freezed
class ContactModel with _$ContactModel {
  const factory ContactModel({
    required int? id,
    required String? name,
    String? phone,
    String? email,
    String? address,
    String? category,
    String? company,
    String? notes,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
    @JsonKey(name: 'photo_url') String? photoUrl,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'modified_at') String? modifiedAt,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'modified_by') String? modifiedBy,
  }) = _ContactModel;

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);
}

@freezed
class ContactListResponse with _$ContactListResponse {
  const factory ContactListResponse({
    required bool success,
    required int count,
    @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
    required List<ContactModel> contacts,
  }) = _ContactListResponse;

  factory ContactListResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactListResponseFromJson(json);
}

@freezed
class ContactSingleResponse with _$ContactSingleResponse {
  const factory ContactSingleResponse({
    required bool success,
    required ContactModel contact,
  }) = _ContactSingleResponse;

  factory ContactSingleResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactSingleResponseFromJson(json);
}

@freezed
class CreateContactResponse with _$CreateContactResponse {
  const factory CreateContactResponse({
    required bool success,
    String? message,
    required ContactModel contact,
  }) = _CreateContactResponse;

  factory CreateContactResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateContactResponseFromJson(json);
}

@freezed
class UpdateContactResponse with _$UpdateContactResponse {
  const factory UpdateContactResponse({
    required bool success,
    String? message,
    @JsonKey(name: 'contact_id') required int contactId,
  }) = _UpdateContactResponse;

  factory UpdateContactResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateContactResponseFromJson(json);
}

@freezed
class DeleteContactResponse with _$DeleteContactResponse {
  const factory DeleteContactResponse({
    required bool success,
    String? message,
    @JsonKey(name: 'deleted_contact') ContactModel? deletedContact,
  }) = _DeleteContactResponse;

  factory DeleteContactResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteContactResponseFromJson(json);
}
