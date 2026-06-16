// To parse this JSON data, do
//
//     final updateCart = updateCartFromJson(jsonString);

import 'dart:convert';

UpdateCart updateCartFromJson(String str) => UpdateCart.fromJson(json.decode(str));

String updateCartToJson(UpdateCart data) => json.encode(data.toJson());

class UpdateCart {
  UpdateCart({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  dynamic data;
  String? message;
  int? status;

  factory UpdateCart.fromJson(Map<String, dynamic> json) => UpdateCart(
    success: json['success'] == null ? null : json["success"],
    data: json["data"],
    message: json['message'] == null ? null : json["message"],
    status: json['status'] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data,
    "message": message,
    "status": status,
  };
}
