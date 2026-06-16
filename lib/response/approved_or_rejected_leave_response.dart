// To parse this JSON data, do
//
//     final approvedOrRejectLeaveResponse = approvedOrRejectLeaveResponseFromJson(jsonString);

import 'dart:convert';

ApprovedOrRejectLeaveResponse approvedOrRejectLeaveResponseFromJson(String str) =>
    ApprovedOrRejectLeaveResponse.fromJson(json.decode(str));

String approvedOrRejectLeaveResponseToJson(ApprovedOrRejectLeaveResponse data) =>
    json.encode(data.toJson());

class ApprovedOrRejectLeaveResponse {
  ApprovedOrRejectLeaveResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<LeaveData>? data;
  String? message;
  int? status;

  factory ApprovedOrRejectLeaveResponse.fromJson(Map<String, dynamic> json) =>
      ApprovedOrRejectLeaveResponse(
        success: json['success'],
        data: json['data'] == null
            ? null
            : List<LeaveData>.from(json['data'].map((x) => LeaveData.fromJson(x))),
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

class LeaveData {
  LeaveData({
    this.title,
    this.time,
    this.date,
    this.reason,
    this.status,
    this.rejectreason,
    this.forwardperson,
    this.responsibleperson,
  });

  String? title;
  String? time;
  String? date;
  String? reason;
  String? status;
  String? rejectreason;
  String? forwardperson;
  String? responsibleperson;

  factory LeaveData.fromJson(Map<String, dynamic> json) => LeaveData(
        title: json['title'],
        time: json['time'],
        date: json['date'],
        reason: json['reason'],
        status: json['status'],
    rejectreason: json['rejectreason'],
    forwardperson: json['forwardperson'],
    responsibleperson: json['responsibleperson'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'time': time,
        'date': date,
        'reason': reason,
        'status': status,
        'rejectreason': rejectreason,
        'forwardperson': forwardperson,
        'responsibleperson': responsibleperson,
      };
}
