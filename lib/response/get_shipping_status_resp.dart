// To parse this JSON data, do
//
//     final getShippingStatusResp = getShippingStatusRespFromJson(jsonString);

import 'dart:convert';

GetShippingStatusResp getShippingStatusRespFromJson(String str) => GetShippingStatusResp.fromJson(json.decode(str));

String getShippingStatusRespToJson(GetShippingStatusResp data) => json.encode(data.toJson());

class GetShippingStatusResp {
  bool? success;
  List<GetShippingStatusData>? data;
  String? message;
  int? status;

  GetShippingStatusResp({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory GetShippingStatusResp.fromJson(Map<String, dynamic> json) => GetShippingStatusResp(
    success: json["success"],
    data: List<GetShippingStatusData>.from(json["data"]?.map((x) => GetShippingStatusData.fromJson(x))??[]),
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

class GetShippingStatusData {
  int? statusid;
  String? statusname;

  GetShippingStatusData({
    this.statusid,
    this.statusname,
  });

  factory GetShippingStatusData.fromJson(Map<String, dynamic> json) => GetShippingStatusData(
    statusid: json["statusid"],
    statusname: json["statusname"],
  );

  Map<String, dynamic> toJson() => {
    "statusid": statusid,
    "statusname": statusname,
  };
}
