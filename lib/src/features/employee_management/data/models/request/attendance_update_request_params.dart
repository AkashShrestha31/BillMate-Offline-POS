/// Request body for PUT /api/employee-management/attendance/
/// Only [attendanceId] is required; all other fields are optional (partial update).
class AttendanceUpdateRequestParams {
  const AttendanceUpdateRequestParams({
    required this.attendanceId,
    this.checkInTime,
    this.checkOutTime,
    this.breakStartTime,
    this.breakEndTime,
    this.attendanceStatus,
    this.location,
    this.notes,
  });

  @override
  String toString() =>
      'AttendanceUpdateRequestParams(attendanceId: $attendanceId, checkInTime: $checkInTime, checkOutTime: $checkOutTime, breakStartTime: $breakStartTime, breakEndTime: $breakEndTime, attendanceStatus: $attendanceStatus, location: $location, notes: $notes)';

  final int attendanceId;
  final String? checkInTime;
  final String? checkOutTime;
  final String? breakStartTime;
  final String? breakEndTime;
  final String? attendanceStatus;
  final String? location;
  final String? notes;

  /// JSON map with only non-null fields (for partial update).
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'attendance_id': attendanceId};
    if (checkInTime != null) map['check_in_time'] = checkInTime;
    if (checkOutTime != null) map['check_out_time'] = checkOutTime;
    if (breakStartTime != null) map['break_start_time'] = breakStartTime;
    if (breakEndTime != null) map['break_end_time'] = breakEndTime;
    if (attendanceStatus != null) map['attendance_status'] = attendanceStatus;
    if (location != null) map['location'] = location;
    if (notes != null) map['notes'] = notes;
    return map;
  }
}
