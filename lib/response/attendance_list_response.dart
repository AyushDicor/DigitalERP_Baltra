// To parse this JSON data, do
//
//     final attendanceListResponse = attendanceListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:digitalerp/response/attendance_summary_response.dart';

AttendanceListResponse attendanceListResponseFromJson(String str) =>
    AttendanceListResponse.fromJson(json.decode(str));

String attendanceListResponseToJson(AttendanceListResponse data) => json.encode(data.toJson());

class AttendanceListResponse {
  AttendanceListResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<DayDetails>? data;
  String? message;
  int? status;

  factory AttendanceListResponse.fromJson(Map<String, dynamic> json) => AttendanceListResponse(
        success: json['success'],
        data: json['data'] == null
            ? null
            : List<DayDetails>.from(json['data'].map((x) => DayDetails.fromJson(x))),
        message: json['message'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
        'message': message,
        'status': status,
      };
}
