import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_party_request.freezed.dart';
part 'delete_party_request.g.dart';

@freezed
class DeletePartyRequest with _$DeletePartyRequest {
  const factory DeletePartyRequest({
    required String name,
    @JsonKey(name: 'confirm_delete') bool? confirmDelete,
    @JsonKey(name: 'force_delete') bool? forceDelete,
    @JsonKey(name: 'delete_transactions') bool? deleteTransactions,
    String? deletedBy,
  }) = _DeletePartyRequest;

  factory DeletePartyRequest.fromJson(Map<String, dynamic> json) =>
      _$DeletePartyRequestFromJson(json);
}
