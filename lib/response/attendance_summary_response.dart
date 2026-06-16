import 'dart:convert';

AttendanceSummaryResponse attendanceSummaryResponseFromJson(String str) =>
    AttendanceSummaryResponse.fromJson(json.decode(str));

String attendanceSummaryResponseToJson(AttendanceSummaryResponse data) =>
    json.encode(data.toJson());

class AttendanceSummaryResponse {
  AttendanceSummaryResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<AttendanceSummaryData>? data;
  String? message;
  int? status;

  factory AttendanceSummaryResponse.fromJson(Map<String, dynamic> json) =>
      AttendanceSummaryResponse(
        success: json['success'],
        data: json['data'] == null
            ? null
            : List<AttendanceSummaryData>.from(
            json['data'].map((x) => AttendanceSummaryData.fromJson(x))),
        message: json['message'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data == null
        ? null
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    'message': message,
    'status': status,
  };

  @override
  String toString() {
    return 'AttendanceSummaryResponse{success: $success, data: $data, message: $message, status: $status}';
  }
}

class AttendanceSummaryData {
  AttendanceSummaryData({
    this.month,
    this.present,
    this.absent,
    this.totalLeave,
    this.remainingLeave,
    this.remainingTotalLeave,
    this.approveLeave,
    this.rejectLeave,
    this.totalel,
    this.totalcl,
    this.details,
  });

  String? month;
  int? present;
  int? absent;
  double? totalLeave;
  double? remainingLeave;
  double? remainingTotalLeave;
  double? approveLeave;
  double? rejectLeave;
  double? totalel;
  double? totalcl;
  List<DayDetails>? details;

  factory AttendanceSummaryData.fromJson(Map<String, dynamic> json) =>
      AttendanceSummaryData(
        month: json['month'],
        present: json['present'],
        absent: json['absent'],
        totalLeave: (json['total_leave'] as num?)?.toDouble(),
        remainingLeave: (json['remaining_leave'] as num?)?.toDouble(),
        remainingTotalLeave: (json['remaining_total_leave'] as num?)?.toDouble(),
        approveLeave: (json['approve_leave'] as num?)?.toDouble(),
        rejectLeave: (json['reject_leave'] as num?)?.toDouble(),
        totalel: (json['totalel'] as num?)?.toDouble(),
        totalcl: (json['totalcl'] as num?)?.toDouble(),
        details: json['details'] == null
            ? null
            : List<DayDetails>.from(
            json['details'].map((x) => DayDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    'month': month,
    'present': present,
    'absent': absent,
    'total_leave': totalLeave,
    'remaining_leave': remainingLeave,
    'remaining_total_leave': remainingTotalLeave,
    'approve_leave': approveLeave,
    'reject_leave': rejectLeave,
    'totalel': totalel,
    'totalcl': totalcl,
    'details': details == null
        ? null
        : List<dynamic>.from(details!.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'AttendanceSummaryData{month: $month, present: $present, absent: $absent, totalLeave: $totalLeave, remainingLeave: $remainingLeave, remainingTotalLeave: $remainingTotalLeave, approveLeave: $approveLeave, rejectLeave: $rejectLeave, totalel: $totalel, totalcl: $totalcl, details: $details}';
  }
}

class DayDetails {
  DayDetails({
    this.date,
    this.inTime,
    this.outTime,
    this.batterylevel,
    this.photo,
    this.location,
  });

  String? date;
  String? inTime;
  String? outTime;
  String? batterylevel;
  String? photo;
  String? location;

  factory DayDetails.fromJson(Map<String, dynamic> json) => DayDetails(
    date: json['date'],
    inTime: json['in_time'] == '' ? null : json['in_time'],
    outTime: json['out_time'] == '' ? null : json['out_time'],
    batterylevel: json['batterylevel'] == '' ? null : json['batterylevel'],
    photo: json['photo'],
    location: json['location'],
  );

  Map<String, dynamic> toJson() => {
    'date': date,
    'in_time': inTime,
    'out_time': outTime,
    'batterylevel': batterylevel,
    'photo': photo,
    'location': location,
  };

  @override
  String toString() {
    return 'DayDetails{date: $date, inTime: $inTime, outTime: $outTime, batterylevel: $batterylevel, photo: $photo, location: $location}';
  }
}
