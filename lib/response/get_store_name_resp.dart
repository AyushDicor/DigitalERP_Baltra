// To parse this JSON data, do
//
//     final getStoreNameResp = getStoreNameRespFromJson(jsonString);

import 'dart:convert';

GetStoreNameResp getStoreNameRespFromJson(String str) =>
    GetStoreNameResp.fromJson(json.decode(str));

String getStoreNameRespToJson(GetStoreNameResp data) => json.encode(data.toJson());

class GetStoreNameResp {
  bool? success;
  List<GetStoreNameData>? data;
  String? message;
  int? status;

  GetStoreNameResp({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory GetStoreNameResp.fromJson(Map<String, dynamic> json) => GetStoreNameResp(
        success: json["success"],
        data: json["data"] == null
            ? null
            : List<GetStoreNameData>.from(json["data"].map((x) => GetStoreNameData.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class GetStoreNameData {
  int? storeid;
  String? storename;

  GetStoreNameData({
    this.storeid,
    this.storename,
  });

  factory GetStoreNameData.fromJson(Map<String, dynamic> json) => GetStoreNameData(
        storeid: json["storeid"],
        storename: json["storename"],
      );

  Map<String, dynamic> toJson() => {
        "storeid": storeid,
        "storename": storename,
      };
}
