import 'package:freezed_annotation/freezed_annotation.dart';

part 'party_available_filters_model.freezed.dart';
part 'party_available_filters_model.g.dart';

@freezed
class PartyAvailableFiltersModel with _$PartyAvailableFiltersModel {
  const factory PartyAvailableFiltersModel({
    @JsonKey(name: 'role_options') List<String>? roleOptions,
    @JsonKey(name: 'currency_options') List<String>? currencyOptions,
    @JsonKey(name: 'loyalty_program_options') List<String>? loyaltyProgramOptions,
  }) = _PartyAvailableFiltersModel;

  factory PartyAvailableFiltersModel.fromJson(Map<String, dynamic> json) =>
      _$PartyAvailableFiltersModelFromJson(json);
}
