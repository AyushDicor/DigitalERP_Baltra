// To parse this JSON data, do
//
//     final allVisitDataResponse = allVisitDataResponseFromJson(jsonString);

import 'dart:convert';

AllVisitDataResponse allVisitDataResponseFromJson(String str) => AllVisitDataResponse.fromJson(json.decode(str));

String allVisitDataResponseToJson(AllVisitDataResponse data) => json.encode(data.toJson());

class AllVisitDataResponse {
  AllVisitDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<VisitListData>? data;
  String? message;
  int? status;

  factory AllVisitDataResponse.fromJson(Map<String, dynamic> json) => AllVisitDataResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<VisitListData>.from(json["data"]!.map((x) => VisitListData.fromJson(x))),
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

class VisitListData {
  VisitListData({
    this.vistarea,
    this.visitdate,
    this.visittime,
    this.visitstatus,
    this.executive,
    this.planid,
    this.visitid,
    this.party
  });

  String? vistarea;
  String? visitdate;
  String? visittime;
  String? visitstatus;
  String? executive;
  int? planid;
  int? visitid;
  String ? party;

  factory VisitListData.fromJson(Map<String, dynamic> json) => VisitListData(
    vistarea: json["Vistarea"],
    visitdate: json["visitdate"],
    visittime: json["visittime"],
    visitstatus: json["visitstatus"],
    executive: json["Executive"],
    planid: json["Planid"],
    visitid: json["visitid"],
    party: json["party"]
  );

  Map<String, dynamic> toJson() => {
    "Vistarea": vistarea,
    "visitdate": visitdate,
    "visittime": visittime,
    "visitstatus": visitstatus,
    "Executive": executive,
    "Planid": planid,
    "visitid": visitid,
    "party":party
  };
}
