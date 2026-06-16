// To parse this JSON data, do
//
//     final visitCheckInResponse = visitCheckInResponseFromJson(jsonString);

import 'dart:convert';

VisitCheckInResponse visitCheckInResponseFromJson(String str) => VisitCheckInResponse.fromJson(json.decode(str));

String visitCheckInResponseToJson(VisitCheckInResponse data) => json.encode(data.toJson());

class VisitCheckInResponse {
  VisitCheckInResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<VisitCheckInData>? data;
  String? message;
  int? status;

  factory VisitCheckInResponse.fromJson(Map<String, dynamic> json) => VisitCheckInResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<VisitCheckInData>.from(json["data"]!.map((x) => VisitCheckInData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class VisitCheckInData {
  VisitCheckInData({
    this.customername,
    this.partyid,
    this.visitdate,
    this.visittime,
    this.visitstatus,
    this.distance,
    this.checkstatus,
  });

  String? customername;
  int? partyid;
  String? visitdate;
  String? visittime;
  String? visitstatus;
  String? distance;
  String? checkstatus;

  factory VisitCheckInData.fromJson(Map<String, dynamic> json) => VisitCheckInData(
    customername: json["Customername"],
    partyid: json["partyid"],
    visitdate: json["visitdate"],
    visittime: json["visittime"],
    visitstatus: json["visitstatus"],
    distance: json["Distance"],
    checkstatus: json["checkstatus"],
  );

  Map<String, dynamic> toJson() => {
    "Customername": customername,
    "partyid": partyid,
    "visitdate": visitdate,
    "visittime": visittime,
    "visitstatus": visitstatus,
    "Distance": distance,
    "checkstatus": checkstatus,
  };
}
