// To parse this JSON data, do
//
//     final getParentGroupResp = getParentGroupRespFromJson(jsonString);

import 'dart:convert';

GetParentGroupResp getParentGroupRespFromJson(String str) => GetParentGroupResp.fromJson(json.decode(str));

String getParentGroupRespToJson(GetParentGroupResp data) => json.encode(data.toJson());

class GetParentGroupResp {
  bool? success;
  List<GetParentGroupData>? data;
  String? message;
  int? status;

  GetParentGroupResp({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory GetParentGroupResp.fromJson(Map<String, dynamic> json) => GetParentGroupResp(
    success: json["success"],
    data: List<GetParentGroupData>.from(json["data"]?.map((x) => GetParentGroupData.fromJson(x))??[]),
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

class GetParentGroupData {
  int? parentid;
  String? parentgroup;

  GetParentGroupData({
    this.parentid,
    this.parentgroup,
  });

  factory GetParentGroupData.fromJson(Map<String, dynamic> json) => GetParentGroupData(
    parentid: json["parentid"],
    parentgroup: json["parentgroup"],
  );

  Map<String, dynamic> toJson() => {
    "parentid": parentid,
    "parentgroup": parentgroup,
  };
}
