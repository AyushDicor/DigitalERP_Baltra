// To parse this JSON data, do
//
//     final getAttendanceReportResp = getAttendanceReportRespFromJson(jsonString);

import 'dart:convert';

GetAttendanceReportResp getAttendanceReportRespFromJson(String str) =>
    GetAttendanceReportResp.fromJson(json.decode(str));

String getAttendanceReportRespToJson(GetAttendanceReportResp data) => json.encode(data.toJson());

class GetAttendanceReportResp {
  bool? success;
  List<GetAttendanceReportData>? data;
  String? message;
  int? status;

  GetAttendanceReportResp({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory GetAttendanceReportResp.fromJson(Map<String, dynamic> json) => GetAttendanceReportResp(
        success: json["success"],
        data: json["data"] == null
            ? null
            : List<GetAttendanceReportData>.from(
                json["data"].map((x) => GetAttendanceReportData.fromJson(x)),
              ),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data":data==null?null: List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class GetAttendanceReportData {
  int? executiveid;
  String? name;
  String? workingdays;
  String? presentdays;
  String? absentdays;

  GetAttendanceReportData({
    this.executiveid,
    this.name,
    this.workingdays,
    this.presentdays,
    this.absentdays,
  });

  factory GetAttendanceReportData.fromJson(Map<String, dynamic> json) => GetAttendanceReportData(
        executiveid: json["executiveid"],
        name: json["name"],
        workingdays: json["workingdays"],
        presentdays: json["presentdays"],
        absentdays: json["absentdays"],
      );

  Map<String, dynamic> toJson() => {
        "executiveid": executiveid,
        "name": name,
        "workingdays": workingdays,
        "presentdays": presentdays,
        "absentdays": absentdays,
      };
}
