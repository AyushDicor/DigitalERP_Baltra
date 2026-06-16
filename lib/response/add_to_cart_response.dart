// To parse this JSON data, do
//
//     final addToCartResponse = addToCartResponseFromJson(jsonString);

import 'dart:convert';

AddToCartResponse addToCartResponseFromJson(String str) => AddToCartResponse.fromJson(json.decode(str));

String addToCartResponseToJson(AddToCartResponse data) => json.encode(data.toJson());

class AddToCartResponse {
  AddToCartResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<AddToCartData>? data;
  String? message;
  int? status;

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) => AddToCartResponse(
    success: json["success"],
    data: json["data"] == null ? null : List<AddToCartData>.from(json["data"].map((x) => AddToCartData.fromJson(x))),
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

class AddToCartData {
  AddToCartData({
    this.totalnumber,
  });

  int? totalnumber;

  factory AddToCartData.fromJson(Map<String, dynamic> json) => AddToCartData(
    totalnumber: json["totalnumber"],
  );

  Map<String, dynamic> toJson() => {
    "totalnumber": totalnumber,
  };
}
