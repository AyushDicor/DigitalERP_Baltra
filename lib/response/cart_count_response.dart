// To parse this JSON data, do
//
//     final cartCountResponse = cartCountResponseFromJson(jsonString);

import 'dart:convert';

CartCountResponse cartCountResponseFromJson(String str) =>
    CartCountResponse.fromJson(json.decode(str));

String cartCountResponseToJson(CartCountResponse data) =>
    json.encode(data.toJson());

class CartCountResponse {
  CartCountResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<CartCountData>? data;
  String? message;
  int? status;

  factory CartCountResponse.fromJson(Map<String, dynamic> json) =>
      CartCountResponse(
        success: json['success'] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<CartCountData>.from(
                json["data"].map((x) => CartCountData.fromJson(x))),
        message: json['message'] == null ? null : json["message"],
        status: json['status'] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class CartCountData {
  CartCountData({
    this.totalcartcount,
  });

  int? totalcartcount;

  factory CartCountData.fromJson(Map<String, dynamic> json) => CartCountData(
        totalcartcount:
            json['totalcartcount'] == null ? null : json["totalcartcount"],
      );

  Map<String, dynamic> toJson() => {
        "totalcartcount": totalcartcount,
      };
}
