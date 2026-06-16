// To parse this JSON data, do
//
//     final userValidateForOrderResponse = userValidateForOrderResponseFromJson(jsonString);

import 'dart:convert';

UserValidateForOrderResponse userValidateForOrderResponseFromJson(String str) =>
    UserValidateForOrderResponse.fromJson(json.decode(str));

String userValidateForOrderResponseToJson(UserValidateForOrderResponse data) => json.encode(data.toJson());

class UserValidateForOrderResponse {
  UserValidateForOrderResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  dynamic data;
  String? message;
  int? status;

  factory UserValidateForOrderResponse.fromJson(Map<String, dynamic> json) => UserValidateForOrderResponse(
        success: json["success"],
        data: json["data"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
        "message": message,
        "status": status,
      };
}
