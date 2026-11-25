import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/reconciliation/data/models/response/deletion_summary_model.dart';

part 'previous_stock_delete_response_model.freezed.dart';
part 'previous_stock_delete_response_model.g.dart';

@freezed
class PreviousStockDeleteResponseModel with _$PreviousStockDeleteResponseModel {
  const factory PreviousStockDeleteResponseModel({
    required bool success,
    required String message,
    @JsonKey(name: 'deletion_summary')
        required DeletionSummaryModel deletionSummary,
    @JsonKey(name: 'deleted_count') required int deletedCount,
    @JsonKey(name: 'deleted_at') required String deletedAt,
    @JsonKey(name: 'deleted_by') required String deletedBy,
  }) = _PreviousStockDeleteResponseModel;

  factory PreviousStockDeleteResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$PreviousStockDeleteResponseModelFromJson(json);
}

