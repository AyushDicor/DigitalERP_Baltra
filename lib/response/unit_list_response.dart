// To parse this JSON data, do
//
//     final unitListResponse = unitListResponseFromJson(jsonString);

import 'dart:convert';

UnitListResponse unitListResponseFromJson(String str) => UnitListResponse.fromJson(json.decode(str));

String unitListResponseToJson(UnitListResponse data) => json.encode(data.toJson());

class UnitListResponse {
  UnitListResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<UnitListData>? data;
  String? message;
  int? status;

  factory UnitListResponse.fromJson(Map<String, dynamic> json) => UnitListResponse(
        success: json["success"],
        data: json["data"] == null ? [] : List<UnitListData>.from(json["data"].map((x) => UnitListData.fromJson(x))),
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

class UnitListData {
  UnitListData({
    this.unitid,
    this.unitname,
    this.rate,
  });

  int? unitid;
  String? unitname;
  double? rate;

  factory UnitListData.fromJson(Map<String, dynamic> json) => UnitListData(
        unitid: json["unitid"],
        unitname: json["unitname"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "unitid": unitid,
        "unitname": unitname,
        "rate": rate,
      };
}
