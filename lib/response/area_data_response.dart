// To parse this JSON data, do
//
//     final areaDataResponse = areaDataResponseFromJson(jsonString);

import 'dart:convert';

AreaDataResponse areaDataResponseFromJson(String str) => AreaDataResponse.fromJson(json.decode(str));

String areaDataResponseToJson(AreaDataResponse data) => json.encode(data.toJson());

class AreaDataResponse {
  AreaDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<AreaDataList>? data;
  String? message;
  int? status;

  factory AreaDataResponse.fromJson(Map<String, dynamic> json) => AreaDataResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<AreaDataList>.from(json["data"]!.map((x) => AreaDataList.fromJson(x))),
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

class AreaDataList {
  AreaDataList({
    this.areaid,
    this.areaname,
  });

  int? areaid;
  String? areaname;

  factory AreaDataList.fromJson(Map<String, dynamic> json) => AreaDataList(
    areaid: json["areaid"],
    areaname: json["areaname"],
  );

  Map<String, dynamic> toJson() => {
    "areaid": areaid,
    "areaname": areaname,
  };
}
