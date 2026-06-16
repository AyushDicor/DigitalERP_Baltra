// To parse this JSON data, do
//
//     final visitPlanDetailDataResponse = visitPlanDetailDataResponseFromJson(jsonString);

import 'dart:convert';

VisitPlanDetailDataResponse visitPlanDetailDataResponseFromJson(String str) => VisitPlanDetailDataResponse.fromJson(json.decode(str));

String visitPlanDetailDataResponseToJson(VisitPlanDetailDataResponse data) => json.encode(data.toJson());

class VisitPlanDetailDataResponse {
  VisitPlanDetailDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<VisitPlanDetailsDataList>? data;
  String? message;
  int? status;

  factory VisitPlanDetailDataResponse.fromJson(Map<String, dynamic> json) => VisitPlanDetailDataResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<VisitPlanDetailsDataList>.from(json["data"]!.map((x) => VisitPlanDetailsDataList.fromJson(x))),
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

class VisitPlanDetailsDataList {
  VisitPlanDetailsDataList({
    this.customername,
    this.partyid,
    this.visitdate,
    this.visittime,
    this.visitstatus,
    this.distance,
    this.checkstatus,
    this.isCheckIn
  });

  String? customername;
  int? partyid;
  String? visitdate;
  String? visittime;
  String? visitstatus;
  String? distance;
  String? checkstatus;
  bool ? isCheckIn;

  factory VisitPlanDetailsDataList.fromJson(Map<String, dynamic> json) => VisitPlanDetailsDataList(
    customername: json["Customername"],
    partyid: json["partyid"],
    visitdate: json["visitdate"],
    visittime: json["visittime"],
    visitstatus: json["visitstatus"],
    distance: json["Distance"],
    checkstatus: json["checkstatus"],
    isCheckIn: true
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
