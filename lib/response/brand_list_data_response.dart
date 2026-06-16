// To parse this JSON data, do
//
//     final brandDataResponse = brandDataResponseFromJson(jsonString);

import 'dart:convert';

BrandDataResponse brandDataResponseFromJson(String str) => BrandDataResponse.fromJson(json.decode(str));

String brandDataResponseToJson(BrandDataResponse data) => json.encode(data.toJson());

class BrandDataResponse {
  BrandDataResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<BrandItem>? data;
  String? message;
  int? status;

  factory BrandDataResponse.fromJson(Map<String, dynamic> json) => BrandDataResponse(
        success: json["success"],
        data: json["data"] == null ? [] : List<BrandItem>.from(json["data"].map((x) => BrandItem.fromJson(x))),
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

class BrandItem {
  BrandItem({
    this.brandid,
    this.brandname,
    this.brandimage,
  });

  int? brandid;
  String? brandname;
  String? brandimage;

  factory BrandItem.fromJson(Map<String, dynamic> json) => BrandItem(
        brandid: json["brandid"],
        brandname: json["brandname"],
        brandimage: json["brandimage"],
      );

  Map<String, dynamic> toJson() => {
        "brandid": brandid,
        "brandname": brandname,
        "brandimage": brandimage,
      };
}
