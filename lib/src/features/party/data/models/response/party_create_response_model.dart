// hotel/lib/src/features/party/data/models/response/party_create_response_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'party_model.dart';

part 'party_create_response_model.freezed.dart';
part 'party_create_response_model.g.dart';

@freezed
class PartyCreateResponseModel with _$PartyCreateResponseModel {
  const factory PartyCreateResponseModel({
    required bool success,
    required String message,
    required PartyModel party,
  }) = _PartyCreateResponseModel;

  factory PartyCreateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PartyCreateResponseModelFromJson(json);
}