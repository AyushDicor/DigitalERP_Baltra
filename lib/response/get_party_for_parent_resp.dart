// To parse this JSON data, do
//
//     final getPartyForParentResp = getPartyForParentRespFromJson(jsonString);

import 'dart:convert';

GetPartyForParentResp getPartyForParentRespFromJson(String str) => GetPartyForParentResp.fromJson(json.decode(str));

String getPartyForParentRespToJson(GetPartyForParentResp data) => json.encode(data.toJson());

class GetPartyForParentResp {
  bool? success;
  List<GetPartyForParentData>? data;
  String? message;
  int? status;

  GetPartyForParentResp({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory GetPartyForParentResp.fromJson(Map<String, dynamic> json) => GetPartyForParentResp(
    success: json["success"],
    data: List<GetPartyForParentData>.from(json["data"]?.map((x) => GetPartyForParentData.fromJson(x))??[]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data?.map((x) => x.toJson())??[]),
    "message": message,
    "status": status,
  };
}

class GetPartyForParentData {
  int? partyid;
  String? partyname;

  GetPartyForParentData({
    this.partyid,
    this.partyname,
  });

  factory GetPartyForParentData.fromJson(Map<String, dynamic> json) => GetPartyForParentData(
    partyid: json["partyid"],
    partyname: json["partyname"],
  );

  Map<String, dynamic> toJson() => {
    "partyid": partyid,
    "partyname": partyname,
  };
}
