import 'package:freezed_annotation/freezed_annotation.dart';

part 'denomination_request_item.freezed.dart';
part 'denomination_request_item.g.dart';

@freezed
class DenominationRequestItem with _$DenominationRequestItem {
  const factory DenominationRequestItem({
    required double denomination,
    required int quantity,
    required String type,
  }) = _DenominationRequestItem;

  factory DenominationRequestItem.fromJson(Map<String, dynamic> json) =>
      _$DenominationRequestItemFromJson(json);
}
