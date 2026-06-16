// To parse this JSON data, do
//
//     final nearByDataResponse = nearByDataResponseFromJson(jsonString);

import 'dart:convert';

NearByDataResponse nearByDataResponseFromJson(String str) => NearByDataResponse.fromJson(json.decode(str));

String nearByDataResponseToJson(NearByDataResponse data) => json.encode(data.toJson());

class NearByDataResponse {
  NearByDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<NearByDataList>? data;
  String? message;
  int? status;

  factory NearByDataResponse.fromJson(Map<String, dynamic> json) => NearByDataResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<NearByDataList>.from(json["data"]!.map((x) => NearByDataList.fromJson(x))),
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

class NearByDataList {
  NearByDataList({
    this.nearbyid,
    this.nearbyvalue,
  });

  int? nearbyid;
  String? nearbyvalue;

  factory NearByDataList.fromJson(Map<String, dynamic> json) => NearByDataList(
    nearbyid: json["nearbyid"],
    nearbyvalue: json["nearbyvalue"],
  );

  Map<String, dynamic> toJson() => {
    "nearbyid": nearbyid,
    "nearbyvalue": nearbyvalue,
  };
}
