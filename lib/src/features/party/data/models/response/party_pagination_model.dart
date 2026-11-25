import 'package:freezed_annotation/freezed_annotation.dart';

part 'party_pagination_model.freezed.dart';
part 'party_pagination_model.g.dart';

@freezed
class PartyPaginationModel with _$PartyPaginationModel {
  const factory PartyPaginationModel({
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'per_page') required int perPage,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_rows') required int totalRows,
  }) = _PartyPaginationModel;

  factory PartyPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PartyPaginationModelFromJson(json);
}
