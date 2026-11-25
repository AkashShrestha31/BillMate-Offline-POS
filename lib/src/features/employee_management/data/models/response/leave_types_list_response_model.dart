import 'package:freezed_annotation/freezed_annotation.dart';
import 'leave_type_model.dart';

part 'leave_types_list_response_model.freezed.dart';
part 'leave_types_list_response_model.g.dart';

@freezed
class LeaveTypesListResponseModel with _$LeaveTypesListResponseModel {
  const factory LeaveTypesListResponseModel({
    required bool success,
    required int count,
    @JsonKey(name: 'leave_types') required List<LeaveTypeModel> leaveTypes,
  }) = _LeaveTypesListResponseModel;

  factory LeaveTypesListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypesListResponseModelFromJson(json);
}
