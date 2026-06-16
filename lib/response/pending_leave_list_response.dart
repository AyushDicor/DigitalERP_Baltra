// To parse this JSON data, do
//
//     final pendingLeaveListResponse = pendingLeaveListResponseFromJson(jsonString);

import 'dart:convert';

PendingLeaveListResponse pendingLeaveListResponseFromJson(String str) =>
    PendingLeaveListResponse.fromJson(json.decode(str));

String pendingLeaveListResponseToJson(PendingLeaveListResponse data) => json.encode(data.toJson());

class PendingLeaveListResponse {
  PendingLeaveListResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<PendingLeaveData>? data;
  String? message;
  int? status;

  factory PendingLeaveListResponse.fromJson(Map<String, dynamic> json) => PendingLeaveListResponse(
        success: json['success'],
        data: json['data'] == null
            ? null
            : List<PendingLeaveData>.from(json['data'].map((x) => PendingLeaveData.fromJson(x))),
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

class PendingLeaveData {
  PendingLeaveData({
    this.id,
    this.executivename,
    this.title,
    this.time,
    this.date,
    this.reason,
    this.status,
  });

  int? id;
  String? executivename;
  String? title;
  String? time;
  String? date;
  String? reason;
  String? status;

  factory PendingLeaveData.fromJson(Map<String, dynamic> json) => PendingLeaveData(
        id: json['id'],
        executivename: json['executivename'],
        title: json['title'],
        time: json['time'],
        date: json['date'],
        reason: json['reason'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'executivename': executivename,
        'title': title,
        'time': time,
        'date': date,
        'reason': reason,
        'status': status,
      };
}
