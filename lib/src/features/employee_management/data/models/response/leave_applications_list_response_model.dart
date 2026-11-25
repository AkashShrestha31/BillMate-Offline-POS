import 'package:freezed_annotation/freezed_annotation.dart';
import 'leave_application_model.dart';

part 'leave_applications_list_response_model.freezed.dart';
part 'leave_applications_list_response_model.g.dart';

@freezed
class LeaveApplicationsListResponseModel with _$LeaveApplicationsListResponseModel {
  const factory LeaveApplicationsListResponseModel({
    required bool success,
    required int count,
    Map<String, dynamic>? summary,
    @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
    required List<LeaveApplicationModel> applications,
  }) = _LeaveApplicationsListResponseModel;

  factory LeaveApplicationsListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveApplicationsListResponseModelFromJson(json);
}
