// To parse this JSON data, do
//
//     final cityDataResponse = cityDataResponseFromJson(jsonString);

import 'dart:convert';

CityDataResponse cityDataResponseFromJson(String str) => CityDataResponse.fromJson(json.decode(str));

String cityDataResponseToJson(CityDataResponse data) => json.encode(data.toJson());

class CityDataResponse {
  CityDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<CityDataList>? data;
  String? message;
  int? status;

  factory CityDataResponse.fromJson(Map<String, dynamic> json) => CityDataResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<CityDataList>.from(json["data"]!.map((x) => CityDataList.fromJson(x))),
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

class CityDataList {
  CityDataList({
    this.cityid,
    this.cityname,
  });

  int? cityid;
  String? cityname;

  factory CityDataList.fromJson(Map<String, dynamic> json) => CityDataList(
    cityid: json["cityid"],
    cityname: json["cityname"],
  );

  Map<String, dynamic> toJson() => {
    "cityid": cityid,
    "cityname": cityname,
  };
}
