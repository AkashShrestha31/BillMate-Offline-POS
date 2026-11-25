import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_summary_model.freezed.dart';
part 'edit_summary_model.g.dart';

@freezed
class EditSummaryModel with _$EditSummaryModel {
  const factory EditSummaryModel({
    @JsonKey(name: 'total_requested') required int totalRequested,
    @JsonKey(name: 'successfully_updated') required int successfullyUpdated,
    required int failed,
  }) = _EditSummaryModel;

  factory EditSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$EditSummaryModelFromJson(json);
}
