import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_success_response_model.freezed.dart';
part 'common_success_response_model.g.dart';

@freezed
class CommonSuccessResponseModel with _$CommonSuccessResponseModel {
  const factory CommonSuccessResponseModel({
    required bool success,
    required String message,
    Map<String, dynamic>? data,
  }) = _CommonSuccessResponseModel;

  factory CommonSuccessResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CommonSuccessResponseModelFromJson(json);
}
