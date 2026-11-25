import 'package:freezed_annotation/freezed_annotation.dart';
import 'attendance_model.dart';

part 'attendance_list_response_model.freezed.dart';
part 'attendance_list_response_model.g.dart';

@freezed
class AttendanceListResponseModel with _$AttendanceListResponseModel {
  const factory AttendanceListResponseModel({
    required bool success,
    required int count,
    Map<String, dynamic>? summary,
    @JsonKey(name: 'filters_applied') Map<String, dynamic>? filtersApplied,
    @JsonKey(name: 'attendance_records') required List<AttendanceModel> attendanceRecords,
  }) = _AttendanceListResponseModel;

  factory AttendanceListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceListResponseModelFromJson(json);
}
