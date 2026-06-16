// To parse this JSON data, do
//
//     final visitCheckOutResponse = visitCheckOutResponseFromJson(jsonString);

import 'dart:convert';

VisitCheckOutResponse visitCheckOutResponseFromJson(String str) => VisitCheckOutResponse.fromJson(json.decode(str));

String visitCheckOutResponseToJson(VisitCheckOutResponse data) => json.encode(data.toJson());

class VisitCheckOutResponse {
  VisitCheckOutResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<VisitCheckOutData>? data;
  String? message;
  int? status;

  factory VisitCheckOutResponse.fromJson(Map<String, dynamic> json) => VisitCheckOutResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<VisitCheckOutData>.from(json["data"]!.map((x) => VisitCheckOutData.fromJson(x))),
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

class VisitCheckOutData {
  VisitCheckOutData({
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

  factory VisitCheckOutData.fromJson(Map<String, dynamic> json) => VisitCheckOutData(
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
