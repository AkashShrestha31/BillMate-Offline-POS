import 'package:freezed_annotation/freezed_annotation.dart';

part 'denomination_model.freezed.dart';
part 'denomination_model.g.dart';

@freezed
class DenominationModel with _$DenominationModel {
  const factory DenominationModel({
    required double denomination,
    required int quantity,
    required double amount,
    required String type,
  }) = _DenominationModel;

  factory DenominationModel.fromJson(Map<String, dynamic> json) =>
      _$DenominationModelFromJson(json);
}
