import 'package:freezed_annotation/freezed_annotation.dart';

import 'denomination_request_item.dart';

part 'open_register_request.freezed.dart';
part 'open_register_request.g.dart';

@freezed
class OpenRegisterRequest with _$OpenRegisterRequest {
  const factory OpenRegisterRequest({
    @JsonKey(name: 'register_name') required String registerName,
    @JsonKey(name: 'shift_date') required String shiftDate,
    @JsonKey(name: 'opening_amount') required double openingAmount,
    @JsonKey(name: 'opening_note') String? openingNote,
    @JsonKey(name: 'opened_by') required String openedBy,
    @JsonKey(name: 'denominations', includeIfNull: false) List<DenominationRequestItem>? denominations,
  }) = _OpenRegisterRequest;

  factory OpenRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$OpenRegisterRequestFromJson(json);
}
